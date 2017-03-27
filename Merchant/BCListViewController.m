//
//  BCListViewController.m
//  Merchant
//
//  Created by 李江 on 16/12/8.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "BCListViewController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"

@interface BCListViewController ()<BluetoothDelegate,UIAlertViewDelegate>
{
    NSTimer *mytimer;
    UIActivityIndicatorView *activityView;
    NSArray *deviceList;
    NSInteger choosedIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation BCListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 44);
    [btn setImage:[UIImage imageNamed:@"nav-goback"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav-goback"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"蓝牙列表";
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -65, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    self.title = @"蓝牙列表";

    _tableview.rowHeight = 60;
    _tableview.tableFooterView = [UIView new];
    

    // 打印设置的默认值，可以修改，或者获取此值，对应于打印模版设置的内容
    NSDictionary *dic = @{
     @"lineSpace"  :@28,    //0～254 默认28  对应4毫米
     @"printertype":@0,// 打印机宽度  0 58mm,1 80mm,2 110mm,3,A4 针式打印机蓝牙适配器,3 airprint A4（台式无线打印机）
     @"printerfontsize":@0,//字体大小 0自动, 1小，2中，3大,
     @"copycount":@0,//0 1联，1 2联 ，2 3联
     @"autoprint":@1,//0 不自动打印  1自动打印
     @"company":NSLocalizedString(@"公司名称", @""),//公司名称 第一行自动居中 大字体，可多行
     @"operater":NSLocalizedString(@"店小二", @""),//开单员
     @"welcome":NSLocalizedString(@"谢谢惠顾", @""),//页脚，可多行
     @"barcode":@"",//二维码的链接地址
     
     @"name":@YES,//名称
     @"code":@NO,//商品条码编号
     @"styenum":@YES,//款号 货号
     @"color":@YES,//颜色
     @"spec":@NO,//规格
     @"count":@YES,//数量
     @"unit":@YES,//单位
     @"price":@YES,//价格
     @"xiaoji":@YES,//小记
     @"comment":@YES,//订单备注
       };
    [PrinterWraper setPrinterSetting:dic];


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self scanPrinter:nil ];
    [_tableview reloadData];

}

- (void)scanPrinter:(id)sender {
    //clean
    //    [self stopScan];
    
    [PrinterWraper SetBlutoothDelegate:self];
    [PrinterWraper StartScanTimeout:10];
    
    mytimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
}

-(void)timeout{
    [self stopScan];
    if (deviceList.count==0)
    {
        
        UIAlertView*alert=[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"没有扫描到专用打印机,只支持iphone4s或者new pad及以后的苹果设备",@"") delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", @"") otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)stopScan{
    [PrinterWraper StopScan];
    [activityView stopAnimating];
    [mytimer invalidate];
    mytimer=nil;
}

- (void)btnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"tablecellindentify"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tablecellindentify"];
    }
    CBPeripheral *device=[deviceList objectAtIndex:indexPath.row];
    NSString*name= device.name.length>0?device.name:NSLocalizedString(@"未知设备", @"");
    cell.textLabel.text=name;
    cell.detailTextLabel.text=NSLocalizedString(@"点击连接",@"");
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CBPeripheral *device=[deviceList objectAtIndex:indexPath.row];
    choosedIndex =indexPath.row;

    [PrinterWraper connectPrinterTag:0 uid:device.identifier.UUIDString useCache:YES];
}
-(void)BlueToothOpen:(BOOL)isopen
{
    if (!isopen) {
        [self stopScan];
        deviceList=nil;
        choosedIndex= -1;
        [_tableview reloadData];
    }
}

-(void)updateBluetoothDevice:(NSMutableArray*)devices
{
    deviceList  =devices;
    [_tableview reloadData];

}

-(void)didConnected:(NSString*)deviceUid Result:(BOOL)success
{
    [NSUserDefaults setDeviceUid:deviceUid];
    [_tableview reloadData];
    if (success)
        [self excuteTask];

}

-(void)finishPrint
{
    
}

-(void)excuteTask{
    NSString*info;
    if (self.hasTask ||self.taskmodel) {
        info=NSLocalizedString(@"连接成功，立即打印单据吗",@"") ;
    }else
        info=NSLocalizedString(@"恭喜您连接成功，是否检测打印效果？",@"") ;
    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:NSLocalizedString(@"取消", @"") otherButtonTitles:NSLocalizedString(@"确定", @""), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    if (buttonIndex==1) {
        if (self.hasTask) {
            [PrinterWraper startPrint:nil deviceTag:0];
            self.hasTask =NO;
            //            [PrinterWraper printDictionary:self.task fromviewc:nil  printeruid:nil needPreview:NO];
            //            self.task=nil;
            [self.navigationController popViewControllerAnimated:YES];
        }else if(self.taskmodel)
        {
            [PrinterWraper printModel:self.taskmodel fromviewc:nil printerTag:0 preview:NO failed:nil];
            self.taskmodel=nil;
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            //            NSDictionary*oneOder=@{@"title":@"Sale",@"time": [NSDate date],@"buyer":@"customer",@"payedmoney":[NSNumber numberWithFloat:1000],@"sum":[NSNumber numberWithFloat:1000],@"historymoney":[NSNumber numberWithFloat:0]};
            //            [PrinterWraper printDictionary:oneOder fromviewc:nil printeruid:nil needPreview:NO];
            [PrinterWraper addPrintText:@"掌上开单\n掌上开单\n掌上开单\n掌上开单\nSmart Invoice\nSmart Invoice\nSmart Invoice\n\n\n\n"];
            [PrinterWraper startPrint:nil deviceTag:0];
            
        }
    }else
    {
        //dis
        //        [printDevice disconnectPrinter:nil];
    }
}

@end
