//
//  ViewController.m
//  MLKMenuPopover_Extend
//
//  Created by CY on 19/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "KbViewController.h"
#import "PopMenuView.h"

@interface KbViewController ()

@property(nonatomic,strong) PopMenuView *popView;
@property(nonatomic,strong) NSArray *menuItems;
@property(nonatomic,strong) NSArray *menuIcons;

@end

@implementation KbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.menuItems = @[@"编辑",@"删除",@"分享",@"赞一个"];
    self.menuIcons = @[@"nav_edit",@"nav_delete",@"nav_share",@"nav_praise"];
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
        self.popView = [[PopMenuView alloc] initWithFrame:self.tableView.frame menuItems:self.menuItems menuIcons:self.menuIcons];
        self.popView.delegate = self;
        [self.navigationController.view addSubview:self.popView];
    }
    [self.popView show];
    [self.navigationController.view bringSubviewToFront:self.popView];
}

@end
