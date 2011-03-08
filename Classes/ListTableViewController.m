//
//  ListTableViewController.m
//  AppKit
//
//  Created by rupert on 7/03/11.
//  Copyright 2011 2RMobile. All rights reserved.
//

#import "ListTableViewController.h"
#import "DataAccess.h"
#import "UITableViewImageApplicationCell.h"
#import "ApplicationConstants.h"

@implementation ListTableViewController

@synthesize arrayPages, section;

#pragma mark -
#pragma mark Initialization

- (id)initWithDictionary:(NSDictionary*)_section{
	self = [super initWithStyle:UITableViewStylePlain];
	
	self.title = [_section objectForKey:@"title"];
	self.section = _section;
	
	arrayPages = nil;
	
	return self;
}

#pragma mark -
#pragma mark View lifecycle
- (void)initPages{
	DataAccess* da = [[DataAccess alloc] init];
	NSString* _section_id = (NSString*)[section objectForKey:@"id"];
	arrayPages = [[NSMutableArray alloc] initWithArray:[da getPagesForSection:_section_id]];
	[da release];
}

- (void)viewDidLoad {
	NSLog(@"ListTableViewController.viewDidLoad");
    [super viewDidLoad];
	
	[self initPages];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return arrayPages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return TABLEVIEW_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.backgroundColor = ((ApplicationCell *)cell).useDarkBackground ? DARK_BACKGROUND : LIGHT_BACKGROUND;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSDictionary *page = (NSDictionary *)[arrayPages objectAtIndex:indexPath.row];
	NSString *CellIdentifier = @"ImageCell";
	ApplicationCell *cell = (ApplicationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		NSLog(@"ListTableViewController.cellForRowAtIndexPath creating ImageCell cell...");
		cell = [[[UITableViewImageApplicationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	else{
		NSLog(@"ListTableViewController.cellForRowAtIndexPath dequeue for %@", CellIdentifier);
	}
	
	UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT, PADDING_TOP, TABLEVIEW_CELL_THUMB_BACKGROUND_WIDTH, TABLEVIEW_CELL_THUMB_BACKGROUND_HEIGHT)];
	bgView.backgroundColor = [UIColor whiteColor];
	
	DataAccess* da = [[DataAccess alloc] init];
	NSString* page_id = [page objectForKey:@"id"];
	UIImage* image = [da getDefaultThumbImageForPage:page_id];
	NSLog(@"image (%f, %f)", image.size.width, image.size.height);
  
	UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
	imageView.frame = CGRectMake(PADDING_LEFT, PADDING_TOP, TABLEVIEW_CELL_IMAGEVIEW_WIDTH, TABLEVIEW_CELL_IMAGEVIEW_HEIGHT);
	imageView.contentMode = UIViewContentModeScaleToFill;
	imageView.alpha = 0;
	[bgView addSubview:imageView];
	
	/*
	[UIView beginAnimations:@"fadePhotoThumb" context:NULL];
	[UIView setAnimationDuration:0.75];
	imageView.alpha = 1;
	[UIView commitAnimations];
	*/
	
	cell.photoUIView = bgView;
	[bgView release];
    [da release];
	[imageView release];
	
	// Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
	cell.useDarkBackground = (indexPath.row % 2 == 0);
	
	cell.title = [page objectForKey:@"title"];
	cell.subtitle = [page objectForKey:@"content"];
	
	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[section release];
	[arrayPages release];
    [super dealloc];
}


@end

