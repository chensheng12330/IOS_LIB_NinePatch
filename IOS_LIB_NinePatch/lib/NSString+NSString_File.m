//
//  NSString+NSString_File.m
//  SleepMusic
//
//  Created by sherwin on 13-5-13.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import "NSString+NSString_File.h"

@implementation NSString (NSString_File)

+(NSString*) getDocumentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString*) getCachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSProcessInfo*) getProcessInfo
{
    return [NSProcessInfo processInfo];
}

+(NSInteger) getFileSizeFromPath:(char *)path
{
    FILE * file;
    int fileSizeBytes = 0;
    file = fopen(path,"r");
    if(file>0){
        fseek(file, 0, SEEK_END);
        fileSizeBytes = ftell(file);
        fseek(file, 0, SEEK_SET);
        fclose(file);
    }
    return fileSizeBytes;
}

//tool
+(NSString*) getFileListPath
{
    return [NSString stringWithFormat:@"%@%@",[NSString getCachesPath],@"filelist"];
}

+(NSMutableArray*) searchAllFiles
{
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:[NSString getDocumentsPath] error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        NSArray *ar = [filename componentsSeparatedByString:@"."];
        if (ar.count>1) {
            if ([[ar objectAtIndex:1] isEqualToString:@"png"] || [[ar objectAtIndex:1] isEqualToString:@"PNG"] || [[ar objectAtIndex:1] isEqualToString:@"jpg"]) {
                [dataSource addObject:filename];
            }
        }
    }
    [dataSource writeToFile:[NSString getFileListPath] atomically:YES];
    
    return [dataSource autorelease];
}
@end
