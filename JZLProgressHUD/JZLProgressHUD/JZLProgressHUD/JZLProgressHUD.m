//
//  JZLProgressHUD.m
//  JZLProgressHUD
//
//  Created by allenjzl on 2018/11/8.
//  Copyright © 2018 canslife. All rights reserved.
//

#import "JZLProgressHUD.h"

@implementation JZLProgressHUD

/** 单例 */
+(instancetype)shareinstance{
    static JZLProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        instance = [[JZLProgressHUD alloc] init];
    });
    return instance;
}


/// 只显示文字(显示在window上)
/// @param msg 要显示的文字
+(void)showMsg:(nullable NSString *)msg {
    [self show:msg onView:nil hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}
/// 只显示文字
/// @param msg 要显示的文字
/// @param view   要显示的view
+(void)showMsg:(nullable NSString *)msg onView:(nullable UIView *)view{
    [self show:msg onView:view hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}


/// 显示文字,自定义消失时间(显示在window上)
/// @param msg 要显示的文字
/// @param delay 时间
+(void)showMsg:(nullable NSString *)msg afterDelayTime:(NSTimeInterval)delay{
    [self show:msg onView:nil hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:delay];
}
/// 显示文字,自定义消失时间
/// @param msg 要显示的文字
/// @param view 要显示的view
/// @param delay 时间
+(void)showMsg:(nullable NSString *)msg onView:(nullable UIView *)view afterDelayTime:(NSTimeInterval)delay{
    [self show:msg onView:view hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:delay];
}


/// 成功提示(显示在window上)
/// @param msg 要显示的文字
+(void)showSuccessWithMsg:(nullable NSString *)msg {
    [self show:msg onView:nil hudMode:JZLProgressHUDModeSuccess];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}
/// 成功提示
/// @param msg 要显示的文字
/// @param view 要显示的view
+(void)showSuccessWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view{
    [self show:msg onView:view hudMode:JZLProgressHUDModeSuccess];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}


/// 失败提示(显示在window上)
/// @param msg 要显示的文字
+(void)showFailWithMsg:(nullable NSString *)msg{
    [self show:msg onView:nil hudMode:JZLProgressHUDModeFail];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}
/// 失败提示
/// @param msg 要显示的文字
/// @param view 要显示的view
+(void)showFailWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view{
    [self show:msg onView:view hudMode:JZLProgressHUDModeFail];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}


/// 自定义图片显示(显示在window上)
/// @param msg 要显示的文字
/// @param imageName 要显示的图片
+(void)showMsg:(nullable NSString *)msg imageName:(NSString *)imageName{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg onView:nil hudMode:JZLProgressHUDModeCustomerImage customImgView:imgView];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}
/// 自定义图片显示
/// @param msg 要显示的文字
/// @param imageName 要显示的图片
/// @param view 要显示的view
+(void)showMsg:(nullable NSString *)msg imageName:(NSString *)imageName onView:(nullable UIView *)view{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg onView:view hudMode:JZLProgressHUDModeCustomerImage customImgView:imgView];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}


/// 显示动画(显示在window上)
/// @param msg 要显示的文字
/// @param imgArry 帧动画数组
+(void)showCustomAnimationWithMsg:(nullable NSString *)msg withImageArry:(NSArray *)imgArry{
    UIImageView *imgView = [[UIImageView alloc] init];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imageString in imgArry) {
        [imageArray addObject:[UIImage imageNamed:imageString]];
    }
    imgView.animationImages = imageArray;
    [imgView setAnimationRepeatCount:0];
    [imgView setAnimationDuration:imgArry.count  * 0.25];
    [imgView startAnimating];
    [self show:msg onView:nil hudMode:JZLProgressHUDModeCustomAnimation customImgView:imgView];
}
/// 显示动画
/// @param msg 要显示的文字
/// @param imgArry 帧动画数组
/// @param view 要显示的view
+(void)showCustomAnimationWithMsg:(nullable NSString *)msg withImageArry:(NSArray *)imgArry onView:(nullable UIView *)view{
    UIImageView *imgView = [[UIImageView alloc] init];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imageString in imgArry) {
        [imageArray addObject:[UIImage imageNamed:imageString]];
    }
    imgView.animationImages = imageArray;
    [imgView setAnimationRepeatCount:0];
    [imgView setAnimationDuration:imgArry.count  * 0.25];
    [imgView startAnimating];
    [self show:msg onView:view hudMode:JZLProgressHUDModeCustomAnimation customImgView:imgView];
}



/// 显示下载上传进度(显示在window上)
/// @param msg 要显示的文字
+(MBProgressHUD *)showProgressWithMsg:(nullable NSString *)msg{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:(UIView*)[UIApplication sharedApplication].delegate.window animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.bezelView.color = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [hud setMargin:20];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.detailsLabel.text = msg == nil ? @"" : msg;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    return hud;
}
/// 显示下载上传进度
/// @param msg 要显示的文字
/// @param view 要显示的view
+(MBProgressHUD *)showProgressWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.bezelView.color = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [hud setMargin:20];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.detailsLabel.text = msg == nil ? @"" : msg;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    return hud;
}


/// 显示正在加载菊花(显示在window上)
/// @param msg 要显示的文字
+(void)showLoadingWithMsg:(nullable NSString *)msg{
    [self show:msg onView:nil hudMode:JZLProgressHUDModeLoading];
}
/// 显示正在加载菊花
/// @param msg 要显示的文字
/// @param view 要显示的view
+(void)showLoadingWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view{
    [self show:msg onView:view hudMode:JZLProgressHUDModeLoading];
}


/// 显示正在加载圆圈(显示在window上)
/// @param msg 要显示的文字
+(void)showCircleLoadingWithMsg:(nullable NSString *)msg{
    [self show:msg onView:nil hudMode:JZLProgressHUDModeCircle];
}
/// 显示正在加载圆圈
/// @param msg 要显示的文字
/// @param view 要显示的view
+(void)showCircleLoadingWithMsg:(nullable NSString *)msg onView:(nullable UIView *)view{
    [self show:msg onView:view hudMode:JZLProgressHUDModeCircle];
    
}




+ (void)hide {
    if ([JZLProgressHUD shareinstance].hud != nil) {
        [[JZLProgressHUD shareinstance].hud hideAnimated:YES];
    }
}



+ (void)show:(nullable NSString *)msg onView:(nullable UIView *)view hudMode:(JZLProgressHUDMode)hudMode  {
    [self show:msg onView:view hudMode:hudMode customImgView:nil];
    
}

+ (void)show:(nullable NSString *)msg onView:(nullable UIView *)view hudMode:(JZLProgressHUDMode)hudMode customImgView:(UIImageView *)customImgView{
    // 如果当前存在,则先消失
    if ([JZLProgressHUD shareinstance].hud != nil) {
        [[JZLProgressHUD shareinstance].hud hideAnimated:YES];
        [JZLProgressHUD shareinstance].hud = nil;
    }
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [JZLProgressHUD shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置黑色背景
    [JZLProgressHUD shareinstance].hud.bezelView.color = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
    [JZLProgressHUD shareinstance].hud.contentColor = [UIColor whiteColor];
    [JZLProgressHUD shareinstance].hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [[JZLProgressHUD shareinstance].hud setMargin:20];
    [[JZLProgressHUD shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [JZLProgressHUD shareinstance].hud.detailsLabel.text = msg == nil ? @"" : msg;
    [JZLProgressHUD shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    switch (hudMode) {
        case JZLProgressHUDModeTextOnly://只显示文字
            [JZLProgressHUD shareinstance].hud.mode = MBProgressHUDModeText;
            break;
            
        case JZLProgressHUDModeLoading://加载菊花
            [JZLProgressHUD shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case JZLProgressHUDModeCircle:{//加载环形
            [JZLProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
            CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.toValue = [NSNumber numberWithFloat:M_PI*2];
            animation.duration = 1.0;
            animation.repeatCount = 100;
            [img.layer addAnimation:animation forKey:nil];
            [JZLProgressHUD shareinstance].hud.customView = img;
        }
            break;
            
        case JZLProgressHUDModeCustomerImage://自定义图片
            [JZLProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [JZLProgressHUD shareinstance].hud.customView = customImgView;
            break;
            
        case JZLProgressHUDModeCustomAnimation://自定义帧动画
            //这里设置动画的背景色
            [JZLProgressHUD shareinstance].hud.bezelView.color = [UIColor whiteColor];
            [JZLProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [JZLProgressHUD shareinstance].hud.customView = customImgView;
            [JZLProgressHUD shareinstance].hud.detailsLabel.textColor = [UIColor blackColor];
            break;
            
        case JZLProgressHUDModeSuccess:
            [JZLProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [JZLProgressHUD shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
            
        case JZLProgressHUDModeFail:
            [JZLProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [JZLProgressHUD shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fail"]];
            break;
        default:
            break;
    }
}

@end
