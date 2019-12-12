//
//  JZLProgressHUD.h
//  JZLProgressHUD
//
//  Created by allenjzl on 2018/11/8.
//  Copyright © 2018 canslife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger, JZLProgressHUDMode){
    JZLProgressHUDModeTextOnly,         // 只显示文字
    JZLProgressHUDModeLoading,          // 加载菊花
    JZLProgressHUDModeCircle,           // 加载环形
    JZLProgressHUDModeProgress,         // 加载进度
    JZLProgressHUDModeCustomAnimation,  // 加载序列帧动画
    JZLProgressHUDModeSuccess,          // 加载成功
    JZLProgressHUDModeFail,             // 加载失败
    JZLProgressHUDModeCustomerImage     // 自定义图片
};



NS_ASSUME_NONNULL_BEGIN

@interface JZLProgressHUD : NSObject
@property (nonatomic,strong, nullable) MBProgressHUD  *hud;

/**
 只显示文字,默认1.5s后消失

 @param msg msg
 @param view view
 */
+(void)showMessage:(NSString *)msg onView:(UIView *)view;
/**
 只显示文字,自己设定显示时间

 @param msg msg
 @param view view
 @param delay 显示时间
 */
+(void)showMessage:(NSString *)msg onView:(UIView *)view afterDelayTime:(NSTimeInterval)delay;

/**
 成功hud

 @param msg msg
 @param view view
 */
+(void)showSuccessWithMsg:(NSString *)msg onView:(UIView *)view;

/**
 失败hud

 @param msg msg
 @param view view
 */
+(void)showFailWithMsg:(NSString *)msg onView:(UIView *)view;

/**
 显示自定义图片和文字

 @param msg msg
 @param imageName 图片名称
 @param view view
 */
+(void)showMsg:(NSString *)msg imageName:(NSString *)imageName onView:(UIView *)view;

/**
 显示序列帧动画

 @param msg msg
 @param imgArry 序列帧动画数组
 @param view view
 */
+(void)showCustomAnimationWithMsg:(NSString *)msg withImageArry:(NSArray *)imgArry onView:(UIView *)view;


/**
 定义加载进度

 @param msg msg
 @param view view
 @return hud
 */
+(MBProgressHUD *)showDownloadProgressWithMsg:(NSString *)msg onView:(UIView *)view;

/**
 显示加载中菊花

 @param msg msg
 @param view view
 */
+(void)showLoadingWithMsg:(NSString *)msg onView:(UIView *)view;

/**
 显示加载中环形

 @param msg msg
 @param view view
 */
+(void)showCircleLoadingWithMsg:(NSString *)msg onView:(UIView *)view;

/**
 隐藏
 */
+ (void)hide;
@end

NS_ASSUME_NONNULL_END
