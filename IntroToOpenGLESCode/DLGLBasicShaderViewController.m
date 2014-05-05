//
//  DLGLBasicShaderViewController.m
//  IntroToOpenGLESCode
//
//  Created by Jeff Kelley on 5/4/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//


#import "DLGLBasicShaderViewController.h"


// Constants
static NSString * const kViewControllerTitle = @"Basic Shaders";


@interface DLGLBasicShaderViewController ()

@end


@implementation DLGLBasicShaderViewController

#pragma mark - View Controller Lifecycle

- (NSString *)title
{
    return kViewControllerTitle;
}

#pragma mark - GLKViewController Lifecycle

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [super glkView:view drawInRect:rect];
}

#pragma mark -

@end
