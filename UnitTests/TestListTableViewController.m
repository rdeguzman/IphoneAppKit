//
//  TestListTableViewController.m
//  AppKit
//
//  Created by rupert on 7/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//
#import <GHUnitIOS/GHUnit.h>
#import <Foundation/Foundation.h>

#import	"ListTableViewController.h"

@interface TestListTableViewController : GHTestCase {
	NSDictionary *section;
	ListTableViewController *viewController;
}
@end

@implementation TestListTableViewController

-(void)setUp {
	//This should be the same in appkit.db > sections data
	NSArray *arrayObjects = [[[NSArray alloc] initWithObjects:	
							  @"34",
							  @"Rooms", 
							  nil] autorelease];
	
	NSArray *arrayKeys = [[[NSArray alloc] initWithObjects:@"id", @"title", nil] autorelease];
	
	section = [[NSDictionary alloc] initWithObjects:arrayObjects forKeys:arrayKeys];
	viewController = [[ListTableViewController alloc] initWithDictionary:section];
}

-(void)tearDown {
	[section release];
	[viewController release];
}

-(void)testShouldDisplayTitle{
	GHAssertEquals(viewController.title, [section objectForKey:@"title"], nil);
	GHAssertEquals(viewController.navigationController.navigationBar.hidden, NO, nil);
}

-(void)testShouldHaveData{
	[viewController initPages];
	GHAssertNotNil(viewController.arrayPages, nil);
}

-(void)testShouldCreatePageViewController{
	[viewController initPages];
	NSDictionary* page = [[viewController arrayPages] objectAtIndex:1];
	BOOL flag = [viewController showPageViewController:page];
	GHAssertTrue(flag, nil);
}

@end