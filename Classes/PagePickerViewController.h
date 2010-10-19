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
	NSArray *_titles;
	EditorViewController *_editorViewController;
}

@property (retain) IBOutlet UITableView *tableView;
@property (retain) NSArray *titles;
@property (retain) EditorViewController *editorViewController;

- (IBAction)editTapped:(id)sender;

@end
