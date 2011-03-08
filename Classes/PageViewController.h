//
//  PageViewController.h
//  Hotel
//
//  Created by rupert on 28/01/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageViewController : UIViewController {
	NSDictionary* info;
	IBOutlet UITextView *textview;
	IBOutlet UILabel *titleLabel;
	IBOutlet UIImageView *imageview;
}

@property(nonatomic, retain) IBOutlet UITextView* textview;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) IBOutlet UIImageView *imageview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDictionary:(NSDictionary*)_info;

-(IBAction)buttonHomePressed;

-(IBAction)buttonImagePressed;

@end
