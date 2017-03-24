//
//  RootTabBarController.m
//  Direct
//
//  Created by fanXing on 17/3/13.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import "RootTabBarController.h"
#import "MineVC.h"
#import "HomeVC.h"
#import "BeginShowVC.h"
#import "MacroInfo.h"
#import "AnimateTabbar.h"
#import "ReactiveCocoa.h"
@interface RootTabBarController ()<AnimateSelectDelegate>

@property (nonatomic,strong) MineVC *mineVC;
@property (nonatomic,strong) HomeVC *homeVC;
@property (nonatomic,strong) BeginShowVC *beginShowVC;


@end

@implementation RootTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.homeVC = [HomeVC new];
    [self createTabBarItem:self.homeVC title:@"首页" image:@"home_shouye2" imageSelected:@"home_shouye1"];
    [self addChildViewController:self.homeVC];

    self.beginShowVC = [BeginShowVC new];
    [self createTabBarItem:self.beginShowVC title:@"开播" image:@"home_shouye2" imageSelected:@"home_shouye1"];
    [self addChildViewController:self.beginShowVC];
    
    self.mineVC = [MineVC new];
    [self createTabBarItem:self.mineVC title:@"我的" image:@"home_shouye2" imageSelected:@"home_shouye1"];
    [self addChildViewController:self.mineVC];
    [self.tabBar setHidden:YES];
    AnimateTabbar *animateTabbar = [[AnimateTabbar alloc] initWithFrame:self.view.frame index:0];
    animateTabbar.tag = 2000;
    animateTabbar.delegate = self;
    [self.view addSubview:animateTabbar];
}



- (void)createTabBarItem:(UIViewController *)vc title:(NSString *)title image:(NSString *)image imageSelected:(NSString *)imageSelected {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:km_rgb(155.0, 155.0, 163.0), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:km_rgb(42.0, 187.0, 255.0), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UIOffset offset;
    offset.horizontal = 0.0;
    offset.vertical = -2.0;
    [vc.tabBarItem setTitlePositionAdjustment:offset];
}

-(void) animateselectIndex:(NSInteger)index {
    self.selectedIndex = index;
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
