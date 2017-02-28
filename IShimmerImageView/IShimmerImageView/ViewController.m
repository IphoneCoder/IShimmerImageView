//
//  ViewController.m
//  IShimmerImageView
//
//  Created by Yaqiang Wang on 17/2/28.
//  Copyright © 2017年 Yaqiang Wang. All rights reserved.
//

#import "ViewController.h"
#import "IShimmerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i<5; i++) {
        IShimmerView *tempView = [[IShimmerView alloc] initWithImage:[UIImage imageNamed:@"1"] frame:CGRectMake(20, 50+i*20, 28, 15)];
        tempView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tempView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
