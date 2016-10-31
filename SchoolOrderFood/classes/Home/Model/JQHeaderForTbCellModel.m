//
//  JQHeaderForTbCellModel.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/30.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHeaderForTbCellModel.h"

@implementation JQHeaderForTbCellModel

- (instancetype)initWithImgName:(NSString *)imgName title:(NSString *)title {
    
    if (self = [super init]) {
        _imgName = imgName;
        _title = title;
    }
    
    return self;
}


+ (instancetype)headerForTbCellModelWithImgName:(NSString *)imgName title:(NSString *)title{
    
    return [[self alloc] initWithImgName:imgName title:title];
}

@end
