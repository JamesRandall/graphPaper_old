//
//  ColorPicker.h
//  graphPaper
//
//  Created by James Randall on 30/09/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Color;

@protocol ColorPickerDelegate
- (IBAction)colorChanged:(id)sender;
@end

@interface ColorPicker : UIView {
	int _selectedColorIndex;
	NSArray* _colors;
	id<ColorPickerDelegate> _delegate;
}

@property (retain) NSArray* colors;
@property (retain) id<ColorPickerDelegate> delegate;
@property (assign) int selectedColorIndex;
@property (retain, readonly) Color* selectedColor;

- (void)selectColor:(Color*)color;

@end
