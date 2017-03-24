//
//  AnimateTabbar.h
//  Direct
//
//  Created by fanXing on 17/3/13.
//  Copyright © 2017年 fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnimateSelectDelegate <NSObject>
-(void) animateselectIndex:(NSInteger) index;
@end

@interface AnimateTabbar : UIView

@property (nonatomic,assign) id<AnimateSelectDelegate> delegate;

-(id)initWithFrame:(CGRect)frame index:(NSInteger)index;


@end
