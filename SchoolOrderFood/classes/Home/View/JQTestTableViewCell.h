//
//  JQTestTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/29.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQACFoodModel;
UIKIT_EXTERN NSString * const TESTID;
@interface JQTestTableViewCell : UITableViewCell
/**热门食物的数据模型*/
@property (nonatomic, strong) JQACFoodModel *acFoodModel;

@end
