//
//  EditorViewController.h
//  graphPaper
//
//  Created by James Randall on 11/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphPaperView;
@class GraphPaper;
@class GraphPaperLocation;
@class Color;
@class Shape;
@class PropertiesViewController;
@class ExportViewController;
@class PagePickerViewController;

typedef enum
{
	emLayout = 0,
	emPolygon = 1,
	emEllipse = 2
} editModeEnum;

@interface EditorViewController : UIViewController {
	GraphPaper *_graphPaper;
	editModeEnum _editMode;
	BOOL _isPlacingPoints;
	NSMutableArray *_grabHandles;
	Color *_strokeColor;
	CGFloat _strokeWidth;
	Shape *_selectedShape;
	BOOL _isDraggingShape;
	GraphPaperLocation *_oldDragLocation;
	
	PropertiesViewController *_propertiesViewController;
	UIPopoverController *_propertiesPopoverController;
	ExportViewController *_exportViewController;
	UIPopoverController *_exportPopoverController;
	PagePickerViewController *_pagePickerViewController;
	UIPopoverController *_pagePickerPopoverController;
	
	UIToolbar *_toolbar;
	GraphPaperView* _graphPaperView;
	UIBarButtonItem *_newButton;
	UIBarButtonItem *_pages;
	UIBarButtonItem *_editmodeControlContainer;
	UISegmentedControl *_editmodeControl;
	UIBarButtonItem *_properties;
	UIBarButtonItem *_trash;
	UIBarButtonItem *_done;
	UIBarButtonItem *_cancel;
	UIBarButtonItem *_firstSeperator;
	UIBarButtonItem *_secondSeperator;
	UIBarButtonItem *_thirdSeperator;
	UIBarButtonItem *_finalSeperator;
	UIBarButtonItem *_export;
}

@property (retain) IBOutlet GraphPaperView* graphPaperView;
@property (retain) IBOutlet UIBarButtonItem *newButton;
@property (retain) IBOutlet UIBarButtonItem *pages;
@property (retain) IBOutlet UIBarButtonItem *export;
@property (retain) IBOutlet UIBarButtonItem *editmodeControlContainer;
@property (retain) IBOutlet UISegmentedControl *editmodeControl;
@property (retain) IBOutlet UIBarButtonItem *properties;
@property (retain) IBOutlet UIBarButtonItem *trash;
@property (retain) IBOutlet UIBarButtonItem *done;
@property (retain) IBOutlet UIBarButtonItem *cancel;
@property (retain) IBOutlet UIToolbar* toolbar;
@property (retain) IBOutlet UIBarButtonItem *firstSeperator;
@property (retain) IBOutlet UIBarButtonItem *secondSeperator;
@property (retain) IBOutlet UIBarButtonItem *thirdSeperator;
@property (retain) IBOutlet UIBarButtonItem *finalSeperator;
@property (assign) editModeEnum editMode;
@property (assign) BOOL isPlacingPoints;
@property (retain) GraphPaper *graphPaper;
@property (retain) NSMutableArray *grabHandles;
@property (retain) Color* strokeColor;
@property (assign) CGFloat strokeWidth;
@property (retain) Shape* selectedShape;
@property (assign) BOOL isDraggingShape;
@property (retain) GraphPaperLocation* oldDragLocation;
@property (retain) PropertiesViewController* propertiesViewController;
@property (retain) UIPopoverController* propertiesPopoverController;
@property (retain) ExportViewController *exportViewController;
@property (retain) UIPopoverController *exportPopoverController; 
@property (retain) PagePickerViewController *pagePickerViewController;
@property (retain) UIPopoverController *pagePickerPopoverController;

- (IBAction)editModeChanged:(id)sender;
- (IBAction)doneClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;
- (IBAction)propertiesClicked:(id)sender;
- (IBAction)exportClicked:(id)sender;
- (IBAction)trashClicked:(id)sender;
- (IBAction)pagesClicked:(id)sender;
- (IBAction)newClicked:(id)sender;

- (void)graphPaperClickedAt:(GraphPaperLocation*)location viewLocation:(CGPoint)viewLocation;
- (void)graphPaperDragAt:(GraphPaperLocation*)location viewLocation:(CGPoint)viewLocation;
- (void)graphPaperReleasedAt:(GraphPaperLocation*)location viewLocation:(CGPoint)viewLocation;
- (void)loadGraphFromTitle:(NSString*)title;
- (void)deleteGraphPaper:(NSString*)title;
- (void)newGraphPaper;

@end
