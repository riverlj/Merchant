//
//  OrderInfoViewController.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "OrderInfoTableViewCell.h"
#import "AllModelDetail.h"
#import "PrintUtli.h"
#import "BCListViewController.h"

@interface OrderInfoViewController ()<UITableViewDelegate, UITableViewDataSource, PrintBtnClickDelegate>
@property (nonatomic, strong)UITableView *totalTableView;
@property (nonatomic, strong)AllModelDetail *allModelDetail;

@end

@implementation OrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.totalTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.totalTableView.backgroundColor = CORLOR_BACKGROUND;
    self.totalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.totalTableView.delegate = self;
    self.totalTableView.dataSource = self;
    self.totalTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.totalTableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_print"]];
    imageView.frame = CGRectMake(0, SCREEN_HEIGHT -120, 80, 80);
    imageView.centerX = self.view.centerX;
    imageView.layer.cornerRadius = 40;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    [imageView addTapAction:@selector(printAllOrders:) target:self];
    
    __weak OrderInfoViewController *selfWeak = self;
    
    [AllModelDetail getAllOrderDetail:self.ordertype OrderDate:self.date success:^(AllModelDetail *model) {
        selfWeak.allModelDetail = model;
        [selfWeak.totalTableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allModelDetail.orders.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderModel *orderModel = self.allModelDetail.orders[indexPath.row];
    return 40+45*5+orderModel.dashes.count*45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    OrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoTableViewCell"];
    if (!cell) {
        cell = [[OrderInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderInfoTableViewCell"];
    }
    cell.printBtnClickDelegate = self;
    
    OrderModel *orderModel = self.allModelDetail.orders[indexPath.row];
    [cell setModels:orderModel];
    
    return cell;
}

-(void)printAllOrders:(UIGestureRecognizer *)sender
{
    NSLog(@"2222");
}

-(void)printBtnClick:(OrderModel *)model
{
    //打印
    NSArray *array = @[
                       model
                       ];
    BCListViewController *bclist = [[BCListViewController alloc] init];
    [PrintUtli print:array fromVc:self nav:self.navigationController printListVc:bclist];
}


@end
