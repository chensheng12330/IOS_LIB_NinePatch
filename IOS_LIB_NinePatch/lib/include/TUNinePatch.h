//
//  TUNinePatch.h
//  NinePatch
//
//  Copyright 2009 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

/*
 工程引入如下库：
1、CoreFoundation
2、CoreGraphics
 
 工程设置如下参数：
 liner flag:  -all_load  -ObjC
*/

/**/

@protocol TUNinePatch;

@interface TUNinePatch : NSObject < NSCoding, NSCopying > {

}


/*!
 @method
 @abstract   nil
 @discussion 根据传据入点9图片，对其进行解析
 @param      ninePatchImage 点九图片数据
 @result     TUNinePatch 对象
 */
+(TUNinePatch*) ninePatchWithNinePatchImage:(UIImage *)ninePatchImage;

/*!
 @method     ninePatchWithImage:stretchableRegion:
 @abstract   nil
 @discussion ninePatchWithNinePatchImage 函数的扩张函数，可增加自定点九切割分界点
 @result     TUNinePatch 对象
 */
+(TUNinePatch*) ninePatchWithImage:(UIImage *)image stretchableRegion:(CGRect)stretchableRegion;


+(TUNinePatch*) ninePatchWithImage:(UIImage *)image stretchableRegion:(CGRect)stretchableRegion contentRegion:(CGRect)contentRegion tileCenterVertically:(BOOL)tileCenterVertically tileCenterHorizontally:(BOOL)tileCenterHorizontally;

/*!
 @method     ninePatchNamed
 @abstract   nil
 @discussion //根据9宫格模块，解析点9图片,将各角数据保存到内部对象中，可使用 imageOfSize 访问 拉伸图片，Diagnostic Utilities可访问边角图片
 @param      filename ：点9图片，例如文件名为test.9.png，只需传入 [test]即可
 @result     TUNinePatch 对象
 */
+(TUNinePatch*) ninePatchNamed:(NSString *)filename;


// Diagnostic Utilities
-(UIImage *)upperEdge;
-(UIImage *)lowerEdge;
-(UIImage *)leftEdge;
-(UIImage *)rightEdge;

//边角
-(UIImage *)upperLeftCorner;
-(UIImage *)lowerLeftCorner;
-(UIImage *)upperRightCorner;
-(UIImage *)lowerRightCorner;



// TUNinePatch Protocol Methods - Image Construction
-(UIImage *)imageOfSize:(CGSize)size;


// Customized Description
-(NSString *)description;
-(NSString *)descriptionPostfix;
@end