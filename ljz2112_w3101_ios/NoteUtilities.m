//
//  NoteUtilities.m
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import "NoteUtilities.h"

@implementation NoteUtilities

#pragma mark - File System
+ (NSString *)getDocumentsDirectoryPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)getNoteFilePath:(NSString *)noteId {
    NSString *documentsDirectoryPath = [self getDocumentsDirectoryPath];
    return [documentsDirectoryPath stringByAppendingPathComponent:noteId];
}

+ (void)logFileSystem {
    NSString *documentsDirectoryPath = [self getDocumentsDirectoryPath];
    NSURL *documentsURL = [NSURL URLWithString:documentsDirectoryPath];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *documentsDirectoryContents = [fileManager contentsOfDirectoryAtURL:documentsURL
                                               includingPropertiesForKeys:nil
                                                                  options:0
                                                                    error:&error]; 
    for (NSURL *url in documentsDirectoryContents) {
        NSLog(@"%@ is in the documents directory", url);
    }
}

#pragma mark - Misc
+ (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM dd, yyyy HH:mm a";
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatDateForTableView:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-yy HH:mm a";
    return [dateFormatter stringFromDate:date];
}

@end
