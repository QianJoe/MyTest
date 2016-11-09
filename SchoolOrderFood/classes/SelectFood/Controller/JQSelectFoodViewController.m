//
//  JQSelectFoodViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/9.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQSelectFoodViewController.h"
#import "JQMultipleButtonView.h"
#import "JSDropDownMenu.h"
#import "JQProvince.h"
#import <MJExtension/MJExtension.h>

#define menuIndicatorColor [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0]
#define menuSeparatorColor [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]
#define menuTextColor [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f]

//#define FIRSTMENUDATAS @[@{@"炸的" : @[@"炸土豆", @"炸年糕", @"炸鱿鱼", @"炸玉米"]}, @{@"煮的" : @[@"煮饭", @"煮粥", @"煮玉米"]}, @{@"煎的" : @[@"煎蛋", @"煎饼"]}, @{@"蒸的" : @[@"蒸馒头", @"蒸包子", @"蒸西瓜"]}]
//#define data1 @[@"炸土豆", @"炸年糕", @"炸鱿鱼", @"炸玉米"]
//#define data2 @[@"煮饭", @"煮粥", @"煮玉米"]
//#define data3 @[@"煎蛋", @"煎饼"]
//#define data4 @[@"蒸馒头", @"蒸包子", @"蒸西瓜"]
//
//#define FIRSTMENUDATAS @[@{@"title":@"炸的", @"data":data1}, @{@"title":@"煮的", @"data":data2}, @{@"title":@"煎的", @"data":data3}]

#define SECONDMENUDATAS @[@"智能排序", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高"]
#define THRIDMENUDATAS @[@"早餐", @"午餐", @"晚餐", @"夜宵"]

@interface JQSelectFoodViewController () <JQMultipleButtonViewDelegate, JSDropDownMenuDataSource, JSDropDownMenuDelegate>

/**顶部下拉筛选菜单*/
@property (nonatomic, strong) JSDropDownMenu *menu;

/**记录第一列数据当前的角标索引*/
@property (nonatomic, assign) NSInteger currentFirstDataIndex;
/**记录第一列数据右边被选中的角标*/
@property (nonatomic, assign) NSInteger currentFirstDataSelectedIndex;

/**记录第二列数据当前的角标索引*/
@property (nonatomic, assign) NSInteger currentSecondDataIndex;

/**记录第三列数据当前的角标索引*/
@property (nonatomic, assign) NSInteger currentThridDataIndex;

/**存储省市模型的数组*/
@property (nonatomic, strong) NSArray<JQProvince *> *provinces;

@end

@implementation JQSelectFoodViewController

- (NSArray<JQProvince *> *)provinces{
    
    if (!_provinces) {
        _provinces = [JQProvince mj_objectArrayWithFilename:@"provinces.plist"];
    }
    return _provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeNav];
    
    [self setDropMenu];

}

#pragma mark - 下拉菜单
- (void)setDropMenu {
    
    // 指定第一列默认选中
    self.currentFirstDataIndex = 0;
    self.currentFirstDataSelectedIndex = 0;
    
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
    menu.indicatorColor = menuIndicatorColor;
    menu.separatorColor = menuSeparatorColor;
    menu.textColor = menuTextColor;
    menu.dataSource = self;
    menu.delegate = self;
    
    self.menu = menu;
    [self.view addSubview:menu];
}

#pragma mark - 初始化导航栏
- (void)changeNav {
    
    NSArray  *array = @[@"全部商家",@"优惠商家"];
    
    //这个地方用UIView来接收也不会报错的，因为JFMultipleButtonView继承于UIView但是没有代理方法
    JQMultipleButtonView *buttonView = [[JQMultipleButtonView alloc] initWithFrame:CGRectMake(0, 0, 160, 40) titleArray:array];
    
    buttonView.delegate = self;
    
    self.navigationItem.titleView = buttonView;
    
}

#pragma mark - 导航条中间的JQMultipleButtonViewDelegate
- (void)multipleButtonView:(JQMultipleButtonView *)multipleBtn clickAtIndex:(NSInteger)index {
    
    JQLOG(@"multipleBtn:%ld", index);
}

#pragma mark - 下拉菜单的数据源方法JSDropDownMenuDataSource
/**菜单有几列*/
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    /* 为3列：
     第0列：里面有两列（为按口味，炸的，煎的，煮的，蒸的...）
     第1列：一列（按人气，评价，智能排序）
     第2列：一列（早，中，晚，夜）
     */
    return 3;
}

/**是否需要显示为UICollectionView 默认为否*/
- (BOOL)displayByCollectionViewInColumn:(NSInteger)column {
    
    if (column == 2) { // 第2列为collection
        
        return YES;
    }
    
    return NO;
}

/**表视图显示时，是否需要两个表显示*/
- (BOOL)haveRightTableViewInColumn:(NSInteger)column {
    
    if (column == 0) { // 第0列中有左右两个table
        
        return YES;
    }
    
    return NO;
}


/**表视图显示时，左边表显示比例*/
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column {
    
    if (column == 0) { // 第0列中左边的table宽度占0.3
        
        return 0.3;
    }
    
    return 1;
}

/**返回当前菜单左边表选中行*/
- (NSInteger)currentLeftSelectedRow:(NSInteger)column {
    
    if (column == 0) { // 第0列返回（为按口味，炸的，煎的，煮的，蒸的...）的数据
        
        return self.currentFirstDataIndex;
        
    }
    
    if (column == 1) { // 第1列返回（按人气，评价，智能排序））的数据
        
        return self.currentSecondDataIndex;
    }
    
    return 0;
}

/**返回每一列有多少行数据*/
- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow {
    
    if (column == 0) { // 第0列时，返回左右table数据不同的数量来确定行数
        
        if (leftOrRight == 0) { // 为左时,返回大分类的数量 （0为左）
            
            return self.provinces.count;
        
        } else { // 为右时,返回大分类中的小分类的数量
            
            JQProvince *p = self.provinces[leftRow];
            return p.cities.count;
        }
        
    } else if (column == 1){ // 返回第1列的数据的数量
        
        return SECONDMENUDATAS.count;
        
    } else if (column == 2){ // 返回第2列中的数据数量
        
        return THRIDMENUDATAS.count;
    }
    
    return 0;
    
}

/**显示每一列的标题*/
- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column {
    
    switch (column) {
            
        case 0:return [[self.provinces[self.currentFirstDataIndex] cities] objectAtIndex:self.currentFirstDataSelectedIndex];
            
            break;
            
        case 1: return SECONDMENUDATAS[self.currentSecondDataIndex];
            
            break;
            
        case 2: return THRIDMENUDATAS[self.currentThridDataIndex];
            
            break;
            
        default:
            return nil;
            break;
    }
}

/**显示点击下拉菜单之后，左边的小菜单*/
- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if (indexPath.leftOrRight == 0) { // 第0列的左右table的数据
            
            JQProvince *p = self.provinces[indexPath.row];
            NSString *proName = p.name;
            return proName;
            
        } else {
            
            NSInteger leftRow = indexPath.leftRow;
            JQProvince *p = self.provinces[leftRow];
            return p.cities[indexPath.row];
        }
        
    } else if (indexPath.column == 1) {
        
        return SECONDMENUDATAS[indexPath.row];
        
    } else {
        
        return THRIDMENUDATAS[indexPath.row];
    }
}

#pragma mark - JSDropDownMenuDelegate
/**
 * 选择哪一行，会设置为当前行，然后设置为该列的标题
 * 选择的是哪行
 * 第一列是返回左边小菜单
 */
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight == 0){
            
            self.currentFirstDataIndex = indexPath.row;
            
            return;
        }
        
        JQLOG(@"第1列左边：%ld:%@---%ld----第1列右边：%ld:%@", indexPath.leftOrRight, self.provinces[indexPath.leftRow].name , indexPath.row, indexPath.leftRow, self.provinces[indexPath.leftRow].cities[indexPath.row]);
        
    } else if(indexPath.column == 1){
        
        self.currentSecondDataIndex = indexPath.row;
        JQLOG(@"第2列：%ld:%@", indexPath.leftRow, SECONDMENUDATAS[indexPath.leftRow]);
        
    } else {
        
        self.currentThridDataIndex = indexPath.row;JQLOG(@"第3列：%ld:%@", indexPath.row, THRIDMENUDATAS[indexPath.row]);
    }
    
}

@end