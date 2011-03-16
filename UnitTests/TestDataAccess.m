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
	da = [[DataAccess alloc] init];
}

-(void)tearDown {
    [da release];
	da = nil;
}

-(void)testGetButtons {
	NSArray *arrayRecords = [[NSArray alloc] initWithArray:[da getButtons]];
	GHAssertGreaterThan( (int)arrayRecords.count, 0, nil);
	[arrayRecords release];
}

-(void)testGetBackgroundImage{
	UIImage* backgroundImage = nil;
	backgroundImage = (UIImage *)[da getAppBackgroundImage];
	GHAssertNotNil(backgroundImage, nil);
}

-(void)testShouldHavePages{
	NSMutableArray* arrayPages = [da getPagesForSection:@"34"];
	GHAssertGreaterThan( (int)arrayPages.count, 0, nil);
}

-(void)testShouldGetDefaultThumbImageForPage{
	NSMutableArray* arrayPages = [da getPagesForSection:@"34"];
	NSDictionary* page = [arrayPages objectAtIndex:0];
	NSString* page_id = [page objectForKey:@"id"];
	GHAssertNotNil([da getDefaultThumbImageForPage:page_id], nil);
}

-(void)testShouldGetDafaultFullImageForPage{
	NSMutableArray* arrayPages = [da getPagesForSection:@"34"];
	NSDictionary* page = [arrayPages objectAtIndex:0];
	NSString* page_id = [page objectForKey:@"id"];
	GHAssertNotNil([da getDefaultFullImageForPage:page_id], nil);
}

-(void)testShouldGetPage{
	NSDictionary* page = [da getPage:@"72"];
	GHAssertNotNil( page, nil);
}

-(void)testShouldHavePictures{
	NSMutableArray* arrayPages = [da getAllPictures];
	GHAssertGreaterThan( (int)arrayPages.count, 0, nil);
}

-(void)testShouldGetThumbImageForPictureId{
	GHAssertNotNil([da getThumbImageForPictureId:@"55"], nil);
}

-(void)testShouldGetFullImageForPictureId{
	GHAssertNotNil([da getFullImageForPictureId:@"55"], nil);
}

@end