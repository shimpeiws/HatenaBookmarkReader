#!/bin/sh
 
#--------------要編集部分--------------#
# SDK (xcodebuild -showsdksで確認可能)
SDK="iphoneos6.1"
 
# Debug or Release
CONFIGURATION="Debug"
 
# Xcodeのプロジェクト名
PROJ_FILE_PATH="Proj.xcodeproj"
 
# ターゲット名
TARGET_NAME="Proj"
 
# プロダクトネーム (Xcode -> Build Settings -> Product Name)
PRODUCT_NAME="Proj"
#--------------要編集部分--------------#
 
 
# クリーン
xcodebuild clean -project "../${PROJ_FILE_PATH}"
 
 
#  ビルド
xcodebuild -project "../${PROJ_FILE_PATH}" -sdk "${SDK}" -configuration "${CONFIGURATION}" -target "${TARGET_NAME}"
 
# 実機転送
APP_PATH=../build/${CONFIGURATION}-iphoneos/${PRODUCT_NAME}.app
~/fruitstrap/fruitstrap -d -b ${APP_PATH}
 
# echo "UDID:"
# ~/mobiledevice/mobiledevice get_udid
 
# echo "\nBundle Identifier:"
# ~/mobiledevice/mobiledevice get_bundle_id ${APP_PATH}
 
# echo "\nRESULT:"
# ~/mobiledevice/mobiledevice install_app ${APP_PATH}
