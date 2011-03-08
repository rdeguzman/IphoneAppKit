//
//  PageViewController.m
//  Hotel
//
//  Created by rupert on 28/01/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import "PageViewController.h"
#import "DataAccess.h"
//#import "KTPhotoScrollViewController.h"
//#import "PhotoDataSource.h"

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
	
	textview.font = [UIFont systemFontOfSize:14];
	
	textview.text = [info objectForKey:@"content"];
	titleLabel.text = [info objectForKey:@"title"];
	
	DataAccess *da = [[DataAccess alloc] init];
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
	
	//[self.navigationController setNavigationBarHidden:YES animated:YES];
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
	/*
	NSLog(@"PageViewControllerb.buttonImagePressed");
	
	NSMutableArray *arrayPhotos = [[NSMutableArray alloc] initWithObjects:nil];
	
	NSString *file_name_full = [NSString stringWithFormat:@"%@.jpg", [info objectForKey:@"full_image"]];
	NSLog(@"file_name_full: %@", file_name_full);
	UIImage *fullImage = [UIImage imageNamed:file_name_full];
	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: fullImage, @"fullsize", nil];
	[arrayPhotos addObject:dict];
		
	
	PhotoDataSource *datasource = [[PhotoDataSource alloc] initWithArray:arrayPhotos];
	[arrayPhotos release];
	
	KTPhotoScrollViewController *newController = [[KTPhotoScrollViewController alloc] 
												  initWithDataSource:datasource 
                                                  andStartWithPhotoAtIndex:0];
	
	[[self navigationController] pushViewController:newController animated:YES];
	[newController release];
	 */
}

@end
