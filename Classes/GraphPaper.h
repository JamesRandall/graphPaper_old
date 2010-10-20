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
	NSString *_title;
}

@property (nonatomic, retain) NSMutableArray *shapes;
@property (retain) NSString* title;
@property (assign) CGFloat spacing;
@property (readonly) CGRect bounds;

- (id)initWithCoder:(NSCoder*)coder;
- (void)encodeWithCoder:(NSCoder*)coder;

- (GraphPaperLocation*)normalisedLocation:(CGPoint)location;
- (CGPoint)viewLocation:(GraphPaperLocation*)location;
- (NSString*)generateObjectiveCWithScale:(CGFloat)scale;
- (NSString*)generateHtmlWithScale:(CGFloat)scale;
- (NSString*)filename;
- (void)save;

+ (NSString*)extension;
+ (NSArray*)persistedPages;
+ (NSString*)filenameFromTitle:(NSString*)title;
+ (void)deleteWithTitle:(NSString*)title;

@end
