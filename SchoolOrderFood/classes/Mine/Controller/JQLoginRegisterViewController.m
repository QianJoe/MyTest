//
//  JQLoginRegisterViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/6.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQLoginRegisterViewController.h"
#import "JQLoginRegisterView.h"
#import <SVProgressHUD/SVProgressHUD.h>
//#import "JQPasswordConfirmViewController.h"
//#import "JQBasicNaviController.h"

@interface JQLoginRegisterViewController () <JQLoginRegisterViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleLeadingCons;

/**账号*/
@property (nonatomic, copy) NSString *username;
/**密码*/
@property (nonatomic, copy) NSString *password;

@end

@implementation JQLoginRegisterViewController


- (IBAction)close:(id)sender {
    
    // dismiss掉sp
    [SVProgressHUD dismiss];
    
    // 退出
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    
    sender.selected = !sender.selected;

    // 平移中间view
    _middleLeadingCons.constant = _middleLeadingCons.constant == 0? - self.middleView.frame.size.width * 0.3333 : 0;
    
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
    
    // 添加注册界面
    JQLoginRegisterView *registerView = [JQLoginRegisterView registerView];
    
    // 添加下一步view
    JQLoginRegisterView *finishView = [JQLoginRegisterView finishView];
    
    // 添加到中间的view
    [self.middleView addSubview:loginView];
    [self.middleView addSubview:registerView];
    [self.middleView addSubview:finishView];
    
    loginView.delegate = self;
    registerView.delegate = self;
    finishView.delegate = self;
}

#pragma mark - viewDidLayoutSubviews:才会根据布局调整控件的尺寸
- (void)viewDidLayoutSubviews {
    // 一定要调用super
    [super viewDidLayoutSubviews];
    
    // 设置登录view
    JQLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.frame.size.width * 0.3333, self.middleView.frame.size.height);
    
    // 设置注册view
    JQLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.frame.size.width * 0.3333, 0,self.middleView.frame.size.width * 0.3333, self.middleView.frame.size.height);

    JQLoginRegisterView *finishView = self.middleView.subviews[2];
    finishView.frame = CGRectMake(self.middleView.frame.size.width * 0.6666, 0,self.middleView.frame.size.width * 0.3333, self.middleView.frame.size.height);

}

#pragma mark - 登录界面的代码
// 用于登录和检测注册是否合法
- (void)loginRegisterView:(JQLoginRegisterView *)loginRegisterView clickLoginRegisterWithUserName:(NSString *)username withPwd:(NSString *)pwd withTag:(NSInteger)tag {
    // 提交登录
    JQLOG(@"%@----%@----%ld", username, pwd, tag);
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:BackgroundColor];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    
    if (tag) { // 1为注册
        
        if (![self isValidateEmail:username]) { // 账号是否是邮箱
            
            [SVProgressHUD showErrorWithStatus:@"邮箱格式错误，请好好检查邮箱格式"];
            
            return;
        }
        
        if (![self checkPassWord:pwd]) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入6-9位非纯数字密码"];
            
            return;
        }
        
        self.username = username;
        self.password = pwd;
        
//        JQPasswordConfirmViewController *pwdConVC= [[JQPasswordConfirmViewController alloc] init];
        
//        [self presentViewController:pwdConVC animated:YES completion:nil];
//        JQBasicNaviController *naviVc = [[JQBasicNaviController alloc] initWithRootViewController:pwdConVC];
        
        
//        [self.navigationController :naviVc animated:YES completion:nil];
        
        // 平移到完成界面
        self.middleLeadingCons.constant = - self.middleView.frame.size.width * 0.6666;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.view layoutIfNeeded];
        }];

        // 平移到完成界面
        
    } else { // 0为登录
        
        // 提交登录
//        JQLOG(@"%@----%@----%ld", username, pwd, tag);
        
        [SVProgressHUD showWithStatus:@"正在登录"];
        
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//           
//            
//            
//        });
        
        // afn本身就是异步，就不需要自己在写异步了
//        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// 提交注册
- (void)loginRegisterView:(JQLoginRegisterView *)loginRegisterView finshiRegisterWithConfirmPwd:(NSString *)confirmPwd {
    
//    JQLOG(@"------%@", confirmPwd);
    
    if (![confirmPwd isEqualToString:self.password]) { // 如果两次密码不一致
        
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致，请重新输如!"];
        
        return;
    }
    
    // 提交注册
    
    

}

// 判断 email 是否合理
- (BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z_]{6,11}@[A-Za-z0-9-]{1,15}\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 判断密码是否合理
- (BOOL)checkPassWord:(NSString *)pwd {
    
    //6-15位非纯数字组成
    NSString *regex = @"^(?![0-9]+$)[0-9A-Za-z]{6,15}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:pwd];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [SVProgressHUD dismiss];
//}

@end
