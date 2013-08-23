//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//


#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"


@interface NIDropDown ()
-(void) didHideDropView;

@property (nonatomic,retain) UIView* showInView;
@end

@implementation NIDropDown
@synthesize showInView;

@synthesize list      = _list;
@synthesize table     = _table;
@synthesize btnSender = _btnSender;
@synthesize delegate  =_delegate;
@synthesize strSelectIndexString = _strSelectIndexString;
@synthesize bHider    = _bHider;

-(void)dealloc {

    [_table release];
    //[upImageView release];
    self.showInView = nil;
    [super dealloc];
}

-(id)initWithPoint:(CGPoint) fPoint
            inView:(UIView*) fView
    dropListWidth:(CGFloat) width
   dropListHegith:(CGFloat) height
       listString:(NSArray *)arr   //CategoryEntity
{
    self = [super init];
    if (self) {
        // Initialization code
        
        _bIsChild = NO;
        _strSelectIndexString = NULL; //no select
        
        DropViewSize.width  = width;
        DropViewSize.height = height;
        
        DropViewBgPoint = fPoint;
        
        self.showInView = fView;
        
        DropViewBgPoint.x -= (width/2);
        //DropViewBgPoint.y += fButton.frame.size.height/2;
        
        fViewWidth = width;
        
        self.frame = CGRectMake(DropViewBgPoint.x, DropViewBgPoint.y, width, 0);
        self.list = [NSArray arrayWithArray:arr];
        self.layer.masksToBounds = NO;
        //self.layer.cornerRadius = 8;
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity= 0.5;
        
        //upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 35, 0)];
        //[upImageView setImage:[UIImage imageNamed:@"NID_UP.png"]];
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
        _table.delegate   = self;
        _table.dataSource = self;
        //_table.layer.cornerRadius = 5;
        

        _table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        
        
        _table.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        _table.separatorColor  = [UIColor grayColor];
        _table.separatorStyle    = UITableViewCellSeparatorStyleNone;
        _bHider = YES;
    }
    
    return self;
}


-(id)initWithPoint:(CGPoint) fPoint
            inView:(UIView*) fView
     dropListWidth:(CGFloat) width
     dropViewWidth:(CGFloat) vwidth
    dropListHegith:(CGFloat) height
        listString:(NSArray *)arr
{
    self = [self initWithPoint:fPoint inView:fView dropListWidth:width dropListHegith:height listString:arr];
    CGRect fram = self.frame;
    fram.size.width = vwidth;
    
    fViewWidth = vwidth;
    [self setBackgroundColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1]];
    self.frame = fram;
    
    return self;
}

-(void)showDropDown
{
    @synchronized(self)
    {
        if (!_bHider) {
            return;
        }
        [self.table reloadData];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(didShowDrop)];
        
        self.frame          = CGRectMake(DropViewBgPoint.x, DropViewBgPoint.y, fViewWidth, DropViewSize.height);
        
        //upImageView.frame   = CGRectMake(30, 0, 35, 20);
        _table.frame        = CGRectMake(0, 0, DropViewSize.width, DropViewSize.height-0);
        
        [UIView commitAnimations];
        
        [self.showInView addSubview:self];
        //[self addSubview:upImageView];
        [self addSubview:_table];
        
        _bHider = NO;
    }
}

-(void) didShowDrop
{
    SEL sentAction = @selector(didShowDropDown:);
    if(self.delegate!=NULL && [_delegate retainCount]>0 && [self.delegate respondsToSelector:sentAction])
    {
        [self.delegate didShowDropDown:self];
    }
}

-(void) didHideDropView
{
    _bHider = YES;
    [self removeFromSuperview];
    return;
}

-(void)hideDropDown
{
    @synchronized(self)
    {
        if (_bHider) {
            return;
        }
        if (!cateDropDown.bHider) {
            [cateDropDown hideDropDown];
        }
        
        //NSLog(@"hideDropDown");
        [UIView beginAnimations:nil context:nil];
        
        if (_bIsChild) {
           [UIView setAnimationDuration:0.3];
        }
        else
        {
            [UIView setAnimationDuration:0.5];
        }
        
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(didHideDropView)];
        
        self.frame = CGRectMake(DropViewBgPoint.x,DropViewBgPoint.y, fViewWidth, 0);
        _table.frame = CGRectMake(0, 0, DropViewSize.width, 0);
        //upImageView.frame = CGRectMake(0, 0, DropViewSize.width, 0);
        [UIView commitAnimations];
        return;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}   


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    NSString *strTitle = nil;
    
    strTitle = [_list objectAtIndex:indexPath.row];
    
    cell.textLabel.text = strTitle;
    
    
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.textLabel.font      = [UIFont systemFontOfSize:14];
    
    UIColor *textColor = NULL;
    NSString *backGoundBG   = NULL;
    NSString *selBackGoundBG= NULL;
    
    textColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1];
    backGoundBG   =  @"bg_product_category_menu_list_1_normal.png";
    selBackGoundBG=  @"bg_product_category_menu_list_1_selected.png";
    
    cell.textLabel.textColor = textColor;//[UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1];
    UIImageView * ivBackGound = [[[UIImageView alloc] init] autorelease];
    [ivBackGound setFrame:cell.bounds];
    [ivBackGound setImage:[UIImage imageNamed:backGoundBG]];
    cell.backgroundView = ivBackGound;

    
    
    
    UIImageView * ivSelBackGound = [[[UIImageView alloc] init] autorelease];
    [ivSelBackGound setFrame:cell.bounds];
    
    UIImage *imageScal = [UIImage imageNamed:selBackGoundBG];
    imageScal  = [imageScal stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    [ivSelBackGound setImage:imageScal];
    cell.selectedBackgroundView = ivSelBackGound;
    
    
    if ([_strSelectIndexString isEqualToString:cell.textLabel.text]) {
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        //[cell setSelected:YES];
    }
    else
    {
        //[cell setSelected:NO];
        //cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.strSelectIndexString = cell.textLabel.text;

    SEL sentAction = @selector(NIDropDown:DidSelectIndexRow:SelectObject:);
    if(self.delegate!=NULL && [_delegate retainCount]>0 && [self.delegate respondsToSelector:sentAction])
    {
        [self.delegate NIDropDown:self DidSelectIndexRow:indexPath.row SelectObject:cell.textLabel.text];
    }
    
    [self hideDropDown];
    return;
}



@end
