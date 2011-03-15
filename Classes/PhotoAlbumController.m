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
	
	for(NSDictionary *picture in arrayURLPictures){
		
		NSString *file_name_thumb = [NSString stringWithFormat:@"%@.jpg", [picture objectForKey:@"thumb_image"]];
		NSLog(@"file_name_thumb: %@", file_name_thumb);
		UIImage *thumbImage = [UIImage imageNamed:file_name_thumb];
		
		NSString *file_name_full = [NSString stringWithFormat:@"%@.jpg", [picture objectForKey:@"full_image"]];
		NSLog(@"file_name_full: %@", file_name_full);
		UIImage *fullImage = [UIImage imageNamed:file_name_full];

		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:thumbImage, @"thumbnail", fullImage, @"fullsize", nil];
		[arrayPhotos addObject:dict];
		
	}
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
