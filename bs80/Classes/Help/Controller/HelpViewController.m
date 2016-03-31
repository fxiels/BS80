//
//  HelpViewController.m
//  bs80
//
//  Created by xie on 16/3/29.
//  Copyright © 2016年 bs80. All rights reserved.
//

#import "HelpViewController.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define GlobalBg RGBColor(223, 223, 223)

@interface HelpViewController ()

@end

UIScrollView *scrollView;
@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.2);
    [scrollView flashScrollIndicators];
    scrollView.directionalLockEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-180/2, 10, 180, 40)];
    label.text = @"bs80蓝牙扫描设置条码";
    [scrollView addSubview:label];
    
    
    
    
    UIImageView  *imageSpp=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-300/2, 70, 300, 150)];
    [imageSpp setImage:[UIImage imageNamed:@"spp"]];
    [scrollView addSubview:imageSpp];
    
    
    
    
    UIImageView  *imageBle=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-300/2, 230, 300, 150)];
    [imageBle setImage:[UIImage imageNamed:@"ble"]];
    [scrollView addSubview:imageBle];
    
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }



@end