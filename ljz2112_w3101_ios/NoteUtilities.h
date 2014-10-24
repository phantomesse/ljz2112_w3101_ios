//
//  NoteUtilities.h
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteUtilities : NSObject

+ (NSString *)getDocumentsDirectoryPath;
+ (NSString *)getNoteFilePath:(NSString *)noteId;
+ (BOOL)deleteNoteFromFileSystem:(NSString *)noteId;
+ (void)logFileSystem;

+ (NSString *)formatDate:(NSDate *)date;
+ (NSString *)formatDateForTableView:(NSDate *)date;

@end
