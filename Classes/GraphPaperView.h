//
//  GraphPaperView.h
//  graphPaper
//
//  Created by James Randall on 11/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat kGraphPaperSpacing;

@class EditorViewController;

@interface GraphPaperView : UIView {
	EditorViewController *_controller;
}

@property (retain) EditorViewController *controller;

@end
