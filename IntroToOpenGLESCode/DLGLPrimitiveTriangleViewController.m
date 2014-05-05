//
//  DLGLPrimitiveTriangleViewController.m
//  IntroToOpenGLESCode
//
//  Created by Jeff Kelley on 5/4/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//


#import "DLGLPrimitiveTriangleViewController.h"


// Constants
static const int kVertexCount = 3;
static const int kCoordinatesPerVertex = 3;
static const GLfloat coordinates[kVertexCount][kCoordinatesPerVertex] = {
    { -0.75f, -0.75f, 0.0f },
    {  0.75f, -0.75f, 0.0f },
    {  0.75f,  0.75f, 0.0f },
};


@interface DLGLPrimitiveTriangleViewController ()

@property (strong) GLKBaseEffect *effect;
@property (strong, nonatomic) EAGLContext *renderingContext;

- (void)setupGL;

@end


@implementation DLGLPrimitiveTriangleViewController

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
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glVertexAttribPointer(GLKVertexAttribPosition,
                          kVertexCount,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(GL_FLOAT) * kCoordinatesPerVertex,
                          &coordinates);
    
    [self.effect prepareToDraw];
    
    glDrawArrays(GL_TRIANGLES, 0, kVertexCount);
    
    glDisableVertexAttribArray(GLKVertexAttribPosition);
}

#pragma mark - DLGLPrimitiveTriangleViewController Lifecycle

- (void)establishRenderingContext
{
    if ([EAGLContext currentContext] != self.renderingContext) {
        [EAGLContext setCurrentContext:self.renderingContext];
    }
    
    [(GLKView *)self.view setContext:self.renderingContext];
}

- (void)initializeBackgroundColor
{
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
}

- (void)initializeEffect
{
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
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
    
    [self initializeEffect];
}

#pragma mark -

@end
