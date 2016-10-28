//
//  JQPageView.m
//  复习之轮播器
//
//  Created by 乔谦 on 16/8/3.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQPageView.h"

@interface JQPageView () <UIScrollViewDelegate>

/**scrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;

/**UIPageControl*/
@property (nonatomic, strong) UIPageControl *pageControl;


/**定时器*/
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JQPageView

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY);
            make.width.equalTo(self.width);
            make.height.equalTo(self.height);
            
        }];
        
        // 启动分页
        _scrollView.pagingEnabled = YES;
        
        // 隐藏滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [self addSubview:_pageControl];
        _pageControl.currentPage = 0;
//        _pageControl.numberOfPages = 5;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.bottom).offset(-5);
            make.right.equalTo(self.right).offset(-30);
            make.width.equalTo(self.width).multipliedBy(0.2);
            make.height.equalTo(10);
        }];
        
    }
    
    return _pageControl;
}

- (void)setImgNames:(NSArray<NSString *> *)imgNames {
    
    _imgNames = imgNames;
    
    // 每次设置图片之前，都要先清除子控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.pageControl.numberOfPages = imgNames.count;
    
    // 1.创建一个过度控件
    // 为什么要过度控件：因为使用masonry时，无法使用CGSizeMake设置scrollView的Contentsize
    UIView *container = [[UIView alloc] init];
    [self.scrollView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 1.1 设置的位置和scrollView一样
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    
    // 创建一个用于保存上一个控件的控件
    UIImageView *preImgView = nil;
    
    // 设置图片
    for (NSInteger i = 0; i < imgNames.count; i ++) {
    
        // 3.创建imgview
        UIImageView *imgView = [[UIImageView alloc] init];
        
        // 3.1 将imgview添加到过度的view上
        [container addSubview:imgView];
        
        imgView.image = [UIImage imageNamed:imgNames[i]];
        
        // 3.2 设置imgview的大小和位置
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.and.bottom.equalTo(container);
            make.width.equalTo(self.scrollView);
            
            if (!preImgView) { // 第一次的时候，位于最左边

                make.left.equalTo(0);
            } else { // 之后每一次新建的imgView都位于它之前添加的右边
                
                make.left.mas_equalTo(preImgView.right);
            }
            
        }];
        
        // 将当前的控件赋值给它
        preImgView = imgView;
        
    }
    
    // 最后设置过度控件的右边，以确定contentsize
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(preImgView.right);
    }];
    
}

#pragma mark - 定时器控制
- (void)startTimer {
//    NSLog(@"startTimer%f", self.bounds.size.width);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    
    [self.timer invalidate];
}

- (void)nextPage {
//    NSLog(@"nextPage%f", self.bounds.size.width);
    NSUInteger page = (self.pageControl.currentPage + 1) % self.pageControl.numberOfPages;
//    NSLog(@"%zd--%zd", page, self.pageControl.numberOfPages);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * page, 0) animated:YES];
}

#pragma mark - UIScrollViewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSUInteger currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width + 0.5;

    self.pageControl.currentPage = currentPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"layoutSubviews%f", self.bounds.size.width);
    [self startTimer];
}

@end
