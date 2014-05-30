//
//  main.m
//  IntroToOpenGLESCode
//
//  Created by Jeff Kelley on 5/4/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DLGLAppDelegate.h"

int main(int argc, char * argv[])
{
    int returnValue;
    
    @autoreleasepool {
        returnValue =
        UIApplicationMain(argc,
                          argv,
                          nil,
                          NSStringFromClass([DLGLAppDelegate class]));
    }

    return returnValue;
}
