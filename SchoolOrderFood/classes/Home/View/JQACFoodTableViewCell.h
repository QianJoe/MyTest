//
//  JQACFoodTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/28.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQACFoodModel;
UIKIT_EXTERN NSString * const ACCELLID;

@interface JQACFoodTableViewCell : UITableViewCell

/**精品活动食物的数据模型*/
@property (nonatomic, strong) JQACFoodModel *acFoodModel;
@end
