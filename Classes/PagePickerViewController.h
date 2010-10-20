//
//  PagePickerViewController.h
//  graphPaper
//
//  Created by James Randall on 19/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditorViewController;

@interface PagePickerViewController : UIViewController {
	UITableView *_tableView;
	NSMutableArray *_titles;
	EditorViewController *_editorViewController;
	
	UIToolbar *_toolbar;
	UIBarButtonItem *_done;
	UIBarButtonItem *_edit;
}

@property (retain) IBOutlet UITableView *tableView;
@property (copy) NSArray *titles;
@property (retain) EditorViewController *editorViewController;
@property (retain) IBOutlet UIBarButtonItem *done;
@property (retain) IBOutlet UIBarButtonItem *edit;
@property (retain) IBOutlet UIToolbar *toolbar;

- (IBAction)editTapped:(id)sender;
- (IBAction)doneTapped:(id)sender;

@end
