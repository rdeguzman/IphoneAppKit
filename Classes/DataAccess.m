//
//  DataAccess.m
//  iDig
//
//  Created by rupert on 27/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DataAccess.h"
#import "AppKitAppDelegate.h"

@interface DataAccess(private)
- (NSData*)getImageForPage:(NSString*)_page_id dataColumn:(NSString*)_column;
@end


@implementation DataAccess

- (id)init{
	if( self = [super init]){
		AppKitAppDelegate *app = (AppKitAppDelegate *)[[UIApplication sharedApplication] delegate];
		//NSLog(@"DataAccess init dbPath: %@", app.dbPath);
		db = [[FMDatabase alloc] initWithPath:app.dbPath];
		[db open];

	}
	
	return self;
}

- (id)initWithPath:(NSString*)_path{
	if( self = [super init]){
		NSLog(@"DataAccess.initWithPath %@", _path);
		db = [[FMDatabase alloc] initWithPath:_path];
		[db open];
	}
	
	return self;
}

- (void)dealloc{
	[db close];
	[db release];

	[super dealloc];
}

- (NSMutableArray*)getButtons{
	NSLog(@"DataAccess.getButtons");
	
	NSMutableArray *array = [[[NSMutableArray alloc] initWithObjects:nil] autorelease];
	
	rs = [db executeQuery:@"SELECT * FROM buttons"];
	
	if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	
	while ([rs next]) {
		NSArray *arrayObjects = [[[NSArray alloc] initWithObjects:	
								  [rs stringForColumn:@"parent_id"],
								  [rs stringForColumn:@"button_index"], 
								  [rs stringForColumn:@"title"],
								  [rs stringForColumn:@"table_name"],
								  nil] autorelease];
		
		NSArray *arrayKeys = [[[NSArray alloc] initWithObjects:@"id", @"button_index", @"title", @"table_name", nil] autorelease];
		
		NSDictionary *obj = [[[NSDictionary alloc] initWithObjects:arrayObjects forKeys:arrayKeys] autorelease];
		
		[array addObject:obj];
	}
	
	NSLog(@"DataAccess.getButtons: %d found", [array count]);
	
	[rs close];
	
	return array;
}

- (UIImage*)getAppBackgroundImage{
	NSLog(@"DataAccess.getAppBackgroundImage");
	UIImage* image = nil;
	
	rs = [db executeQuery:@"SELECT background_image FROM app_profile"];
	
	if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	
	if( [rs next] ){
		image = [[[UIImage alloc] initWithData:[rs dataForColumn:@"background_image"]] autorelease];
		NSLog(@"DataAccess.getAppBackgroundImage found image (%f, %f)", image.size.width, image.size.height);
	}
	
	[rs close];
	
	return image;
}

- (NSDictionary*)getPage:(NSString*)_page_id{
	NSLog(@"DataAccess.getPage: %@", _page_id);
	
	NSDictionary *obj = nil;
	
	rs = [db executeQuery:@"SELECT * FROM pages WHERE id = ?", _page_id];
	
	if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	
	if ([rs next]) {
		NSArray *arrayObjects = [[[NSArray alloc] initWithObjects:	
								  [rs stringForColumn:@"id"],
								  [rs stringForColumn:@"title"],
								  [rs stringForColumn:@"sub_title"],
								  [rs stringForColumn:@"content"],
								  nil] autorelease];
		
		NSArray *arrayKeys = [[[NSArray alloc] initWithObjects:@"id", @"title", @"sub_title", @"content", nil] autorelease];
		
		obj = [[[NSDictionary alloc] initWithObjects:arrayObjects forKeys:arrayKeys] autorelease];
	}
	
	NSLog(@"DataAccess.getPage: %@ found", [obj	objectForKey:@"title"]);
	
	[rs close];
	
	return obj;
}

- (NSMutableArray*)getPagesForSection:(NSString*)_section_id{
	NSLog(@"DataAccess.getPagesForSection: %@", _section_id);
	
	NSMutableArray *array = [[[NSMutableArray alloc] initWithObjects:nil] autorelease];
	
	rs = [db executeQuery:@"SELECT * FROM pages WHERE section_id = ?", _section_id];
	
	if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	
	while ([rs next]) {
		NSArray *arrayObjects = [[[NSArray alloc] initWithObjects:	
								  [rs stringForColumn:@"id"],
								  [rs stringForColumn:@"title"],
								  [rs stringForColumn:@"sub_title"],
								  [rs stringForColumn:@"content"],
								  nil] autorelease];
		
		NSArray *arrayKeys = [[[NSArray alloc] initWithObjects:@"id", @"title", @"sub_title", @"content", nil] autorelease];
		
		NSDictionary *obj = [[[NSDictionary alloc] initWithObjects:arrayObjects forKeys:arrayKeys] autorelease];
		
		[array addObject:obj];
	}
	
	NSLog(@"DataAccess.getPagesForSection: %d found", [array count]);
	
	[rs close];
	
	return array;
}

- (UIImage*)getDefaultThumbImageForPage:(NSString*)_page_id{
	NSData* imageData = [self getImageForPage:_page_id dataColumn:@"thumb_image"];
	UIImage* image = [[[UIImage alloc] initWithData:imageData] autorelease];
	NSLog(@"DataAccess.getDefaultThumbImageForPage found image (%f, %f)", image.size.width, image.size.height);
	return image;
}

- (UIImage*)getDefaultFullImageForPage:(NSString*)_page_id{
	NSData* imageData = [self getImageForPage:_page_id dataColumn:@"full_image"];
	UIImage* image = [[[UIImage alloc] initWithData:imageData] autorelease];
	NSLog(@"DataAccess.getFullThumbImageForPage found image (%f, %f)", image.size.width, image.size.height);
	return image;
}

- (NSData*)getImageForPage:(NSString*)_page_id dataColumn:(NSString*)_column{
	NSLog(@"DataAccess.getImageForPage %@", _page_id);
	NSData* data = nil;
	
	rs = [db executeQuery:@"SELECT * FROM pictures WHERE page_id = ? LIMIT 1", _page_id];
	
	if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	
	if( [rs next] ){
		data = [[[NSData alloc] initWithData:[rs dataForColumn:_column]] autorelease];
	}
	
	[rs close];
	
	return data;
}

- (UIImage*)getImageForPageTest:(NSString*)_page_id dataColumn:(NSString*)_column{
	NSLog(@"DataAccess.getImageForPage %@", _page_id);
	UIImage* image = nil;
	
	rs = [db executeQuery:@"SELECT * FROM pictures WHERE page_id = ? LIMIT 1", _page_id];
	
	if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	
	if( [rs next] ){
		image = [[[UIImage alloc] initWithData:[rs dataForColumn:_column]] autorelease];
		NSLog(@"DataAccess.getImageForPage found image (%f, %f)", image.size.width, image.size.height);
	}
	
	[rs close];
	
	return image;
}



@end
