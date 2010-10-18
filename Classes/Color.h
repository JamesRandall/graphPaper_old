//
//  Color.h
//  graphPaper
//
//  Created by James Randall on 14/10/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Color : NSObject {
	CGFloat _red;
	CGFloat _green;
	CGFloat _blue;
}

@property (assign) CGFloat red;
@property (assign) CGFloat green;
@property (assign) CGFloat blue;
@property (readonly) NSString* hexCode;

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
- (id)initWithCoder:(NSCoder*)coder;
- (void)encodeWithCoder:(NSCoder*)coder;

- (void)setStrokeInContext:(CGContextRef)context;
- (void)setFillInContext:(CGContextRef)context;

+ (Color*)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (Color*)blackColor;
+ (Color*)redColor;
+ (Color*)greenColor;
+ (Color*)blueColor;
+ (Color*)yellowColor;
+ (Color*)whiteColor;

@end
