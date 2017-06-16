//
//  BookMark.h
//  LMReader
//
//  Created by 于君 on 16/9/1.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "DModel.h"

//CREATE TABLE BookMark ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'m_uid' TEXT REFERENCES 'User' (u_id) ON DELETE CASCADE ON UPDATE NO ACTION, 'm_type' INTEGER, 'm_bookid' TEXT,'m_chapter_name' TEXT,'m_chapter_index' INTEGER,'m_time' TEXT, 'm_text' TEXT, 'm_offset' INTEGER, 'm_lenght' INTEGER
@interface BookMark : DModel

@property (nonatomic, strong)NSString *m_bookid;
@property (nonatomic, strong)NSString *m_chapter_name;
@property (nonatomic, assign)NSInteger m_chapter_index;
@property (nonatomic, assign)NSInteger m_offset;
@property (nonatomic, assign)NSInteger m_lenght;

@property (nonatomic, strong)NSString *m_text;
@property (nonatomic, assign)NSInteger m_type;
@property (nonatomic, strong)NSString *m_uid;
@property (nonatomic, assign)NSTimeInterval m_time;

@end
