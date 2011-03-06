//
//  MainViewController.h
//  AppKit
//
//  Created by rupert on 4/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController {
	NSMutableArray *arraySections;
	UIImageView* imageViewBackground;
}

@property(nonatomic, retain) NSMutableArray *arraySections;
@property(nonatomic, retain) UIImageView* imageViewBackground;

- (void)setBackgroundImage:(UIImage*)_image;

@end
