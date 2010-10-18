//
//  GraphPaperLocation.m
//  graphPaper
//
//  Created by James Randall on 13/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "GraphPaperLocation.h"


@implementation GraphPaperLocation

@synthesize x = _x;
@synthesize y = _y;

- (id)initWithX:(int)x y:(int)y
{
	self = [super init];
	if (self)
	{
		self.x = x;
		self.y = y;
	}
	return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
	self = [super init];
	if (self != nil)
	{
		self.x = [coder decodeIntForKey:@"x"];
		self.y = [coder decodeIntForKey:@"y"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
	[coder encodeInt:self.x forKey:@"x"];
	[coder encodeInt:self.y forKey:@"y"];
}

+ (GraphPaperLocation*)locationWithX:(int)x y:(int)y
{
	return [[[GraphPaperLocation alloc] initWithX:x y:y] autorelease];
}

@end
