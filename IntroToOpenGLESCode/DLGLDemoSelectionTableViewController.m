//
//  DLGLDemoSelectionTableViewController.m
//  IntroToOpenGLESCode
//
//  Created by Jeff Kelley on 5/4/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//


#import "DLGLDemoSelectionTableViewController.h"

#import "DLGLBasicShaderViewController.h"
#import "DLGLColorShaderViewController.h"
#import "DLGLPrimitiveTriangleViewController.h"
#import "DLGLTeapotViewController.h"


// Table View Constants
typedef NS_ENUM(NSInteger, DLGLDemoSelectionTableViewSection) {
    DLGLDemoSelectionTableViewSectionDemoList = 0,
    DLGLDemoSelectionTableViewSectionCount    = 1
};

typedef NS_ENUM(NSInteger, DLGLDemoSelectionTableViewDemoSectionRow) {
    DLGLDemoSelectionTableViewDemoSectionRowPrimitiveTriangle = 0,
    DLGLDemoSelectionTableViewDemoSectionRowBasicShaders      = 1,
    DLGLDemoSelectionTableViewDemoSectionRowColorShader       = 2,
    DLGLDemoSelectionTableViewDemoSectionRowTeapot            = 3,
    DLGLDemoSelectionTableViewDemoSectionRowCount             = 4
};

static NSString * const kTableViewCellReuseIdentifier = @"DemoListingCell";
static NSString * const kViewControllerTitle = @"OpenGL ES Demos";


@interface DLGLDemoSelectionTableViewController ()

- (NSString *)titleForDemoAtIndexPath:(NSIndexPath *)indexPath;
- (Class)viewControllerClassForDemoAtIndexPath:(NSIndexPath *)indexPath;

@end


@implementation DLGLDemoSelectionTableViewController

#pragma mark - Object Lifecycle

- (id)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

#pragma mark - View Controller Lifecycle

- (NSString *)title
{
    return kViewControllerTitle;
}

#pragma mark - DLGLDemoSelectionTableViewController Lifecycle

- (NSString *)titleForDemoAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = nil;
    
    if (indexPath.section == DLGLDemoSelectionTableViewSectionDemoList) {
        if (indexPath.row == DLGLDemoSelectionTableViewDemoSectionRowPrimitiveTriangle) {
            title = @"Primitive Triangle";
        }
        else if (indexPath.row == DLGLDemoSelectionTableViewDemoSectionRowBasicShaders) {
            title = @"Basic Shaders";
        }
        else if (indexPath.row == DLGLDemoSelectionTableViewDemoSectionRowColorShader) {
            title = @"Color Shader";
        }
        else if (indexPath.row == DLGLDemoSelectionTableViewDemoSectionRowTeapot) {
            title = @"Teapot";
        }
    }
    
    return title;
}

- (Class)viewControllerClassForDemoAtIndexPath:(NSIndexPath *)indexPath
{
    Class viewControllerClass = Nil;
    
    if (indexPath.section == DLGLDemoSelectionTableViewSectionDemoList) {
        if (indexPath.row == DLGLDemoSelectionTableViewDemoSectionRowPrimitiveTriangle) {
            viewControllerClass = [DLGLPrimitiveTriangleViewController class];
        }
        else if (indexPath.row == DLGLDemoSelectionTableViewDemoSectionRowBasicShaders) {
            viewControllerClass = [DLGLBasicShaderViewController class];
        }
        else if (indexPath.row == DLGLDemoSelectionTableViewDemoSectionRowColorShader) {
            viewControllerClass = [DLGLColorShaderViewController class];
        }
        else if (indexPath.row == DLGLDemoSelectionTableViewDemoSectionRowTeapot) {
            viewControllerClass = [DLGLTeapotViewController class];
        }
    }
    
    return viewControllerClass;
}

#pragma mark - UITableViewDataSource Protocol Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return DLGLDemoSelectionTableViewSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    
    if (section == DLGLDemoSelectionTableViewSectionDemoList) {
        rowCount = DLGLDemoSelectionTableViewDemoSectionRowCount;
    }
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier];
    
    if (!cell) {
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:kTableViewCellReuseIdentifier];
    }
    
    cell.textLabel.text = [self titleForDemoAtIndexPath:indexPath];
    
    if ([self viewControllerClassForDemoAtIndexPath:indexPath] != Nil) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate Protocol Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class viewControllerClass =
    [self viewControllerClassForDemoAtIndexPath:indexPath];
    
    if (viewControllerClass != Nil) {
        UIViewController *viewController = [[viewControllerClass alloc] init];
        
        [self.navigationController pushViewController:viewController
                                             animated:YES];
    }
}

@end
