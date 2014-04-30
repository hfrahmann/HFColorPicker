//
//  HFColorPickerView.m
//  HFColorPickerDemo
//
//  Created by Hendrik Frahmann on 30.04.14.
//  Copyright (c) 2014 Hendrik Frahmann. All rights reserved.
//

#import "HFColorPickerView.h"
#import "HFColorButton.h"

@interface HFColorPickerView()

@property (nonatomic, strong) NSMutableArray* colorButtons;

- (void)setupColorButtons;
- (void)buttonClicked:(id)sender;
- (void)selectButton:(HFColorButton*)button;
- (void)calculateButtonFrames;

@end


@implementation HFColorPickerView

@synthesize colorButtons   = _colorButtons;
@synthesize colors         = _colors;
@synthesize buttonDiameter = _buttonDiameter;

- (void)setColors:(NSArray *)colors
{
    _colors = colors;
    [self setupColorButtons];
}

- (void)setButtonDiameter:(CGFloat)buttonDiameter
{
    _buttonDiameter = buttonDiameter;
    [self calculateButtonFrames];
}

- (CGFloat)buttonDiameter
{
    if(_buttonDiameter == 0.0)
        _buttonDiameter = 40.0;
    return _buttonDiameter;
}

- (NSMutableArray*)colorButtons
{
    if(_colorButtons == nil)
        _colorButtons = [NSMutableArray new];
    return _colorButtons;
}

- (void)setupColorButtons
{
    // remove all buttons
    for (HFColorButton* button in self.colorButtons)
    {
        [button removeFromSuperview];
    }
    [_colorButtons removeAllObjects];
    
    CGFloat buttonCount = 0;
    
    // create new buttons
    for (UIColor* color in _colors)
    {
        HFColorButton* button = [HFColorButton new];
        [button setColor:color];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setClipsToBounds:NO];
        
        if(buttonCount == 0)
            button.selected = YES;
        buttonCount++;
        
        [self addSubview:button];
        [_colorButtons addObject:button];
    }
    
    [self calculateButtonFrames];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self calculateButtonFrames];
}

- (void)calculateButtonFrames
{
    NSInteger buttonCount = self.colorButtons.count;
    
    CGFloat frameWidth = self.frame.size.width;
    
    CGFloat buttonWidth = self.buttonDiameter;
    CGFloat buttonSpace = 10.0f;
    
    CGFloat fullWidth = (buttonCount * (buttonWidth + buttonSpace)) + buttonSpace;
    
    NSInteger buttonsPerRow = floor( buttonCount / (fullWidth / frameWidth) );
    if(buttonsPerRow > buttonCount)
        buttonsPerRow = buttonCount;
    
    CGFloat rowWidth = (buttonsPerRow * (buttonWidth + buttonSpace)) + buttonSpace;
    buttonSpace += floor((frameWidth - (double)rowWidth) / buttonsPerRow);
    
    CGFloat x = ceil(buttonSpace / 2.0f);
    CGFloat y = 5.0f;
    
    NSInteger currentRow = 1;
    NSInteger currentPosition = 1;
    for (HFColorButton* button in self.colorButtons)
    {
        CGRect frame = CGRectMake(x, y, buttonWidth, buttonWidth);
        button.frame = frame;
        
        x += (buttonWidth + buttonSpace);
        
        currentPosition++;
        if(currentPosition > buttonsPerRow)
        {
            currentPosition = 1;
            currentRow++;
            x = ceil(buttonSpace / 2.0f);
            y += buttonWidth + buttonSpace;
        }
    }
}

- (void)buttonClicked:(id)sender
{
    NSInteger index = [_colorButtons indexOfObject:sender];
    if(index >= 0)
    {
        [self selectButton:sender];
        
        UIColor* color = [_colors objectAtIndex:index];
        if(_delegate != nil)
            [_delegate colorPicker:self selectedColor:color];
    }
}

- (void)selectButton:(HFColorButton *)button
{
    for (HFColorButton* button in self.colorButtons)
    {
        button.selected = NO;
    }
    button.selected = YES;
}

@end
