//
//  PropertiesViewController.h
//  graphPaper
//
//  Created by James Randall on 17/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPicker.h"

@class EditorViewController;

@interface PropertiesViewController : UIViewController <ColorPickerDelegate> {
	EditorViewController *_editorViewController;
	
	ColorPicker *_colorPicker;
	UISlider *_slider;
	UILabel *_strokeWidthLabel;
}

@property (retain) EditorViewController* editorViewController;
@property (retain) IBOutlet ColorPicker *colorPicker;
@property (retain) IBOutlet UISlider *slider;
@property (retain) IBOutlet UILabel *strokeWidthLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil editorViewController:(EditorViewController*)editorViewController;

- (IBAction)strokeWidthChanged:(id)sender;

@end
