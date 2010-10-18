//
//  Color.m
//  graphPaper
//
//  Created by James Randall on 14/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "Color.h"


@implementation Color

#pragma mark --- property synthesis

@synthesize red = _red;
@synthesize green = _green;
@synthesize blue = _blue;

#pragma mark --- setup and teardown

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
	self = [super init];
	if (self != nil)
	{
		self.red = red;
		self.green = green;
		self.blue = blue;
	}
	return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
	self = [super init];
	if (self != nil)
	{
		self.red = [coder decodeFloatForKey:@"red"];
		self.green = [coder decodeFloatForKey:@"green"];
		self.blue = [coder decodeFloatForKey:@"blue"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
	[coder encodeFloat:self.red forKey:@"red"];
	[coder encodeFloat:self.green forKey:@"green"];
	[coder encodeFloat:self.blue forKey:@"blue"];
}

#pragma mark --- document methods

- (void)setStrokeInContext:(CGContextRef)context
{
	CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, 1.0);
}

- (void)setFillInContext:(CGContextRef)context
{
	CGContextSetRGBFillColor(context, self.red, self.green, self.blue, 1.0);
}

- (BOOL)isEqual:(id)object
{
	Color* otherColor = (Color*)object;
	return otherColor.red == self.red &&
		   otherColor.green == self.green &&
		   otherColor.blue == self.blue;
}

- (NSString*)hexCode
{
	return [NSString stringWithFormat:@"%02X%02X%02X", (int)(self.red * 255), (int)(self.green * 255), (int)(self.blue * 255)];
}

+ (Color*)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
	return [[[Color alloc] initWithRed:red green:green blue:blue] autorelease];
}


+ (Color*)blackColor
{
	return [Color colorWithRed:0.0 green:0.0 blue:0.0];
}

+ (Color*)redColor
{
	return [Color colorWithRed:1.0 green:0.0 blue:0.0];
}

+ (Color*)greenColor
{
	return [Color colorWithRed:0.0 green:1.0 blue:0.0];
}

+ (Color*)blueColor
{
	return [Color colorWithRed:0.0 green:0.0 blue:1.0];
}

+ (Color*)yellowColor
{
	return [Color colorWithRed:1.0 green:1.0 blue:0.0];
}

+ (Color*)whiteColor
{
	return [Color colorWithRed:1.0 green:1.0 blue:1.0];
}


@end
