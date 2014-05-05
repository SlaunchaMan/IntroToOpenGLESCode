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
    { -0.75f, -0.85f, 0.0f },
    {  0.75f, -0.85f, 0.0f },
    {  0.75f,  0.65f, 0.0f },
};
static NSString * const kViewControllerTitle = @"Primitive Triangle";


@interface DLGLPrimitiveTriangleViewController ()

@property (strong) GLKBaseEffect *effect;

@end


@implementation DLGLPrimitiveTriangleViewController

#pragma mark - View Controller Lifecycle

- (NSString *)title
{
    return kViewControllerTitle;
}

#pragma mark - GLKViewController Lifecycle

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [super glkView:view drawInRect:rect];
    
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

#pragma mark - DLGKLViewController Lifecycle

- (void)setupGL
{
    [super setupGL];
    
    [self initializeEffect];
}

#pragma mark - DLGLPrimitiveTriangleViewController Lifecycle

- (void)initializeEffect
{
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.constantColor = GLKVector4Make(0.0f, 0.0f, 0.0f, 1.0f);
}

#pragma mark -

@end
