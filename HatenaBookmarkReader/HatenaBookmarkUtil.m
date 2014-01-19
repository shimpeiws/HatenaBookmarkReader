//
//  HatenaBookmarkUtil.m
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2013/12/31.
//  Copyright (c) 2013年 shimpeiws. All rights reserved.
//

#import "HatenaBookmarkUtil.h"
#import "HatenaBookmarkEntry.h"
#import "DDXMLDocument.h"

static NSString * const HATENA_API_BASE_URL = @"http://b.hatena.ne.jp/entrylist/";
static NSString * const HATENA_FAVORITE_API_BASE_URL = @"http://b.hatena.ne.jp/{user}/favorite.rss";

@interface HatenaBookmarkUtil () {
}
@end

@implementation HatenaBookmarkUtil

-(NSJSONSerialization *) getJsonResponse:(NSString *)requestUrl
{
    return nil;
}

-(void) entriesByCategory:(NSUInteger)category
{
//    NSString *requestUrl = [HATENA_API_BASE_URL stringByAppendingString:@"social?sort=hot&threshold=&mode=rss"];
    NSString* categoryName;
    switch ((int)category) {
        case SOCIAL:
            categoryName = @"social";
            break;
        case ECONOMICS:
            categoryName = @"economics";
            break;
        case LIFE:
            categoryName = @"life";
            break;
        case KNOWLEDGE:
            categoryName = @"knowledge";
            break;
        case IT:
            categoryName = @"it";
            break;
        case ENTERTAINMENT:
            categoryName = @"entertainment";
            break;
        case GAME:
            categoryName = @"game";
            break;
        case FUN:
            categoryName = @"fun";
            break;
        case VIDEO:
            categoryName = @"video";
            break;
        default:
            break;
    }
    NSString *requestUrl =[NSString stringWithFormat:@"%@%@%@",HATENA_API_BASE_URL, categoryName, @"?sort=hot&threshold=&mode=rss"];
    [self recentyHotEntries:requestUrl];
}

-(void) favoriteEntries:(NSString *)userName
{
    NSString *requestUrl = [HATENA_FAVORITE_API_BASE_URL stringByReplacingOccurrencesOfString:@"{user}" withString:userName];
    [self recentyHotEntries:requestUrl];
    
}

-(void) recentyHotEntries:(NSString*) requestUrl
{
//    NSString *requestUrl = [HATENA_API_BASE_URL stringByAppendingString:@"social?sort=hot&threshold=&mode=rss"];
    
    
    NSURL *url = [NSURL URLWithString:requestUrl];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    NSMutableArray* entryList = [[NSMutableArray alloc] init];
    
    // Set the method(HTTP-GET)
    [request setHTTPMethod:@"GET"];
    
    // Send the url-request.
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                             
       if (data) {
           
           DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
           DDXMLElement *root = [doc rootElement];
           
           [root addNamespace:[DDXMLNode namespaceWithName:@"rdf" stringValue:@"http://www.w3.org/1999/02/22-rdf-syntax-ns#"]];
           [root addNamespace:[DDXMLNode namespaceWithName:@"purl" stringValue:@"http://purl.org/rss/1.0/"]];
           [root addNamespace:[DDXMLNode namespaceWithName:@"content" stringValue:@"http://purl.org/rss/1.0/modules/content/"]];
           [root addNamespace:[DDXMLNode namespaceWithName:@"taxo" stringValue:@"http://purl.org/rss/1.0/modules/taxonomy/"]];
           [root addNamespace:[DDXMLNode namespaceWithName:@"opensearch" stringValue:@"http://a9.com/-/spec/opensearchrss/1.0/"]];
           [root addNamespace:[DDXMLNode namespaceWithName:@"dc" stringValue:@"http://purl.org/dc/elements/1.1/"]];
           [root addNamespace:[DDXMLNode namespaceWithName:@"hatena" stringValue:@"http://www.hatena.ne.jp/info/xmlns#"]];
           [root addNamespace:[DDXMLNode namespaceWithName:@"media" stringValue:@"http://search.yahoo.com/mrss"]];
           
           NSArray* titleList = [root nodesForXPath:@"//purl:item/purl:title" error:&error];
           NSArray* linkList  = [root nodesForXPath:@"//purl:item/purl:link" error:&error];
           NSArray* dateList  = [root nodesForXPath:@"//purl:item/dc:date" error:&error];
           NSArray* bookmarkCountList  = [root nodesForXPath:@"//purl:item/hatena:bookmarkcount" error:&error];
           
           for (NSUInteger i = 0; i < [titleList count]; i++){
               NSLog(@"title = %@", [[titleList objectAtIndex:i] stringValue]);
               HatenaBookmarkEntry *entry = [[HatenaBookmarkEntry alloc] init];
               entry.title = [[titleList objectAtIndex:i] stringValue];
               entry.url = [[linkList objectAtIndex:i] stringValue];
               entry.date = [self trimDate:[[dateList objectAtIndex:i] stringValue]];
               entry.count = [[[bookmarkCountList objectAtIndex:i] stringValue] stringByAppendingString:@"users"];
               [entryList addObject:entry];
           }
           [self.delegate finishLoading:entryList]; //デリゲートで通知
           
       } else {
           NSLog(@"error: %@", error);
       }
   }];
}

-(NSString*) trimDate:(NSString*) date
{
    NSLog(@"inputDate = %@", date);
    NSString* outStr;
    outStr = [[date substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    return outStr;
}


@end
