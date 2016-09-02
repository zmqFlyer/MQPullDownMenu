//
//  HomeViewController.m
//  MQPullDownMenu
//
//  Created by irs on 16/9/2.
//  Copyright © 2016年 zmq. All rights reserved.
//

#import "HomeViewController.h"
#import "MQMesaageBtn.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    
    UIButton *msgBtn = [MQMesaageBtn sharedButton];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:msgBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
