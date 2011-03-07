//
//  TestApplicationDelegate.h
//  AppKit
//
//  Created by rupert on 7/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GHUnitIOS/GHUnit.h>

@interface TestApplicationDelegate : GHUnitIPhoneAppDelegate {
	NSString *dbPath;
}

@property (nonatomic, retain) NSString *dbPath;

@end
