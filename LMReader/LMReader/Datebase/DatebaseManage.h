//
//  DatebaseManage.h
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "BookMark.h"

@interface DatebaseManage : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

+ (instancetype)sharedDatebase;

- (NSArray *)fetchBooks;

/**
 *  添加删除书签
 *
 *  @param mark <#mark description#>
 */
- (void)addBookMark:(BookMark*)mark;
- (void)deleteBookMark:(BookMark*)mark;
- (NSArray*)fetchBookMark:(NSString *)bookid chapterIndex:(NSInteger)index;
/**
 *  添加或删除批准
 *
 *  @param type  批注划线颜色
 *  @param range 选中文字range
 *  @param notes 想法观点
 */
- (void)addBookIdeals:(BookMark*)mark ;
- (void)deleteBookIdeal:(BookMark*)mark;
- (void)updateBookIdeal:(BookMark *)mark;
- (NSArray*)fetchBookIdeal:(NSString *)bookid chapterIndex:(NSInteger)index;
@end
