//
//  JQFoodTotalModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/21.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQFoodTotalModel : NSObject

/**id*/
@property (nonatomic, assign) int food_id;

/**image*/
@property (nonatomic, copy) NSString *image;

/**name*/
@property (nonatomic, copy) NSString *name;

/**money*/
@property (nonatomic, copy) NSString *money;

/**购买的数量*/
@property (nonatomic, assign) NSInteger count;

/**是否减少*/
@property (nonatomic, assign) NSInteger minus;

/**是否被选中*/
@property (nonatomic, assign, getter=isChecked) BOOL check;

@end
