//
//  HistoryOrderViewController.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "HistoryOrderViewController.h"
#import "HistoryTableViewCell.h"
#import "OrderlistModel.h"

@interface HistoryOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *historyTableview;

@end

@implementation HistoryOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.historyTableview = [[UITableView alloc] initWithFrame:self.view.frame];
    self.historyTableview.backgroundColor = CORLOR_BACKGROUND;
    self.historyTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.historyTableview.delegate = self;
    self.historyTableview.dataSource = self;
    self.historyTableview.tableFooterView = [UIView new];
    self.historyTableview.tableHeaderView =  [self tableHearder];
    [self.view addSubview:self.historyTableview];
}

-(void)settableViewFrame
{
    self.historyTableview.frame = self.view.bounds;
}
-(void)reloadTableView {
    [self.historyTableview reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell"];
    if (!cell) {
        cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryTableViewCell"];
    }
    
    OrderlistModel *model = self.datasource[indexPath.row];
    [cell setModels:model];
    
    return cell;
}

-(UIView *)tableHearder{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    NSArray *array = @[@"日期",@"总数量",@"总金额"];
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15+(SCREEN_WIDTH-30)/3*i, 0, (SCREEN_WIDTH-30)/3, 40)];
        label.textColor = CORLOR_7d7d7d;
        label.font = RS_FONT_12;
        label.text = array[i];
        switch (i) {
            case 0:
                label.textAlignment = NSTextAlignmentLeft;
                break;
            case 1:
                label.textAlignment = NSTextAlignmentCenter;
                break;
            case 2:
                label.textAlignment = NSTextAlignmentRight;
                break;
            default:
                break;
        }
        [view addSubview:label];
    }
    view.backgroundColor = [UIColor whiteColor];
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(0, 39, SCREEN_WIDTH, 1);
    layer.backgroundColor = CORLOR_LINE.CGColor;
    [view.layer addSublayer:layer];
    return view;
}




@end
