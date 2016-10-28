//
//  JQContainerView.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQContainerView.h"
#import "JQPageView.h"

@interface JQContainerView()

/**轮询器*/
@property (nonatomic, weak) JQPageView *pageView;

@end

@implementation JQContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self uiSet];
    }
    
    return self;
}

#pragma mark - 设置UI
- (void) uiSet {
    
    // 设置轮播器
    [self pageViewSet];
    
    // 更新约束底部与pageView的底部一样高
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pageView);
    }];
}

#pragma mark - 设置轮播器
- (void)pageViewSet {
    
    JQPageView *pageView =[[JQPageView alloc] init];
    self.pageView = pageView;
    //    pageView.backgroundColor = [UIColor redColor];
    [self addSubview:pageView];
    
    // 自动布局
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(200);
    }];
    

}

- (void)setImgNames:(NSArray<NSString *> *)imgNames {
    
    self.pageView.imgNames = imgNames;
}

@end
