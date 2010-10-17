//
//  Ellipse.m
//  graphPaper
//
//  Created by James Randall on 17/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "Ellipse.h"
#import "GraphPaper.h"

@implementation Ellipse

- (CGRect)boundingRectangle
{
	GraphPaperLocation* originLocation = [self.points objectAtIndex:0];
	GraphPaperLocation* destLocation = [self.points objectAtIndex:1];
	CGPoint origin = [self.graphPaper viewLocation:originLocation];
	CGPoint dest = [self.graphPaper viewLocation:destLocation];
	
	CGFloat ox = origin.x < dest.x ? origin.x : dest.x;
	CGFloat oy = origin.y < dest.y ? origin.y : dest.y;
	CGFloat dx = origin.x < dest.x ? dest.x : origin.x;
	CGFloat dy = origin.y < dest.y ? dest.y : origin.y;
	
	return CGRectMake(ox, oy, dx - ox, dy - oy);
}

- (void)pathInContext:(CGContextRef)context
{
	CGRect boundingRectangle = [self boundingRectangle];
	CGContextBeginPath(context);	
	CGContextAddEllipseInRect(context, boundingRectangle);
}

// Thanks to http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html#The%20C%20Code
// for the beautiful ray casting method description and implementation.
- (BOOL)containsViewPoint:(CGPoint)point
{
	CGRect boundingRectangle = [self boundingRectangle];
	return CGRectContainsPoint(boundingRectangle, point);
}

- (NSString*)objectiveCWithScale:(CGFloat)scale transform:(CGPoint)transform
{
	NSMutableString *objectiveC = [[[NSMutableString alloc] initWithString:@"// Polygon\n"] autorelease];
	[objectiveC appendString:[NSString stringWithFormat:@"CGContextSetRGBStrokeColor(context, %f, %f, %f, 1.0);\n",
							  self.strokeColor.red, self.strokeColor.green, self.strokeColor.blue]];
	[objectiveC appendString:[NSString stringWithFormat:@"CGContextSetLineWidth(context, %.0f);\n", self.strokeWidth]];

	GraphPaperLocation* first = [self.points objectAtIndex:0];
	GraphPaperLocation* last = [self.points objectAtIndex:1];
	CGFloat left = (first.x + transform.x) * scale;
	CGFloat top = (first.y + transform.y) * scale;
	CGFloat right = (last.x + transform.x) * scale;
	CGFloat bottom = (last.y + transform.y) * scale;
	
	[objectiveC appendString:[NSString stringWithFormat:@"CGContextStrokeEllipseInRect(context, CGRectMake(%.0f, %.0f, %.0f, %.0f));\n",
							  left, top, right - left, bottom - top]];

	return objectiveC;
}

- (NSString*)htmlWithScale:(CGFloat)scale transform:(CGPoint)transform
{
	NSMutableString* html = [[[NSMutableString alloc] init] autorelease];
	[html appendString:[NSString stringWithFormat:@"context.strokeStyle = \"#%@\";\n", self.strokeColor.hexCode]];
	[html appendString:[NSString stringWithFormat:@"context.lineWidth = %.0f\n", self.strokeWidth]];
	
	GraphPaperLocation* first = [self.points objectAtIndex:0];
	GraphPaperLocation* last = [self.points objectAtIndex:1];
	CGFloat left = (first.x + transform.x) * scale;
	CGFloat top = (first.y + transform.y) * scale;
	CGFloat right = (last.x + transform.x) * scale;
	CGFloat bottom = (last.y + transform.y) * scale;
	
	[html appendString:[NSString stringWithFormat:@"drawEllipse(context, %.0f, %.0f, %.0f, %.0f);\n", left, top, right - left, bottom - top]];
	
	return html;
}

@end
