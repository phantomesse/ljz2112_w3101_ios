//
//  NotesIndex.h
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface NotesIndex : NSObject

- (void)addNote:(Note *)note;
- (NSMutableArray *)getArrayForAllNotesTableView;
- (NSMutableArray *)getIdArrayForAllNotesTableView;

+ (NotesIndex *)retrieveNotesIndexFromFileSystem;

@end
