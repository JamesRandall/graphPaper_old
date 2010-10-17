//
//  Polygon.m
//  graphPaper
//
//  Created by James Randall on 15/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "Polygon.h"
#import "GraphPaper.h"

@implementation Polygon

- (id)initWithGraphPaper:(GraphPaper*)graphPaper points:(NSArray*)points strokeColor:(Color*)strokeColor strokeWidth:(CGFloat)strokeWidth
{
	GraphPaperLocation* first = [points objectAtIndex:0];
	GraphPaperLocation* last = [points objectAtIndex:1];
	
	if (first.x == last.x && first.y == last.y)
	{
		NSMutableArray* closedPolygon = [NSMutableArray arrayWithArray:points];
		[closedPolygon removeLastObject];
		points = closedPolygon;
	}
	
	return [super initWithGraphPaper:graphPaper points:points strokeColor:strokeColor strokeWidth:strokeWidth];
}

- (void)pathInContext:(CGContextRef)context
{
	CGContextBeginPath(context);
	BOOL first = YES;
	for(GraphPaperLocation* location in self.points)
	{
		CGPoint pt = [self.graphPaper viewLocation:location];
		if (first)
		{
			CGContextMoveToPoint(context, pt.x, pt.y);
			first = NO;
		}
		else
		{
			CGContextAddLineToPoint(context, pt.x, pt.y);
		}
	}
	CGContextClosePath(context);
}

- (void)drawInContext:(CGContextRef)context
{
	[self.strokeColor setStrokeInContext:context];
	CGContextSetLineWidth(context, self.strokeWidth);
	[self pathInContext:context];
	CGContextStrokePath(context);
}

// Thanks to http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html#The%20C%20Code
// for the beautiful ray casting method description and implementation.
- (BOOL)containsViewPoint:(CGPoint)point
{
	BOOL result = NO;
	int numberOfVertices = self.points.count;
	for (int i=0, j = numberOfVertices-1; i < numberOfVertices; j = i++)
	{
		GraphPaperLocation* iLocation = [self.points objectAtIndex:i];
		GraphPaperLocation* jLocation = [self.points objectAtIndex:j];
		
		CGPoint iPoint = [self.graphPaper viewLocation:iLocation];
		CGPoint jPoint = [self.graphPaper viewLocation:jLocation];
		
		if (((iPoint.y > point.y) != (jPoint.y>point.y)) &&
			(point.x < (jPoint.x-iPoint.x) * (point.y-iPoint.y) / (jPoint.y-iPoint.y) + iPoint.x))
			result = !result;
	}
	return result;
}

- (NSString*)objectiveCWithScale:(CGFloat)scale transform:(CGPoint)transform
{
	NSMutableString *objectiveC = [[[NSMutableString alloc] initWithString:@"// Polygon\n"] autorelease];
	[objectiveC appendString:[NSString stringWithFormat:@"CGContextSetRGBStrokeColor(context, %f, %f, %f, 1.0);\n",
							  self.strokeColor.red, self.strokeColor.green, self.strokeColor.blue]];
	[objectiveC appendString:[NSString stringWithFormat:@"CGContextSetLineWidth(context, %.0f);\n", self.strokeWidth]];
	[objectiveC appendString:@"CGContextBeginPath(context);\n"];
	BOOL first = YES;
	for (GraphPaperLocation* location in self.points)
	{
		CGFloat x = (location.x + transform.x) * scale;
		CGFloat y = (location.y + transform.y) * scale;
		if (first)
		{
			[objectiveC appendString:[NSString stringWithFormat:@"CGContextMoveToPoint(context, %f, %f);\n", x, y]];
			first = NO;
		}
		else {
			[objectiveC appendString:[NSString stringWithFormat:@"CGContextAddLineToPoint(context, %f, %f);\n", x, y]];
		}
	}
	[objectiveC appendString:@"CGContextClosePath(context);\n"];
	[objectiveC appendString:@"CGContextStrokePath(context);\n"];
	return objectiveC;
}

- (NSString*)htmlWithScale:(CGFloat)scale transform:(CGPoint)transform
{
	NSMutableString* html = [[[NSMutableString alloc] init] autorelease];
	[html appendString:[NSString stringWithFormat:@"context.strokeStyle = \"#%@\";\n", self.strokeColor.hexCode]];
	[html appendString:[NSString stringWithFormat:@"context.lineWidth = %.0f\n", self.strokeWidth]];
	[html appendString:@"context.beginPath();\n"];
	
	BOOL first = YES;
	for (GraphPaperLocation* location in self.points)
	{
		CGFloat x = (location.x + transform.x) * scale;
		CGFloat y = (location.y + transform.y) * scale;
		if (first)
		{
			[html appendString:[NSString stringWithFormat:@"context.moveTo(%.0f, %.0f);\n", x, y]];
			first = NO;
		}
		else {
			[html appendString:[NSString stringWithFormat:@"context.lineTo(%.0f, %.0f);\n", x, y]];
		}
	}
	
	[html appendString:@"context.closePath();\n"];
	[html appendString:@"context.stroke();\n"];
	
	return html;
}


@end
