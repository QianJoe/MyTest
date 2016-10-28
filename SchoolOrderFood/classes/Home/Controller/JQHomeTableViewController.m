//
//  JQHomeTableViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/10/27.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQHomeTableViewController.h"
#import "JQContainerView.h"

@interface JQHomeTableViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

/**导航条中间搜索框*/
@property (nonatomic, weak) UISearchBar *searchBar;
/**导航条右边的按钮*/
@property (nonatomic, weak) UIButton *rightCategoryBtn;

/**tableview*/
@property (nonatomic, weak) UITableView *tableView;
/**headerView*/
@property (nonatomic, weak) UIView *headerView;

/**轮播器的图片*/
@property (nonatomic, strong) NSMutableArray<NSString *> *pageViewImgs;

@end

@implementation JQHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 改变navigationbar
    [self changeNavi];
    
    // tableview的设置
    [self tableviewSet];
}

- (NSMutableArray *)pageViewImgs{
    
    if (!_pageViewImgs) {
        _pageViewImgs = [NSMutableArray array];
        
        // 这里应该是从服务器上获取图，现在先模拟一下
        [_pageViewImgs addObject:@"01.jpg"];
        [_pageViewImgs addObject:@"02.jpg"];
        [_pageViewImgs addObject:@"03.jpg"];
    }
    return _pageViewImgs;
}

#pragma mark - 设置tableview
- (void)tableviewSet {
    
    /************************* 创建tableview ******************************/
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    
    //将tableview添加到view上
    [self.view addSubview:tableView];
    
    // 设置一些属性
    tableView.backgroundColor = BackgroundColor;
    tableView.rowHeight = 150;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置数据源和代理
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // 添加约束
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view);
        make.leading.equalTo(self.view.leading);
        make.trailing.equalTo(self.view.trailing);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    // 注册cell
//    [self.tableView registerClass:[JQFoodFriendsTableViewCell class] forCellReuseIdentifier:ID];
//
//    // 刷新
//    [tableView setNeedsLayout];
//    [tableView layoutIfNeeded];
    
    
    /*********************** 设置tableHeaderView *******************************/
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    self.headerView = headerView;
    
    JQContainerView *con = [[JQContainerView alloc] init];
//    con.imgNames = @[@"01.jpg", @"02.jpg", @"03.jpg"];
    con.imgNames = self.pageViewImgs;

    con.backgroundColor = [UIColor blackColor];
    [headerView addSubview:con];
    
    [con mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];
    
    // 根据约束反推出高度
    CGFloat height = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    CGRect frame = headerView.frame;
    frame.size.height = height;
    headerView.frame = frame;
    
    tableView.tableHeaderView = headerView;

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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
