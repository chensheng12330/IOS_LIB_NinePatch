//
//  ViewController.h
//  IOS_LIB_NinePatch
//
//  Created by sherwin.chen on 13-7-29.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUNinePatch.h"
#import "NIDropDown.h"

@interface ViewController : UIViewController<NIDropDownDelegate>
{
    NIDropDown *cateDropDown;
    
    NSMutableArray       *_arFilePathList;
}

@property (nonatomic, retain) NSString *selectImageName;


@property (retain, nonatomic) IBOutlet UIImageView *myImageView;

@property (retain, nonatomic) IBOutlet UIImageView *up;
@property (retain, nonatomic) IBOutlet UIImageView *down;
@property (retain, nonatomic) IBOutlet UIImageView *left;
@property (retain, nonatomic) IBOutlet UIImageView *right;

@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property (retain, nonatomic) IBOutlet UISlider *slider;

@property (retain, nonatomic) IBOutlet UILabel *lbWidth;
@property (retain, nonatomic) IBOutlet UILabel *lbHeight;
@property (retain, nonatomic) IBOutlet UILabel *lbImageInfo;

- (IBAction)showFileList:(id)sender;

- (IBAction)valueChange:(UISegmentedControl *)sender;

- (IBAction)shuSlider:(UISlider*)sender;
- (IBAction)sliderValueChange:(UISlider *)sender;
@end
