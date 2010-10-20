    //
//  PagePickerViewController.m
//  graphPaper
//
//  Created by James Randall on 19/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "PagePickerViewController.h"
#import "EditorViewController.h"
#import "GraphPaper.h"

@implementation PagePickerViewController

@synthesize tableView = _tableView;
@synthesize titles = _titles;
@synthesize editorViewController = _editorViewController;
@synthesize done = _done;
@synthesize edit = _edit;
@synthesize toolbar = _toolbar;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self.toolbar setItems:[NSArray arrayWithObject:self.edit] animated:NO];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.titles = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.titles == nil ? 0 : self.titles.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text = [NSString stringWithFormat:@"Page %@", [self.titles objectAtIndex:indexPath.row]];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{ 
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source
		NSString* currentTitle = [self.titles objectAtIndex:indexPath.row];
		if ([self.editorViewController.graphPaper.title isEqualToString:currentTitle])
		{
			NSString* toLoadTitle = nil;
			if (indexPath.row > 0)
			{
				toLoadTitle = [self.titles objectAtIndex:indexPath.row-1];
			}
			else if (indexPath.row < (self.titles.count - 1))
			{
				toLoadTitle = [self.titles objectAtIndex:indexPath.row+1];
			}
			
			if (toLoadTitle != nil)
			{
				[self.editorViewController loadGraphFromTitle:toLoadTitle];
			}
			else
			{
				[self.editorViewController newGraphPaper];
			}
		}
		[self.editorViewController deleteGraphPaper:[self.titles objectAtIndex:indexPath.row]];
		[_titles removeObjectAtIndex:indexPath.row];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}   
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}


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
    [self.editorViewController loadGraphFromTitle:[self.titles objectAtIndex:indexPath.row]];
}

#pragma mark --- property accessors

- (void)setTitles:(NSArray *)value
{
	@synchronized(self)
	{
		[_titles release];
		_titles = value == nil ? nil : [[NSMutableArray alloc] initWithArray:value];
	}
}

#pragma mark --- actions

- (IBAction)editTapped:(id)sender
{
	[self.toolbar setItems:[NSArray arrayWithObject:self.done] animated:YES];
	self.tableView.editing = YES;
}

- (IBAction)doneTapped:(id)sender
{
	[self.toolbar setItems:[NSArray arrayWithObject:self.edit] animated:YES];
	self.tableView.editing = NO;
}

@end
