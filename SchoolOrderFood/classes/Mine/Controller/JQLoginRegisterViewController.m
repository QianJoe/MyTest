//
//  JQLoginRegisterViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/6.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQLoginRegisterViewController.h"
#import "JQLoginRegisterView.h"

@interface JQLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleLeadingCons;

@end

@implementation JQLoginRegisterViewController


- (IBAction)close:(id)sender {
    
    // 退出
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    // 平移中间view

    _middleLeadingCons.constant = _middleLeadingCons.constant == 0? - self.middleView.frame.size.width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 状态栏改成亮白色
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    
//    return UIStatusBarStyleLightContent;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建登录view
    JQLoginRegisterView *loginView = [JQLoginRegisterView loginView];
    // 添加到中间的view
    [self.middleView addSubview:loginView];
    
    // 添加注册界面
    JQLoginRegisterView *registerView = [JQLoginRegisterView registerView];
    
    // 添加到中间的view
    [self.middleView addSubview:registerView];
}

// viewDidLayoutSubviews:才会根据布局调整控件的尺寸
- (void)viewDidLayoutSubviews {
    // 一定要调用super
    [super viewDidLayoutSubviews];
    
    // 设置登录view
    JQLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.frame.size.width * 0.5, self.middleView.frame.size.height);
    
    // 设置注册view
    JQLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake( self.middleView.frame.size.width * 0.5, 0,self.middleView.frame.size.width * 0.5, self.middleView.frame.size.height);
    
}


@end
