//
//  MacroFunctions.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//
#ifndef MacroFunctions_h
#define MacroFunctions_h

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WEAK_SELF __weak typeof(self) weakSelf = self;

#pragma mark - file path
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

#pragma mark - color

#define LMRED RGBA(238,80,72,1)
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define UIColorFromRGBA(rgbValue,alph) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alph]
#define COLOR_BG_DARK RGBA(51,51,51,1)
#define COLOR_BG_DAY RGBA(241,242,243,1)

#define COLOR_STROKE_GRAY RGBA(51,51,51,1)
#define COLOR_STROKE_WHITE RGBA(1,1,1,1)

#pragma mark - debug

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s %s [Line %d] " fmt), __FILE__,__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#endif /* MacroFunctions_h */
