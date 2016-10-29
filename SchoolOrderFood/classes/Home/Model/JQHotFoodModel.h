//
//  JQHotFoodModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/29.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQHotFoodModel : NSObject

/**主要图片名称*/
@property (nonatomic, copy) NSString *mainImg;
/**小图片1*/
@property (nonatomic, copy) NSString *subImg1;
/**小图片2*/
@property (nonatomic, copy) NSString *subImg2;
/**小图片3*/
@property (nonatomic, copy) NSString *subImg3;

/**标题*/
@property (nonatomic, copy) NSString *title;
/**数量*/
@property (nonatomic, copy) NSString *number;
@end
