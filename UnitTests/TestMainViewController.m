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
#import "DataAccess.h"

@interface TestMainViewController : GHTestCase {
	DataAccess *da;
	MainViewController *viewController;
}
@end

@implementation TestMainViewController

-(void)setUp {
	da = [[DataAccess alloc] initWithPath:@"/Volumes/rupert/projects/iphone/2RMobile/AppKit/appkit.db"];
	viewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
}

-(void)tearDown {
	[da release];
	[viewController release];
}

-(void)testShouldHaveBackgroundImage {
	[viewController setBackgroundImage: [da getAppBackgroundImage]];
	GHAssertNotNil(viewController.imageViewBackground, nil);
}

@end
