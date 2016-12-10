//
//  HomeViewController.m
//  Merchant
//
//  Created by 李江 on 16/11/29.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "HomeViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "HomeTableViewCell.h"
#import "OrderViewController.h"
#import "UserInfoModel.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "PrinterSDK.h"
#import "BCListViewController.h"



@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource,BluetoothDelegate>
{
    NSInteger count;
}
@property (strong, nonatomic) UITableView *homeTableView;
@property (nonatomic, copy)NSMutableArray *dataSource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    NSDictionary *dic  = @{
                           @"1": @{@"imageName":@"icon_breakfast",@"typeName":@"早餐订单", @"typeid":@"1"},
                           @"2": @{@"imageName":@"icon_lunch",@"typeName":@"午餐订单", @"typeid":@"2"},
                           @"3":@{@"imageName":@"icon_dinner",@"typeName":@"晚餐订单", @"typeid":@"3"}
                           };
    _dataSource = [[NSMutableArray alloc] init];
    count = 5;
    
    [UserInfoModel getUserInfoSuccess:^{}];
    
    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.homeTableView.backgroundColor = CORLOR_BACKGROUND;
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTableView.tableFooterView = [UIView new];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    [self.view addSubview:self.homeTableView];
    
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [leftDrawerButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    __weak HomeViewController *selfWeak = self;
    [UserInfoModel getUserbizlistSuccess:^{
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSArray *bizlistArray = delegate.userInfoModel.bizlist;
        for (int i=0; i<bizlistArray.count; i++) {
            NSString *biz = [bizlistArray[i] stringValue];
            NSDictionary *tempdic = [dic valueForKey:biz];
            [selfWeak.dataSource addObject:tempdic];
            [selfWeak.homeTableView reloadData];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *homeTableCell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewController"];
    if (!homeTableCell) {
        homeTableCell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeViewController"];
    }
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    homeTableCell.foodtypeImageView.image = [UIImage imageNamed:[dic valueForKey:@"imageName"]];
    homeTableCell.foodNameLabel.text = [dic valueForKey:@"typeName"];
    
    return homeTableCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    OrderViewController *order = [[OrderViewController alloc] init];
    order.ordertype = [dic valueForKey:@"typeid"];
    order.title = [dic valueForKey:@"typeName"];
    [self.navigationController pushViewController:order animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
