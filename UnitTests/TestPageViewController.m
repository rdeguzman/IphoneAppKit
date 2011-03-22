//
//  TestPageViewController.m
//  AppKit
//
//  Created by rupert on 22/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//
#import <GHUnitIOS/GHUnit.h>
#import <Foundation/Foundation.h>

#import	"PageViewController.h"

@interface TestPageViewController : GHTestCase {
	NSDictionary *page;
	PageViewController *viewController;
}
@end

@implementation TestPageViewController

-(void)setUp {
	//This should be the same in appkit.db > sections data
	NSArray *arrayObjects = [[[NSArray alloc] initWithObjects:	
							  @"1",
							  @"My Title",
							  @"My SubTitle",
							  @"Lorem Ipsum",
							  nil] autorelease];
	
	NSArray *arrayKeys = [[[NSArray alloc] initWithObjects:@"id", @"title", @"sub_title", @"content", nil] autorelease];
	
	page = [[NSDictionary alloc] initWithObjects:arrayObjects forKeys:arrayKeys];
	viewController = [[PageViewController alloc] initWithNibName:@"PageViewController" bundle:nil withDictionary:page];
}

-(void)tearDown {
	[page release];
	[viewController release];
}

-(void)testShouldDisplayTitle{
	GHAssertEquals(viewController.title, [page objectForKey:@"title"], nil);
	GHAssertEquals(viewController.navigationController.navigationBar.hidden, NO, nil);
}

@end
