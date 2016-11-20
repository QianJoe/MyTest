//
//  JQCommentViewController.m
//  SchoolOrderFood
//
//  Created by 乔谦 on 16/11/15.
//  Copyright © 2016年 wlr. All rights reserved.
//

#import "JQCommentViewController.h"

@interface JQCommentViewController () <UITableViewDataSource, UITableViewDelegate>

/**头view，用于总评分*/
@property (nonatomic, weak) UIView *headView;
/**总平均评分*/
@property (nonatomic, weak) UILabel *avgPointLabel;

/**评论的tableview*/
@property (nonatomic, weak) UITableView *commentTableView;

@end

@implementation JQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHeadView];
    
    [self initTableView];
    
}

- (void)initHeadView {
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    self.headView = headView;
    [self.view addSubview:headView];
    
    [headView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.height.equalTo(70);
    }];
    
    UILabel *comLabel = [[UILabel alloc] init];
    comLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    comLabel.text = @"综合评分";
    [headView addSubview:comLabel];
    
    [comLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(headView).offset(50);
        make.top.equalTo(headView).offset(8);
        make.bottom.equalTo(headView.bottom).offset(-8);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BackgroundColor;
    [headView addSubview:line];
    
    [line makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.centerX.equalTo(headView);
        make.top.equalTo(headView).offset(8);
        make.bottom.equalTo(headView.bottom).offset(-8);
        make.width.equalTo(2);
    }];
    
    UILabel *avgPointLabel = [[UILabel alloc] init];
    self.avgPointLabel = avgPointLabel;
    avgPointLabel.textColor = naviColor;
    avgPointLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    avgPointLabel.text = @"4.9";
    [headView addSubview:avgPointLabel];
    
    [avgPointLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(line.right).offset(50);
        make.top.equalTo(headView).offset(8);
        make.bottom.equalTo(headView.bottom).offset(-8);
    }];
    
}

- (void)initTableView {
    
    UITableView *commentTableView = [[UITableView alloc] init];
    commentTableView.delegate = self;
    commentTableView.dataSource = self;
    self.commentTableView = commentTableView;
    [self.view addSubview:commentTableView];
    
    [commentTableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headView.bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom);
    }];
    
//    [commentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TESTID];
}

#pragma mark - tableview的数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

//NSString *TESTID = @"TESTID";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = @"xxxx";
    return cell;
}

@end

