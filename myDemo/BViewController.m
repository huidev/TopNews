//
//  BViewController.m
//  myDemo
//
//  Created by 于君 on 15/3/16.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import "BViewController.h"
#import "CNCommentTableViewCell.h"
#import "TextTableViewCell.h"
@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"backvalue" style:UIBarButtonItemStylePlain target:self action:@selector(popAndGiveValue:)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self.m_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.m_tableview registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    self.m_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
}

-(void)popAndGiveValue:(id )sender
{
    self.myBlock(@"This is B ViewController value");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark uitableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TextTableViewCell *cell = (TextTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TextTableViewCell" owner:self options:nil][0];
    }
    cell.contentLB.text =@"sshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshs";
//    cell.textLabel.numberOfLines = 0;
//    cell.textLabel.text = @"sshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshs";
    return cell;
}

#pragma mark - uitableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGRect textRect = [@"sshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshssshshhshshshshshhshshshshshshshhshshshshshs" boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return textRect.size.height+28+1+18;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{
    
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
