//
//  Note.h
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding>

@property (nonatomic) NSString *noteId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSDate *timestamp;
@property (nonatomic) NSString *body;

@end
