//
//  JQHeaderForTableViewCell.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/29.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHeaderForTableViewCell.h"
#import "JQHeaderForTbCellModel.h"


@interface JQHeaderForTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JQHeaderForTableViewCell

#pragma mark - 从nib中加载出控件
+ (instancetype)headerForTableViewCel {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"JQHeaderForTableViewCell" owner:nil options:nil] lastObject];
}

#pragma mark - 重写set方法，来赋值
- (void)setHeaderForTbCellModel:(JQHeaderForTbCellModel *)headerForTbCellModel {
    
    _headerForTbCellModel = headerForTbCellModel;
    
    _imgView.image = [UIImage imageNamed:headerForTbCellModel.imgName];
    
    _titleLabel.text = headerForTbCellModel.title;
}

@end
