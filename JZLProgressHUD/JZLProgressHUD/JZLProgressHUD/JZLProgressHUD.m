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
+(instancetype)shareInstance{
    static JZLProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        instance = [[JZLProgressHUD alloc] init];
        instance.HUDStyle = JZLProgressHUDStyleBlack;
    });
    return instance;
}




/// 只显示文字(显示在window上)
/// @param message 要显示的文字
+(void)showMessage:(nullable NSString *)message {
    [self show:message onView:nil hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:1.5];
}
/// 只显示文字
/// @param message 要显示的文字
/// @param view   要显示的view
+(void)showMessage:(nullable NSString *)message onView:(nullable UIView *)view{
    [self show:message onView:view hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:1.5];
}


/// 显示文字,自定义消失时间(显示在window上)
/// @param message 要显示的文字
/// @param delay 时间
+(void)showMessage:(nullable NSString *)message afterDelayTime:(NSTimeInterval)delay{
    [self show:message onView:nil hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:delay];
}
/// 显示文字,自定义消失时间
/// @param message 要显示的文字
/// @param view 要显示的view
/// @param delay 时间
+(void)showMessage:(nullable NSString *)message onView:(nullable UIView *)view afterDelayTime:(NSTimeInterval)delay{
    [self show:message onView:view hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:delay];
}


/// 成功提示(显示在window上)
/// @param message 要显示的文字
+(void)showSuccessWithMessage:(nullable NSString *)message {
    [self show:message onView:nil hudMode:JZLProgressHUDModeSuccess];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:1.5];
}
/// 成功提示
/// @param message 要显示的文字
/// @param view 要显示的view
+(void)showSuccessWithMessage:(nullable NSString *)message onView:(nullable UIView *)view{
    [self show:message onView:view hudMode:JZLProgressHUDModeSuccess];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:1.5];
}


/// 失败提示(显示在window上)
/// @param message 要显示的文字
+(void)showFailWithMessage:(nullable NSString *)message{
    [self show:message onView:nil hudMode:JZLProgressHUDModeFail];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:1.5];
}
/// 失败提示
/// @param message 要显示的文字
/// @param view 要显示的view
+(void)showFailWithMessage:(nullable NSString *)message onView:(nullable UIView *)view{
    [self show:message onView:view hudMode:JZLProgressHUDModeFail];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:1.5];
}


/// 自定义图片显示(显示在window上)
/// @param message 要显示的文字
/// @param imageName 要显示的图片
+(void)showMessage:(nullable NSString *)message imageName:(NSString *)imageName{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:message onView:nil hudMode:JZLProgressHUDModeCustomerImage customImgView:imgView];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:1.5];
}
/// 自定义图片显示
/// @param message 要显示的文字
/// @param imageName 要显示的图片
/// @param view 要显示的view
+(void)showMessage:(nullable NSString *)message imageName:(NSString *)imageName onView:(nullable UIView *)view{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:message onView:view hudMode:JZLProgressHUDModeCustomerImage customImgView:imgView];
    [[JZLProgressHUD shareInstance].hud hideAnimated:YES afterDelay:1.5];
}


/// 显示动画(显示在window上)
/// @param message 要显示的文字
/// @param imgArry 帧动画数组
+(void)showCustomAnimationWithMessage:(nullable NSString *)message withImageArry:(NSArray *)imgArry{
    UIImageView *imgView = [[UIImageView alloc] init];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imageString in imgArry) {
        [imageArray addObject:[UIImage imageNamed:imageString]];
    }
    imgView.animationImages = imageArray;
    [imgView setAnimationRepeatCount:0];
    [imgView setAnimationDuration:imgArry.count  * 0.25];
    [imgView startAnimating];
    [self show:message onView:nil hudMode:JZLProgressHUDModeCustomAnimation customImgView:imgView];
}
/// 显示动画
/// @param message 要显示的文字
/// @param imgArry 帧动画数组
/// @param view 要显示的view
+(void)showCustomAnimationWithMessage:(nullable NSString *)message withImageArry:(NSArray *)imgArry onView:(nullable UIView *)view{
    UIImageView *imgView = [[UIImageView alloc] init];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imageString in imgArry) {
        [imageArray addObject:[UIImage imageNamed:imageString]];
    }
    imgView.animationImages = imageArray;
    [imgView setAnimationRepeatCount:0];
    [imgView setAnimationDuration:imgArry.count  * 0.25];
    [imgView startAnimating];
    [self show:message onView:view hudMode:JZLProgressHUDModeCustomAnimation customImgView:imgView];
}


/// 显示下载上传进度
/// @param message 要显示的文字
/// @param progress 进度
/// @param view 要显示的view
+(void)showProgressWithMessage:(nullable NSString *)message progress:(double)progress onView:(nullable UIView *)view{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([JZLProgressHUD shareInstance].hud == nil) {
            [JZLProgressHUD shareInstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
        
        [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeAnnularDeterminate;
        // 设置背景颜色
        if ([JZLProgressHUD shareInstance].HUDStyle == JZLProgressHUDStyleBlack) {
            [JZLProgressHUD shareInstance].hud.bezelView.color = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
            [JZLProgressHUD shareInstance].hud.contentColor = [UIColor whiteColor];
            [JZLProgressHUD shareInstance].hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        }else {
            [JZLProgressHUD shareInstance].hud.contentColor = [UIColor blackColor];
        }
        [[JZLProgressHUD shareInstance].hud setMargin:20];
        [[JZLProgressHUD shareInstance].hud setRemoveFromSuperViewOnHide:YES];
        [JZLProgressHUD shareInstance].hud.detailsLabel.text = message == nil ? @"" : message;
        [JZLProgressHUD shareInstance].hud.detailsLabel.font = [UIFont systemFontOfSize:16];
        [JZLProgressHUD shareInstance].hud.progress = progress;
        if (progress >= 1) {
            [[JZLProgressHUD shareInstance].hud hideAnimated:YES];
            [JZLProgressHUD shareInstance].hud = nil;
        }
    });
    
}
/// 显示下载上传进度
/// @param message 要显示的文字
/// @param progress 进度
+(void)showProgressWithMessage:(nullable NSString *)message progress:(double)progress {
    UIView *view = (UIView*)[UIApplication sharedApplication].delegate.window;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([JZLProgressHUD shareInstance].hud == nil) {
            [JZLProgressHUD shareInstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
        
        [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeAnnularDeterminate;
        // 设置背景颜色
        if ([JZLProgressHUD shareInstance].HUDStyle == JZLProgressHUDStyleBlack) {
            [JZLProgressHUD shareInstance].hud.bezelView.color = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
            [JZLProgressHUD shareInstance].hud.contentColor = [UIColor whiteColor];
            [JZLProgressHUD shareInstance].hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        }else {
            [JZLProgressHUD shareInstance].hud.contentColor = [UIColor blackColor];
        }
        [[JZLProgressHUD shareInstance].hud setMargin:20];
        [[JZLProgressHUD shareInstance].hud setRemoveFromSuperViewOnHide:YES];
        [JZLProgressHUD shareInstance].hud.detailsLabel.text = message == nil ? @"" : message;
        [JZLProgressHUD shareInstance].hud.detailsLabel.font = [UIFont systemFontOfSize:16];
        [JZLProgressHUD shareInstance].hud.progress = progress;
        if (progress >= 1) {
            [[JZLProgressHUD shareInstance].hud hideAnimated:YES];
            [JZLProgressHUD shareInstance].hud = nil;
        }
    });
}


/// 显示正在加载菊花(显示在window上)
/// @param message 要显示的文字
+(void)showLoadingWithMessage:(nullable NSString *)message{
    [self show:message onView:nil hudMode:JZLProgressHUDModeLoading];
}
/// 显示正在加载菊花
/// @param message 要显示的文字
/// @param view 要显示的view
+(void)showLoadingWithMessage:(nullable NSString *)message onView:(nullable UIView *)view{
    [self show:message onView:view hudMode:JZLProgressHUDModeLoading];
}


/// 显示正在加载圆圈(显示在window上)
/// @param message 要显示的文字
+(void)showCircleLoadingWithMessage:(nullable NSString *)message{
    [self show:message onView:nil hudMode:JZLProgressHUDModeCircle];
}
/// 显示正在加载圆圈
/// @param message 要显示的文字
/// @param view 要显示的view
+(void)showCircleLoadingWithMessage:(nullable NSString *)message onView:(nullable UIView *)view{
    [self show:message onView:view hudMode:JZLProgressHUDModeCircle];
    
}


+ (void)hide {
    if ([JZLProgressHUD shareInstance].hud != nil) {
        [[JZLProgressHUD shareInstance].hud hideAnimated:YES];
    }
}



- (void)setHUDStyle:(JZLProgressHUDStyle)HUDStyle {
    _HUDStyle = HUDStyle;
    
}



+ (void)show:(nullable NSString *)message onView:(nullable UIView *)view hudMode:(JZLProgressHUDMode)hudMode  {
    [self show:message onView:view hudMode:hudMode customImgView:nil];
    
}

+ (void)show:(nullable NSString *)message onView:(nullable UIView *)view hudMode:(JZLProgressHUDMode)hudMode customImgView:(UIImageView *)customImgView{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    dispatch_async(dispatch_get_main_queue(), ^{
        // 如果当前存在,则先消失
        if ([JZLProgressHUD shareInstance].hud != nil) {
            [[JZLProgressHUD shareInstance].hud hideAnimated:YES];
            [JZLProgressHUD shareInstance].hud = nil;
        }
        
        [JZLProgressHUD shareInstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        // 设置背景颜色
        if ([JZLProgressHUD shareInstance].HUDStyle == JZLProgressHUDStyleBlack) {
            [JZLProgressHUD shareInstance].hud.bezelView.color = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
            [JZLProgressHUD shareInstance].hud.contentColor = [UIColor whiteColor];
            [JZLProgressHUD shareInstance].hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        }else {
            [JZLProgressHUD shareInstance].hud.contentColor = [UIColor blackColor];
        }
        
        [[JZLProgressHUD shareInstance].hud setMargin:20];
        [[JZLProgressHUD shareInstance].hud setRemoveFromSuperViewOnHide:YES];
        [JZLProgressHUD shareInstance].hud.detailsLabel.text = message == nil ? @"" : message;
        [JZLProgressHUD shareInstance].hud.detailsLabel.font = [UIFont systemFontOfSize:16];
        switch (hudMode) {
            case JZLProgressHUDModeTextOnly://只显示文字
                [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeText;
                break;
                
            case JZLProgressHUDModeLoading://加载菊花
                [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeIndeterminate;
                break;
                
            case JZLProgressHUDModeCircle:{//加载环形
                [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeCustomView;
                UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
                CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
                animation.toValue = [NSNumber numberWithFloat:M_PI*2];
                animation.duration = 1.0;
                animation.repeatCount = 100;
                [img.layer addAnimation:animation forKey:nil];
                [JZLProgressHUD shareInstance].hud.customView = img;
            }
                break;
                
            case JZLProgressHUDModeCustomerImage://自定义图片
                [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeCustomView;
                [JZLProgressHUD shareInstance].hud.customView = customImgView;
                break;
                
            case JZLProgressHUDModeCustomAnimation://自定义帧动画
                //这里设置动画的背景色
                //            [JZLProgressHUD shareInstance].hud.bezelView.color = [UIColor whiteColor];
                [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeCustomView;
                [JZLProgressHUD shareInstance].hud.customView = customImgView;
                //            [JZLProgressHUD shareInstance].hud.detailsLabel.textColor = [UIColor blackColor];
                break;
                
            case JZLProgressHUDModeSuccess:{
                [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeCustomView;
                UIImageRenderingMode renderMode = [JZLProgressHUD shareInstance].HUDStyle == JZLProgressHUDStyleBlack ? UIImageRenderingModeAlwaysOriginal : UIImageRenderingModeAlwaysTemplate;
                UIImage *image = [[UIImage imageNamed:@"success"] imageWithRenderingMode:renderMode];
                UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
                [JZLProgressHUD shareInstance].hud.customView = imgView;
            }
                break;
                
            case JZLProgressHUDModeFail:{
                [JZLProgressHUD shareInstance].hud.mode = MBProgressHUDModeCustomView;
                UIImageRenderingMode renderMode = [JZLProgressHUD shareInstance].HUDStyle == JZLProgressHUDStyleBlack ? UIImageRenderingModeAlwaysOriginal : UIImageRenderingModeAlwaysTemplate;
                UIImage *image = [[UIImage imageNamed:@"fail"] imageWithRenderingMode:renderMode];
                UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
                [JZLProgressHUD shareInstance].hud.customView = imgView;
            }
                break;
            default:
                break;
        }
    });
    
}

@end
