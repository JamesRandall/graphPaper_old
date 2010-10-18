//
//  GraphPaperLocation.h
//  graphPaper
//
//  Created by James Randall on 13/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GraphPaperLocation : NSObject {
	int _x;
	int _y;
}

@property (assign) int x;
@property (assign) int y;

- (id)initWithX:(int)x y:(int)y;
- (id)initWithCoder:(NSCoder*)coder;
- (void)encodeWithCoder:(NSCoder*)coder;

+ (GraphPaperLocation*)locationWithX:(int)x y:(int)y;

@end
