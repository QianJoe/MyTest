//
//  JQMineTakeDetailViewController.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQFoodTotalModel;

@interface JQMineTakeDetailViewController : UIViewController
/**持有一个foodTotalModel*/
@property (nonatomic, strong) JQFoodTotalModel *foodTotalModel;

@end
