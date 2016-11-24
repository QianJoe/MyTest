//
//  JQShopIntroViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/19.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQShopIntroViewController.h"
#import "JQShopIntroModel.h"

@interface JQShopIntroViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportLabel;

@end

@implementation JQShopIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneNumLabel.text = _shopIntroModel.phone;
    self.locationLabel.text = _shopIntroModel.location;
    self.categoryLabel.text = _shopIntroModel.category;
    self.timeLabel.text = _shopIntroModel.time;
}



@end
