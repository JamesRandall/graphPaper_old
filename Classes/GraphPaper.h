//
//  GraphPaper.h
//  graphPaper
//
//  Created by James Randall on 13/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GraphPaperLocation;

@interface GraphPaper : NSObject {
	NSMutableArray *_shapes;
	CGFloat _spacing;
}

@property (nonatomic, retain) NSMutableArray *shapes;
@property (assign) CGFloat spacing;
@property (readonly) CGRect bounds;

- (GraphPaperLocation*)normalisedLocation:(CGPoint)location;
- (CGPoint)viewLocation:(GraphPaperLocation*)location;
- (NSString*)generateObjectiveCWithScale:(CGFloat)scale;
- (NSString*)generateHtmlWithScale:(CGFloat)scale;

@end
