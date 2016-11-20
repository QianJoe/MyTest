//
//  NSString+Extension.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/14.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
}
@end