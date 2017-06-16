//
//  LMCatelogVCViewController.m
//  LMReader
//
//  Created by 于君 on 16/6/7.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMCatelogVCViewController.h"
#import "DTAttStringManage.h"
#import "Chapter.h"
#import "DatebaseManage.h"
#import "BookMark.h"

static NSString *const kCellIndent = @"kCellIndent";

@interface LMCatelogVCViewController ()
{
    NSArray *lChapters;
    NSMutableArray *lBookmarks;
    UISegmentedControl *_segmentControl;
    UIToolbar *_toolbar;
}
@end

@implementation LMCatelogVCViewController

- (void)loadView
{
    [super loadView];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, SCREEN_HEIGHT);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [lBookmarks removeAllObjects];
    [lBookmarks addObjectsFromArray:[[DatebaseManage sharedDatebase] fetchBookMark:[DTAttStringManage sharedManage].bookId chapterIndex:[DTAttStringManage sharedManage].indexOfChapter]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    [self _layoutSubviews];
    lBookmarks = [NSMutableArray array];
    lChapters = [[DTAttStringManage sharedManage]lChapters];
    // Do any additional setup after loading the view.
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}
#pragma mark -private

- (void)_layoutSubviews
{
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview1 = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableview1.dataSource = self;
    _tableview1.delegate = self;
    [_tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIndent];
    
    
    _tableview2 = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIndent];
    _tableview2.dataSource = self;
    _tableview2.delegate = self;
    [self.view insertSubview:_tableview2 atIndex:2];
    
    _tableview3 = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableview3 registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIndent];
    _tableview3.dataSource = self;
    _tableview3.delegate = self;
    [self.view insertSubview:_tableview3 atIndex:1];
    
    [self.view insertSubview:_tableview1 atIndex:3];
    _toolbar = [[UIToolbar alloc]init];
    [self.view insertSubview:_toolbar atIndex:4];
    
    _segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"目录",@"书签",@"笔记"]];
    _segmentControl.frame = CGRectMake(30, 10, (SCREEN_WIDTH-60)/2, 30);
    _segmentControl.selectedSegmentIndex = 0;
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_segmentControl];
    UIBarButtonItem *fixItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [_toolbar setItems:@[fixItem,barItem,fixItem]];
    
    [_toolbar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [_tableview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_toolbar.mas_top);
    }];
    [_tableview2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_toolbar.mas_top);
    }];
    [_tableview3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_toolbar.mas_top);
    }];
    
}
#pragma mark - user interaction
- (void)segmentAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex==1) {
        
        [self.view bringSubviewToFront:_tableview2];
        [_tableview2 reloadData];
//        [self.view exchangeSubviewAtIndex:[[self.view subviews]indexOfObject:_tableview1] withSubviewAtIndex:[[self.view subviews]indexOfObject:_tableview2]];
    }else if (sender.selectedSegmentIndex==0)
    {
        [self.view bringSubviewToFront:_tableview1];
    }else if (sender.selectedSegmentIndex==2)
    {
        [self.view bringSubviewToFront:_tableview3];
        [_tableview3 reloadData];
    }
    
}
#pragma mark uitableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (_segmentControl.selectedSegmentIndex) {
        return lBookmarks.count;
    }
    return [[DTAttStringManage sharedManage]lChapters].count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndent];
    
    if (_segmentControl.selectedSegmentIndex==0) {
        Chapter *item = lChapters[indexPath.row];
        cell.textLabel.text = item.chapterName;
    }else if (_segmentControl.selectedSegmentIndex==1)
    {
        BookMark *mark = [lBookmarks objectAtIndex:indexPath.row];
        cell.textLabel.text = mark.m_chapter_name;
    }else
    {
        cell.textLabel.text = @"sssssssssss";
    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_segmentControl.selectedSegmentIndex) {
        return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookMark *mark = [lBookmarks objectAtIndex:indexPath.row];
    [[DatebaseManage sharedDatebase]deleteBookMark:mark];
    [lBookmarks removeObject:mark];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - uitableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_segmentControl.selectedSegmentIndex==0) {
        return 50;
    }
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self.delegate LMCatelogSelectedCell:indexPath type:1];
//    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{
    
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
