    //
//  ExportViewController.m
//  graphPaper
//
//  Created by James Randall on 17/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "ExportViewController.h"
#import "EditorViewController.h"
#import "GraphPaper.h"

@implementation ExportViewController

@synthesize editorViewController = _editorViewController;
@synthesize width = _width;
@synthesize height = _height;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil editorViewController:(EditorViewController*)editorViewController {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.editorViewController = editorViewController;
    }
    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	CGRect bounds = self.editorViewController.graphPaper.bounds;
	self.width.text = [NSString stringWithFormat:@"%.0f", bounds.size.width];
	self.height.text = [NSString stringWithFormat:@"%.0f", bounds.size.height];
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
	self.editorViewController = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)exportAsHtml:(id)sender
{
	if ([MFMailComposeViewController canSendMail])
	{
		CGRect bounds = self.editorViewController.graphPaper.bounds;
		CGFloat scale = [self.width.text floatValue] / bounds.size.width;
		NSString* html = [self.editorViewController.graphPaper generateHtmlWithScale:scale];
		NSLog(@"HTML:\n%@", html);
		MFMailComposeViewController* controller = [[[MFMailComposeViewController alloc] init] autorelease];
		controller.mailComposeDelegate = self;
		[controller setMessageBody:html isHTML:NO];
		[controller setSubject:@"GraphPaper Objective-C Export"];
		[self presentModalViewController:controller animated:YES];
	}
	else {
		UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your iPad must be configured for email to export a diagram." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
	}
}

- (IBAction)exportAsObjectiveC:(id)sender
{
	if ([MFMailComposeViewController canSendMail])
	{
		CGRect bounds = self.editorViewController.graphPaper.bounds;
		CGFloat scale = [self.width.text floatValue] / bounds.size.width;
		NSString* objectiveC = [self.editorViewController.graphPaper generateObjectiveCWithScale:scale];
		NSLog(@"Objective-C:\n%@", objectiveC);
		MFMailComposeViewController* controller = [[[MFMailComposeViewController alloc] init] autorelease];
		controller.mailComposeDelegate = self;
		[controller setMessageBody:objectiveC isHTML:NO];
		[controller setSubject:@"GraphPaper Objective-C Export"];
		[self presentModalViewController:controller animated:YES];
	}
	else {
		UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your iPad must be configured for email to export a diagram." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
	}

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    [controller dismissModalViewControllerAnimated:YES];
}


- (IBAction)widthChanged:(id)sender
{
	CGRect bounds = self.editorViewController.graphPaper.bounds;
	CGFloat height = bounds.size.height / bounds.size.width * [self.width.text floatValue];
	self.height.text = [NSString stringWithFormat:@"%.0f", height];
}

- (IBAction)heightChanged:(id)sender
{
	CGRect bounds = self.editorViewController.graphPaper.bounds;
	CGFloat width = bounds.size.width / bounds.size.height * [self.height.text floatValue];
	self.width.text = [NSString stringWithFormat:@"%.0f", width];
}

@end
