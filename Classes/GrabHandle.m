//
//  GrabHandle.m
//  graphPaper
//
//  Created by James Randall on 13/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "GrabHandle.h"
#import "EditorViewController.h"
#import "GraphPaperLocation.h"
#import "GraphPaper.h"
#import "GraphPaperView.h"

const CGFloat kGrabHandleSize = 16;

@implementation GrabHandle

@synthesize controller = _controller;
@synthesize graphPaperLocation = _graphPaperLocation;

- (id)initWithController:(EditorViewController*)controller graphPaperLocation:(GraphPaperLocation*)graphPaperLocation
{
	self = [super init];
	if (self != nil)
	{
		self.controller = controller;
		self.graphPaperLocation = graphPaperLocation;
		[self updatePosition];
		self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
	CGContextStrokeRect(context, self.bounds);
}


- (void)dealloc {
	self.controller = nil;
	self.graphPaperLocation = nil;
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] == 1)
	{
		//_oldLocation = [[touches anyObject] locationInView:self];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] == 1)
	{
		CGPoint newLocation = [[touches anyObject] locationInView:self.controller.graphPaperView];
		GraphPaperLocation* location = [self.controller.graphPaper normalisedLocation:newLocation];
		self.graphPaperLocation.x = location.x;
		self.graphPaperLocation.y = location.y;
		[self updatePosition];
		[self.controller.graphPaperView setNeedsDisplay];
	}
}

- (void)updatePosition
{
	CGPoint point = [self.controller.graphPaper viewLocation:self.graphPaperLocation];
	self.frame = CGRectMake(point.x - kGrabHandleSize/2, point.y - kGrabHandleSize/2, kGrabHandleSize, kGrabHandleSize);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	if (self.controller.isPlacingPoints)
		return NO;
	return [super hitTest:point withEvent:event];
}


@end
