//
//  TestMainViewController.m
//  AppKit
//
//  Created by rupert on 6/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import <Foundation/Foundation.h>

#import	"MainViewController.h"

@interface TestMainViewController : GHTestCase {
	MainViewController *viewController;
}
@end

@implementation TestMainViewController

-(void)setUp {
	viewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
}

-(void)tearDown {
	[viewController release];
}

-(void)testShouldHaveBackgroundImage {
	[viewController initBackgroundImage];

	UIImageView *imageView = (UIImageView*)viewController.imageViewBackground;
	GHAssertNotNil(imageView, nil);
}

-(void)testShouldHaveButtons{
	[viewController initButtons];
	GHAssertNotNil([viewController arrayButtons], nil);
}

-(void)testShouldShowListTableViewController{
	[viewController initButtons];
	NSDictionary* section = [[viewController arrayButtons] objectAtIndex:1];
	BOOL flag = [viewController showListTableViewController:section];
	GHAssertTrue(flag, nil);
}

-(void)testShouldShowPageViewController{
	[viewController initButtons];
	NSDictionary* page = [[viewController arrayButtons] objectAtIndex:1];
	BOOL flag = [viewController showPageViewController:page];
	GHAssertTrue(flag, nil);
}

-(void)testShouldShowPhotosViewController{
	BOOL flag = [viewController showPhotosViewController];
	GHAssertTrue(flag, nil);
}

@end