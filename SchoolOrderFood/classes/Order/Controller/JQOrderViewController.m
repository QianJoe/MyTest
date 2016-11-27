//
//  JQOrderViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/25.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQOrderViewController.h"
#import "JQOrderDefaultView.h"
#import "JQOrderTableFootView.h"
#import "JQOrderTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <MJExtension/MJExtension.h>
#import "JQFoodTotalModel.h"

@interface JQOrderViewController () <UITableViewDataSource, UITableViewDelegate, JQOrderTableViewCellDeleagte, JQOrderTableFootViewDelegate>

/**没有订餐，显示的界面*/
@property (nonatomic, weak) JQOrderDefaultView *defaultView;

/**已经订的tableview*/
@property (nonatomic, weak) UITableView *orderTableView;

/**footview*/
@property (nonatomic, weak) JQOrderTableFootView *footView;

/**接受数据的数据*/
@property (nonatomic, strong) NSMutableArray *foodTotalDataArrMFromJSON;

/**存放购买的食物*/
@property (nonatomic, strong) NSMutableArray<JQFoodTotalModel *> *buyFoodTotalArrayM;
;

/**总价*/
@property (nonatomic, assign) NSInteger totalPrice;

@end

@implementation JQOrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.defaultView.hidden = YES;
    self.orderTableView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单";
    self.view.backgroundColor = BackgroundColor;
    
    [self initTableView];
    [self initDefaultView];
    [self initTableFootView];
    
    // 加载数据
    [self loadJSONData:^{
        
        [self.orderTableView registerClass:[JQOrderTableViewCell class] forCellReuseIdentifier:ORDERTABLEVIEWCELLID];
        [self.orderTableView reloadData];
    }];
}

#pragma mark - 初始化tableview
- (void)initTableView {
    
    UITableView *orderTableView = [[UITableView alloc] init];
    [orderTableView registerClass:[JQOrderTableViewCell class] forCellReuseIdentifier:ORDERTABLEVIEWCELLID];
    orderTableView.showsVerticalScrollIndicator = NO;
    orderTableView.dataSource = self;
    orderTableView.delegate = self;
    
    self.orderTableView = orderTableView;
    [self.view addSubview:orderTableView];
    
    [orderTableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - 初始化脚view
- (void)initTableFootView {
    
    // 脚view
    JQOrderTableFootView *footView = [[JQOrderTableFootView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 50)];
    footView.delegate = self;
//    JQOrderTableFootView *footView = [[JQOrderTableFootView alloc] init];
    self.footView = footView;
    self.orderTableView.tableFooterView = footView;
//    [self.view addSubview:footView];
    
//    [footView makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//        make.height.equalTo(50);
//    }];
    
}

#pragma mark - 默认view
- (void)initDefaultView {
    
    JQOrderDefaultView *defaultView = [[JQOrderDefaultView alloc] init];
    // 默认隐藏，无订餐时，为NO
//    defaultView.hidden = YES;
    self.defaultView = defaultView;
    [self.view addSubview:defaultView];
    
    [self.defaultView makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(170);
    }];
}

#pragma mark - tableview数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.foodTotalDataArrMFromJSON.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ORDERTABLEVIEWCELLID];
    
    // 设置代理
    cell.delegate = self;
    
    // 设置数据模型
    //    cell.foodTotalModel = self.foodTotalDataArrMFromJSON[indexPath.row];
    
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - 设置cell的数据
- (void)setupModelOfCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    JQOrderTableViewCell *orderCell = (JQOrderTableViewCell *)cell;
    orderCell.foodTotalModel = self.foodTotalDataArrMFromJSON[indexPath.row];
}

#pragma mark - 改变cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.orderTableView fd_heightForCellWithIdentifier:ORDERTABLEVIEWCELLID cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - JQOrderTableViewCellDeleagte
- (void)orderCellPlusBtnClick:(JQOrderTableViewCell *)cell {
    
    if (![self.buyFoodTotalArrayM containsObject:cell.foodTotalModel]) {
        
        [self.buyFoodTotalArrayM addObject:cell.foodTotalModel];
    }
    
    NSInteger money = [cell.foodTotalModel.money integerValue];
    self.totalPrice += money;
    
    // 显示在footview上
    self.footView.totalPrice = self.totalPrice;
    JQLOG(@"增加.....总结:%ld,%@", self.totalPrice, self.buyFoodTotalArrayM);
}

- (void)orderCellMinusBtnClick:(JQOrderTableViewCell *)cell {
    
    // 当count为0 删除购物车中的模型
    if (!cell.foodTotalModel.count) {
        [self.buyFoodTotalArrayM removeObject:cell.foodTotalModel];
    }
    
    NSInteger money = [cell.foodTotalModel.money integerValue];
    self.totalPrice -= money;
    // 显示在footview上
    self.footView.totalPrice = self.totalPrice;
    JQLOG(@"减少.....总结:%ld, %@", self.totalPrice, self.buyFoodTotalArrayM);
}

- (void)orderCellSelectedBtnClick:(JQOrderTableViewCell *)cell {
    
    // 先将数据模型中的被选中设置YES，下一次循环引用时，就为选中
    cell.foodTotalModel.check = YES;
    
    // 添加进去
    [self.buyFoodTotalArrayM addObject:cell.foodTotalModel];
    NSInteger money = [cell.foodTotalModel.money integerValue];
    money = money * cell.foodTotalModel.count;
    self.totalPrice += money;
    // 显示在footview上
    self.footView.totalPrice = self.totalPrice;
    JQLOG(@"选中.....总结:%ld, %@", self.totalPrice, self.buyFoodTotalArrayM);

}

- (void)orderCellNoSelectedBtnClick:(JQOrderTableViewCell *)cell {
    
    // 先将数据模型中的被选中设置NO，下一次循环引用时，就为未选中
    cell.foodTotalModel.check = NO;
    
    // 直接将它移除
    [self.buyFoodTotalArrayM removeObject:cell.foodTotalModel];
    NSInteger money = [cell.foodTotalModel.money integerValue];
    money = money * cell.foodTotalModel.count;
    self.totalPrice -= money;
    // 显示在footview上
    self.footView.totalPrice = self.totalPrice;
    JQLOG(@"未选中.....总结:%ld, %@", self.totalPrice, self.buyFoodTotalArrayM);

}

#pragma mark - JQOrderTableFootViewDelegate
- (void)tableFootViewDidCommit:(JQOrderTableFootView *)orderTableFootView {
    
    for (JQFoodTotalModel *foodModel in self.buyFoodTotalArrayM) {
        
        JQLOG(@"买了%@:共%ld个", foodModel.name, foodModel.count);
    }
}

#pragma mark - 异步加载数据
- (void)loadJSONData:(void(^)()) then {
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
#warning 现在是模拟的json数据
        // 读取json数据
        // 获取json地址
        NSString *foodTotalDataFilePath =[[NSBundle mainBundle] pathForResource:@"OrderFoodData" ofType:@"json"];
        
        // 获取二进制数据
        NSData *data = [NSData dataWithContentsOfFile:foodTotalDataFilePath];
        
        // 转成字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        // 转成数组
        NSArray *foodTotalDataArr = dataDictionary[@"foodTotalData"];
        NSMutableArray *foodTotalDataArrM = @[].mutableCopy;
        
        foodTotalDataArrM = [JQFoodTotalModel mj_objectArrayWithKeyValuesArray:foodTotalDataArr];
        
        for (JQFoodTotalModel *foodTotalModel in foodTotalDataArrM) {
            
            foodTotalModel.check = YES;
        }
        weakSelf.foodTotalDataArrMFromJSON = foodTotalDataArrM;
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

#pragma mark - 懒加载
- (NSMutableArray<JQFoodTotalModel *> *)buyFoodTotalArrayM {
    
    if (!_buyFoodTotalArrayM) {
        _buyFoodTotalArrayM = [NSMutableArray array];
    }
    return _buyFoodTotalArrayM;
}

@end
