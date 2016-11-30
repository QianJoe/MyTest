//
//  JQShopCarTool.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQShopCarTool.h"
#import "JQFoodTotalModel.h"
#import "NSString+Extension.h"

@implementation JQShopCarTool

#pragma mark - 单例
+ (instancetype)sharedInstance {
    
    static dispatch_once_t one;
    static JQShopCarTool *shopCarTool;
    
    dispatch_once(&one, ^{
        
        if (shopCarTool == nil) {
            
            shopCarTool = [[JQShopCarTool alloc] init];
        }
    });
    
    return shopCarTool;
}

#pragma mark - 添加商品
- (void)addFoodToShopCar:(JQFoodTotalModel *)foodTotalModel {
    
//    if (![self.shopCar containsObject:foodTotalModel]) { // 如果购物车中没有
//        
//        // 添加
//        [self.shopCar addObject:foodTotalModel];
//        foodTotalModel.count = 1;
//        // 默认是选中的
//        foodTotalModel.check = YES;
//
//    } else { // 有了，数量就++
//        
//        foodTotalModel.count ++;
//    }
    
    [JQNotification postNotificationName:JQFoodChangedNotification object:self userInfo:nil];
    
    for (JQFoodTotalModel *ftModel in self.shopCar) {
        
        if (foodTotalModel.food_id == ftModel.food_id) { // 用food_id判断是否已存在购物车中
            
            // 如果存在，就将购物车里原本的数量加1
            ftModel.count ++;
            return;
        }
    }
    
    // 否则就添加到购物车里
    [self.shopCar addObject:foodTotalModel];
    foodTotalModel.count = 1;
    // 默认是选中的
    foodTotalModel.check = YES;
    
}

#pragma mark - 删除商品
- (void)removeFromFoodShopCar:(JQFoodTotalModel *)foodTotalModel {
    
//    if (!foodTotalModel.count) { // 如果有
//        
//        [self.shopCar removeObject:foodTotalModel];
//        
//    } else {
//        
//        foodTotalModel.count --;
//        
//        if (foodTotalModel.count == 0) {
//            
//            [self.shopCar removeObject:foodTotalModel];
//
//        }
//    }
    
    
    
    [JQNotification postNotificationName:JQFoodChangedNotification object:self userInfo:nil];
    
    for (JQFoodTotalModel *ftModel in self.shopCar) {
        
        if (foodTotalModel.food_id == ftModel.food_id) { // 用food_id判断是否已存在购物车中
            
            // 如果存在，就将购物车里原本的数量减1
            ftModel.count --;
            
            if (ftModel.count == 0) {
                
                [self.shopCar removeObject:foodTotalModel];
            }
            
            return;
        }
    }
    
    // 否则就从购物车中移除
    [self.shopCar removeObject:foodTotalModel];
}

#pragma mark - 获取食物的数量
- (NSInteger)getShopCarFoodNumber {
    
    __block NSInteger count = 0;
    
    [self.shopCar enumerateObjectsUsingBlock:^(JQFoodTotalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        count += obj.count;
    }];
    return count;
}

#pragma mark - 获取食物用价格
- (CGFloat)getShopCarTotalPrice {

    __block CGFloat price = 0;
    
    [self.shopCar enumerateObjectsUsingBlock:^(JQFoodTotalModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        price += [[obj.money cleanDecimalPointZear] doubleValue] * obj.count;
        price += [obj.money integerValue] * obj.count;

//        JQLOG(@"count:%ld---getShopCarTotalPrice:%.2f", obj.count, price);
    }];
    
    return price;
}

#pragma mark - 是否购物车为空
- (BOOL)isEmpty {
    
    return self.shopCar.count == 0;
}

- (NSMutableArray<JQFoodTotalModel *> *)shopCar {
    
    if (!_shopCar) {
        
        _shopCar = [NSMutableArray array];
    }
    return  _shopCar;
}
@end