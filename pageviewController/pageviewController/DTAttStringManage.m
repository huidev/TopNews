//
//  DTAttStringManage.m
//  pageviewController
//
//  Created by 于君 on 16/5/20.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "DTAttStringManage.h"

@implementation DTAttStringManage

+ (id)sharedManage;
{
    static DTAttStringManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[DTAttStringManage alloc] init];
    });
    return manage;
}
- (NSMutableArray *)pagesOfFrame
{
    if (!_pagesOfFrame) {
        [self resolvePageOfFrameWithAttStr:[self _attributedStringForSnippetUsingiOS6Attributes:YES] rect:CGRectInset([UIScreen mainScreen].bounds, 0, 80)];
    }
    return _pagesOfFrame;
}

- (NSArray <DTCoreTextLayoutFrame*>*)resolvePageOfFrameWithAttStr:(NSAttributedString *)str rect:(CGRect)rect;
{
    NSMutableArray *results = [NSMutableArray array];
    if (str) {
        
        DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc]initWithAttributedString:str];
        layouter.shouldCacheLayoutFrames = YES;
        NSRange range = NSMakeRange(0, str.length);

        DTCoreTextLayoutFrame *frame;
        do {
            frame = [layouter layoutFrameWithRect:rect range:range];
            range = [frame visibleStringRange];
            if (frame) {
                range.location += range.length;
                range.length = 0;
                [results addObject:frame];
            }
            
        }while (frame);
       
    }
    _pagesOfFrame = results;
    return results;
}
- (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes
{
    // Load HTML data
    NSString *readmePath = [[NSBundle mainBundle] pathForResource:_bookName ofType:nil];
    NSString *html = [NSString stringWithContentsOfFile:readmePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create attributed string from HTML
    CGSize maxImageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20.0, [UIScreen mainScreen].bounds.size.height - 20.0);
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        // the block is being called for an entire paragraph, so we check the individual elements
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, nil];
    
    if (useiOS6Attributes)
    {
        [options setObject:[NSNumber numberWithBool:YES] forKey:DTUseiOS6Attributes];
    }
    
    [options setObject:[NSURL fileURLWithPath:readmePath] forKey:NSBaseURLDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    return string;
}

@end
