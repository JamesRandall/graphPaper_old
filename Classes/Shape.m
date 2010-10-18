//
//  Shape.m
//  graphPaper
//
//  Created by James Randall on 13/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "Shape.h"
#import "GraphPaper.h"

@implementation Shape

#pragma mark --- property synthesis

@synthesize points = _points;
@synthesize graphPaper = _graphPaper;
@synthesize strokeColor = _strokeColor;
@synthesize strokeWidth = _strokeWidth;

#pragma mark --- setup and teardown

- (id)initWithGraphPaper:(GraphPaper*)graphPaper points:(NSArray*)points strokeColor:(Color*)strokeColor strokeWidth:(CGFloat)strokeWidth
{
	self = [super init];
	if (self != nil)
	{
		self.graphPaper = graphPaper;
		self.points = [NSMutableArray arrayWithArray:points];
		self.strokeColor = strokeColor;
		self.strokeWidth = strokeWidth;
	}
	return self;
}

- (void)dealloc
{
	[self.points removeAllObjects];
	self.strokeColor = nil;
	self.graphPaper = nil;
	self.points = nil;
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)coder
{
	self = [super init];
	if (self != nil)
	{
		self.graphPaper = nil;
		self.points = [coder decodeObjectForKey:@"points"];
		self.strokeColor = [coder decodeObjectForKey:@"strokeColor"];
		self.strokeWidth = [coder decodeFloatForKey:@"strokeWidth"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
	[coder encodeObject:self.points forKey:@"points"];
	[coder encodeObject:self.strokeColor forKey:@"strokeColor"];
	[coder encodeFloat:self.strokeWidth forKey:@"strokeWidth"];
}

#pragma mark --- document methods

- (void)drawInContext:(CGContextRef)context
{
	[self.strokeColor setStrokeInContext:context];
	CGContextSetLineWidth(context, self.strokeWidth);
	[self pathInContext:context];
	CGContextStrokePath(context);
}

- (void)pathInContext:(CGContextRef)context
{
	
}

- (BOOL)containsViewPoint:(CGPoint)point
{
	return NO;
}

- (void)transformWithX:(int)x y:(int)y
{
	for(GraphPaperLocation* location in self.points)
	{
		location.x += x;
		location.y += y;
	}
}

- (CGRect)bounds
{
	int left=32768, top=32768, right=-32768, bottom=-32768;
	for (GraphPaperLocation* location in self.points)
	{
		if (location.x < left)
			left = location.x;
		if (location.x > right)
			right = location.x;
		if (location.y < top)
			top = location.y;
		if (location.y > bottom)
			bottom = location.y;
	}
	return CGRectMake(left, top, right-left, bottom-top);
}

- (NSString*)objectiveCWithScale:(CGFloat)scale transform:(CGPoint)transform
{
	return @"";
}

- (NSString*)htmlWithScale:(CGFloat)scale transform:(CGPoint)transform
{
	return @"";
}

@end
