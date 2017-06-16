//
//  ReadingSettingView.m
//  LMReader
//
//  Created by 于君 on 16/6/6.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "ReadingSettingView.h"

@implementation ReadingSettingView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configSubview];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)configSubview
{
    _fontProgress = [[UISlider alloc] init];
    _fontProgress.maximumValue = 0.7;
    [_fontProgress addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_fontProgress];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_fontProgress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-80, 20));
    }];
}
- (void)sliderAction:(UISlider*)slider
{
    [LMGoble sharedGoble].brightness = slider.value;
    [self.delegate readingSettingChangeBrightness:slider.value];
}
@end
