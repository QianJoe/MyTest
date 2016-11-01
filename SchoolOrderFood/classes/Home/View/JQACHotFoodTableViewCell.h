//
//  JQACHotFoodTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/31.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQACHotFoodModel;
UIKIT_EXTERN NSString * const ACHOTFOODCELLID;
@interface JQACHotFoodTableViewCell : UITableViewCell

/**热门活动热门食物*/
@property (nonatomic, strong) JQACHotFoodModel *acHotFoodModel;

@end
