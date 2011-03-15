#import "KTThumbsViewController.h"
#import "PhotoDataSource.h"

@interface PhotoAlbumController : KTThumbsViewController {
	NSMutableArray *arrayURLPictures;
	PhotoDataSource *datasource;
}

@property(nonatomic, retain) NSMutableArray *arrayURLPictures;

@end
