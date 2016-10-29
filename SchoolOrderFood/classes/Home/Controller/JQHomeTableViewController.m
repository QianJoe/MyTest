//
//  JQHomeTableViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHomeTableViewController.h"
#import <MJExtension/MJExtension.h>
#import "JQACFoodModel.h"
#import "JQACFoodTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "JQLineLayout.h"
#import "JQAdView.h"
#import "JQHotFoodCollectionViewCell.h"

@interface JQHomeTableViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

/**导航条中间搜索框*/
@property (nonatomic, weak) UISearchBar *searchBar;
/**导航条右边的按钮*/
@property (nonatomic, weak) UIButton *rightCategoryBtn;

/**headView*/
@property (nonatomic,weak) UIView *headView;
/**轮播器*/
@property (nonatomic,weak) JQAdView *adView;
/**横向滚动*/
@property (nonatomic,weak) UICollectionView *collectionView;

/**tableview*/
@property (nonatomic, weak) UITableView *listTableView;
/**活动的数据模型JSON数组*/
@property (nonatomic, strong) NSArray *acFoodModelsFromJSON; // json中解析出来的
/**活动的数据模型数组*/
@property (nonatomic, strong) NSMutableArray *acFoodModels;

@end

@implementation JQHomeTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 改变navigationbar
    [self changeNavi];
    
    // tableview的设置
//    [self tableviewSet];
    
    // 创建头view（作为轮播器和collectionview的容器）,方便设置为tableview的头view
    [self createHeadView];
    
    // 初始化轮播图
    [self createAdView];
    
    // 初始化横版滚动图
    [self createLandscapeScrollView];
    
    // 创建tableview
    [self createTableView];
    
    // 加载json数据
    [self loadJSONData:^{ // 加载完josn数据后要做的操作
        
        self.acFoodModels = @[].mutableCopy;
        
        [self.acFoodModels addObject:self.acFoodModelsFromJSON.mutableCopy];
        
        // 给一个标识符，告诉tableView要创建哪个类
        [self.listTableView registerClass:[JQACFoodTableViewCell class] forCellReuseIdentifier:ACCELLID];
        
        [self.listTableView reloadData];
        
    }];
}

#pragma mark - 创建headView
- (void)createHeadView {
    
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210 + SCREEN_WIDTH / 2);
//    headView.backgroundColor = BackgroundColor;
    [self.view addSubview:headView];
    self.headView = headView;
}

#pragma mark - 创建轮播器
- (void)createAdView {
    
    // 从服务器中取(http最好不用)
    NSArray *imagesURL = @[
                           @"http://img1.hoto.cn//haodou//recipe_mobile_ad//2016//05//1463743688.jpg",
                           @"http://img1.hoto.cn//haodou//recipe_mobile_ad//2016//05//1463743624.jpg",
                           @"http://img1.hoto.cn//haodou//recipe_mobile_ad//2016//05//1463568626.jpg"
                           ];
    
    
    JQAdView *AdScrollView = [JQAdView adScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2) imageLinkURL:imagesURL placeHoderImageName:@"dogebread" pageControlShowStyle:UIPageControlShowStyleCenter];
    
    // 是否需要支持定时循环滚动，默认为YES
    AdScrollView.isNeedCycleRoll = YES;
    
    // 设置图片滚动时间,默认3s
    AdScrollView.adMoveTime = 3.0;
    
    // 图片被点击后回调的方法
    AdScrollView.callBack = ^(NSInteger index,NSString * imageURL) {
        
        // 跳转到下一个控制器用
        NSLog(@"被点中图片的索引:%ld---地址:%@",index,imageURL);
    };
    
    [self.headView addSubview:AdScrollView];
    self.adView = AdScrollView;
}

#pragma mark - 创建横向滚动
- (void)createLandscapeScrollView {
    
    CGFloat w = self.view.bounds.size.width;
    CGRect frame = CGRectMake(0,CGRectGetMaxY(self.adView.frame), w, 200);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[[JQLineLayout alloc] init]];
    
    // 设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.backgroundColor = BackgroundColor;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"JQHotFoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CETID];
    
    [self.headView addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - createTableView
- (void)createTableView {
    
    UITableView *listTabelView = [[UITableView alloc] init];
    self.listTableView = listTabelView;

    //将tableview添加到view上
    [self.view addSubview:listTabelView];

    // 设置一些属性
    listTabelView.backgroundColor = BackgroundColor;
//    listTabelView.rowHeight = 150;
    listTabelView.showsVerticalScrollIndicator = NO;
//    listTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 设置数据源和代理
    listTabelView.dataSource = self;
    listTabelView.delegate = self;
    
     // 添加约束
    [listTabelView makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.view);
        make.leading.equalTo(self.view.leading);
        make.trailing.equalTo(self.view.trailing);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    listTabelView.tableHeaderView = self.headView;
    
    [listTabelView registerClass:[JQACFoodTableViewCell class] forCellReuseIdentifier:ACCELLID];
}

#pragma mark - 加载json数据
- (void) loadJSONData:(void(^)()) then {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *dataFilePath =[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *feedArray = dataDictionary[@"feed"];
        NSMutableArray *feedArrayM = @[].mutableCopy;
        
        // 这个直接用的枚举遍历，这里不使用这种方法，直接用MJExtension
//        [feedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            
//            [feedArrayM addObject:[XQFeedModel feedWithDictionary:obj]];
//        }];
        
        feedArrayM = [JQACFoodModel mj_objectArrayWithKeyValuesArray:feedArray];
        self.acFoodModelsFromJSON = feedArrayM;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

#pragma mark - UICollectionView的代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JQHotFoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CETID forIndexPath:indexPath];
    return cell;
}

#pragma mark - 设置导航条
- (void)changeNavi {
    
    /***************************导航条中间搜索框****************************************/
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.searchBar = searchBar;
    searchBar.delegate = self;
    searchBar.backgroundImage = [UIImage imageNamed:@"icon_homepage_search"];
    searchBar.placeholder = @"吊龙泉";
    self.navigationItem.titleView = searchBar;
    
    // 右边设置一个item（具体功能以后再想)
    // 不能使用默认的UIBarButtonItem，会变成系统默认颜色
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"category"] style:0 target:self action:@selector(rightClick)];
    
    
    
    /***************************导航条右边按钮****************************************/
    // 创建自定义item（用btn）
    UIButton *rightCategoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 强引用
    self.rightCategoryBtn = rightCategoryBtn;
    // 设置一下大小(这里就不必用自动布局了)
    rightCategoryBtn.frame = CGRectMake(0, 0, 40, 35);
    // 也不需要自适应
//    [rightCategoryBtn sizeToFit];
    // 设置图片
    [rightCategoryBtn setImage:[UIImage imageNamed:@"category"] forState:UIControlStateNormal];
    // 设置点击事件
    [rightCategoryBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    // 设置为导航条右边的Item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightCategoryBtn];
    
}

#pragma mark - 导航条右边Item的点击事件
- (void)rightClick {
    
    JQLOGFUNC;
}

#pragma mark - searchBar的代理
// 开始编辑时调用
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    JQLOGFUNC;
    return YES;
}

#pragma mark - tableview的数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // 暂定3类（热门食物，猜你喜欢，精品活动）

    return [self.acFoodModels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.acFoodModels[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JQACFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ACCELLID];
//    JQLOG(@"%@", cell);
    [self setupModelOfCell:cell atIndexPath:indexPath];

    return cell;
}

#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(JQACFoodTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    
    cell.acFoodModel = self.acFoodModels[indexPath.section][indexPath.row];
}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.listTableView fd_heightForCellWithIdentifier:ACCELLID cacheByIndexPath:indexPath configuration:^(JQACFoodTableViewCell *cell) {
        
        // 在这个block中，重新cell配置数据源
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

@end
