//
//  JQHotShopTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHotShopTableViewCell.h"
#import "JQHotShopModel.h"
NSString * const HOTSHOPCELLID = @"HOTSHOPCELLID";

@interface JQHotShopTableViewCell ()

/**商家图片ImgView*/
@property (nonatomic, weak) UIImageView *shopImgView;
/**商家名称Label*/
@property (nonatomic, weak) UILabel *shopNameLabel;
/**商家简介Label*/
@property (nonatomic, weak) UILabel *shopIntroLabel;
/**平均价格Label*/
@property (nonatomic, weak) UILabel *priceLabel;
/**容器*/
@property (nonatomic, weak) UIView *backGroundView;

@end

@implementation JQHotShopTableViewCell

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
    
    UIImageView *shopImgView = [[UIImageView alloc] init];
    [self.backGroundView addSubview:shopImgView];
    self.shopImgView = shopImgView;
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    [self.backGroundView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UILabel *shopIntroLabel = [[UILabel alloc] init];
    shopIntroLabel.font = [UIFont systemFontOfSize:12.5];
    shopIntroLabel.textColor = [UIColor lightGrayColor];
    shopIntroLabel.numberOfLines = 0;
    [self.backGroundView addSubview:shopIntroLabel];
    self.shopIntroLabel = shopIntroLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = JQHeavyGreen;
    priceLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [self.backGroundView addSubview:priceLabel];
    self.priceLabel = priceLabel;
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
    
    [self.shopImgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self.backGroundView).offset(margin);
        make.width.equalTo(imgW);
        make.height.equalTo(imgH);
    }];
    
    [self.shopNameLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.shopImgView);
        make.left.equalTo(self.shopImgView.right).offset(margin);
        make.right.equalTo(self.backGroundView.right).offset(-30);

        
    }];
    
    [self.shopIntroLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.shopNameLabel.bottom).offset(1);
        make.left.right.equalTo(self.shopNameLabel);
        
    }];
    
    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.shopImgView.bottom);
        make.left.equalTo(self.shopNameLabel.left);

    }];
    
    [self.backGroundView updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.shopImgView.bottom).offset(bottomMargin);
    }];
}

- (void)setHotShopModel:(JQHotShopModel *)hotShopModel {
    
    _hotShopModel = hotShopModel;
    
    self.shopImgView.image = [UIImage imageNamed:hotShopModel.shopImgName];
    self.shopNameLabel.text = hotShopModel.shopName;
    self.shopIntroLabel.text = hotShopModel.shopIntro;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", hotShopModel.price];
}

@end
