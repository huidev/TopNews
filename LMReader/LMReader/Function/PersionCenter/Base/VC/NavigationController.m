//
//  MyNavigationControllerViewController.m
//  ViewControllerTransitions
//
//  Created by Colin Eberhardt on 09/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "NavigationController.h"
#import "AppDelegate.h"
#import "CEBaseInteractionController.h"
#import "CEReversibleAnimationController.h"

@interface NavigationController () <UINavigationControllerDelegate>

@end

@implementation NavigationController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
        [self commonInit];
    }
    return self;
}
- (void)commonInit
{
//    self.navigationController.navigationBarHidden = YES;
//    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    // when a push occurs, wire the interaction controller to the to- view controller
    if (delegate.navigationControllerInteractionController) {
        [delegate.navigationControllerInteractionController wireToViewController:toVC forOperation:CEInteractionOperationPop];
    }
    
    if (delegate.navigationControllerAnimationController) {
        delegate.navigationControllerAnimationController.reverse = operation == UINavigationControllerOperationPop;
    }
    
    return delegate.navigationControllerAnimationController;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    // if we have an interaction controller - and it is currently in progress, return it
    return delegate.navigationControllerInteractionController && delegate.navigationControllerInteractionController.interactionInProgress ? delegate.navigationControllerInteractionController : nil;
}

@end
