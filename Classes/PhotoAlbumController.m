#import "PhotoAlbumController.h"
#import "DataAccess.h"
#import "PhotoDataSource.h"

@interface PhotoAlbumController(private)
- (void)initDatasource;
@end

@implementation PhotoAlbumController

@synthesize arrayURLPictures;

- (id)init{
	
	if (self = [super init]) {
		DataAccess* da = [[DataAccess alloc] init];
		arrayURLPictures = [[NSMutableArray alloc] initWithArray:[da getAllPictures]];
		[da release];
	}
	
	return self;
}

- (void)dealloc 
{
	[datasource release];
	[arrayURLPictures release];
	[super dealloc];
}

- (void)initDatasource{
	NSMutableArray *arrayPhotos = [[NSMutableArray alloc] initWithObjects:nil];
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	DataAccess* da = [[DataAccess alloc] init];
	
	for(NSDictionary *picture in arrayURLPictures){
		
		NSString* picture_id = [picture objectForKey:@"id"];
		UIImage *thumbImage = [da getThumbImageForPictureId:picture_id];
		UIImage *fullImage = [da getFullImageForPictureId:picture_id];

		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:thumbImage, @"thumb_image", fullImage, @"full_image", nil];
		[arrayPhotos addObject:dict];
		
	}
	[da release];
	
	[pool drain];
	
	datasource = [[PhotoDataSource alloc] initWithArray:arrayPhotos];
	[arrayPhotos release];
	
	[self setDataSource:datasource];
	[self setTitle:[NSString stringWithFormat:@"%i Photos", [datasource numberOfPhotos]]];
}

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	[self initDatasource];
	
	// Label back button as "Back".
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"Back button title") style:UIBarButtonItemStylePlain target:nil action:nil];
	[[self navigationItem] setBackBarButtonItem:backButton];
	[backButton release];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"PhotoAlbumController.viewWillAppear");
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	
	[super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}


@end
