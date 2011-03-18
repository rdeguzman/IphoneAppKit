    //
//  MainViewController.m
//  AppKit
//
//  Created by rupert on 4/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import "MainViewController.h"
#import "DataAccess.h"
#import "ListTableViewController.h"
#import "PageViewController.h"
#import "PhotoAlbumController.h"

@implementation MainViewController

@synthesize arrayButtons, imageViewBackground;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		NSLog(@"MainViewController.init");

		self.title = @"Back";
		
		arrayButtons = nil;
		imageViewBackground = nil;
		firstRun = YES;
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
	
	if (firstRun) {
		[self.navigationController setNavigationBarHidden:YES animated:NO];
		firstRun = NO;
	}
	else{
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	}
	
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
	[arrayButtons release];
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
	if(imageViewBackground == nil){
		DataAccess *da = [[DataAccess alloc] init];
		[self setBackgroundImage:(UIImage*)[da getAppBackgroundImage]];
		[da release];
	}
}

#define PADDING_VERTICAL 5.0f
#define PADDING_HORIZONTAL 5.0f
#define BUTTON_HEIGHT 34.0f
#define BUTTON_WIDTH 160.0f
#define BUTTON_ORIGIN_X (320.0f - BUTTON_WIDTH)/2.0f
#define BUTTON_ORIGIN_Y 20.0f
#define BUTTON_FONT [UIFont boldSystemFontOfSize:14.0f]

-(CGFloat)computeForButtonOriginY:(NSArray*)buttons{
	CGFloat totalHeight = 0;
	for(int i=0;i < arrayButtons.count; i++){
		totalHeight = totalHeight + BUTTON_HEIGHT + PADDING_VERTICAL;
	}
	CGSize size = [[UIScreen mainScreen] applicationFrame].size;
	return (size.height - totalHeight)/2.0f;
}

-(CGFloat)computeForButtonWidth:(NSArray*)buttons{
	CGSize appSize = [[UIScreen mainScreen] applicationFrame].size;
	CGFloat longestWidth = 0;
	for(int i=0;i < buttons.count; i++){
		NSString* title = [[buttons objectAtIndex:i] objectForKey:@"title"];
		struct CGSize size = [title sizeWithFont: BUTTON_FONT constrainedToSize:CGSizeMake(appSize.width, BUTTON_HEIGHT) lineBreakMode:UILineBreakModeCharacterWrap];
		
		NSLog(@"computeForButtonWidth: %f", size.width);
		if(size.width > longestWidth){
			longestWidth = size.width;
		}
	}
	
	//NSLog(@"computeForButtonWidth longestWidth: %f", longestWidth);
	if(longestWidth < BUTTON_WIDTH){
		longestWidth = BUTTON_WIDTH;
	}
	
	return longestWidth;
}

- (void)initButtons{
	NSLog(@"MainViewController.initButtons");
	
	if(arrayButtons == nil){
		DataAccess *da = [[DataAccess alloc] init];
		arrayButtons = [[NSMutableArray alloc] initWithArray:[da getButtons]];
		[da release];
	}
	
	CGFloat totalHeight = [self computeForButtonOriginY:arrayButtons];
	CGFloat buttonWidth = PADDING_VERTICAL + [self computeForButtonWidth:arrayButtons] + PADDING_VERTICAL;
	
	UIImage* buttonImage = [UIImage imageNamed:@"button_center_ts.png"];

	for(int i=0;i < arrayButtons.count; i++){
		NSString* title = [[arrayButtons objectAtIndex:i] objectForKey:@"title"];
		
		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(BUTTON_ORIGIN_X, totalHeight, buttonWidth, BUTTON_HEIGHT);
		[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
		
		[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
		[button setTitle:title forState:UIControlStateNormal];
		[button setTag:i];
		
		button.titleLabel.font = BUTTON_FONT;
		
		[self.view addSubview:button];
		
		totalHeight = totalHeight + BUTTON_HEIGHT + PADDING_VERTICAL;
	} 
}

- (void)buttonPressed:(id)sender{
	UIButton* button = (UIButton*)sender;
	NSLog(@"MainViewController.buttonPressed %@ tag: %d", [button currentTitle], [button tag]);
	int i = (int)[button tag];
	NSDictionary* buttonData = [arrayButtons objectAtIndex:i];
	
	NSString* tableName = [buttonData objectForKey:@"table_name"];
	NSLog(@"MainViewController.butonPressed: tableName: %@", tableName);
	
	if( [tableName isEqualToString:@"Section"] ){
		[self showListTableViewController:buttonData];
	}
	else if( [tableName isEqualToString:@"Page"] ){
		[self showPageViewController:buttonData];
	}
	else if( [tableName isEqualToString:@"Photos"] ){
		[self showPhotosViewController];
	}
}

- (BOOL)showListTableViewController:(NSDictionary*)_section{
	BOOL flag = NO;
	
	NSLog(@"MainViewController.showListTableViewController");
	ListTableViewController *tableViewController = [[ListTableViewController alloc] initWithDictionary:_section];
	[self.navigationController pushViewController:tableViewController animated:YES];
	[tableViewController release];
	
	flag = YES;
	return flag;
}

- (BOOL)showPageViewController:(NSDictionary*)_page{
	BOOL flag = NO;
	
	NSLog(@"MainViewController.showPageViewController");
	PageViewController *pageView = [[PageViewController alloc] initWithNibName:@"PageViewController" bundle:nil withDictionary:_page];
	[self.navigationController pushViewController:pageView animated:YES];
	[pageView release];
	
	flag = YES;
	return flag;
}

- (BOOL)showPhotosViewController{
	BOOL flag = NO;
	
	NSLog(@"MainViewController.showPhotosViewController");
	PhotoAlbumController *thumbnailController = [[PhotoAlbumController alloc] init];
	[self.navigationController pushViewController:thumbnailController animated:YES];
	[thumbnailController release];
	
	flag = YES;
	return flag;	
}

@end
