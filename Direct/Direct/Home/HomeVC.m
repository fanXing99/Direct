//
//  HomeVC.m
//  Direct
//
//  Created by fanXing on 17/3/13.
//  Copyright © 2017年 fanxing. All rights reserved.


#import "HomeVC.h"
#import <YYKit/YYKit.h>
#import "MacroInfo.h"
#import "ReactiveCocoa.h"

#define NAV_HEIGHT 94
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIScrollView *sclRootView;
@property (nonatomic,assign) CGFloat lastContentOffset;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *barNav;
@property (nonatomic,strong) CustomNavigationBar *customNavigationBar;
@property (nonatomic,strong)  UIView *titleNavView;
@property (nonatomic,strong)  NSMutableArray *btnArray;

@end

@implementation HomeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    self.sclRootView = [UIScrollView new];
    self.sclRootView.backgroundColor = [UIColor brownColor];
    self.sclRootView.contentSize =CGSizeMake(kScreenWidth, kScreenHeight-NAV_HEIGHT);
    self.sclRootView.frame = CGRectMake(0, NAV_HEIGHT, kScreenWidth, kScreenHeight - NAV_HEIGHT);
    self.sclRootView.pagingEnabled = YES;
    self.sclRootView.tag = 1000;
    self.btnArray = [[NSMutableArray alloc] initWithCapacity:0];
    
//    self.sclRootView.decelerationRate = 0.1;
  
    self.sclRootView.delegate = self;
    self.sclRootView.bounces = NO;
    [self.view addSubview:self.sclRootView];
    //self.title = @"首页";
    self.navBar.backgroundColor = [UIColor blackColor];
    
       NSArray *titleArr = @[@"关注",@"热门",@"最新"];
 
    for(int i = 0;i < [titleArr count]; i ++){
        
        UITableView *tableView = [UITableView new];
        [self.sclRootView addSubview:tableView];
       // tableView.bounces = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i+100;
        tableView.frame = CGRectMake(i * kScreenWidth , 0,kScreenWidth, kScreenHeight-NAV_HEIGHT);
        
//        if(i == 1){
//             self.tableView = tableView;
//        }
       
        
    }
   self.sclRootView.contentSize =CGSizeMake(kScreenWidth * [titleArr count] , kScreenHeight-NAV_HEIGHT);
   // tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.sclRootView setContentOffset:CGPointMake(kScreenWidth, 0)];
 
    UIView *navbar = [[UIView alloc] initWithFrame:CGRectMake(0,  0,kScreenWidth , NAV_HEIGHT)];
    [self.view addSubview:navbar];
    navbar.backgroundColor = [UIColor blackColor];
    self.barNav = navbar;

    [[[RACSignal return:@"Nav"] map:^id(id value) {
        
        CustomNavigationBar *customNavigationBar = [[[NSBundle mainBundle] loadNibNamed:@"CustomNavigationBar" owner:self options:nil] lastObject];
        customNavigationBar.frame = CGRectMake(0, 0, kScreenWidth, NAV_HEIGHT - 30);
        customNavigationBar.backgroundColor = [UIColor redColor];
        customNavigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        customNavigationBar.lineView.backgroundColor = [UIColor lightGrayColor];
        customNavigationBar.titleLB.text = @"直播";
       dispatch_async(dispatch_get_main_queue(), ^{
        [customNavigationBar.rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
           [self.barNav addSubview:customNavigationBar];
       });
        
       return customNavigationBar.rightBtn;
        
    }] subscribeNext:^(id x) {
        
    }];
    RACSignal *titleNavSignal  =  [RACSignal return:@"titleNav"];
       [[titleNavSignal map:^id(id value) {
        UIView *titleNavView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT - 30 , kScreenWidth, 30)];
           self.titleNavView = titleNavView;
           titleNavView.backgroundColor = [UIColor whiteColor];
        for(int i = 0;i < [titleArr count]; i ++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleNavView addSubview:btn];
            
            btn.frame = CGRectMake(i *kScreenWidth/titleArr.count , 0, kScreenWidth/titleArr.count,30);
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            btn.tag = 100 + i;
            [self.btnArray addObject:btn];
            [titleNavView addSubview:btn];
            
            if(i == 1){
                btn.selected = YES;
            }
           // btn.backgroundColor = [UIColor lightGrayColor];
            
        }
        return titleNavView;
        
    }] subscribeNext:^(UIView* titleNavView) {
        NSMutableArray *signalArr = [NSMutableArray arrayWithCapacity:0];
        for(UIView *view in titleNavView.subviews){
            if([view  isKindOfClass:[UIButton class]]){
                UIButton *btn = (UIButton*) view;
                
             [signalArr addObject:[btn rac_signalForControlEvents:UIControlEventTouchUpInside]];
            }
        }
        [[RACSignal merge:signalArr] subscribeNext:^(UIButton *selectbtn) {
            
             [self.sclRootView setContentOffset:CGPointMake(kScreenWidth*(selectbtn.tag - 100), self.sclRootView.contentOffset.y) animated:YES];
            
        
            
            [self selectBtn:selectbtn];
           
        }];
      
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.barNav addSubview:titleNavView];
        });

    }];

}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FF"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FF"];
    }
    cell.textLabel.text = km_str(@"%ld",(long)indexPath.row);
    return cell;

}
#pragma mark - 关键代码：滚动方向判断
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.lastContentOffset = scrollView.contentOffset.y;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if(scrollView.tag == 1000) return;
    UIView *tabbar = [self.tabBarController.view viewWithTag:2000];
    if(tabbar.top >= kScreenHeight -tabbar.height && tabbar.top <= kScreenHeight){
        if(fabs(scrollView.contentOffset.y-self.lastContentOffset) <= tabbar.height){
            tabbar.top  +=  scrollView.contentOffset.y-self.lastContentOffset;

            if(tabbar.top >= kScreenHeight){
                 tabbar.top =kScreenHeight;
            }else if(tabbar.top <= kScreenHeight - tabbar.height ){
                tabbar.top = kScreenHeight - tabbar.height;
            }
        }
    }else  if(tabbar.top > kScreenHeight){
         tabbar.top =kScreenHeight;
    } else{
        tabbar.top = kScreenHeight - tabbar.height;
    }
    if( self.barNav.top >=  -self.barNav.height &&  self.barNav.top <= 0){
        if(fabs(scrollView.contentOffset.y-self.lastContentOffset) <=  self.barNav.height){
             self.barNav.top  -=  scrollView.contentOffset.y-self.lastContentOffset;
            
            if( self.barNav.top > 0){
                 self.barNav.top = 0;
            }else if( self.barNav.top <  -  self.barNav.height ){
                self.barNav.top =- self.barNav.height;
            }
            
         }
    }else  if( self.barNav.top >  0){
         self.barNav.top = 0;
    } else{
         self.barNav.top =  - self.barNav.height;
        
    }
    self.sclRootView.frame = CGRectMake(0,NAV_HEIGHT+self.barNav.top , kScreenWidth,kScreenHeight - NAV_HEIGHT-self.barNav.top+20);
//    self.sclRootView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight - NAV_HEIGHT-self.barNav.top+20);
    for(UIView * view in self.sclRootView.subviews){
        if([view isKindOfClass:[UITableView class]]){
            view.frame = CGRectMake(kScreenWidth*(view.tag - 100),-20 , kScreenWidth,kScreenHeight - NAV_HEIGHT-self.barNav.top);
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if(!decelerate){
        
        [self scrollViewDidEndDecelerating:scrollView];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if ( self.lastContentOffset  < scrollView.contentOffset.y) {
        NSLog(@"向上滚动");
    }else{
        NSLog(@"向下滚动");
    }
    
    
    
    
    if(scrollView.tag == 1000){
        NSInteger currentPage = scrollView.contentOffset.x/kScreenWidth ;
        [self selectBtn:self.btnArray[currentPage]];
    }
  
}

-(void) selectBtn:(UIButton*)selectbtn{
    
    for(UIView *view in self.titleNavView.subviews){
        if([view  isKindOfClass:[UIButton class]]){
            
            
            UIButton *btn = (UIButton*) view;
            if(btn.tag == selectbtn.tag){
                btn.selected = YES;
                [UIView animateWithDuration:0.1 animations:^{
                    btn.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
                }];
            }else{
                
                [UIView animateWithDuration:0.1 animations:^{
                    btn.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
                }];
                
                btn.selected = NO;
            }
        }
    }
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
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
