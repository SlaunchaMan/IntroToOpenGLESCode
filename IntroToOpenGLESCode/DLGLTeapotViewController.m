//
//  DLGLTeapotViewController.m
//  IntroToOpenGLESCode
//
//  Created by Jeff Kelley on 8/9/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//


#import "DLGLTeapotViewController.h"

#import "teapot.h"


// Constants
static NSString * const kViewControllerTitle = @"Teacup";


@interface DLGLTeapotViewController ()

@property (strong) GLKBaseEffect *effect;

@end


@implementation DLGLTeapotViewController

#pragma mark - View Controller Lifecycle

- (NSString *)title
{
    return kViewControllerTitle;
}

#pragma mark - GLKViewController Lifecycle

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [super glkView:view drawInRect:rect];
    
    glClear(GL_DEPTH_BUFFER_BIT|GL_COLOR_BUFFER_BIT);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(GLfloat) * 3,
                          teapot_vertices);
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(GLfloat) * 3,
                          teapot_normals);
    
    GLKMatrix4 modelviewMatrix = self.effect.transform.modelviewMatrix;
    
    
    modelviewMatrix = GLKMatrix4Rotate(modelviewMatrix,
                                       self.timeSinceLastDraw,
                                       0.0f, 1.0f, 0.0f);
    
    
    self.effect.transform.projectionMatrix =
    GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65),
                              (float)view.drawableWidth / (float)view.drawableHeight,
                              0.01f, 100.0f);
    
    self.effect.transform.modelviewMatrix = modelviewMatrix;
    
    [self.effect prepareToDraw];
    
    glClearDepthf(1.0);
    
	for(int i = 0; i < num_teapot_indices; i += new_teapot_indicies[i] + 1) {
		glDrawElements(GL_TRIANGLE_STRIP,
                       new_teapot_indicies[i],
                       GL_UNSIGNED_SHORT,
                       &new_teapot_indicies[i+1]);
	}
}

#pragma mark - DLGLKViewControllerLifecycle

- (void)setupGL
{
    [super setupGL];
    
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);
    
    [(GLKView *)self.view setDrawableDepthFormat:GLKViewDrawableDepthFormat24];
    
    [self initializeEffect];
}

#pragma mark - DLGLTeapotViewController Lifecycle

- (void)initializeEffect
{
    self.effect = [[GLKBaseEffect alloc] init];
    
    self.effect.lightingType = GLKLightingTypePerVertex;
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.position = GLKVector4Make(0.0f, 10.0f, 0.0f, 1.0f);
    self.effect.light0.ambientColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    self.effect.transform.modelviewMatrix = GLKMatrix4Rotate(GLKMatrix4MakeTranslation(0.0f, -0.05f, -0.5f), GLKMathDegreesToRadians(15.0f), 1.0f, 0.0f, 0.0f);
}

#pragma mark -

@end
