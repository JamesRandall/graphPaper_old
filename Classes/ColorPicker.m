//
//  ColorPicker.m
//  graphPaper
//
//  Created by James Randall on 30/09/2010.
//  Copyright 2010 Accidental Fish. All rights reserved.
//

#import "ColorPicker.h"
#import "Color.h"

@implementation ColorPicker

@synthesize delegate = _delegate;
@synthesize colors = _colors;
@synthesize selectedColorIndex = _selectedColorIndex;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
    }
    return self;
}

- (void)awakeFromNib
{
	_selectedColorIndex = 0;
	self.colors = [NSArray arrayWithObjects:[Color blackColor],
				   [Color redColor],
				   [Color greenColor],
				   [Color blueColor],
				   [Color yellowColor],
				   [Color whiteColor],
				   nil];
	self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
	UITapGestureRecognizer* tapRecogniser = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)] autorelease];
	[self addGestureRecognizer:tapRecogniser];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGRect highlightRect;
	const CGFloat highlightWidth = 2;
    CGFloat cellWidth = self.bounds.size.width / self.colors.count;
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect cellRect = CGRectMake(0, 0, cellWidth, self.bounds.size.height);
	// Drawing code
    for (int slot = 0; slot < self.colors.count; slot++)
	{
		Color* color = [self.colors objectAtIndex:slot];
		[color setFillInContext:context];
		CGContextFillRect(context, cellRect);
		
		if (slot == _selectedColorIndex)
		{
			highlightRect = CGRectInset(cellRect, highlightWidth/2, highlightWidth/2);
		}
		
		cellRect.origin.x += cellWidth;
	}
	
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
	CGContextSetLineWidth(context, highlightWidth);
	CGContextStrokeRect(context, highlightRect);
}

- (void)dealloc {
    [super dealloc];
}

- (void)tapped:(UITapGestureRecognizer*)recognizer
{
	CGPoint pt = [recognizer locationInView:self];
	CGFloat cellWidth = self.bounds.size.width / self.colors.count;
	
	int slot = floorf(pt.x / cellWidth);
	self.selectedColorIndex = slot;
	[self setNeedsDisplay];
	
	if (self.delegate != nil)
	{
		[self.delegate colorChanged:self];
	}
}

- (Color*)selectedColor
{
	return [self.colors objectAtIndex:self.selectedColorIndex];
}

- (void)selectColor:(Color*)color
{
	int index = 0;
	for (Color* slotColor in self.colors)
	{
		if ([slotColor isEqual:color])
		{
			self.selectedColorIndex = index;
			break;
		}
		index++;
	}
}

@end
