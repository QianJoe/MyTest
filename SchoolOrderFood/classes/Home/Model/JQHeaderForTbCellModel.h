//
//  JQHeaderForTbCellModel.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQHeaderForTbCellModel : NSObject

/**图片名称*/
@property (nonatomic, copy) NSString *imgName;
/**标题名称*/
@property (nonatomic, copy) NSString *title;

//两种实例化方法
- (instancetype)initWithImgName:(NSString *)imgName title:(NSString *)title;
+ (instancetype)headerForTbCellModelWithImgName:(NSString *)imgName title:(NSString *)title;

@end
