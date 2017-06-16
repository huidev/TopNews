//
//  BatteryView.m
//  LMReader
//
//  Created by 于君 on 16/8/30.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "BatteryView.h"
#import "LMGoble.h"

static CGFloat kbatteryHeight = 10;
@implementation BatteryView

- (void)setBatteryLevel:(CGFloat)level Time:(NSString *)time;
{
    timeStr = time;
    batteryLevel = level;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([LMGoble sharedGoble].theme == STThemeBlack) {
        
    }else
    {
        
    }
    [[UIColor lightGrayColor] set];
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextAddRect(context, CGRectMake(0, (rect.size.height - kbatteryHeight)/2, 20, kbatteryHeight));
    CGContextStrokePath(context);
    CGContextFillRect(context, CGRectMake(2, (rect.size.height - kbatteryHeight)/2+2, 20*batteryLevel, kbatteryHeight-4));
    CGContextFillRect(context, CGRectMake(20, (rect.size.height - kbatteryHeight)/2+(kbatteryHeight-5)/2, 3, 5));
    UIFont  *font = [UIFont boldSystemFontOfSize:13.0];
    [timeStr drawInRect:CGRectMake(35, 2, 40, 18) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    
}
@end
