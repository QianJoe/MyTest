//
//  JQACHotFoodTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/31.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQACHotFoodTableViewCell.h"
#import "JQACHotFoodModel.h"

NSString * const ACHOTFOODCELLID = @"ACHOTFOODCELLID";

@interface JQACHotFoodTableViewCell ()

/**食物图片ImgView*/
@property (nonatomic, weak) UIImageView *foodImgView;
/**食物名称Label*/
@property (nonatomic, weak) UILabel *foodNameLabel;
/**食物简介Label*/
@property (nonatomic, weak) UILabel *foodIntroLabel;
/**价格Label*/
@property (nonatomic, weak) UILabel *priceLabel;
/**食物地点*/
@property (nonatomic, weak) UILabel *locationLabel;
/**地点图片*/
@property (nonatomic, weak) UIImageView *locaImg;

/**容器*/
@property (nonatomic, weak) UIView *backGroundView;

@end

@implementation JQACHotFoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self setViewAtuoLayout];
    }
    
    return self;
}

- (void)createUI {
    
    UIView *backGroundView = [[UIView alloc] init];
    self.backGroundView = backGroundView;
    [self.contentView addSubview:backGroundView];
    
    UIImageView *foodImgView = [[UIImageView alloc] init];
    [self.backGroundView addSubview:foodImgView];
    self.foodImgView = foodImgView;
    
    UILabel *foodNameLabel = [[UILabel alloc] init];
    [self.backGroundView addSubview:foodNameLabel];
    self.foodNameLabel = foodNameLabel;
    
    UILabel *foodIntroLabel = [[UILabel alloc] init];
    foodIntroLabel.numberOfLines = 0;
    foodIntroLabel.font = [UIFont systemFontOfSize:12.5];
    foodIntroLabel.textColor = [UIColor lightGrayColor];
    [self.backGroundView addSubview:foodIntroLabel];
    self.foodIntroLabel = foodIntroLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = JQHeavyGreen;
    priceLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [self.backGroundView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UIImageView *locaImg = [[UIImageView alloc] init];
    locaImg.image = [UIImage imageNamed:@"main_food"];
    [self.backGroundView addSubview:locaImg];
    self.locaImg = locaImg;
    
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.font = [UIFont systemFontOfSize:13];
    locationLabel.textColor = naviColor;
    [self.backGroundView addSubview:locationLabel];
    self.locationLabel = locationLabel;
    
}

- (void)setViewAtuoLayout {
    
    NSInteger margin = 5;
    NSInteger bottomMargin = 8;
    NSInteger imgW = 105;
    NSInteger imgH = 80;
    
    UIEdgeInsets padding = UIEdgeInsetsMake(margin, margin, margin, margin);
    [self.backGroundView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).insets(padding);
    }];
    
    [self.foodImgView makeConstraints:^(MASConstraintMaker *make) {
            
        make.top.left.equalTo(self.backGroundView).offset(margin);
        make.width.equalTo(imgW);
        make.height.equalTo(imgH);
        
    }];

    [self.foodNameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.foodImgView);
        make.left.equalTo(self.foodImgView.right).offset(margin);
        make.right.equalTo(self.backGroundView.right).offset(-30);
        
    }];

    [self.foodIntroLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.foodNameLabel.bottom).offset(1);
        make.left.right.equalTo(self.foodNameLabel);
    }];

    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.foodImgView.bottom);
        make.left.equalTo(self.foodNameLabel.left);
    
    }];

    [self.locationLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.priceLabel.centerY);
        make.right.equalTo(self.backGroundView.right).offset(-margin);
    }];
    
    [self.locaImg makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.priceLabel.centerY);
        make.right.equalTo(self.locationLabel.left).offset(2);
        make.width.height.equalTo(20);
    }];

    [self.backGroundView makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.foodImgView.bottom).offset(bottomMargin);
    }];
}

- (void)setAcHotFoodModel:(JQACHotFoodModel *)acHotFoodModel {
    
    _acHotFoodModel = acHotFoodModel;
    
    self.foodImgView.image = [UIImage imageNamed:acHotFoodModel.foodImgName];
    self.foodNameLabel.text = acHotFoodModel.foodName;
    self.foodIntroLabel.text = acHotFoodModel.foodIntro;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", acHotFoodModel.price];
    self.locationLabel.text = acHotFoodModel.location;
}

@end
