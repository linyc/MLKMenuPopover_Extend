//
//  PopMenuView.m
//
//
//  Created by CY on 19/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopViewTableViewDelegate <NSObject>

-(void)didPopViewSelected:(NSInteger)selectedIndex;

@end

@interface PopMenuView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) id<PopViewTableViewDelegate> delegate;

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems;
//弹出菜单
-(void)show;
//收起菜单
-(void)hide;
@end
