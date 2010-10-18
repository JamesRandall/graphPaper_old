//
//  Shape.h
//  graphPaper
//
//  Created by James Randall on 13/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "Color.h"
#import "GraphPaperLocation.h"

@class GraphPaper;
@class Color;

@interface Shape : NSObject {
	GraphPaper *_graphPaper;
	NSMutableArray* _points;
	Color* _strokeColor;
	CGFloat _strokeWidth;
}

@property (retain) GraphPaper *graphPaper;
@property (retain) NSMutableArray *points;
@property (retain) Color* strokeColor;
@property (assign) CGFloat strokeWidth;
@property (readonly) CGRect bounds;

- (id)initWithGraphPaper:(GraphPaper*)graphPaper points:(NSArray*)points strokeColor:(Color*)strokeColor strokeWidth:(CGFloat)strokeWidth;
- (id)initWithCoder:(NSCoder*)coder;
- (void)encodeWithCoder:(NSCoder*)coder;

- (void)pathInContext:(CGContextRef)context;
- (void)drawInContext:(CGContextRef)context;
- (BOOL)containsViewPoint:(CGPoint)point;
- (void)transformWithX:(int)x y:(int)y;
- (NSString*)objectiveCWithScale:(CGFloat)scale transform:(CGPoint)transform;
- (NSString*)htmlWithScale:(CGFloat)scale transform:(CGPoint)transform;

@end
