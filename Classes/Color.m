//
//  Color.m
//  graphPaper
//
//  Created by James Randall on 14/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "Color.h"


@implementation Color

@synthesize red = _red;
@synthesize green = _green;
@synthesize blue = _blue;

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
