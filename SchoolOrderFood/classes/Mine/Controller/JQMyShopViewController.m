//
//  JQMyShopViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/4.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQMyShopViewController.h"
#import <MXSegmentedPager.h>
#import "MXParallaxHeader.h"
#import <UIImageView+WebCache.h>
#import <MJExtension/MJExtension.h>
//#import "UIImage+Blur.h"
#import "UIImage+Image.h"
#import "JQFoodModel.h"
#import "JQMineShopFoodViewController.h"
#import "JQMineShopIntroViewController.h"
#import "JQMineShopModel.h"
#import "JQMineShopFoodView.h"
#import "JQFoodTotalModel.h"
#import "JQMineShopFoodManagementViewController.h"
#import "JQMineShopAddFoodViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define ShopDetailTitles @[@"食物", @"商店"]

@interface JQMyShopViewController () <MXSegmentedPagerDelegate, MXSegmentedPagerDataSource, JQMineShopFoodViewDelegate>

/**MX框架*/
@property (nonatomic,strong) MXSegmentedPager *segmentedPager;
/**头部视图*/
@property (nonatomic, weak) UIView *headView;
/**头部图片*/
@property (nonatomic, weak) UIImageView *blurImageView;

///**JQShopTotalViewController*/
//@property (nonatomic, weak) JQMineShopFoodViewController *firstChildVC;
/**第二个控制器(商店详情)*/
@property (nonatomic, weak) JQMineShopIntroViewController *secondChildVC;

@property (nonatomic, weak) JQMineShopFoodView *firstChildView;

/**存在子控制器的数组*/
@property (nonatomic, strong) NSMutableArray *childVCArray;
/**存放子控制器View的数组*/
@property (nonatomic, strong) NSMutableArray *childVCViewArray;

/**我的餐店数据模型*/
@property (nonatomic, strong) JQMineShopModel *mineShopModel;
/**食物数组*/
@property (nonatomic, strong) NSMutableArray *foodTotalDataArrM;
@end

@implementation JQMyShopViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    __weak typeof (self) weakSelf = self;
    [SVProgressHUD showWithStatus:@"加载中"];
    
    // 异步加载出,每次都加载一边
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf loadJSONData:^{
            
            weakSelf.firstChildView.foodTotalModelArrayM = weakSelf.foodTotalDataArrM;
            
            [weakSelf.blurImageView sd_setImageWithURL:[NSURL URLWithString:weakSelf.mineShopModel.shopImgName]  placeholderImage:[UIImage imageNamed:@"shaxianxiaochi"]];
            
        }];
        
        [SVProgressHUD dismiss];
    });
    
}

#pragma mark - 跳转下一个控制器
- (void)mineShopFoodViewEdit:(JQMineShopFoodView *)mineShopFoodView foodTotalModel:(JQFoodTotalModel *)foodTotalModel andArray:(NSMutableArray *)foodTotalModelArrayM {
    
    JQMineShopFoodManagementViewController *msfmVC = [[JQMineShopFoodManagementViewController alloc] init];
    msfmVC.foodTotalModel = foodTotalModel;
    
    [self presentViewController:msfmVC animated:YES completion:nil];
}

- (void)mineShopFoodViewAdd:(JQMineShopFoodView *)mineShopFoodView {
    
    JQMineShopAddFoodViewController *msafVC = [[JQMineShopAddFoodViewController alloc] init];
    
    [self presentViewController:msafVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的餐厅";
    [self initAllChildVC];
    [self initHeadView];
    [self initMX];
}

#pragma mark - 懒加载
- (NSMutableArray *)childVCViewArray{
    
    if (!_childVCViewArray) {
        _childVCViewArray = [NSMutableArray array];
    }
    return _childVCViewArray;
}

- (NSMutableArray *)childVCArray{
    
    if (!_childVCArray) {
        _childVCArray = [NSMutableArray array];
    }
    return _childVCArray;
}


#pragma mark - 初始化子控制器
- (void)initAllChildVC {
    
//    JQMineShopFoodViewController *firstChildVC = [[JQMineShopFoodViewController alloc] init];
//    self.firstChildVC = firstChildVC;
    
    JQMineShopFoodView *firstChildView = [[JQMineShopFoodView alloc] init];
    firstChildView.delegate = self;
    firstChildView.foodTotalModelArrayM = self.foodTotalDataArrM;
    
    self.firstChildView = firstChildView;
    //    JQCommentHeadTableView *commentHeadTableView = [[JQCommentHeadTableView alloc] init];
    //    self.commentHeadTableView = commentHeadTableView;
    
    JQMineShopIntroViewController *secondChildVC = [[JQMineShopIntroViewController alloc] init];
    self.secondChildVC = secondChildVC;
    
//    [self.childVCArray addObject:firstChildVC];
//    [self.childVCArray addObject:secondChildVC];
    
//    [self.childVCViewArray addObject:firstChildVC.view];
    [self.childVCViewArray addObject:firstChildView];

    [self.childVCViewArray addObject:secondChildVC.view];
}


#pragma mark - 加载头部模糊视图的图片和头像
- (void)initHeadView {
    
    // 头view
    UIView *headView = [[UIView alloc] init];
    self.headView = headView;
    [self.view addSubview:_headView];
    
    [headView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(240);
    }];
    
    //顶部图片
    UIImageView *blurImageView = [[UIImageView alloc] init];
    
    
    self.blurImageView = blurImageView;
    [headView addSubview:blurImageView];
    
    [blurImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(headView);
    }];
    
    // 用sd赋值图片
//    [self.blurImageView sd_setImageWithURL:[NSURL URLWithString:self.mineShopModel.shopImgName]  placeholderImage:[UIImage imageNamed:@"hot_food04"]];
    
    JQLOG(@"self.mineShopModel.shopImgName:%@", self.mineShopModel.shopImgName);
    //    __weak typeof(self)weakSelf = self;
    //    [self.blurImageView sd_setImageWithURL:
    //                                    [NSURL URLWithString:self.foodModel.foodImgName]
    //                                    placeholderImage:[UIImage imageNamed:@"hot_food04"]
    //                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //
    //                                            [self.blurImageView setNeedsDisplay];
    //
    //                                             // 模糊开始
    //                                             NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    //
    //                                             // 模糊接口，参数越接近1越模糊，直接调用他就OK了
    //                                             UIImage *blurImage = [[UIImage imageWithData:imageData] blurredImage:0.00f];
    //
    //                                             weakSelf.blurImageView.image = blurImage;
    //
    //                                             if (image && cacheType == SDImageCacheTypeNone) {
    //
    //                                                 weakSelf.blurImageView.alpha = 0;
    //
    //                                                 [UIView animateWithDuration:1.0 animations:^{
    //
    //                                                     weakSelf.blurImageView.alpha = 1.0f;
    //
    //                                                 }];
    //
    //                                             } else {
    //
    //                                                 weakSelf.blurImageView.alpha = 1.0f;
    //                                             }
    //
    //                                 }];
    
    // 重新布局子控件
    [self.headView layoutSubviews];
}

#pragma mark - 初始化MX框架控制器，头部和选择栏
- (void)initMX {
    
    // 头部
    self.segmentedPager = [[MXSegmentedPager alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.segmentedPager.parallaxHeader.view = self.headView; // 注意这里加载平行头部
    // MXParallaxHeaderModeCenter MXParallaxHeaderModeCenter MXParallaxHeaderModeTop  MXParallaxHeaderModeBottom四个，大家可以自己测试
    self.segmentedPager.parallaxHeader.mode = MXParallaxHeaderModeFill; // 平行头部填充模式
    self.segmentedPager.parallaxHeader.height = 240; // 头部高度
    self.segmentedPager.parallaxHeader.minimumHeight = 64; // 头部最小高度
    
    // 选择栏控制器属性
    self.segmentedPager.segmentedControl.borderWidth = 1.0; // 边框宽度
    self.segmentedPager.segmentedControl.borderColor = [UIColor redColor]; // 边框颜色
    self.segmentedPager.segmentedControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44); // frame
    self.segmentedPager.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);// 间距
    
    /**设置指示器*/
    self.segmentedPager.segmentedControl.selectionIndicatorHeight = 2;// 底部是否需要横条指示器，0的话就没有了，如图所示
    // 底部指示器的宽度是否根据内容
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    //HMSegmentedControlSelectionIndicatorLocationNone 不需要底部滑动指示器
    // 指示器的颜色
    self.segmentedPager.segmentedControl.selectionIndicatorColor = naviColor;
    
    self.segmentedPager.segmentedControl.verticalDividerEnabled = NO;// 不可以垂直滚动
    // fix的枚举说明宽度是适应屏幕的，不会根据字体   HMSegmentedControlSegmentWidthStyleDynamic则是字体多大就多宽
    self.segmentedPager.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    
    // 默认状态的字体
    self.segmentedPager.segmentedControl.titleTextAttributes =
    @{NSForegroundColorAttributeName : [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1],
      NSFontAttributeName : [UIFont systemFontOfSize:14]};
    // 选择状态下的字体
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes =
    @{NSForegroundColorAttributeName : naviColor,
      NSFontAttributeName : [UIFont systemFontOfSize:18]};
    self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置数据源和代理为当前控制器
    self.segmentedPager.delegate = self;
    self.segmentedPager.dataSource = self;
    [self.view addSubview:self.segmentedPager];
    
    [self.segmentedPager makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(0);
        make.left.equalTo(self.view.left);
        make.bottom.equalTo(self.view.bottom);
        make.right.equalTo(self.view.right);
        make.width.equalTo(self.view.width);
    }];
}

#pragma mark - 滚动整体的时候调用
- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didScrollWithParallaxHeader:(MXParallaxHeader *)parallaxHeader {
    
    // 通过拿到滚动的对应的View
    UIScrollView *scrollView = (UIScrollView *)segmentedPager.subviews[0];
    JQLOG(@"%lf",scrollView.contentOffset.y);
    
    // 计算alpha值
    CGFloat headAlpha = (1 - (-(scrollView.contentOffset.y + 64) / 136)) >= 0 ? (1 - (-(scrollView.contentOffset.y + 64) / 136)) : 0;
    
    self.headView.alpha = 1 - headAlpha;
    
    if (self.headView.alpha == 0) { // 判断滚到顶部时，导航条设置为原来的颜色
        
                self.navigationController.navigationBar.hidden = NO;
//        UIColor *color = JQColor(255, 214, 0, 1.0);
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        
    } else { //不在顶部时，为透明
        
                self.navigationController.navigationBar.hidden = YES;
        // 设置透明
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
    }
}

#pragma mark - <MXSegmentedPagerDelegate>
/**指示栏的高度*/
- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    
    return 44.0f;
}

#pragma mark - <MXSegmentedPagerDataSource>
/**需要多少个界面*/
- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    
    return self.childVCViewArray.count;
}

/**指示栏的文字数组*/
- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    
    return [ShopDetailTitles objectAtIndex:index];
}

/**最关键的，通过懒加载把对应控制的初始化View加载到框架上面去*/
- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    
    //    return [@[self.firstChildVC.view, self.secondChildVC.view] objectAtIndex:index];
    return [self.childVCViewArray objectAtIndex:index];
    
}

#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        /****************************我的餐厅**********************************************/
        NSString *mineShopDataFilePath =[[NSBundle mainBundle] pathForResource:@"MineShopData" ofType:@"json"];

        // 获取二进制数据
        NSData *mineShopData = [NSData dataWithContentsOfFile:mineShopDataFilePath];

        // 转成字典
        NSDictionary *mineShopDataDictionary = [NSJSONSerialization JSONObjectWithData:mineShopData options: NSJSONReadingAllowFragments error:nil];

        JQMineShopModel *msModel = [JQMineShopModel mj_objectWithKeyValues:mineShopDataDictionary];
        
        weakSelf.mineShopModel = msModel;
        
        
        /**食物**/
        NSString *foodAlreadyBuyFoodFilePath =[[NSBundle mainBundle] pathForResource:@"foodShaxianxiaochiData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:foodAlreadyBuyFoodFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *foodAlreadyBuyArrayM = dataDictionary[@"foodShaxianxiaochiData"];
        NSMutableArray *foodTotalDataArrM = @[].mutableCopy;
        
        foodTotalDataArrM = [JQFoodTotalModel mj_objectArrayWithKeyValuesArray:foodAlreadyBuyArrayM];
        weakSelf.foodTotalDataArrM = foodTotalDataArrM;
                
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

@end
