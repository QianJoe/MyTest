//
//  JQHeaderForTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/29.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JQHeaderForTbCellModel;

@interface JQHeaderForTableViewCell : UIView

/**每一组的头header内容数据模型*/
@property (nonatomic, strong) JQHeaderForTbCellModel *headerForTbCellModel;

/**创建控件的类方法*/
+ (instancetype)headerForTableViewCel;

@end
