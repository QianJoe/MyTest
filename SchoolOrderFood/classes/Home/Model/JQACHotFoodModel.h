//
//  JQACHotFoodModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/31.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQACHotFoodModel : NSObject

/**食物图片*/
@property (nonatomic, copy) NSString *foodImgName;
/**食物名称*/
@property (nonatomic, copy) NSString *foodName;
/**食物简介*/
@property (nonatomic, copy) NSString *foodIntro;
/**价格*/
@property (nonatomic, copy) NSString *price;
/**食物地点*/
@property (nonatomic, copy) NSString *location;

@end
