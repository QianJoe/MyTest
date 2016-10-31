//
//  JQHtoFoodCollectionViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/28.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHotFoodCollectionViewCell.h"
#import "JQHotFoodModel.h"

NSString * const CETID = @"CETID";

@interface JQHotFoodCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImg;
@property (weak, nonatomic) IBOutlet UIImageView *subImg1;
@property (weak, nonatomic) IBOutlet UIImageView *subImg2;
@property (weak, nonatomic) IBOutlet UIImageView *subImg3;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation JQHotFoodCollectionViewCell

- (void)awakeFromNib {
    
    // 圆角
    self.layer.cornerRadius = 5;
    self.mainImg.layer.cornerRadius = 3;
    self.subImg1.layer.cornerRadius = 2;
    self.subImg2.layer.cornerRadius = 2;
    self.subImg2.layer.cornerRadius = 2;

}

- (void)setHotFoodModel:(JQHotFoodModel *)hotFoodModel {
    
    _hotFoodModel = hotFoodModel;
    
    _mainImg.image = [UIImage imageNamed:hotFoodModel.mainImg];
    _subImg1.image = [UIImage imageNamed:hotFoodModel.subImg1];
    _subImg2.image = [UIImage imageNamed:hotFoodModel.subImg2];
    _subImg3.image = [UIImage imageNamed:hotFoodModel.subImg3];
    
    _titleLabel.text = hotFoodModel.title;
    _numLabel.text = hotFoodModel.number;
}

@end
