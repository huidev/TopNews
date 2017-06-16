//
//  LMCatelogVCViewController.h
//  LMReader
//
//  Created by 于君 on 16/6/7.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"
typedef NS_ENUM(NSInteger, CAContentType) {
    CAContentTypeCatelog,
    CAContentTypeMark,
    CAContentTypeNote,
};

@protocol LMCatelogDelegate <NSObject>

- (void)LMCatelogSelectedCell:(NSIndexPath *)index type:(CAContentType)type;

@end
@interface LMCatelogVCViewController : LMViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview1;
    UITableView *_tableview2;
    UITableView *_tableview3;
    CAContentType type;
}
@property (assign, nonatomic)id <LMCatelogDelegate>delegate;
@property (copy, nonatomic) void(^selectBlock)();
@end
