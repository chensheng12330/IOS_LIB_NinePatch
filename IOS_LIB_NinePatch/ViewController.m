//
//  ViewController.m
//  IOS_LIB_NinePatch
//
//  Created by sherwin.chen on 13-7-29.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    TUNinePatch *tuninePath = [TUNinePatch ninePatchNamed:@"test1"];
    [self.myImageView setImage: [tuninePath imageOfSize:self.myImageView.frame.size]];
    
    [self.up setImage:[tuninePath upperLeftCorner]];
    [self.down setImage:[tuninePath lowerLeftCorner]];
    [self.left setImage:[tuninePath upperRightCorner]];
    [self.right setImage:[tuninePath lowerRightCorner]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myImageView release];
    [_up release];
    [_down release];
    [_left release];
    [_right release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUp:nil];
    [self setDown:nil];
    [self setLeft:nil];
    [self setRight:nil];
    [super viewDidUnload];
}
@end
