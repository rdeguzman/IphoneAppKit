//
//  TestApplicationDelegate.m
//  AppKit
//
//  Created by rupert on 7/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import "TestApplicationDelegate.h"
#import "ApplicationConstants.h"

@implementation TestApplicationDelegate

@synthesize dbPath;

- (id)init{
	if( self = [super init]){
		dbPath = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME]];
		
	}
	
	return self;
}

- (void)dealloc{
	[super dealloc];
}

@end
