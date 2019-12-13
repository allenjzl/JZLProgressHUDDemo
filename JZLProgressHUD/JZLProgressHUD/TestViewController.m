//
//  TestViewController.m
//  JZLProgressHUD
//
//  Created by allenjzl on 2019/12/13.
//  Copyright © 2019 canslife. All rights reserved.
//

#import "TestViewController.h"
#import "JZLProgressHUD/JZLProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *array = @[@"显示提示文字",@"显示提示文字(window上)",@"显示提示文字(自定义消失时间)", @"显示菊花(加载中)",@"显示环形(加载中)"];
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
//            [JZLProgressHUD showMessage:@"Hello World" onView:self.view];
            [JZLProgressHUD showMessage:@"123"];
            break;
            
        case 1:// 显示提示文字(window上)

            [JZLProgressHUD showMessage:@"Hello World" onView:nil];
            break;
            
        case 2:// 显示提示文字(自定义消失时间)
            [JZLProgressHUD shareInstance].HUDStyle = JZLProgressHUDStyleBlack;
            [JZLProgressHUD showMessage:@"Hello World"];
            break;
            
        case 3:// 显示菊花(加载中)
//            [JZLProgressHUD showLoadingWithMessage:@"加载中..." onView:self.view];
             [JZLProgressHUD showLoadingWithMessage:@"加载中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [JZLProgressHUD hide];
            });
            break;
            
        case 4:// 显示环形(加载中)
//            [JZLProgressHUD showCircleLoadingWithMessage:nil onView:self.view];
            [JZLProgressHUD showCircleLoadingWithMessage:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [JZLProgressHUD hide];
            });
            break;
       
            
        default:{

        }
            break;
    }
}

@end
