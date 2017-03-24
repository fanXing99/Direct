//
//  CustomNavigationBar.h
//  XiaoBao
//
//  Created by fanXing on 16/7/20.
//  Copyright © 2016年 baosm. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end
