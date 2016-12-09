//
//  JQHttpRequestTool.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQHttpRequestTool : NSObject
+ (instancetype)shareHttpRequestTool;

- (void)runRequestWithPara:(NSMutableDictionary *)para
                      path:(NSString *)path
                   success:(void(^)(id responseObject))success
                   failure:(void(^)(id error))failure;
@end
