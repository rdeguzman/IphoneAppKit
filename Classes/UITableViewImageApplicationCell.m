//
//  PoiTableViewApplicationCell.m
//  Philippines
//
//  Created by rupert on 31/07/10.
//  Copyright 2010 2RMobile. All rights reserved.
//
#import "UITableViewImageApplicationCell.h"
#import "ApplicationConstants.h"

#define MAX_RATING 5.0

@interface PoiImageTableViewApplicationCellContentView : UIView
{
    ApplicationCell *_cell;
    BOOL _highlighted;
}

@end

@implementation PoiImageTableViewApplicationCellContentView

- (id)initWithFrame:(CGRect)frame cell:(ApplicationCell *)cell
{
    if (self = [super initWithFrame:frame])
    {
        _cell = cell;
        
        self.opaque = YES;
        self.backgroundColor = _cell.backgroundColor;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //[[NSString stringWithFormat:@"%d Ratings", _cell.numRatings] drawAtPoint:CGPointMake(150.0, 50.0) withFont:[UIFont systemFontOfSize:10.0]];
	
    //CGPoint ratingImageOrigin = CGPointMake(81.0, 48.0);
//    UIImage *ratingBackgroundImage = [UIImage imageNamed:@"StarsBackground.png"];
//    [ratingBackgroundImage drawAtPoint:ratingImageOrigin];
//    UIImage *ratingForegroundImage = [UIImage imageNamed:@"StarsForeground.png"];
//    UIRectClip(CGRectMake(ratingImageOrigin.x, ratingImageOrigin.y, ratingForegroundImage.size.width * (_cell.rating / MAX_RATING), ratingForegroundImage.size.height));
//    [ratingForegroundImage drawAtPoint:ratingImageOrigin];
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

- (BOOL)isHighlighted
{
    return _highlighted;
}

@end


#pragma mark -

@implementation UITableViewImageApplicationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        cellContentView = [[PoiImageTableViewApplicationCellContentView alloc] initWithFrame:CGRectInset(self.contentView.bounds, 0.0, 1.0) cell:self];
        cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cellContentView.contentMode = UIViewContentModeLeft;
        [self.contentView addSubview:cellContentView];
		
		photoImageView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TABLEVIEW_CELL_THUMB_BACKGROUND_WIDTH, TABLEVIEW_CELL_THUMB_BACKGROUND_HEIGHT)];
		[self.contentView addSubview:photoImageView];
		
		imageCellContentLeft = 3.0f;
		imageCellContentWidth = 315.0f;
    }
    
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    cellContentView.backgroundColor = backgroundColor;
	titleLabel.backgroundColor = backgroundColor;
	subtitle1Label.backgroundColor = backgroundColor;
	subtitle2Label.backgroundColor = backgroundColor;
	photoImageView.backgroundColor = backgroundColor;
}

- (void)setTitle:(NSString *)_name{
    [super setTitle:_name];
    //titleLabel.text = _name;
	
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageCellContentLeft, 6.0f, imageCellContentWidth, 20.0f)];
	titleLabel.textAlignment = UITextAlignmentLeft;
	titleLabel.font = [UIFont boldSystemFontOfSize:19.0];
	titleLabel.textColor = [UIColor blackColor];
	titleLabel.highlightedTextColor = [UIColor whiteColor];
	titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	titleLabel.text = _name;
	[self.contentView addSubview:titleLabel];
}

- (void)setSubtitle1:(NSString *)_text{
	NSLog(@"setSubtitle1: %@", _text);
    [super setSubtitle1:_text];
    //subtitle1Label.text = _text;
	
	subtitle1Label = [[UILabel alloc] initWithFrame:CGRectMake(imageCellContentLeft, 25.0f, imageCellContentWidth, 15.0f)];
	subtitle1Label.textAlignment = UITextAlignmentLeft;
	subtitle1Label.font = [UIFont boldSystemFontOfSize:10.0];
	subtitle1Label.textColor = [UIColor whiteColor];
	subtitle1Label.highlightedTextColor = [UIColor whiteColor];
	subtitle1Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	subtitle1Label.numberOfLines = 1;
	subtitle1Label.text = _text;
	[self.contentView addSubview:subtitle1Label];
}

- (void)setSubtitle2:(NSString *)_text{
	NSLog(@"setSubtitle2: %@", _text);
	[super setSubtitle2:_text];
	
	if( [subtitle1Label.text length] > 0){
		subtitle2Label = [[UILabel alloc] initWithFrame:CGRectMake(imageCellContentLeft, 42.0f, imageCellContentWidth, 25.0f)];
		subtitle2Label.numberOfLines = 2;
	}
	else{
		subtitle2Label = [[UILabel alloc] initWithFrame:CGRectMake(imageCellContentLeft, 25.0f, imageCellContentWidth, 45.0f)];
		subtitle2Label.numberOfLines = 3;
	}
	
	subtitle2Label.textAlignment = UITextAlignmentLeft;
	subtitle2Label.font = [UIFont boldSystemFontOfSize:11.0];
	subtitle2Label.textColor = [UIColor colorWithWhite:0.23 alpha:1.0];
	subtitle2Label.highlightedTextColor = [UIColor whiteColor];
	subtitle2Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	subtitle2Label.text = _text;
	[self.contentView addSubview:subtitle2Label];
}

- (void)setPhotoUIView:(UIView *)_view{
	NSLog(@"setPhotoUIView");
	for(UIView* _view in photoImageView.subviews){
		[_view removeFromSuperview];
	}
	
	[photoImageView addSubview:_view];
	imageCellContentLeft = IMAGECELL_CONTENT_LEFT;
	imageCellContentWidth = IMAGECELL_CONTENT_TEXT_WIDTH;
}

- (void)dealloc{
    [cellContentView release];
	[titleLabel release];
	[subtitle1Label release];
	[subtitle2Label release];
	[photoImageView release];
	
    [super dealloc];
}

@end
