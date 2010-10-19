//
//  GraphPaper.m
//  graphPaper
//
//  Created by James Randall on 13/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "GraphPaper.h"
#import "GraphPaperLocation.h"
#import "Shape.h"

@interface GraphPaper (private)
- (NSString*)nextAvailableTitle;
@end

@implementation GraphPaper (private)

- (NSString*)nextAvailableTitle
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *homeDirectory = [paths objectAtIndex:0];
    NSFileManager* fm = [NSFileManager defaultManager];
    NSError* error;
    NSArray* directoryContents = [fm contentsOfDirectoryAtPath:homeDirectory error:&error];
    
    int untitledNumber = 1;
    BOOL alreadyExists = YES;
    while(alreadyExists)
    {
        NSString* filename = [NSString stringWithFormat:@"%d.%@", untitledNumber, [GraphPaper extension]];
        alreadyExists = NO;
        for(NSString* existingFilename in directoryContents)
        {
            if ([filename isEqualToString:existingFilename])
            {
                alreadyExists = YES; 
                break;
            }
        }
        
        if (alreadyExists)
        {
            untitledNumber++;
		}
    }
    
    return [NSString stringWithFormat:@"%d", untitledNumber];
}

@end

@implementation GraphPaper

#pragma mark --- property synthesis

@synthesize shapes = _shapes;
@synthesize spacing = _spacing;
@synthesize title = _title;

#pragma mark --- setup and teardown

- (id)init
{
	self = [super init];
	if (self != nil)
	{
		self.shapes = [[[NSMutableArray alloc] init] autorelease];
		self.spacing = 32;
		self.title = [self nextAvailableTitle];
	}
	return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
	self = [super init];
	if (self != nil)
	{
		self.shapes = [coder decodeObjectForKey:@"shapes"];
		self.spacing = [coder decodeFloatForKey:@"spacing"];
		self.title = [coder decodeObjectForKey:@"title"];
		for(Shape* shape in self.shapes)
		{
			shape.graphPaper = self;
		}
	}
	return self;
}

-(void)encodeWithCoder:(NSCoder*)coder
{
	[coder encodeObject:self.shapes forKey:@"shapes"];
	[coder encodeFloat:self.spacing forKey:@"spacing"];
	[coder encodeObject:self.title forKey:@"title"];
}

- (void)dealloc
{
	self.shapes = nil;
	[super dealloc];
}

#pragma mark --- document methods

- (GraphPaperLocation*)normalisedLocation:(CGPoint)location
{
	div_t result = div((int)location.x, (int)self.spacing);
	int x = result.quot + (result.rem > self.spacing/2 ? 1 : 0);
	
	result = div((int)location.y, (int)self.spacing);
	int y = result.quot + (result.rem > self.spacing/2 ? 1 : 0);
	
	return [[[GraphPaperLocation alloc] initWithX:x y:y] autorelease];
}

- (CGPoint)viewLocation:(GraphPaperLocation*)location
{
	return CGPointMake(location.x * self.spacing, location.y * self.spacing);
}

- (CGRect)bounds
{
	CGRect bounds;
	BOOL first = YES;
	for(Shape* shape in self.shapes)
	{
		CGRect shapeBounds = shape.bounds;
		if (first)
		{
			bounds = shapeBounds;
			first = NO;
		}
		else
		{
			bounds = CGRectUnion(bounds, shapeBounds);
		}
	}
	return bounds;
}

- (NSString*)generateObjectiveCWithScale:(CGFloat)scale
{
	CGRect bounds = [self bounds];
	NSMutableString *objectiveC = [[[NSMutableString alloc] init] autorelease];
	[objectiveC appendString:@"CGContextRef context = UIGraphicsGetCurrentContext();\n"];
	for(Shape* shape in self.shapes)
	{
		[objectiveC appendString:[shape objectiveCWithScale:scale transform:CGPointMake(-bounds.origin.x, -bounds.origin.y)]];
	}
	return objectiveC;
}

// current impl. is lame and needs moving out to a template file
- (NSString*)generateHtmlWithScale:(CGFloat)scale
{
	CGRect bounds = [self bounds];
	CGFloat width = bounds.size.width * scale;
	CGFloat height = bounds.size.height * scale;
	NSMutableString *script = [[[NSMutableString alloc] init] autorelease];
	[script appendString:@"window.onload = function() {\n"];
	[script appendString:@"var drawingCanvas = document.getElementById('drawing');\n"];
	[script appendString:@"if(drawingCanvas && drawingCanvas.getContext) {\n"];
	[script appendString:@"var context = drawingCanvas.getContext('2d');\n"];
	for(Shape* shape in self.shapes)
	{
		[script appendString:[shape htmlWithScale:scale transform:CGPointMake(-bounds.origin.x, -bounds.origin.y)]];
	}
	[script appendString:@"}\n"];
	[script appendString:@"}\n"];
	
	[script appendString:@"function drawEllipse(context, x, y, w, h) {\n"];
	[script appendString:@"var kappa = .5522848,\n"];
	[script appendString:@"ox = (w / 2) * kappa,\n"];
	[script appendString:@"oy = (h / 2) * kappa,\n"];
	[script appendString:@"xe = x + w,\n"];
	[script appendString:@"ye = y + h,\n"];
	[script appendString:@"xm = x + w / 2,\n"];
	[script appendString:@"ym = y + h / 2;\n"];
	[script appendString:@"context.beginPath();\n"];
	[script appendString:@"context.moveTo(x, ym);\n"];
	[script appendString:@"context.bezierCurveTo(x, ym - oy, xm - ox, y, xm, y);\n"];
	[script appendString:@"context.bezierCurveTo(xm + ox, y, xe, ym - oy, xe, ym);\n"];
	[script appendString:@"context.bezierCurveTo(xe, ym + oy, xm + ox, ye, xm, ye);\n"];
	[script appendString:@"context.bezierCurveTo(xm - ox, ye, x, ym + oy, x, ym);\n"];
	[script appendString:@"context.closePath();\n"];
	[script appendString:@"context.stroke();\n"];
	[script appendString:@"}\n"];
	
	return [NSString stringWithFormat:@"<!DOCTYPE html>\n<html>\n<head>\n<script type=\"text/javascript\">\n%@</script>\n</head>\n<body>\n<canvas id=\"drawing\" width=\"%.0f\" height=\"%.0f\" />\n</body></html>",
			script, width, height];	
}

- (void)save
{
	NSString *filename = [self filename];
	NSMutableData* data = [[[NSMutableData alloc] init] autorelease];
	NSKeyedArchiver* archiver = [[[NSKeyedArchiver alloc] initForWritingWithMutableData:data] autorelease];
	[archiver encodeObject:self];
	[archiver finishEncoding];
	[data writeToFile:filename atomically:YES];
}

- (NSString*)filename
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *homeDirectory = [paths objectAtIndex:0];
	return [homeDirectory stringByAppendingPathComponent:[self.title stringByAppendingPathExtension:[GraphPaper extension]]];
}

+ (NSString*)extension
{
	return @"gpp";
}

@end
