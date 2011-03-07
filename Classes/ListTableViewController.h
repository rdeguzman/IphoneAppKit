//
//  ListTableViewController.h
//  AppKit
//
//  Created by rupert on 7/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListTableViewController : UITableViewController {
	NSMutableArray* arrayPages;
	NSDictionary* section;
}

@property(nonatomic, retain) NSMutableArray *arrayPages;
@property(nonatomic, retain) NSDictionary* section;

- (id)initWithDictionary:(NSDictionary*)_section;

- (void)initPages;

@end
