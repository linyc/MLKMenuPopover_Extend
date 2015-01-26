//
//  PopMenuView.m
//
//  Created by CY on 19/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "PopMenuView.h"
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define MENU_ITEM_HEIGHT        44
#define FONT_SIZE               15
#define CELL_IDENTIGIER         @"MenuPopoverCell"
#define MENU_TABLE_VIEW_FRAME   CGRectMake(0, 0, frame.size.width, frame.size.height)
#define SEPERATOR_LINE_RECT     CGRectMake(10, MENU_ITEM_HEIGHT - 1, self.frame.size.width - 20, 1)
#define MENU_POINTER_RECT       CGRectMake([UIScreen mainScreen].bounds.size.width - 38, frame.origin.y, 23, 11)

#define CONTAINER_BG_COLOR      RGBA(0, 0, 0, 0.1f)

#define ZERO                    0.0f
#define ONE                     1.0f
#define ANIMATION_DURATION      0.5f

#define MENU_POINTER_TAG        1011
#define MENU_TABLE_VIEW_TAG     1012

#define LANDSCAPE_WIDTH_PADDING 50

@interface PopMenuView()

@property(nonatomic,retain) NSArray *menuItems;

@property(nonatomic,strong) UIButton *btnFrame;

@end

@implementation PopMenuView

- (instancetype)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.menuItems = aMenuItems;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.btnFrame = [[UIButton alloc] initWithFrame:frame];
        self.btnFrame.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self.btnFrame addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // Adding Menu Options Pointer
        UIImageView *menuPointerView = [[UIImageView alloc] initWithFrame:MENU_POINTER_RECT];
        menuPointerView.image = [UIImage imageNamed:@"options_pointer"];
        menuPointerView.tag = MENU_POINTER_TAG;
        [self.btnFrame addSubview:menuPointerView];
        
        // Adding menu Items table
        UITableView *menuItemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width - 140, 11, 130, aMenuItems.count * 44 - 1)];
        
        menuItemsTableView.dataSource = self;
        menuItemsTableView.delegate = self;
        menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        menuItemsTableView.scrollEnabled = NO;
        menuItemsTableView.backgroundColor = [UIColor clearColor];
        menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu_PopOver_BG"]];
        menuItemsTableView.backgroundView = bgView;
        
        [self.btnFrame addSubview:menuItemsTableView];
        
        [self addSubview:self.btnFrame];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_ITEM_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = CELL_IDENTIGIER;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    if( [tableView numberOfRowsInSection:indexPath.section] > ONE && !(indexPath.row == numberOfRows - 1) )
    {
        [self addSeparatorImageToCell:cell];
    }
    
    
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //linyc add begin.
    for (int i = 0; i<self.menuItems.count; i++) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        NSString *text;
        if (i == indexPath.row) {
            text = [NSString stringWithFormat:@"%@  √",[self.menuItems objectAtIndex:i]];
        }
        else{
            text = [NSString stringWithFormat:@"%@",[self.menuItems objectAtIndex:i]];
        }
        cell.textLabel.text = text;
    }
    //linyc add end.
    
    [self.delegate didPopViewSelected:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self hide];
}

- (void)addSeparatorImageToCell:(UITableViewCell *)cell
{
    UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:SEPERATOR_LINE_RECT];
    [separatorImageView setImage:[UIImage imageNamed:@"DefaultLine"]];
    separatorImageView.opaque = YES;
    [cell.contentView addSubview:separatorImageView];
}
-(void)btnClick:(UIButton*)sender
{
    NSLog(@"click");
    [self hide];
}
-(void)show
{
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        //self.hidden = NO;
    }];
}
-(void)hide
{
    [UIView animateWithDuration:0.4f animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        //self.hidden = YES;
    }];
}

@end
