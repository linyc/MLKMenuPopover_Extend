//
//  ViewController.m
//  MLKMenuPopover_Extend
//
//  Created by CY on 19/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "ViewController.h"
#import "PopMenuView.h"

@interface ViewController ()

@property(nonatomic,strong) PopMenuView *popView;
@property(nonatomic,strong) NSArray *menuItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.menuItems = @[@"按时间排序",@"按人气排序",@"随机显示"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"testCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"line: %lu",indexPath.row];
    
    return cell;
}
#pragma mark - PopMenuViewDelegate
-(void)didPopViewSelected:(NSInteger)selectedIndex
{
    [self.popView hide];
    
    //do your something
    
}

- (IBAction)btnClick:(id)sender {
    if (self.popView == nil) {
        self.popView = [[PopMenuView alloc] initWithFrame:self.tableView.frame menuItems:self.menuItems];
        self.popView.delegate = self;
        [self.tableView addSubview:self.popView];
    }
    [self.popView show];
    [self.tableView bringSubviewToFront:self.popView];
}

@end
