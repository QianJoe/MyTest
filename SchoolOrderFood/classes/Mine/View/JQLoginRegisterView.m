//
//  JQLoginRegisterView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/6.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQLoginRegisterView.h"

@interface JQLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation JQLoginRegisterView

- (void)awakeFromNib {
    
    self.loginRegisterBtn.layer.cornerRadius = 5;
    self.loginRegisterBtn.clipsToBounds = YES;
    
}

+ (instancetype)loginView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
