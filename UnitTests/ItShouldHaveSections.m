//
//  ItShouldHaveSections.m
//  UnitTests
//
//  Created by Brett Schuchert on 11/9/10.
//  Copyright 2010 Brett L. Schuchert. Use at will, just don't blame me.
//

#import <GHUnitIOS/GHUnit.h>
#import <Foundation/Foundation.h>

#import	"MainViewController.h"
#import "DataAccess.h"


@interface ItShouldHaveSections : GHTestCase {
    DataAccess *da;
}
@end

@implementation ItShouldHaveSections

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
@end