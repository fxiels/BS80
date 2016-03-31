//
//  ViewController.m
//  bs80
//
//  Created by xie on 16/3/29.
//  Copyright © 2016年 bs80. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "HelpViewController.h"
#import "NavigationController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildVc:[[HomeViewController alloc] init] title:@"主页" image:@"icon_tabbar_mine" selectedImage:@"icon_tabbar_mine_selected"];
    [self setupChildVc:[[HelpViewController alloc] init] title:@"帮助" image:@"icon_tabbar_onsite" selectedImage:@"icon_tabbar_onsite_selected"];
    
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
