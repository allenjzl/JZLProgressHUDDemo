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


+(void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}


+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSTimeInterval)delay{
    [self show:msg inView:view hudMode:JZLProgressHUDModeTextOnly];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:delay];
}

+(void)showSuccessWithMsg:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view hudMode:JZLProgressHUDModeSuccess];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}

+(void)showFailWithMsg:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view hudMode:JZLProgressHUDModeFail];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}

+(void)showMsg:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg inView:view hudMode:JZLProgressHUDModeCustomerImage customImgView:imgView];
    [[JZLProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.5];
}

+(void)showCustomAnimationWithMsg:(NSString *)msg withImageArry:(NSArray *)imgArry inview:(UIView *)view{
    UIImageView *imgView = [[UIImageView alloc] init];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imageString in imgArry) {
        [imageArray addObject:[UIImage imageNamed:imageString]];
    }
    imgView.animationImages = imageArray;
    [imgView setAnimationRepeatCount:0];
    [imgView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [imgView startAnimating];
    [self show:msg inView:view hudMode:JZLProgressHUDModeCustomAnimation customImgView:imgView];
}

+(MBProgressHUD *)showDownloadProgressWithMsg:(NSString *)msg inView:(UIView *)view{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = msg;
    return hud;
}

+(void)showLoadingWithMsg:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view hudMode:JZLProgressHUDModeLoading];
}

+(void)showCircleLoadingWithMsg:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view hudMode:JZLProgressHUDModeCircle];
    
}




+ (void)hide {
    if ([JZLProgressHUD shareinstance].hud != nil) {
        [[JZLProgressHUD shareinstance].hud hideAnimated:YES];
    }
}



+ (void)show:(NSString *)msg inView:(nullable UIView *)view hudMode:(JZLProgressHUDMode)hudMode  {
    [self show:msg inView:view hudMode:hudMode customImgView:nil];
    
}

+ (void)show:(NSString *)msg inView:(UIView *)view hudMode:(JZLProgressHUDMode)hudMode customImgView:(UIImageView *)customImgView{
    // 如果当前存在,则先消失
    if ([JZLProgressHUD shareinstance].hud != nil) {
        [[JZLProgressHUD shareinstance].hud hideAnimated:YES];
        [JZLProgressHUD shareinstance].hud = nil;
    }
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [JZLProgressHUD shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置黑色背景
    [JZLProgressHUD shareinstance].hud.bezelView.color = [UIColor blackColor];
    [JZLProgressHUD shareinstance].hud.contentColor = [UIColor whiteColor];
    [[JZLProgressHUD shareinstance].hud setMargin:10];
    [[JZLProgressHUD shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [JZLProgressHUD shareinstance].hud.detailsLabel.text = msg;
    [JZLProgressHUD shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:14];
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
