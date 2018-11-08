//
//  ViewController.m
//  JZLProgressHUD
//
//  Created by allenjzl on 2018/11/8.
//  Copyright © 2018 canslife. All rights reserved.
//

#import "ViewController.h"
#import "JZLProgressHUD/JZLProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong)  MBProgressHUD *hud;
@property (nonatomic, assign) double progress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"显示提示文字",@"显示提示文字(window上)",@"显示提示文字(自定义消失时间)", @"显示菊花(加载中)",@"显示环形(加载中)",@"下载进度",@"成功",@"失败",@"自定义动画+文字",@"自定义图片+文字"];
    for (int i =0; i < array.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 100 + i * 30, 300, 25)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:// 显示提示文字
            [JZLProgressHUD showMessage:@"Hello World" inView:self.view];
            break;
            
        case 1:// 显示提示文字(window上)
            [JZLProgressHUD showMessage:@"Hello World" inView:nil];
            break;
            
        case 2:// 显示提示文字(自定义消失时间)
            [JZLProgressHUD showMessage:@"Hello World" inView:self.view afterDelayTime:3];
            break;
            
        case 3:// 显示菊花(加载中)
            [JZLProgressHUD showLoadingWithMsg:@"加载中..." inView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [JZLProgressHUD hide];
            });
            break;
            
        case 4:// 显示环形(加载中)
            [JZLProgressHUD showCircleLoadingWithMsg:nil inView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [JZLProgressHUD hide];
            });
            break;
            
        case 5:{// 下载进度
            self.hud = [JZLProgressHUD showDownloadProgressWithMsg:@"下载中..." inView:self.view];
            self.progress = 0.0f;
           self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(downloadProgress) userInfo:nil repeats:YES];
            
        }
            break;
            
        case 6:// 成功
            [JZLProgressHUD showSuccessWithMsg:@"加载成功" inview:self.view];
            break;
            
        case 7:// 失败
            [JZLProgressHUD showFailWithMsg:@"加载失败" inview:self.view];

            break;
            
        case 8:{// 自定义动画
            NSMutableArray *imageArr = [NSMutableArray array];
            for (int i =1; i <= 4; i++) {
                [imageArr addObject:[NSString stringWithFormat:@"0%d.png",i]];
            }
            //如果不需要文字,msg传nil即可
            [JZLProgressHUD showCustomAnimationWithMsg:@"loading" withImageArry:imageArr inview:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [JZLProgressHUD hide];
            });
        }
            break;
            
        case 9:{// 自定义图片 如果不需要文字,msg传nil即可
            [JZLProgressHUD showMsg:@"自定义图片" imageName:@"success" inview:self.view];
        }
            break;
            
        default:
            break;
    }
}

- (void)downloadProgress {
    if (self.progress >= 1.0f) {
        [self.hud hideAnimated:YES];
        self.hud = nil;
        [self.timer invalidate];
        self.timer = nil;
        
    }else {
        self.progress = self.progress + 0.1;
        self.hud.progress = self.progress;
    }

}


@end
