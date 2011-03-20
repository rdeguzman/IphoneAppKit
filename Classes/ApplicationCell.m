//
//  ApplicationCell.m
//  Philippines
//
//  Created by rupert on 31/07/10.
//  Copyright 2010 2RMobile. All rights reserved.
//

#import "ApplicationCell.h"

@implementation ApplicationCell

@synthesize useDarkBackground, photoUIView, subtitle1, subtitle2, title;

- (void)setUseDarkBackground:(BOOL)flag
{
    if (flag != useDarkBackground || !self.backgroundView)
    {
        useDarkBackground = flag;
		
        NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:useDarkBackground ? @"DarkBackground" : @"LightBackground" ofType:@"png"];
        UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        self.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView.frame = self.bounds;
    }
}

- (void)dealloc
{
    [photoUIView release];
    [subtitle1 release];
	[subtitle2 release];
    [title release];
	
    [super dealloc];
}

@end