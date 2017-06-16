//
//  MarkPanGesture.h
//  LMReader
//
//  Created by 于君 on 16/8/31.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface MarkPanGesture : UIPanGestureRecognizer
{
    CGPoint touchBeginPoint;
}
@property (nonatomic, strong, getter=isFailed) NSNumber *failed;
@property (nonatomic, assign)CGPoint touchBeginPoint;
@end
