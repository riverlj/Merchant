//
//  PrintUtli.h
//  Merchant
//
//  Created by 李江 on 16/12/10.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrintUtli : NSObject
+ (void)print:(NSArray *)models fromVc:(UIViewController *)vc nav:(UINavigationController *)nav printListVc:(UIViewController *)pvc;
@end
