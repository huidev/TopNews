//
//  ProgressSettingView.h
//  LMReader
//
//  Created by 于君 on 16/8/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMView.h"
#import "ReadingSettingView.h"

@interface ProgressSettingView : LMView
{
    UISlider *_fontProgress;
}
@property (assign, nonatomic) id<ReadingViewSettingDelegate>delegate;

- (void)setProgress:(CGFloat)pro;
@end
