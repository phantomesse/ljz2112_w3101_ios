//
//  Note.m
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import "Note.h"

@implementation Note

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.noteId forKey:@"noteId"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.timestamp forKey:@"timestamp"];
    [coder encodeObject:self.body forKey:@"body"];
    [coder encodeObject:self.photo forKey:@"photo"];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [self init]) {
        self.noteId = [coder decodeObjectForKey:@"noteId"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.timestamp = [coder decodeObjectForKey:@"timestamp"];
        self.body = [coder decodeObjectForKey:@"body"];
        self.photo = [coder decodeObjectForKey:@"photo"];
    }
    return self;
}

@end
