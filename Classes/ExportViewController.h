//
//  ExportViewController.h
//  graphPaper
//
//  Created by James Randall on 17/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class EditorViewController;

@interface ExportViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	EditorViewController *_editorViewController;
	
	UITextField *_width;
	UITextField *_height;
}

@property (retain) EditorViewController *editorViewController;
@property (retain) IBOutlet UITextField *width;
@property (retain) IBOutlet UITextField *height;

- (IBAction)exportAsHtml:(id)sender;
- (IBAction)exportAsObjectiveC:(id)sender;
- (IBAction)widthChanged:(id)sender;
- (IBAction)heightChanged:(id)sender;

@end
