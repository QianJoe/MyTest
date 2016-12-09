//
//  JQMineTakeTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQFoodTotalModel;

UIKIT_EXTERN NSString * const MINETAKETABLEVIEWCELLID;

@interface JQMineTakeTableViewCell : UITableViewCell
/**持有一个foodtotalModel*/
@property (nonatomic, strong) JQFoodTotalModel *foodTotalModel;

@end
