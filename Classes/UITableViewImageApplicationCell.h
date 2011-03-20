//
//  PoiTableViewApplicationCell.h
//  Philippines
//
//  Created by rupert on 31/07/10.
//  Copyright 2010 2RMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationCell.h"

@interface UITableViewImageApplicationCell : ApplicationCell {
	UIView *cellContentView;
	UILabel* titleLabel;
	UILabel* subtitle1Label;
	UILabel* subtitle2Label;
	UIView* photoImageView;
	CGFloat imageCellContentLeft;
	CGFloat imageCellContentWidth;
}

@end
