//
//  HatenaBookmarkUtil.h
//  HatenaBookmarkReader
//
//  Created by shimpeiws on 2013/12/31.
//  Copyright (c) 2013年 shimpeiws. All rights reserved.
//

#import <Foundation/Foundation.h>

// デリゲートを定義
@protocol HatenaBookmarkUtilDelegate <NSObject>
- (void)finishLoading:(NSArray*)entryList;
@end

typedef enum HatenaCategories : NSUInteger {
    SOCIAL,
    ECONOMICS,
    LIFE,
    KNOWLEDGE,
    IT,
    ENTERTAINMENT,
    GAME,
    FUN,
    VIDEO
} HatenaCategories;

@interface HatenaBookmarkUtil : NSObject
@property id<HatenaBookmarkUtilDelegate> delegate; //コールバック先。FileReadWriteDelegateのデリゲートだけを指定できる
@property (nonatomic, assign) HatenaCategories hatenaCategories;
-(NSJSONSerialization*) getJsonResponse: (NSString*) requestUrl;
-(void) entriesByCategory:(NSUInteger)category;
-(void) favoriteEntries:(NSString*)userName;
-(void) bookmarkedEntries:(NSString*)userName;
-(void) recentyHotEntries:(NSString*) requestUrl;

@end
