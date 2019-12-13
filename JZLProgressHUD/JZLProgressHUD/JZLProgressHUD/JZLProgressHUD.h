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
/** 单例 */
+(instancetype)shareinstance;


/// 只显示文字(显示在window上)
/// @param msg 要显示的文字
+(void)showMsg:(nullable NSString *)msg;
/// 只显示文字
/// @param msg 要显示的文字
/// @param view   要显示的view
+(void)showMsg:(nullable NSString *)msg onView:(nullable UIView *)view;


/// 显示文字,自定义消失时间(显示在window上)
/// @param msg 要显示的文字
/// @param delay 时间
+(void)showMsg:(nullable NSString *)msg afterDelayTime:(NSTimeInterval)delay;
/// 显示文字,自定义消失时间
/// @param msg 要显示的文字
/// @param view 要显示的view
/// @param delay 时间
+(void)showMsg:(nullable NSString *)msg onView:(nullable UIView *)view afterDelayTime:(NSTimeInterval)delay;


/// 成功提示(显示在window上)
/// @param msg 要显示的文字
+(void)showSuccessWithMsg:(nullable NSString *)msg;
/// 成功提示
/// @param msg 要显示的文字
/// @param view 要显示的view
+(void)showSuccessWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view;

/// 失败提示(显示在window上)
/// @param msg 要显示的文字
+(void)showFailWithMsg:(nullable NSString *)msg;
/// 失败提示
/// @param msg 要显示的文字
/// @param view 要显示的view
+(void)showFailWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view;

/// 自定义图片显示(显示在window上)
/// @param msg 要显示的文字
/// @param imageName 要显示的图片
+(void)showMsg:(nullable NSString *)msg imageName:(NSString *)imageName;
/// 自定义图片显示
/// @param msg 要显示的文字
/// @param imageName 要显示的图片
/// @param view 要显示的view
+(void)showMsg:(nullable NSString *)msg imageName:(NSString *)imageName onView:(nullable UIView *)view;


/// 显示动画(显示在window上)
/// @param msg 要显示的文字
/// @param imgArry 帧动画数组
+(void)showCustomAnimationWithMsg:(nullable NSString *)msg withImageArry:(NSArray *)imgArry;
/// 显示动画
/// @param msg 要显示的文字
/// @param imgArry 帧动画数组
/// @param view 要显示的view
+(void)showCustomAnimationWithMsg:(nullable NSString *)msg withImageArry:(NSArray *)imgArry onView:(nullable UIView *)view;


/// 显示下载上传进度(显示在window上)
/// @param msg 要显示的文字
+(MBProgressHUD *)showProgressWithMsg:(nullable NSString *)msg;
 /// 显示下载上传进度
 /// @param msg 要显示的文字
 /// @param view 要显示的view
+(MBProgressHUD *)showProgressWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view;


/// 显示正在加载菊花(显示在window上)
/// @param msg 要显示的文字
+(void)showLoadingWithMsg:(nullable NSString *)msg;
/// 显示正在加载菊花
/// @param msg 要显示的文字
/// @param view 要显示的view
+(void)showLoadingWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view;


/// 显示正在加载圆圈(显示在window上)
/// @param msg 要显示的文字
+(void)showCircleLoadingWithMsg:(nullable NSString *)msg;
/// 显示正在加载圆圈
/// @param msg 要显示的文字
/// @param view 要显示的view
+(void)showCircleLoadingWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view;


/// 隐藏
+ (void)hide;
@end

NS_ASSUME_NONNULL_END
