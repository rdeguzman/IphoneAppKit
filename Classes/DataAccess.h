//
//  DataAccess.h
//  iDig
//
//  Created by rupert on 27/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DataAccess : NSObject {
	FMDatabase *db;
	FMResultSet *rs;
}

- (id)initWithPath:(NSString*)_path;

- (NSMutableArray*)getButtons;

- (UIImage*)getAppBackgroundImage;

- (NSDictionary*)getPage:(NSString*)_page_id;

- (NSMutableArray*)getPagesForSection:(NSString*)_section_id;

- (UIImage*)getDefaultThumbImageForPage:(NSString*)_page_id;

- (UIImage*)getDefaultFullImageForPage:(NSString*)_page_id;

- (NSMutableArray*)getAllPictures;

- (UIImage*)getThumbImageForPictureId:(NSString*)_picture_id;

- (UIImage*)getFullImageForPictureId:(NSString*)_picture_id;


@end
