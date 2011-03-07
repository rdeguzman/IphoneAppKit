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
	GHAssertNotNil([viewController arraySections], nil);
}

-(void)testShouldCreateListTableViewController{
	[viewController initButtons];
	NSDictionary* section = [[viewController arraySections] objectAtIndex:0];
	BOOL flag = [viewController createListTableViewController:section];
	GHAssertTrue(flag, nil);
}

@end