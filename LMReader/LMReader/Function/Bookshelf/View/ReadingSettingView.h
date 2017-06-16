//
//  ReadingSettingView.h
//  LMReader
//
//  Created by 于君 on 16/6/6.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMView.h"


@protocol ReadingViewSettingDelegate <NSObject>

- (void)readingSettingChangeBrightness:(CGFloat)bright;
- (void)readingSettingChangeProgress:(CGFloat)pregress;
@end

@interface ReadingSettingView : LMView

{
    UISlider *_fontProgress;
}
@property (assign, nonatomic) id<ReadingViewSettingDelegate>delegate;
@end
