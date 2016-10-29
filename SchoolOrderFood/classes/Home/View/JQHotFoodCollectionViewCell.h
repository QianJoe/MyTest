//
//  JQHtoFoodCollectionViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/28.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQHotFoodModel;
UIKIT_EXTERN NSString * const CETID;

@interface JQHotFoodCollectionViewCell : UICollectionViewCell

/**热门食物的数据模型*/
@property (nonatomic, strong) JQHotFoodModel *hotFoodModel;

@end
