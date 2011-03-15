//
//  PhotoDataSource.m
//  ReallyBigPhotoLibrary
//
//  Created by Kirby Turner on 9/14/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "PhotoDataSource.h"


@implementation PhotoDataSource

- (void)dealloc
{
	[data_ release];
	data_ = nil;
	[super dealloc];
}

- (id)initWithArray:(NSArray*)_array
{
   self = [super init];
   if (self) {
      data_ = [[NSMutableArray alloc] initWithArray:_array];
   }
   return self;
}

- (NSInteger)numberOfPhotos
{
   return [data_ count];
}

// Implement either these, for synchronous images…
- (UIImage *)imageAtIndex:(NSInteger)index
{
   NSDictionary *dict = [data_ objectAtIndex:index];
   UIImage *image = [dict objectForKey:@"full_image"];
   return image;
}

- (UIImage *)thumbImageAtIndex:(NSInteger)index
{
   NSDictionary *dict = [data_ objectAtIndex:index];
   UIImage *image = [dict objectForKey:@"thumb_image"];
   return image;
}


@end
