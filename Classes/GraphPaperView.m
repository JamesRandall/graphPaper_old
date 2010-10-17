//
//  GraphPaperView.m
//  graphPaper
//
//  Created by James Randall on 11/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "GraphPaperView.h"
#import "EditorViewController.h"
#import "GraphPaper.h"
#import "GraphPaperLocation.h"
#import "GrabHandle.h"
#import "Color.h"
#import "Shape.h"

@implementation GraphPaperView

@synthesize controller = _controller;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGFloat spacing = self.controller.graphPaper.spacing;
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetRGBStrokeColor(context, 0.6, 0.6, 0.6, 1.0);
	CGContextSetLineWidth(context, 0.5);
	
	CGRect bounds = self.bounds;
	CGFloat minY = CGRectGetMinY(bounds);
	CGFloat maxY = CGRectGetMaxY(bounds);
	CGFloat minX = CGRectGetMinX(bounds);
	CGFloat maxX = CGRectGetMaxX(bounds);
	CGFloat x = spacing;
	while (x < bounds.size.width)
	{
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, x, minY);
		CGContextAddLineToPoint(context, x, maxY);
		CGContextStrokePath(context);
		x += spacing;
	}
	
	CGFloat y = spacing;
	while (y < bounds.size.height)
	{
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, minX, y);
		CGContextAddLineToPoint(context, maxX, y);
		CGContextStrokePath(context);
		y += spacing;
	}
	
	for(Shape* shape in self.controller.graphPaper.shapes)
	{
		[shape drawInContext:context];
	}
	
	if (self.controller.isPlacingPoints == YES && self.controller.editMode == emPolygon)
	{
		[self.controller.strokeColor setStrokeInContext:context];
		CGContextSetLineWidth(context, self.controller.strokeWidth);
		CGContextBeginPath(context);
		BOOL first = YES;
		for(GrabHandle* handle in self.controller.grabHandles)
		{
			CGPoint pt = [self.controller.graphPaper viewLocation:handle.graphPaperLocation];
			if (first)
			{
				CGContextMoveToPoint(context, pt.x, pt.y);
				first = NO;
			}
			else {
				CGContextAddLineToPoint(context, pt.x, pt.y);
			}
		}
		CGContextStrokePath(context);
	}
}


- (void)dealloc {
	self.controller = nil;
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] == 1)
	{
		UITouch* touch = [touches anyObject];
		CGPoint unmodifiedViewLocation = [touch locationInView:self];
		GraphPaperLocation* graphPaperLocation = [self.controller.graphPaper normalisedLocation:unmodifiedViewLocation];
		NSLog(@"Graph paper clicked at %.0f, %.0f", graphPaperLocation.x, graphPaperLocation.y);
		[self.controller graphPaperClickedAt:graphPaperLocation viewLocation:unmodifiedViewLocation];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] == 1)
	{
		UITouch* touch = [touches anyObject];
		CGPoint unmodifiedViewLocation = [touch locationInView:self];
		GraphPaperLocation* graphPaperLocation = [self.controller.graphPaper normalisedLocation:unmodifiedViewLocation];
		NSLog(@"Graph paper dragged at %.0f, %.0f", graphPaperLocation.x, graphPaperLocation.y);
		[self.controller graphPaperDragAt:graphPaperLocation viewLocation:unmodifiedViewLocation];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] == 1)
	{
		UITouch* touch = [touches anyObject];
		CGPoint unmodifiedViewLocation = [touch locationInView:self];
		GraphPaperLocation* graphPaperLocation = [self.controller.graphPaper normalisedLocation:unmodifiedViewLocation];
		NSLog(@"Graph paper dragged at %.0f, %.0f", graphPaperLocation.x, graphPaperLocation.y);
		[self.controller graphPaperReleasedAt:graphPaperLocation viewLocation:unmodifiedViewLocation];
	}
}

@end
