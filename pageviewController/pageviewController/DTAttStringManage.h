//
//  DTAttStringManage.h
//  pageviewController
//
//  Created by 于君 on 16/5/20.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTCoreText/DTCoreText.h>

@interface DTAttStringManage : NSObject

@property (strong, nonatomic)NSString *bookName;
@property (strong, nonatomic)NSMutableArray *pagesOfFrame;
+ (id)sharedManage;

- (NSArray <DTCoreTextLayoutFrame*>*)resolvePageOfFrameWithAttStr:(NSAttributedString *)str rect:(CGRect)rect;
@end
