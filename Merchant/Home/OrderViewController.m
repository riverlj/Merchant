//
//  OrderViewController.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "OrderViewController.h"
#import "TodayOrderViewController.h"
#import "HistoryOrderViewController.h"
#import "OrderlistModel.h"

@interface OrderViewController ()
{
    NSMutableArray *_btnArray;
    RSRadioGroup *group;
}
@property (nonatomic, strong)TodayOrderViewController *todayVc;
@property (nonatomic, strong)HistoryOrderViewController *historyVc;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnArray = [[NSMutableArray alloc]init];
    
    NSDictionary *btn1 = @{
                           @"title":@"今日订单",
                           @"key":@"all",
                           @"models":[NSMutableArray array]
                           };
    NSDictionary *btn2 = @{
                           @"title":@"历史订单",
                           @"key":@"needrate",
                           @"models":[NSMutableArray array]
                           };

    [_btnArray addObject:btn1];
    [_btnArray addObject:btn2];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.layer.borderColor = CORLOR_LINE.CGColor;
    view.layer.borderWidth = 1.0;
    group = [[RSRadioGroup alloc] init];
    
    for (int i=0; i<_btnArray.count; i++) {
        NSDictionary *dic = _btnArray[i];
        RSSubTitleView *title = [[RSSubTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.width/[_btnArray count], view.height)];;
        title.left = i*title.width;
        title.tag = i;
        [title setTitle:[dic valueForKey:@"title"] forState:UIControlStateNormal];
        [title addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:title];
        [group addObj:title];
    }
    [group setSelectedIndex:0];

    self.todayVc = [[TodayOrderViewController alloc] init];
    self.todayVc.view.frame = CGRectMake(0, 64+40+10, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-10);
    self.todayVc.ordertype = self.ordertype;
    [self.todayVc settableViewFrame];
    [self.view addSubview:self.todayVc.view];
    
    self.historyVc = [[HistoryOrderViewController alloc] init];
    self.historyVc.view.frame = CGRectMake(0, 64+40+10, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-10);
    self.historyVc.ordertype = self.ordertype;
    [self.historyVc settableViewFrame];
    [self.view addSubview:self.historyVc.view];
    self.historyVc.view.hidden = YES;
    
    __weak OrderViewController *selfWeak = self;
    [[RSToastView shareRSToastView] showHUD:@""];
    [OrderlistModel getOrderList:self.ordertype success:^(NSArray *array) {
        [[RSToastView shareRSToastView] hidHUD];
        if (array.count>0) {
            OrderlistModel *model = array[0];
            selfWeak.todayVc.orderlistModel = model;
            NSMutableArray *historyArray = [[NSMutableArray alloc]init];
            for (int i=1; i<array.count; i++) {
                [historyArray addObject:array[i]];
            }
            selfWeak.historyVc.datasource = [historyArray copy];
            [selfWeak.todayVc reloadTableView];
            [selfWeak.historyVc reloadTableView];
        }
    }];

}

-(void)didClickBtn:(RSSubTitleView *)sender {
    
    [group setSelectedIndex:sender.tag];
    if (sender.tag == 0) {
        self.historyVc.view.hidden = YES;
        self.todayVc.view.hidden = NO;
    }else{
        self.historyVc.view.hidden = NO;
        self.todayVc.view.hidden = YES;
    }
}

@end
