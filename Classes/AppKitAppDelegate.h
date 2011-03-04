//
//  AppKitAppDelegate.h
//  AppKit
//
//  Created by rupert on 4/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppKitAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	NSString *dbPath;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) NSString *dbPath;

@end

