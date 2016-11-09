//
//  JQPronvice.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQProvince : NSObject

/**省名*/
@property (nonatomic, copy) NSString *name;

/**市的*/
@property (nonatomic, strong) NSArray *cities;

@end
