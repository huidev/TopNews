//
//  BatteryView.h
//  LMReader
//
//  Created by 于君 on 16/8/30.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMView.h"

@interface BatteryView : LMView
{
    CGFloat batteryLevel;
    NSString *timeStr;
}
- (void)setBatteryLevel:(CGFloat)level Time:(NSString *)time;
@end
