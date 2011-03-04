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
- (void)initDatabase;
- (void)initButtons;
@end

@implementation MainViewController

@synthesize arraySections;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"MainView";
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
}

- (void)viewWillAppear:(BOOL)animated{
	NSLog(@"MainViewController.viewWillAppear");
    [super viewWillAppear:YES];
	
	[self initDatabase];
	[self initButtons];
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
	
    [super dealloc];
}

- (void)initDatabase{
	NSLog(@"MainViewController.initDatabase");
	
	DataAccess *da = [[DataAccess alloc] init];
	arraySections = [[[NSMutableArray alloc] initWithArray:[da getMainSections]] autorelease];
	[da release];
}

#define PADDING_VERTICAL 5.0f
#define BUTTON_HEIGHT 40.0f
#define BUTTON_ORIGIN_X 20.0f
#define BUTTON_ORIGIN_Y 20.0f

- (void)initButtons{
	NSLog(@"MainViewController.initButtons");
	CGFloat totalHeight = BUTTON_ORIGIN_Y;
	
	for(NSDictionary* section in arraySections){
		NSString* title = [section objectForKey:@"title"];
		
		UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchDown];
		[button setTitle:title forState:UIControlStateNormal];
		button.frame = CGRectMake(BUTTON_ORIGIN_X, totalHeight, 160.0, BUTTON_HEIGHT);
		[self.view addSubview:button];
		
		totalHeight = totalHeight + BUTTON_HEIGHT + PADDING_VERTICAL;
	} 
		

}

@end
