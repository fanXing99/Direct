//
//  RootVC.h
//  Direct
//
//  Created by fanXing on 17/3/13.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"
@interface RootVC : UIViewController
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton  *rightBtn;
@property (nonatomic,strong) UILabel  *titleLB;
@property (nonatomic,strong) UIImageView *navView;
@property (nonatomic,strong) CustomNavigationBar *navBar;
@property (nonatomic,strong) UIView *lineView;

-(void)initNavgationView;

-(void)addCustomBackBtn;
-(void)addRightBtnImage:(UIImage *)image target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)addRightBtnTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)addLeftBtnImage:(UIImage *)image target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)addLeftBtnTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;



@end
