//
//  ViewController.m
//  IOS_LIB_NinePatch
//
//  Created by sherwin.chen on 13-7-29.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import "ViewController.h"
#import "NSString+NSString_File.h"
#import <math.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    TUNinePatch *tuninePath = [TUNinePatch ninePatchNamed:@"test1"];
//    [self.myImageView setImage: [tuninePath imageOfSize:self.myImageView.frame.size]];
//    
//    [self.up setImage:[tuninePath upperLeftCorner]];
//    [self.down setImage:[tuninePath lowerLeftCorner]];
//    [self.left setImage:[tuninePath upperRightCorner]];
//    [self.right setImage:[tuninePath lowerRightCorner]];
    
    self.slider.transform = CGAffineTransformRotate(self.slider.transform, M_PI/2.0);
    
    [self valueChange:self.segment];
    //self.slider.frame = CGRectMake(-20, 0, 30, 200);
    
    _arFilePathList = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_arFilePathList release];
    [_myImageView release];
    [_up release];
    [_down release];
    [_left release];
    [_right release];
    [_segment release];
    [_slider release];
    [_lbWidth release];
    [_lbHeight release];
    [_lbImageInfo release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUp:nil];
    [self setDown:nil];
    [self setLeft:nil];
    [self setRight:nil];
    [self setSegment:nil];
    [self setSlider:nil];
    [self setLbWidth:nil];
    [self setLbHeight:nil];
    [self setLbImageInfo:nil];
    [super viewDidUnload];
}

- (IBAction)showFileList:(id)sender {
    
    //查找doc所有文件
    [_arFilePathList removeAllObjects];
    
    [_arFilePathList addObjectsFromArray:[NSString searchAllFiles]];
    
    
    if (_arFilePathList.count==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"哦，文档目录中没有资源文件，请用Itunes连接IOS设备->应用程序 ->文件共享 -> 选择[拉伸测试]app -> 点击右测 [添加]进行图片文件的上传。" delegate:nil cancelButtonTitle:@"明白" otherButtonTitles:@"不玩了", nil];
        [alertView show];
        [alertView release];
        
        return;
    }
    
    
    CGPoint point = self.segment.center;
    point.y += self.segment.bounds.size.height/2;
    point.x += 20;
    
    if (cateDropDown==NULL) {
        cateDropDown = [[NIDropDown alloc] initWithPoint:point inView:self.view dropListWidth:300 dropListHegith:320 listString:_arFilePathList];
        //cateDropDown = [[NIDropDown alloc] initWithPoint:point inView:self.view dropListWidth:160 dropViewWidth:320  dropListHegith:290 listString:];
        cateDropDown.delegate  = self;
    }
    if (cateDropDown.bHider) {
        [cateDropDown showDropDown];
        [cateDropDown setList:_arFilePathList];
    }
    else
    {
        [cateDropDown hideDropDown];
    }
    
    return;
}

- (void) NIDropDown: (NIDropDown *) dropDownView DidSelectIndexRow:(int) _indexRow SelectObject:(NSString*) object
{
    self.selectImageName = object;
    
  
    [self valueChange:(UISegmentedControl*)@"100"];

}

- (IBAction)valueChange:(UISegmentedControl *)sender {
    //NSLog(@"%d",sender.selectedSegmentIndex);
    
    int index;
    
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        index = sender.selectedSegmentIndex;
    }
    else{
        index = [((NSString*) sender) integerValue];
    }
    
    NSString *strImageName = nil;
    if (index ==0) {
        strImageName = @"BurstAircraftBkgBig@2x";
    }
    else if(index ==1)
    {
        strImageName = @"BurstAircraftButtonBule@2x";
    }
    else if(index ==2)
    {
        strImageName = @"DeleteMessageBkg@2x";
    }
    else if(index ==3)
    {
        strImageName = @"ReceiverVoiceNodeBkgforward@2x";
    }
    else if(index ==4)
    {
        strImageName = @"RedBtn@2x";
    }
    else if(index ==5)
    {
        strImageName = @"RightBarButtonBkg@2x";
    }
    else if(index ==6)
    {
        strImageName = @"ReceiverVoiceNodeBkgforwardHL@2x";
    }

    
    UIImage *imgBG = nil;
    
    if (index<7) {
        imgBG = [UIImage imageNamed: strImageName];
        
    }
    else
    {
        NSString *path = [NSString getDocumentsPath];
        path = [path stringByAppendingPathComponent:self.selectImageName];
        
        imgBG = [[UIImage alloc] initWithContentsOfFile: path];
    }
    
    imgBG  =  [imgBG resizableImageWithCapInsets: UIEdgeInsetsMake(imgBG.size.height/2-1, imgBG.size.width/2-1, imgBG.size.height/2-1, imgBG.size.width/2-1)];
    [self.myImageView setImage:imgBG];
    
    [self.lbImageInfo setText:[NSString stringWithFormat:@"Name:%@... 宽: %.2f 高: %.2f",[strImageName substringToIndex:strImageName.length<15?strImageName.length:15],imgBG.size.width,  imgBG.size.height]];
    
    [self showImageSize];
}

-(void) showImageSize
{
    [self.lbWidth setText:[NSString stringWithFormat:@"W: %.2f",self.myImageView.frame.size.width]];
    [self.lbHeight setText:[NSString stringWithFormat:@"H: %.2f",self.myImageView.frame.size.height]];
    
    return;
}

//竖向
- (IBAction)shuSlider:(UISlider*)sender {
    CGRect rect = self.myImageView.frame;
    
    CGFloat y = 283.0*sender.value;
    rect.size.height = y;
    
    //rect.origin.y = 100;
    
    //[self.lbHeight setText:[NSString stringWithFormat:@"%.2f",self.myImageView.frame.size.height]];
    [self showImageSize];
    
    [self.myImageView setFrame:rect];
    NSLog(@"%f",y);
}


- (IBAction)sliderValueChange:(UISlider *)sender {
    
    CGRect rect = self.myImageView.frame;
    
    CGFloat x = 283.0*sender.value;
    rect.size.width = x;
    
    //rect.origin.y = 100;
    
    //[self.lbWidth setText:[NSString stringWithFormat:@"%.2f",self.myImageView.frame.size.width]];
    
    [self showImageSize];
    [self.myImageView setFrame:rect];
    
    
    
    NSLog(@"%f",x);
    //
    //self.v
}
@end
