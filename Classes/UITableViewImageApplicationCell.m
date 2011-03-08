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

		titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(IMAGECELL_CONTENT_LEFT, 6.0f, IMAGECELL_CONTENT_TEXT_WIDTH, 20.0f)];
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.font = [UIFont boldSystemFontOfSize:19.0];
		titleLabel.textColor = [UIColor blackColor];
        titleLabel.highlightedTextColor = [UIColor whiteColor];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self.contentView addSubview:titleLabel];
		
		subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(IMAGECELL_CONTENT_LEFT, 25.0f, IMAGECELL_CONTENT_TEXT_WIDTH, 45.0f)];
        subtitleLabel.textAlignment = UITextAlignmentLeft;
        subtitleLabel.font = [UIFont boldSystemFontOfSize:11.0];
        subtitleLabel.textColor = [UIColor colorWithWhite:0.23 alpha:1.0];
		subtitleLabel.highlightedTextColor = [UIColor whiteColor];
        subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		subtitleLabel.numberOfLines = 3;
        [self.contentView addSubview:subtitleLabel];
		
		photoImageView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TABLEVIEW_CELL_THUMB_BACKGROUND_WIDTH, TABLEVIEW_CELL_THUMB_BACKGROUND_HEIGHT)];
		[self.contentView addSubview:photoImageView];
    }
    
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    cellContentView.backgroundColor = backgroundColor;
	titleLabel.backgroundColor = backgroundColor;
	subtitleLabel.backgroundColor = backgroundColor;
	photoImageView.backgroundColor = backgroundColor;
}

- (void)setTitle:(NSString *)_name{
    [super setTitle:_name];
    titleLabel.text = _name;
}

- (void)setSubtitle:(NSString *)_text{
    [super setSubtitle:_text];
    subtitleLabel.text = _text;
}

- (void)setPhotoUIView:(UIView *)_view{
	for(UIView* _view in photoImageView.subviews){
		[_view removeFromSuperview];
	}
	
	[photoImageView addSubview:_view];
}

- (void)dealloc{
    [cellContentView release];
	[titleLabel release];
	[subtitleLabel release];
	[photoImageView release];
	
    [super dealloc];
}

@end
