//
//  ViewController.m
//  手势
//
//  Created by Hao on 16/5/10.
//  Copyright © 2016年 xinguo. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyView *view = [[MyView alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
