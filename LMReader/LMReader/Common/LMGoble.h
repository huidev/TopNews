//
//  LMGoble.h
//  LMReader
//
//  Created by 于君 on 16/6/1.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, STTheme) {
    STThemeWhite,
    STThemeBlack,
};
typedef NS_ENUM(NSInteger, STFont) {
    STFontSmall,
};

@interface LMGoble : NSObject

+ (instancetype)sharedGoble;

@property (assign, nonatomic)UIDeviceBatteryState batteryState;
@property (assign ,nonatomic)UIPageViewControllerTransitionStyle pageTransition;
@property (assign, nonatomic)STTheme theme;
@property (assign, nonatomic)CGFloat fontSize;
@property (assign, nonatomic)CGFloat brightness;
@property (strong, nonatomic)NSString *userId;
@end
