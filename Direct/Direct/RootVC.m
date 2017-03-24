//
//  RootVC.m
//  Direct
//
//  Created by fanXing on 17/3/13.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import "RootVC.h"
#import "CustomNavigationBar.h"
#import <YYKit/YYKit.h>

@interface RootVC ()

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    if (self.titleLB.text) {
        self.titleLB.text  =title;
    }else{
        [self initNavgationView];
        self.titleLB.text  =title;
    }
}


-(void)initNavgationView{
    if (self.navBar==nil) {
        CustomNavigationBar *navbar = [[[NSBundle mainBundle] loadNibNamed:@"CustomNavigationBar" owner:self options:nil] lastObject];
        navbar.frame =CGRectMake(0, 0, self.view.frame.size.width, 64);
        [self.view addSubview:navbar];
        self.navBar = navbar;
        //navBar
        _navBar.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:_navBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual  toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [self.view   addConstraint:constraint1];
        
        
        NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:_navBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual  toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
        [self.view addConstraint:constraint2];
        
        
        NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:_navBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual  toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
        [self.view   addConstraint:constraint3];
        
        NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:_navBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual  toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:64.0f];
        [_navBar addConstraint:constraint4];
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:YES];
        if (self.navigationController.viewControllers.count<=1) {
            
        }else{
            [self addCustomBackBtn];
        }
    }
}
-(UILabel *)titleLB{
    return self.navBar.titleLB;
}
-(UIButton *)leftBtn{
    return self.navBar.leftBtn;
}
-(UIButton *)rightBtn{
    [self.navBar.rightBtn setHidden:NO];
    return self.navBar.rightBtn;
    
}

-(UIView *)lineView{
    return self.navBar.lineView;
}
-(void)addCustomBackBtn{
    [self.leftBtn addTarget:self action:@selector(pushLeftBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setHidden:NO];
    
}

-(void)addRightBtnImage:(UIImage *)image target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    
    [self.rightBtn setImage:image forState:UIControlStateNormal];
    [self.rightBtn addTarget:target action:action forControlEvents:controlEvents];
    [self.rightBtn setHidden:NO];
}
-(void)addRightBtnTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [self.rightBtn setHidden:NO];
    [self.rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    

    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGSize size = [title sizeForFont:self.rightBtn.titleLabel.font size:CGSizeMake(100, 44) mode:NSLineBreakByWordWrapping];

    [self.rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 100-size.width-15, 0, 0)];
    [self.rightBtn setTitle:title forState:UIControlStateNormal];
    [self.rightBtn addTarget:target action:action forControlEvents:controlEvents];
}
-(void)addLeftBtnImage:(UIImage *)image target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [self.leftBtn setImage:image forState:UIControlStateNormal];
    [self.leftBtn addTarget:target action:action forControlEvents:controlEvents];
    [self.leftBtn setHidden:NO];
}
-(void)addLeftBtnTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 56)];
    [self.leftBtn setTitle:title forState:UIControlStateNormal];
    [self.leftBtn addTarget:target action:action forControlEvents:controlEvents];
    [self.leftBtn setHidden:NO];
}
- (void)pushLeftBtnclick:(id)sender
{
    
    if (self.navigationController==nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        if (self.navigationController.viewControllers.count==1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
