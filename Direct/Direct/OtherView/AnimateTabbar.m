//
//  AnimateTabbar.m
//  Direct
//
//  Created by fanXing on 17/3/13.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import "AnimateTabbar.h"
#import <YYKit/YYKit.h>
#import "ReactiveCocoa.h"
#define  TAB_HIGHT 50


@interface  AnimateTabbar(){
    UIButton *_curBtn;
}

@end
@implementation AnimateTabbar


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index
{
    
    CGRect frame1=CGRectMake(frame.origin.x, frame.size.height-TAB_HIGHT,kScreenWidth, TAB_HIGHT);
    self = [super initWithFrame:frame1];
    if (self) {
        [self initViewWith:index];
        
    }
    return self;
}


-(void) initViewWith:(NSInteger) index{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), TAB_HIGHT)];
    bgView.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:bgView];
    for(int i = 0 ;i < 3;i ++){
      UIButton* btn = [self createTabBtnIndex:i];
        btn.tag = i;
      [bgView addSubview:btn];
      [[[btn  rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(UIButton *btn) {
          if(_curBtn == btn){
              return nil;
          }
           [self imgAnimate:btn];
          _curBtn.selected = NO;
           btn.selected = YES;
            _curBtn = btn;
            return @(btn.tag);
      }] subscribeNext:^(NSNumber *index) {
          if(self.delegate && [self.delegate respondsToSelector:@selector(animateselectIndex:)]){
              if(index!= nil){
                   [self.delegate animateselectIndex:[index intValue]];
              }
             
          }
      }];
    }
}
-(UIButton *) createTabBtnIndex:(NSInteger)index {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    btn.frame = CGRectMake(index * kScreenWidth/3 , 0, kScreenWidth/3,TAB_HIGHT );
    RACSignal *signal =   [RACSignal return:@(index)];
    [[signal map:^id(NSNumber *value) {
        if([value intValue] == 0){
            _curBtn = btn;
            _curBtn.selected = YES;
            return @"首页";
        }else if([value intValue] == 1){
            return @"开播";
        }else{
            return @"我的";
        }
    }] subscribeNext:^(NSString *title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }];
    return btn;
}
- (void)imgAnimate:(UIButton*)btn{
    UIView *view=btn;
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8, 0.8);
     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.2 animations:
          ^(void){
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
              
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                   
                   
               } completion:^(BOOL finished){//do other thing
               }];
          }];
     }];
    
    
}



@end
