//
//  DemoTableViewController.m
//  HFColorPickerDemo
//
//  Created by Hendrik Frahmann on 30.04.14.
//  Copyright (c) 2014 Hendrik Frahmann. All rights reserved.
//

#import "DemoTableViewController.h"

@interface DemoTableViewController()

- (NSString*)hexCodeFromColor:(UIColor*)color;

@end

@implementation DemoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _colorPickerView.colors = @[
                                [UIColor redColor],
                                [UIColor blueColor],
                                [UIColor greenColor],
                                [UIColor yellowColor],
                                [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                                [UIColor purpleColor],
                                [UIColor orangeColor],
                                [UIColor brownColor],
                                [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0],
                                [UIColor colorWithRed:0.8 green:0.4 blue:0.5 alpha:1.0],
                                [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
                                [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0]
                                ];
}


#pragma mark - HFColorPickerViewControllerDelegate

- (void)colorPicker:(HFColorPickerView *)colorPickerView selectedColor:(UIColor *)selectedColor
{
    _labelColor.textColor = selectedColor;
    _labelColor.text = [self hexCodeFromColor:selectedColor];
}


#pragma mark - Private

- (NSString*)hexCodeFromColor:(UIColor *)color
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)(red * 255.0f), (int)(green * 255.0f), (int)(blue * 255.0f)];
}

@end
