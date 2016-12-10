//
//  TodayOrderViewController.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "TodayOrderViewController.h"
#import "TotalTableViewCell.h"
#import "GoodNumTableViewCell.h"
#import "OrderInfoViewController.h"
#import "AppDelegate.h"

@interface TodayOrderViewController ()<UITableViewDelegate, UITableViewDataSource, DetailBtnClickDelegate>
@property (nonatomic, strong)UITableView *totalTableView;

@end

@implementation TodayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.totalTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.totalTableView.backgroundColor = CORLOR_BACKGROUND;
    self.totalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.totalTableView.delegate = self;
    self.totalTableView.dataSource = self;
    self.totalTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.totalTableView];
}

-(void)reloadTableView {
    [self.totalTableView reloadData];
}

-(void)settableViewFrame
{
    self.totalTableView.frame = self.view.bounds;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    }else if (indexPath.row == 1) {
        return 10;
    }else {
        return 40+45*self.orderlistModel.productsDescArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        TotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"totalTableView"];
        if (!cell) {
            cell = [[TotalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"totalTableView"];
        }
        if ([self.ordertype isEqualToString:@"1"]) {
            cell.mainTitle.text =  @"早餐配送订单总数";
        }else if([self.ordertype isEqualToString:@"2"]){
            cell.mainTitle.text =  @"午餐餐配送订单总数";
        }else {
            cell.mainTitle.text =  @"晚餐配送订单总数";
        }
        cell.timeLabel.text = self.orderlistModel.date;
        cell.numLabel.text = [NSString stringFromNumber:self.orderlistModel.num];
        
        return cell;
    }else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.contentView.backgroundColor = CORLOR_BACKGROUND;
        }
        return cell;
    }else {
        GoodNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodNumTableViewCell"];
        if (!cell) {
            cell = [[GoodNumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodNumTableViewCell"];
        }
        cell.detailBtnClickDelegate = self;
        
        [cell setModels:self.orderlistModel];
        
        return cell;
    }
}

-(void)detailBtnClick
{
    
    OrderInfoViewController *orderinfo = [[OrderInfoViewController alloc]init];
    orderinfo.date = self.orderlistModel.date;
    orderinfo.ordertype = self.ordertype;
    AppDelegate *delelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delelgate.currentNav pushViewController:orderinfo animated:YES];
}


@end
