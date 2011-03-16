//
//  PageViewController.m
//  Hotel
//
//  Created by rupert on 28/01/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import "PageViewController.h"
#import "DataAccess.h"
#import "KTPhotoScrollViewController.h"
#import "PhotoDataSource.h"

@implementation PageViewController

@synthesize textview, titleLabel, imageview;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDictionary:(NSDictionary*)_info{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		info = [[NSDictionary alloc] initWithDictionary:_info];
		self.title = [info objectForKey:@"title"];
    }
    return self;
}


- (void)dealloc {
    [info release];
	
	[textview release];
	[titleLabel release];
	[imageview release];
	
	[super dealloc];
}

-(IBAction)buttonHomePressed{
	NSLog(@"PageViewController.buttonHomePressed");
	[self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"PageViewController.viewDidLoad");
    [super viewDidLoad];
	
	NSString* page_id = [info objectForKey:@"id"];
	DataAccess *da = [[DataAccess alloc] init];
	NSDictionary* page = [[NSDictionary alloc] initWithDictionary:[da getPage:page_id]];
	[da release];
	
	textview.font = [UIFont systemFontOfSize:14];
	textview.text = [page objectForKey:@"content"];

	titleLabel.text = [page objectForKey:@"title"];
	[page release];
	
	da = [[DataAccess alloc] init];
	UIImage *image = [da getDefaultFullImageForPage:[info objectForKey:@"id"]];
	[da release];

	NSLog(@"image (%f, %f)", image.size.width, image.size.height);
	imageview.image = image;
	imageview.alpha = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"PageViewControllerb.viewWillAppear");
	
	[super viewWillAppear:animated];
	
	[UIView beginAnimations:@"fadePhotoThumb" context:NULL];
	[UIView setAnimationDuration:0.75];
	imageview.alpha = 1;
	[UIView commitAnimations];
	
	self.title = [info objectForKey:@"title"];
	
	[self setWantsFullScreenLayout:NO];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)buttonImagePressed{
	NSLog(@"PageViewControllerb.buttonImagePressed");
	self.title = @"Back";
	
	NSMutableArray *arrayPhotos = [[NSMutableArray alloc] initWithObjects:nil];
	
	NSString* page_id = [info objectForKey:@"id"];
	DataAccess *da = [[DataAccess alloc] init];
	UIImage *full_image = [da getDefaultFullImageForPage:page_id];
	[da release];
	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: full_image, @"full_image", nil];
	[arrayPhotos addObject:dict];
		
	
	PhotoDataSource *datasource = [[PhotoDataSource alloc] initWithArray:arrayPhotos];
	[arrayPhotos release];
	
	KTPhotoScrollViewController *newController = [[KTPhotoScrollViewController alloc] 
												  initWithDataSource:datasource 
                                                  andStartWithPhotoAtIndex:0];
	
	[[self navigationController] pushViewController:newController animated:YES];
	[newController release];
	[datasource release];
}

@end
