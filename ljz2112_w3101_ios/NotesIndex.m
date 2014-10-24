//
//  NotesIndex.m
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import "NotesIndex.h"
#import "NoteUtilities.h"

static NSString *const notesIndexFileName = @"notesIndex";

@interface NotesIndex ()

@property (nonatomic) NSMutableArray *noteIds;
@property (nonatomic) NSMutableArray *noteTitles;
@property (nonatomic) NSMutableArray *noteTimestamps;

@property (nonatomic) NSMutableDictionary *noteIdToIndexDictionary;

@end

@implementation NotesIndex

- (id)init {
    self = [super init];
    
    _noteIds = [[NSMutableArray alloc] init];
    _noteTitles = [[NSMutableArray alloc] init];
    _noteTimestamps = [[NSMutableArray alloc] init];
    _noteIdToIndexDictionary = [[NSMutableDictionary alloc] init];
    
    return self;
}

#pragma mark - Notes
- (void)addNote:(Note *)note {
    // Check if the id exists in the dictionary
    NSNumber *index = [_noteIdToIndexDictionary objectForKey:note.noteId];
    if (index == nil) {
        // Doesn't exist, so add it
        [_noteIds addObject:note.noteId];
        [_noteTitles addObject:note.title];
        [_noteTimestamps addObject:note.timestamp];
        [_noteIdToIndexDictionary setObject:[NSNumber numberWithInteger:(_noteIds.count - 1)] forKey:note.noteId];
    } else {
        // Does exist, so update existing entry
        _noteIds[index.integerValue] = note.noteId;
        _noteTitles[index.integerValue] = note.title;
        _noteTimestamps[index.integerValue] = note.timestamp;
    }
    
    [self updateNotesIndexInFileSystem];
}

- (void)removeNote:(NSString *)noteId {
    NSNumber *index = [_noteIdToIndexDictionary objectForKey:noteId];
    [_noteIds removeObjectAtIndex:index.integerValue];
    [_noteTitles removeObjectAtIndex:index.integerValue];
    [_noteTimestamps removeObjectAtIndex:index.integerValue];
    [_noteIdToIndexDictionary removeObjectForKey:noteId];
    
    // Shift all the indices in the dictionary
    [_noteIdToIndexDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *value, BOOL *stop) {
        if (value.intValue > index.intValue) {
            [_noteIdToIndexDictionary setObject:[NSNumber numberWithInteger:(value.intValue - 1)] forKey:key];
        }
    }];
    
    [self updateNotesIndexInFileSystem];
}

- (NSMutableArray *)getArrayForAllNotesTableView {
    NSMutableArray *tableViewArray = [[NSMutableArray alloc] init];
    
    [_noteTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger index, BOOL *stop) {
        if (index == _noteTitles.count) {
            *stop = YES;
        }
        
        tableViewArray[index] = [NSString stringWithFormat:@"%@ (%@)", title, [NoteUtilities formatDateForTableView:_noteTimestamps[index]]];
    }];
    
    return tableViewArray;
}

- (NSMutableArray *)getIdArrayForAllNotesTableView {
    return _noteIds;
}

#pragma mark - Encoding and Decoding
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.noteIds forKey:@"noteIds"];
    [coder encodeObject:self.noteTitles forKey:@"noteTitles"];
    [coder encodeObject:self.noteTimestamps forKey:@"noteTimestamps"];
    [coder encodeObject:self.noteIdToIndexDictionary forKey:@"noteIdToIndexDictionary"];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [self init]) {
        self.noteIds = [coder decodeObjectForKey:@"noteIds"];
        self.noteTitles = [coder decodeObjectForKey:@"noteTitles"];
        self.noteTimestamps = [coder decodeObjectForKey:@"noteTimestamps"];
        self.noteIdToIndexDictionary = [coder decodeObjectForKey:@"noteIdToIndexDictionary"];
    }
    return self;
}

#pragma mark - File System
- (void)updateNotesIndexInFileSystem {
    // Save NotesIndex in file system
    NSString *notesIndexFilePath = [NoteUtilities getNoteFilePath:notesIndexFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:notesIndexFilePath];
}

+ (NotesIndex *)retrieveNotesIndexFromFileSystem {
    // Get the file path of the notes index file
    NSString *notesIndexFilePath = [NoteUtilities getNoteFilePath:notesIndexFileName];
    
    // Check if the file exists
    BOOL notesIndexFileExist = [[NSFileManager defaultManager] fileExistsAtPath:notesIndexFilePath];
    
    // Return an empty NotesIndex if the file doesn't exist
    if (!notesIndexFileExist) {
        return [[NotesIndex alloc] init];
    }
    
    // Return the NotesIndex from the file system
    NSData *data = [NSData dataWithContentsOfFile:notesIndexFilePath];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
