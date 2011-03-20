//
//  ApplicationCell.h
//  Philippines
//
//  Created by rupert on 31/07/10.
//  Copyright 2010 2RMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ApplicationCell : UITableViewCell
{
    BOOL useDarkBackground;
	
    UIView *photoUIView;
    NSString *subtitle1;
	NSString *subtitle2;
    NSString *title;
}

@property BOOL useDarkBackground;

@property(retain) UIView *photoUIView;
@property(retain) NSString *subtitle1;
@property(retain) NSString *subtitle2;
@property(retain) NSString *title;

@end
