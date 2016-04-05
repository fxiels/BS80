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
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.1);
    [scrollView flashScrollIndicators];
    scrollView.directionalLockEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-260/2, 10, 260, 40)];
    label.text = NSLocalizedString(@"LblTitle", nil);
    [scrollView addSubview:label];
    
    
    UIImageView  *imageBle=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-300/2, 70, 300, 150)];
    [imageBle setImage:[UIImage imageNamed:@"ble"]];
    [scrollView addSubview:imageBle];
    
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }



@end
