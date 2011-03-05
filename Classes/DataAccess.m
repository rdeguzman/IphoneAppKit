//
//  DataAccess.m
//  iDig
//
//  Created by rupert on 27/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DataAccess.h"
#import "AppKitAppDelegate.h"

@implementation DataAccess

- (id)init{
	if( self = [super init]){
		NSLog(@"DataAccess.init");
		AppKitAppDelegate *app = (AppKitAppDelegate *)[[UIApplication sharedApplication] delegate];
		db = [[FMDatabase alloc] initWithPath:app.dbPath];
	}
	
	return self;
}

- (id)initWithPath:(NSString*)_path{
	if( self = [super init]){
		NSLog(@"DataAccess.initWithPath %@", _path);
		db = [[FMDatabase alloc] initWithPath:_path];
	}
	
	return self;
}

- (void)dealloc{
	[db release];

	[super dealloc];
}

- (NSMutableArray*)getMainSections{
	NSLog(@"DataAccess.getMainSections");
	
	NSMutableArray *array = [[[NSMutableArray alloc] initWithObjects:nil] autorelease];
	
	[db open];
	rs = [db executeQuery:@"SELECT * FROM sections"];
	
	if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	
	while ([rs next]) {
		NSArray *arrayObjects = [[[NSArray alloc] initWithObjects:	
								  [rs stringForColumn:@"id"],
								  [rs stringForColumn:@"title"], 
								 nil] autorelease];
		
		NSArray *arrayKeys = [[[NSArray alloc] initWithObjects:@"id", @"title", nil] autorelease];
		
		NSDictionary *obj = [[[NSDictionary alloc] initWithObjects:arrayObjects forKeys:arrayKeys] autorelease];
		
		[array addObject:obj];
	}
	
	NSLog(@"DataAccess.getMainSections: %d found", [array count]);
	
	[rs close];
	[db close];
	
	return array;
}

- (UIImage*)getAppBackgroundImage{
	NSLog(@"DataAccess.getAppBackgroundImage");
	UIImage* image = nil;
	
	[db open];
	
	rs = [db executeQuery:@"SELECT background_image FROM app_profile"];
	
	if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	
	if( [rs next] ){
		image = [[[UIImage alloc] initWithData:[rs dataForColumn:@"background_image"]] autorelease];
		NSLog(@"DataAccess.getAppBackgroundImage found image (%f, %f)", image.size.width, image.size.height);
	}
	
	[rs close];
	[db close];
	
	return image;
}

- (UIImage*)getImageForId:(NSString*)_id{
	NSLog(@"DataAccess.getImageForId: %@", _id);
	NSNumber* picture_id = [NSNumber numberWithInt:[_id intValue]];
	
	UIImage* image = nil;
	
	[db open];
	
	FMResultSet* _rs = [db executeQuery:@"SELECT * FROM pictures WHERE id = ?", picture_id];
	if( [_rs next] ){
		image = [[[UIImage alloc] initWithData:[_rs dataForColumn:@"full_image"]] autorelease];
		NSLog(@"DataAccess.getThumbImageForId found image (%f, %f)", image.size.width, image.size.height);
	}
	
	[_rs close];
	[db close];
	
	return image;
}

@end
