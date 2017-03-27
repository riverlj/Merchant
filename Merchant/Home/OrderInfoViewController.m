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

@interface OrderInfoViewController ()<UITableViewDelegate, UITableViewDataSource, PrintBtnClickDelegate, BluetoothDelegate>
@property (nonatomic, strong)UITableView *totalTableView;
@property (nonatomic, strong)AllModelDetail *allModelDetail;
@property (nonatomic, strong)NSArray *printedArray;

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
        
        [selfWeak setPrintedStatus];
        
        [selfWeak.totalTableView reloadData];
    }];
}

-(void)setPrintedStatus
{
    NSArray *printedArray = [NSUserDefaults getPrintedOrders];
    for (int i=0; i<self.allModelDetail.orders.count; i++) {
        OrderModel *model = self.allModelDetail.orders[i];
        for (NSString *orderid in printedArray) {
            if ([orderid isEqualToString:model.orderid]) {
                model.printed = YES;
                continue;
            }
        }
    }
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
    if (![PrinterWraper isPrinterAvailable:[NSUserDefaults getDeviceUid]]) {
        [[RSToastView shareRSToastView] showToast:@"打印机未连接"];
        return;
    }
    [[RSToastView shareRSToastView] showHUD:@"打印中..."];
    BCListViewController *bclist = [[BCListViewController alloc] init];
    self.printedArray = self.allModelDetail.orders;
    [PrintUtli print:self.printedArray fromVc:self nav:self.navigationController printListVc:bclist];
}

-(void)printBtnClick:(OrderModel *)model
{
    if (![PrinterWraper isPrinterAvailable:[NSUserDefaults getDeviceUid]]) {
        [[RSToastView shareRSToastView] showToast:@"打印机未连接"];
        return;
    }
    //打印
    [[RSToastView shareRSToastView] showHUD:@"打印中..."];
    self.printedArray = @[
                       model
                       ];
    BCListViewController *bclist = [[BCListViewController alloc] init];
//    PrintUtli *util = [[PrintUtli alloc] init];
    [PrintUtli print:self.printedArray fromVc:self nav:self.navigationController printListVc:bclist];
}

-(void)finishPrint
{
    for (int i=0; i<self.allModelDetail.orders.count; i++) {
        OrderModel *model = self.allModelDetail.orders[i];
        for (OrderModel *model1 in self.printedArray) {
            if ([model.orderid isEqualToString:model1.orderid]) {
                model.printed = YES;
                continue;
            }
        }
    }
    
    [[RSToastView shareRSToastView] hidHUD];
    [self.totalTableView reloadData];
    
     NSArray *array = [NSUserDefaults getPrintedOrders];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    [mArray addObjectsFromArray:array];
    for (OrderModel *model in self.printedArray) {
        NSString *orderid = model.orderid;
        BOOL flag = false;
        for (NSString *torderid in array) {
            if ([torderid isEqualToString:orderid]) {
                flag = true;
                break;
            }
        }
        
        if (!flag) {
            [mArray addObject:orderid];
        }
    }
    [NSUserDefaults setPrintedOrders:mArray];
}

@end
