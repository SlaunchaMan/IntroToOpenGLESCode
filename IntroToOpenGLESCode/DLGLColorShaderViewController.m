//
//  DLGLColorShaderViewController.m
//  IntroToOpenGLESCode
//
//  Created by Jeff Kelley on 5/4/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//


#import "DLGLColorShaderViewController.h"


// Constants
static const int kVertexCount = 3;
static const int kCoordinatesPerVertex = 3;

static const GLfloat colors[kVertexCount][3] = {
    { 1.0, 0.0, 0.0 },
    { 0.0, 1.0, 0.0 },
    { 0.0, 0.0, 1.0 }
};

static const GLfloat coordinates[kVertexCount][kCoordinatesPerVertex] = {
    { -0.75f, -0.85f, 0.0f },
    {  0.75f, -0.85f, 0.0f },
    {  0.75f,  0.65f, 0.0f },
};

static NSString * const kFragmentShaderFilename = @"ColorFragmentShader";
static NSString * const kVertexShaderFilename = @"ColorVertexShader";
static NSString * const kViewControllerTitle = @"Color Shader";


@interface DLGLColorShaderViewController ()

@property GLuint shaderProgramID;

- (void)compileShaders;

@end


@implementation DLGLColorShaderViewController

#pragma mark - View Controller Lifecycle

- (NSString *)title
{
    return kViewControllerTitle;
}

#pragma mark - GLKViewController Lifecycle

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [super glkView:view drawInRect:rect];
    
    glUseProgram(self.shaderProgramID);
    
    glEnableVertexAttribArray(0);
    glEnableVertexAttribArray(1);
    
    glVertexAttribPointer(0,
                          kVertexCount,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(GL_FLOAT) * kCoordinatesPerVertex,
                          &coordinates);
    
    glVertexAttribPointer(1,
                          kVertexCount,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(GL_FLOAT) * 3,
                          &colors);
    
    glDrawArrays(GL_TRIANGLES, 0, kVertexCount);
    
    glDisableVertexAttribArray(0);
    glDisableVertexAttribArray(1);
}

#pragma mark - DLGLKViewController Lifecycle

- (void)setupGL
{
    [super setupGL];
    
    [self compileShaders];
}

#pragma mark - DLGLColorShaderViewController

- (void)compileShaders
{
    NSString *fragmentShaderPath =
    [[NSBundle mainBundle] pathForResource:kFragmentShaderFilename
                                    ofType:@"fsh"];
    
    NSString *fragmentShaderSource =
    [[NSString alloc] initWithContentsOfFile:fragmentShaderPath
                                    encoding:NSUTF8StringEncoding
                                       error:NULL];
    
    const char *fragmentShaderSourceUTF8 = [fragmentShaderSource UTF8String];
    
    NSString *vertexShaderPath =
    [[NSBundle mainBundle] pathForResource:kVertexShaderFilename
                                    ofType:@"vsh"];
    
    NSString *vertexShaderSource =
    [[NSString alloc] initWithContentsOfFile:vertexShaderPath
                                    encoding:NSUTF8StringEncoding
                                       error:NULL];
    
    const char *vertexShaderSourceUTF8 = [vertexShaderSource UTF8String];
    
    GLuint fragmentShaderID = glCreateShader(GL_FRAGMENT_SHADER);
    
    GLuint vertexShaderID = glCreateShader(GL_VERTEX_SHADER);
    
    glShaderSource(fragmentShaderID,
                   1,
                   &fragmentShaderSourceUTF8,
                   NULL);
    
    glShaderSource(vertexShaderID,
                   1,
                   &vertexShaderSourceUTF8,
                   NULL);
    
    glCompileShader(fragmentShaderID);
    glCompileShader(vertexShaderID);
    
    self.shaderProgramID = glCreateProgram();
    
    glAttachShader(self.shaderProgramID, vertexShaderID);
    glAttachShader(self.shaderProgramID, fragmentShaderID);
    
    glLinkProgram(self.shaderProgramID);
}

#pragma mark -

@end
