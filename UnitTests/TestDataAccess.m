//
//  TestDataAccess.m
//  AppKit
//
//  Created by rupert on 5/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import <Foundation/Foundation.h>

#import	"MainViewController.h"
#import "DataAccess.h"


@interface TestDataAccess : GHTestCase {
    DataAccess *da;
}
@end

@implementation TestDataAccess

-(void)setUp {
    da = [[DataAccess alloc] initWithPath:@"/Volumes/rupert/projects/iphone/2RMobile/AppKit/appkit.db"];
}

-(void)tearDown {
    [da release];
	da = nil;
}

-(void)testGetMainSectionsShouldBe5 {
	NSArray *arrayRecords = [[NSArray alloc] initWithArray:[da getMainSections]];
    GHAssertEquals(5, (int)[arrayRecords count], nil);
	[arrayRecords release];
}

-(void)testGetBackgroundImage{
	UIImage* backgroundImage = nil;
	backgroundImage = (UIImage *)[da getAppBackgroundImage];
	GHAssertNotNil(backgroundImage, nil);
}
@end