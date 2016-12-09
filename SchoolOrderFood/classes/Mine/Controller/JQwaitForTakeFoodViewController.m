//
//  JQwaitForTakeFoodViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/12/1.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQwaitForTakeFoodViewController.h"
#import "JQWaitForTakeFoodTableViewCell.h"
#import "JQShopCarTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <MJExtension/MJExtension.h>
#import "JQFoodTotalModel.h"
#import "JQHeadViewWaitFoodView.h"

@interface JQwaitForTakeFoodViewController () <UITableViewDataSource, UITableViewDelegate>

/**待取餐的tableview*/
@property (nonatomic, weak) UITableView *waitForTakeFoodTableView;

/**存放待取餐的数组*/
@property (nonatomic, strong) NSMutableArray *waitForTakeArrayM;

/**存放已经取餐的*/
@property (nonatomic, strong) NSMutableArray *foodAlreadyBuyArrayM;

/**总的数据*/
@property (nonatomic, strong) NSMutableArray *dataListM;

@end

@implementation JQwaitForTakeFoodViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    __weak typeof (self) weakSelf = self;
        
    [SVProgressHUD showWithStatus:@"加载中"];
        
    // 异步加载出
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        weakSelf.waitForTakeArrayM = [JQShopCarTool sharedInstance].buyFoodArrayM;
        
        [weakSelf.dataListM insertObject:weakSelf.waitForTakeArrayM atIndex:1];
        JQLOG(@"count:%ld", weakSelf.waitForTakeArrayM.count);
        [weakSelf.waitForTakeFoodTableView reloadData];
        
        [SVProgressHUD dismiss];
    });
    
    [weakSelf loadJSONData:^{
        
        [weakSelf.dataListM insertObject:weakSelf.foodAlreadyBuyArrayM atIndex:0];
        //        [self.waitForTakeFoodTableView registerClass:[JQWaitForTakeFoodTableViewCell class] forCellReuseIdentifier:WAITFTFTABLEVIEWCELLID];
        [weakSelf.waitForTakeFoodTableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"待取餐";
    
    [self initTableView];
    
}

#pragma mark - 初始化tableview
- (void)initTableView {
    
    UITableView *waitForTakeFoodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    // cell
    [waitForTakeFoodTableView registerClass:[JQWaitForTakeFoodTableViewCell class] forCellReuseIdentifier:WAITFTFTABLEVIEWCELLID];
    // head
    [waitForTakeFoodTableView registerClass:[JQHeadViewWaitFoodView class] forHeaderFooterViewReuseIdentifier:HEADVWAITID];
    
    waitForTakeFoodTableView.showsVerticalScrollIndicator = NO;
    waitForTakeFoodTableView.dataSource = self;
    waitForTakeFoodTableView.delegate = self;
    
    self.waitForTakeFoodTableView = waitForTakeFoodTableView;
    [self.view addSubview:waitForTakeFoodTableView];
    
    [waitForTakeFoodTableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];

}

#pragma mark - uitableview的数据源和代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataListM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataListM[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQWaitForTakeFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WAITFTFTABLEVIEWCELLID];

    // 设置数据模型
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return waitForTakeFoodHeadTitleArray[section];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    JQLOG(@"section:%ld", section);
    
    JQHeadViewWaitFoodView *headViewWaitFoodView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HEADVWAITID];
    
    headViewWaitFoodView.colorHex = waitForTakeFoodHeadColorArray[section];
    headViewWaitFoodView.name = waitForTakeFoodHeadTitleArray[section];
    
    return headViewWaitFoodView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    JQWaitForTakeFoodTableViewCell *waitCell = (JQWaitForTakeFoodTableViewCell *)cell;
    //    orderCell.foodTotalModel = self.foodTotalDataArrMFromJSON[indexPath.row];
    waitCell.foodTotalModel = self.dataListM[indexPath.section][indexPath.row];
    
}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.waitForTakeFoodTableView fd_heightForCellWithIdentifier:WAITFTFTABLEVIEWCELLID cacheByIndexPath:indexPath configuration:^(id cell) {
        
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
        weakSelf.foodAlreadyBuyArrayM = foodTotalDataArrM;
        
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
