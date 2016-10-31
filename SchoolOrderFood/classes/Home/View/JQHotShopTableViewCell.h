//
//  JQHotShopTableViewCell.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const HOTSHOPCELLID;
@class JQHotShopModel;

@interface JQHotShopTableViewCell : UITableViewCell

/**热门商店数据模型*/
@property (nonatomic, strong) JQHotShopModel *hotShopModel;

@end
