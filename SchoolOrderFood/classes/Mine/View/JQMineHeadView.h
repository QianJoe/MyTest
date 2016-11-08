//
//  JQMineHeadView.h
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/5.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JQMineHeadView;

@protocol JQMineHeadViewDelegate <NSObject>
@required
- (void)mineHeadView:(JQMineHeadView *) mineHeadView clickWithTap:(UITapGestureRecognizer *)tap;
@end

@interface JQMineHeadView : UIView

/**代理*/
@property (nonatomic, weak) id<JQMineHeadViewDelegate> delegate;

@end