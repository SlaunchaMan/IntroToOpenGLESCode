//
//  DLGLKViewController.m
//  IntroToOpenGLESCode
//
//  Created by Jeff Kelley on 5/4/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//


#import "DLGLKViewController.h"


@interface DLGLKViewController ()

@property (strong, nonatomic) EAGLContext *renderingContext;

@end


@implementation DLGLKViewController

#pragma mark - View Controller Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupGL];
}

#pragma mark - GLKViewController Lifecycle

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT);
}

#pragma mark - DLGLKViewControllerLifecycle

- (void)establishRenderingContext
{
    if ([EAGLContext currentContext] != self.renderingContext) {
        [EAGLContext setCurrentContext:self.renderingContext];
    }
    
    [(GLKView *)self.view setContext:self.renderingContext];
}

- (void)initializeBackgroundColor
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
}

- (EAGLContext *)renderingContext
{
    if (!_renderingContext) {
        _renderingContext =
        [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
        
        if (!_renderingContext) {
            _renderingContext =
            [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        }
    }
    
    return _renderingContext;
}

- (void)setupGL
{
    [self establishRenderingContext];
    [self initializeBackgroundColor];
}

#pragma mark -

@end
