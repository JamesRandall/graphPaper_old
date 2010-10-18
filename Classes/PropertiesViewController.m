    //
//  PropertiesViewController.m
//  graphPaper
//
//  Created by James Randall on 17/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "PropertiesViewController.h"
#import "EditorViewController.h"

@interface PropertiesViewController (private)
- (void)setStrokeWidthLabelText;
@end

@implementation PropertiesViewController (private)
- (void)setStrokeWidthLabelText
{
	CGFloat value = self.slider.value;
	self.strokeWidthLabel.text = [NSString stringWithFormat:@"%.0fpx", floorf(value)];
}
@end



@implementation PropertiesViewController

#pragma mark --- property synthesis

@synthesize editorViewController = _editorViewController;
@synthesize colorPicker = _colorPicker;
@synthesize slider = _slider;
@synthesize strokeWidthLabel = _strokeWidthLabel;

#pragma mark --- setup and teardown

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil editorViewController:(EditorViewController*)editorViewController {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.editorViewController = editorViewController;
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.colorPicker.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.slider.value = self.editorViewController.strokeWidth;
	[self setStrokeWidthLabelText];
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
	self.colorPicker = nil;
	self.slider = nil;
	self.strokeWidthLabel = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark --- actions

- (IBAction)colorChanged:(id)sender
{
	self.editorViewController.strokeColor = self.colorPicker.selectedColor;
}

- (IBAction)strokeWidthChanged:(id)sender
{
	[self setStrokeWidthLabelText];
	self.editorViewController.strokeWidth = floorf(self.slider.value);
}

@end
