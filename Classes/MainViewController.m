    //
//  MainViewController.m
//  AppKit
//
//  Created by rupert on 4/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import "MainViewController.h"
#import "DataAccess.h"

@interface MainViewController(private)
- (void)initBackgroundImage;
- (void)initButtons;
@end

@implementation MainViewController

@synthesize arraySections, imageViewBackground;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"MainView";
		imageViewBackground = nil;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"MainViewController.viewDidLoad");
    [super viewDidLoad];
	
	[self initBackgroundImage];
	[self initButtons];
}

- (void)viewWillAppear:(BOOL)animated{
	NSLog(@"MainViewController.viewWillAppear");
    [super viewWillAppear:YES];
	
	[self.navigationController setNavigationBarHidden:YES animated:NO];
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


- (void)dealloc {
	[arraySections release];
	[imageViewBackground release];
	
    [super dealloc];
}

- (void)setBackgroundImage:(UIImage*)_image{
	imageViewBackground = [[UIImageView alloc] initWithImage:_image];
	imageViewBackground.frame = CGRectMake(0.0f, 0.0f, 320.0f, 460.0f);
	imageViewBackground.contentMode = UIViewContentModeScaleToFill;
	imageViewBackground.accessibilityLabel = @"backgroundImageView";
	[self.view addSubview:imageViewBackground];
}

- (void)initBackgroundImage{
	NSLog(@"MainViewController.initBackgroundImage");
	
	DataAccess *da = [[DataAccess alloc] init];
	[self setBackgroundImage:(UIImage*)[da getAppBackgroundImage]];
	[da release];
}

#define PADDING_VERTICAL 5.0f
#define BUTTON_HEIGHT 40.0f
#define BUTTON_WIDTH 160.0f
#define BUTTON_ORIGIN_X (320.0f - BUTTON_WIDTH)/2.0f
#define BUTTON_ORIGIN_Y 20.0f

- (void)initButtons{
	NSLog(@"MainViewController.initButtons");
	
	DataAccess *da = [[DataAccess alloc] init];
	arraySections = [[[NSMutableArray alloc] initWithArray:[da getMainSections]] autorelease];
	[da release];
	
	CGFloat totalHeight = BUTTON_ORIGIN_Y;
	
	UIImage* buttonImage = [UIImage imageNamed:@"button_center_light_gray.png"];

	for(NSDictionary* section in arraySections){
		NSString* title = [section objectForKey:@"title"];
		
		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(BUTTON_ORIGIN_X, totalHeight, BUTTON_WIDTH, BUTTON_HEIGHT);
		[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
		
		[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
		[button setTitle:title forState:UIControlStateNormal];
		
		button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		
		[self.view addSubview:button];
		
		totalHeight = totalHeight + BUTTON_HEIGHT + PADDING_VERTICAL;
	} 
}

- (void)buttonPressed:(id)sender{
	UIButton* button = (UIButton*)sender;
	NSLog(@"MainViewController.buttonPressed %@", [button currentTitle]);
}

@end
