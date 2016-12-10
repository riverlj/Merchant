//
//  PrintUtli.m
//  Merchant
//
//  Created by 李江 on 16/12/10.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "PrintUtli.h"
#import "BaseNavigationController.h"
#import "AllModelDetail.h"
#import "OrderlistModel.h"

@implementation PrintUtli

+ (void)print:(NSArray *)models fromVc:(UIViewController *)vc nav:(UINavigationController *)nav printListVc:(UIViewController *)pvc {
    
    [PrinterWraper SetBlutoothDelegate:self];
    
    for (int i=0; i<models.count; i++) {
        OrderModel *model = models[i];
        
        //中字体
        [PrinterWraper setPrintFormat:0 LineSpace:28 alinment:1 rotation:0];
        [PrinterWraper addPrintText:[NSString stringWithFormat:@"*****#%@红领巾订单*****\n",model.seq]];//打印文字
        [PrinterWraper addPrintText:@"清华大学西区食堂1号窗口\n"];//缺食堂名称
        [PrinterWraper addPrintText:@"已在线支付\n"];
        NSString *line = [PrinterWraper getSplitLine];
        //分割线
        [PrinterWraper addPrintText:line];
        [PrinterWraper addPrintText:[NSString stringWithFormat:@"下单时间：%@\n",model.ordertime]];//下单时间
        [PrinterWraper addPrintText:@"-----菜品信息-----\n"];//下单时间
        NSMutableArray *body = [[NSMutableArray alloc] init];
        NSArray *headers =@[@"菜品名",@"数量",@"金额"];
        [body addObject:headers];
        for (int i=0; i<model.dashes.count; i++) {
            ProductsDesc *desc = model.dashes[i];
            NSArray *values0 =@[desc.name, desc.num, @"￥1"];//缺菜品金额
            [body addObject:values0];
        }
        
        //分割线
        line = [PrinterWraper getSplitLine];
        [PrinterWraper addPrintText:line];
        [PrinterWraper addPrintText:[NSString stringWithFormat:@"已付          %@\n", @(11)]];//缺金额
        line = [PrinterWraper getSplitLine];
        [PrinterWraper addPrintText:line];
        [PrinterWraper addPrintText:[NSString stringWithFormat:@"%@\n", model.address]];
        [PrinterWraper addPrintText:[NSString stringWithFormat:@"%@      %@\n", model.username, model.mobile]];
        [PrinterWraper addPrintText:[NSString stringWithFormat:@"*****#%@红领巾订单*****\n",model.seq]];//打印文字
        [PrinterWraper moveToNextPage];
        
    }
    
    BOOL res=   [PrinterWraper startPrint:nav deviceTag:0];
    if (!res) {
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:pvc];
        [vc presentViewController:baseNav animated:YES completion:nil];
        
    }
    
}

-(void)finishPrint
{
    NSLog(@"finish");
    [PrinterWraper cleanPrinterBuffer];
}

@end
