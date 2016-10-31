//
//  JQHotShopModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQHotShopModel : NSObject

/**商店图片*/
@property (nonatomic, copy) NSString *shopImgName;
/**商店名称*/
@property (nonatomic, copy) NSString *shopName;
/**商店简介*/
@property (nonatomic, copy) NSString *shopIntro;
/**平均价格*/
@property (nonatomic, copy) NSString *price;

@end
