//
//  GrabHandle.h
//  graphPaper
//
//  Created by James Randall on 13/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditorViewController;
@class GraphPaperLocation;

@interface GrabHandle : UIView {
	EditorViewController* _controller;
	GraphPaperLocation* _graphPaperLocation;
}

@property (retain) EditorViewController *controller;
@property (retain) GraphPaperLocation *graphPaperLocation;

- (id)initWithController:(EditorViewController*)controller graphPaperLocation:(GraphPaperLocation*)graphPaperLocation;
- (void)updatePosition;

@end
