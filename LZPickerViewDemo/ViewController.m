//
//  ViewController.m
//  LZPickerViewDemo
//
//  Created by Lvlinzhe on 2018/6/29.
//  Copyright © 2018年 Lvlinzhe. All rights reserved.
//

#import "ViewController.h"
#import "LZPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorful.jpg"]];
    imageView.frame = self.view.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 50);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setTitle:@"showPicker" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn{
    
    LZPickerView *pickerView = [[LZPickerView alloc] initWithItems:@[@"item1",@"item2",@"item3"]];
    
//    LZPickerView *pickerView = [[LZPickerView alloc] initWithDatePickerMode:UIDatePickerModeDateAndTime];
    [pickerView showInView:self.view pickCompletion:^(NSString * _Nonnull string) {
        NSLog(@"%@",string);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
