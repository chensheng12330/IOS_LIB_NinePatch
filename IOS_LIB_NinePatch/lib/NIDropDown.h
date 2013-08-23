//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：<#使用系统#>
//文件名称：<#文件名称#>
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：<#创建日期#>
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v0.0.2
//版本说明：/*<#版本说明#>*/
//功能说明：NIDropDown的变种
//---------------------------------------------------------

#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate<NSObject>
- (void) NIDropDown: (NIDropDown *) dropDownView DidSelectIndexRow:(int) _indexRow SelectObject:(NSObject*) object;
- (void) didShowDropDown:(NIDropDown *) dropDownView;
@end 

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
    CGPoint DropViewBgPoint;
    CGSize  DropViewSize;
    UIImageView *upImageView;
    UIView* showInView;
    

    NSArray       *_arCategoryList;
    NIDropDown *cateDropDown;
    
    CGFloat  fViewWidth;
}

@property (assign) BOOL bHider;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) UIButton *btnSender;
@property (nonatomic, retain) NSArray  *list;
@property (nonatomic,retain) NSString * strSelectIndexString;

@property (nonatomic, assign) BOOL bIsChild;
@property (assign) id <NIDropDownDelegate> delegate;

//listString可包含层次关系 即[NSArray/NSArray]
-(id)initWithPoint:(CGPoint) fPoint
            inView:(UIView*) fView
     dropListWidth:(CGFloat) width
    dropListHegith:(CGFloat) height
        listString:(NSArray *)arr;

-(id)initWithPoint:(CGPoint) fPoint
            inView:(UIView*) fView
     dropListWidth:(CGFloat) width
     dropViewWidth:(CGFloat) vwidth
    dropListHegith:(CGFloat) height
        listString:(NSArray *)arr;

-(void)showDropDown;
-(void)hideDropDown;
@end
