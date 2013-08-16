//
//  ViewController.h
//  IOS_LIB_NinePatch
//
//  Created by sherwin.chen on 13-7-29.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUNinePatch.h"

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIImageView *myImageView;

@property (retain, nonatomic) IBOutlet UIImageView *up;
@property (retain, nonatomic) IBOutlet UIImageView *down;
@property (retain, nonatomic) IBOutlet UIImageView *left;
@property (retain, nonatomic) IBOutlet UIImageView *right;

@end
