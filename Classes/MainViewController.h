//
//  MainViewController.h
//  AppKit
//
//  Created by rupert on 4/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController {
	NSMutableArray *arrayButtons;
	UIImageView* imageViewBackground;
	BOOL firstRun;
}

@property(nonatomic, retain) NSMutableArray *arrayButtons;
@property(nonatomic, retain) UIImageView* imageViewBackground;

- (void)initBackgroundImage;
- (void)initButtons;
- (BOOL)showListTableViewController:(NSDictionary*)_section;
- (BOOL)showPageViewController:(NSDictionary*)_page;

@end
