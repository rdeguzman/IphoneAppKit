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

- (NSMutableArray*)getMainSections;

- (UIImage*)getImageForId:(NSString*)_id;

@end
