//
//  PageModelControll.m
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "PageModelControll.h"
#import "DTAttStringManage.h"

static NSString * const currentPageKey = @"currentPageKey";
static NSString * const lastPageKey = @"lastPageKey";
static NSString * const nextPageKey = @"nextPageKey";

@implementation PageModelControll

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        _pageData = [[dateFormatter monthSymbols] copy];
        _pageFrameset = [NSMutableDictionary dictionary];
        [self defaultConfig];
    }
    return self;
}
- (void)defaultConfig
{
    _chapterIndex = 0;
    _pageAnimationFinished = YES;
    _pageData = [[DTAttStringManage sharedManage] framesetterOfChapter:_chapterIndex];
    [_pageFrameset setObject:_pageData forKey:currentPageKey];
}
- (DemoTextViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    _pageData = _pageFrameset[currentPageKey];
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    //    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    //    dataViewController.dataObject = self.pageData[index];
    //    return dataViewController;
    DemoTextViewController *textview = [[DemoTextViewController alloc]init];
    textview.frameset = self.pageData[index];
    textview.chapterIndex = _chapterIndex;
    textview.chapterText = [[NSAttributedString alloc]initWithString:[[DTAttStringManage sharedManage] chapterNameOfIndex:_chapterIndex] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    textview.pageText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld/%ld",index+1,_pageData.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    return textview;
}

- (NSUInteger)indexOfViewController:(DemoTextViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
   
    _pageData = _pageFrameset[currentPageKey];
    return [self.pageData indexOfObject:viewController.frameset];
}
/**
 *  缓存三章frameset
 */
- (void)setLastChapterToCurrent;
{
    if (_chapterIndex>0) {
        _chapterIndex--;
        NSArray *lastArr = _pageFrameset[lastPageKey];
        if (!lastArr) {
            lastArr =[[DTAttStringManage sharedManage] framesetterOfChapter:_chapterIndex];
        }
        if (_pageFrameset[currentPageKey]) {
            [_pageFrameset setObject:_pageFrameset[currentPageKey] forKey:nextPageKey];
            
        }
        if (lastArr) {
            [_pageFrameset setObject:lastArr forKey:currentPageKey];
            _pageData = _pageFrameset[currentPageKey];
        }
        
        [_pageFrameset removeObjectForKey:lastPageKey];
    }
}
#pragma mark - Page View Controller Data Source
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.pageData.count;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (self.pageAnimationFinished) {
        
        if(pageViewController.doubleSided) {
            if ([viewController isKindOfClass:[DemoTextViewController class]]) {
                self.currentViewController = viewController;
                
                BackViewController *backViewController = [[BackViewController alloc] init];
                [backViewController updateWithViewController:viewController];
                return backViewController;
            }
            
        }else
        {
            self.currentViewController = viewController;
        }
        
        NSInteger index = [self indexOfViewController:(DemoTextViewController *)_currentViewController];
        if (index!= NSNotFound) {
            _pageIndex = index;
        }
        if ((index <= 0) || (index == NSNotFound)) {
            if (_chapterIndex>0) {
                _chapterIndex--;
                NSArray *lastArr = _pageFrameset[lastPageKey];
                if (!lastArr) {
                    lastArr =[[DTAttStringManage sharedManage] framesetterOfChapter:_chapterIndex];
                }
                
                if (_pageFrameset[currentPageKey]) {
                    [_pageFrameset setObject:_pageFrameset[currentPageKey] forKey:nextPageKey];
                }
                if (lastArr) {
                    [_pageFrameset setObject:lastArr forKey:currentPageKey];
                }
                
                [_pageFrameset removeObjectForKey:lastPageKey];
                index = lastArr.count-1;
                DemoTextViewController *textview = [[DemoTextViewController alloc]init];
                textview.frameset = lastArr[index];
                textview.chapterText = [[NSAttributedString alloc]initWithString:[[DTAttStringManage sharedManage] chapterNameOfIndex:_chapterIndex] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
                textview.pageText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld/%ld",index+1,lastArr.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
                return textview;
            }
            return nil;
        }
        
        index--;
        
        return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
    }else
    {
        return nil;
    }
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (self.pageAnimationFinished) {
        if(pageViewController.doubleSided) {
            if ([viewController isKindOfClass:[DemoTextViewController class]]) {
                self.currentViewController = viewController;
                
                BackViewController *backViewController = [[BackViewController alloc] init];
                [backViewController updateWithViewController:viewController];
                return backViewController;
            }
            
        }else
        {
            self.currentViewController = viewController;
        }
        NSInteger index = [self indexOfViewController:(DemoTextViewController *)_currentViewController];
        if (index!= NSNotFound) {
            _pageIndex = index;
        }
        
        index++;
        
        if (index == NSNotFound||index >= [self.pageData count]) {
            if (_chapterIndex+1>[[DTAttStringManage sharedManage] lChapters].count) {
                return nil;
            }
            _chapterIndex++;
            NSArray *lNext = _pageFrameset[nextPageKey];
            if (!lNext) {
                lNext =[[DTAttStringManage sharedManage] framesetterOfChapter:_chapterIndex];
                
            }
            
            if (_pageFrameset[currentPageKey]) {
                [_pageFrameset setObject:_pageFrameset[currentPageKey] forKey:lastPageKey];
            }
            if (lNext) {
                [_pageFrameset setObject:lNext forKey:currentPageKey];
            }
            
            [_pageFrameset removeObjectForKey:nextPageKey];
            index = 0;
            DemoTextViewController *textview = [[DemoTextViewController alloc]init];
            textview.frameset = lNext[index];
            textview.chapterText = [[NSAttributedString alloc]initWithString:[[DTAttStringManage sharedManage] chapterNameOfIndex:_chapterIndex] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
            textview.pageText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld/%ld",index+1,lNext.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
            return textview;
        }
        
        
        return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
    }else
    {
        return nil;
    }
    
}
@end
