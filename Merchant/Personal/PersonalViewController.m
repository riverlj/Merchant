//
//  PersonalViewController.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "PersonalViewController.h"
#import "AppDelegate.h"
#import "BCListViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface PersonalViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *autoPrintSwitch;
@property (weak, nonatomic) IBOutlet UILabel *bCLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation PersonalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.autoPrintSwitch.transform = CGAffineTransformMakeScale( 0.75, .75);
    NSInteger autoprint = [[NSUserDefaults getValue:@"autoprint"] integerValue];
    if (autoprint == 0) {
        [self.autoPrintSwitch setOn:NO];
    }else {
        [self.autoPrintSwitch setOn:YES];
    }
    
    [self.bCLabel addTapAction:@selector(bcLabelTap:) target:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userNameLabel.text = delegate.userInfoModel.name;
}

-(void)bcLabelTap:(id)sender
{
    BCListViewController *bcvc = [[BCListViewController alloc]init];
    BaseNavigationController *baseNav = [[BaseNavigationController alloc]initWithRootViewController:bcvc];
    [self presentViewController:baseNav animated:YES completion:nil];
}

- (IBAction)switchAction:(UISwitch *)sender
{
    BOOL isOn = [sender isOn];
    [NSUserDefaults setValue:[NSString stringFromNumber:@(isOn)] forKey:@"autoprint"];
}
- (IBAction)loginoutAction:(id)sender {
    [NSUserDefaults clearValueForKey:@"token"];
    
    LoginViewController *login = [[LoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
