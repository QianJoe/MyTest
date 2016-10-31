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
@property (nonatomic, weak) UIImageView *imgView;
/**商家名称Label*/
@property (nonatomic, weak) UILabel *shopNameLabel;
/**商家简介Label*/
@property (nonatomic, weak) UILabel *shopIntroLabel;
/**平均价格Label*/
@property (nonatomic, weak) UILabel *priceLabel;

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
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UILabel *shopIntroLabel = [[UILabel alloc] init];
    shopIntroLabel.font = [UIFont systemFontOfSize:12.5];
    shopIntroLabel.textColor = [UIColor lightGrayColor];
    shopIntroLabel.numberOfLines = 0;
    
    [self.contentView addSubview:shopIntroLabel];
    self.shopIntroLabel = shopIntroLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = JQHeavyGreen;
    priceLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [self.contentView addSubview:priceLabel];
    self.priceLabel = priceLabel;
}

- (void)setViewAtuoLayout {
    
    NSInteger margin = 8;

    NSInteger bottomMargin = 3;
    NSInteger imgW = 105;
    NSInteger imgH = 80;
    
    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self.contentView).offset(margin);
//        make.bottom.equalTo(self.contentView.bottom).offset(-margin);
        make.width.equalTo(imgW);
        make.height.equalTo(imgH);
    }];
    
    [self.shopNameLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.imgView);
        make.left.equalTo(self.imgView.right).offset(margin);
        make.width.equalTo(230);
        
//        make.right.mas_equalTo(self.contentView).offset(-margin);
        
    }];
    
    [self.shopIntroLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.shopNameLabel.bottom).offset(margin - 1.5);
        make.left.right.equalTo(self.shopNameLabel);
        
    }];
    
    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.imgView.bottom);
        make.left.equalTo(self.shopNameLabel.left);

    }];
    
    [self.contentView updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.priceLabel.bottom).offset(bottomMargin);
    }];
}

- (void)setHotShopModel:(JQHotShopModel *)hotShopModel {
    
    _hotShopModel = hotShopModel;
    
    self.imgView.image = [UIImage imageNamed:hotShopModel.shopImgName];
    self.shopNameLabel.text = hotShopModel.shopName;
    self.shopIntroLabel.text = hotShopModel.shopIntro;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", hotShopModel.price];
}

@end
