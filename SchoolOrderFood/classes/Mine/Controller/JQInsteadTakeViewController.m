//
//  JQInsteadTakeViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/4.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQInsteadTakeViewController.h"
#import "JQInsteadTakeTableViewCell.h"
#import "JQFoodTotalModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <MJExtension/MJExtension.h>
#import "JQInsteadTakeDetailViewController.h"
#import "UIImage+Image.h"
#import "JQInsteadTakeFood.h"
#import "PCH.h"

@interface JQInsteadTakeViewController () <UITableViewDataSource, UITableViewDelegate>

/**tableview*/
@property (nonatomic, weak) UITableView *tableView;

/**总的数据*/
@property (nonatomic, strong) NSMutableArray *dataListM;

@end

@implementation JQInsteadTakeViewController

#pragma mark - 加载view
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor] forBarMetrics:UIBarMetricsDefault];
    
//    [self loadJSONData:^{
//       
//        [self.tableView reloadData];
//    }];
    
    [self refreshSet];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"代送列表";
    
    [self initTableView];
}

#pragma mark - 刷新数据
- (void)refreshSet {
    
    // 防止循环引用
    IMP_BLOCK_SELF(JQInsteadTakeViewController);
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        JQHttpRequestTool *httpTool = [JQHttpRequestTool shareHttpRequestTool];
        
        [httpTool requestWithMethod:GET andUrlString:JQInsteadTakeFoodDataURL andParameters:nil andFinished:^(id response, NSError *error) {
           
            NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            JQLOG(@"%@", result);
            
            // 转成字典
            NSDictionary *dataDictionary = [result dictionaryWithJsonString:result];
            
            // 转成数组
            NSArray *insteaFooddArray = dataDictionary[@"insteadtakefood"];
            
            block_self.dataListM = [JQInsteadTakeFood mj_objectArrayWithKeyValuesArray:insteaFooddArray];
            
            [block_self.tableView reloadData];

            [block_self.tableView.mj_header endRefreshing];
        }];
        
//        [block_self loadJSONData:^{
//            
//            [block_self.tableView reloadData];
//            
//            [block_self.tableView.mj_header endRefreshing];
//            
//        }];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 初始化tableview
- (void)initTableView {
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[JQInsteadTakeTableViewCell class] forCellReuseIdentifier:INSTEADTAKETABLEVIEWCELLID];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    // 去掉尾部多余的
    tableView.tableFooterView = [[UIView alloc] init];

    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - uitableview的数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListM.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQInsteadTakeDetailViewController *itdVC = [[JQInsteadTakeDetailViewController alloc] init];
    itdVC.foodTotalModel = self.dataListM[indexPath.row];
    
    [self.navigationController pushViewController:itdVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQInsteadTakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:INSTEADTAKETABLEVIEWCELLID];
    
    // 设置数据模型
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    JQInsteadTakeTableViewCell *insteadCell = (JQInsteadTakeTableViewCell *)cell;
    insteadCell.foodTotalModel = self.dataListM[indexPath.row];
    
}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView fd_heightForCellWithIdentifier:INSTEADTAKETABLEVIEWCELLID cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *foodAlreadyBuyFoodFilePath =[[NSBundle mainBundle] pathForResource:@"foodAlreadyBuyData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:foodAlreadyBuyFoodFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *foodAlreadyBuyArrayM = dataDictionary[@"foodAlreadyBuyData"];
        NSMutableArray *foodTotalDataArrM = @[].mutableCopy;
        
        foodTotalDataArrM = [JQFoodTotalModel mj_objectArrayWithKeyValuesArray:foodAlreadyBuyArrayM];
        weakSelf.dataListM = foodTotalDataArrM;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

- (NSMutableArray *)dataListM{
    
    if (!_dataListM) {
        _dataListM = [NSMutableArray array];
    }
    return _dataListM;
}

@end
