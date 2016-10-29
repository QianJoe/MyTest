//
//  JQBasicNaviController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQBasicNaviController.h"
#import "UIImage+Image.h"

@interface JQBasicNaviController ()

@end

@implementation JQBasicNaviController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *navBackImg = [UIImage imageWithColor:naviColor];
    
    [self.navigationBar setBackgroundImage:navBackImg forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 状态栏改成亮白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end
