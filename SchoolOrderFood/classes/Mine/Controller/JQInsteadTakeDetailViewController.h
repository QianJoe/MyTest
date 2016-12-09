//
//  JQInsteadTakeDetailViewController.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/4.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JQMineBaseViewController.h"
@class JQFoodTotalModel;

@interface JQInsteadTakeDetailViewController : JQMineBaseViewController

/**持有一个foodTotalModel*/
@property (nonatomic, strong) JQFoodTotalModel *foodTotalModel;

@end
