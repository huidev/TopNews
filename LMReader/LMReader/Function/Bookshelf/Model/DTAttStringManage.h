//
//  DTAttStringManage.h
//  pageviewController
//
//  Created by 于君 on 16/5/20.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTCoreText/DTCoreText.h>
#import "BookEntity.h"

@interface DTAttStringManage : NSObject<NSStreamDelegate>
{
    NSMutableDictionary *_dCatalog;//文件分区表信息《item 40字节文件名+4字节偏移量+1字节标识+3字节长度》计算公式：88+4+N*48
    NSMutableData *_data;
    NSMutableArray *_lChapters;
    NSInteger _protectedKey;
}
@property (copy, nonatomic)void(^complete)(void);
@property (strong, nonatomic)NSString *bookName;
@property (strong, nonatomic)NSString *bookId;
@property (strong, nonatomic)NSString *author;
@property (strong, nonatomic)NSString *brief;
@property (strong, nonatomic)NSString *publisher;
@property (assign, nonatomic)NSInteger indexOfChapter;
@property (strong, nonatomic)NSString *nameOfChapter;
@property (strong, nonatomic)NSArray *lChapters;//章节
@property (strong, nonatomic)NSMutableArray *lBookmarks;//书签
@property (strong, nonatomic)NSMutableArray *lBookideals;//批注
@property (strong, nonatomic)BookEntity *mBook;
@property (strong, nonatomic)NSMutableArray *pagesOfFrame;//pages of framesetter

+ (instancetype)sharedManage;

-(void)parseBook:(BookEntity *)entity finish:(void(^)(void))finished;
- (NSMutableArray *)framesetterOfChapter:(NSInteger)index;
- (NSString *)getContentOfChapter:(NSString *)chapterName;
- (NSString *)chapterNameOfIndex:(NSInteger)chapterIndex;
- (NSArray <DTCoreTextLayoutFrame*>*)resolvePageOfFrameWithAttStr:(NSAttributedString *)str rect:(CGRect)rect;
@end