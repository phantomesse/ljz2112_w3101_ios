//
//  AllNotesViewController.h
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AllNotesViewDelegate

- (void)loadNote:(NSString *)noteId;

@end


@interface AllNotesViewController : UITableViewController

@property (nonatomic) id<AllNotesViewDelegate> delegate;

@property (nonatomic) NSMutableArray *noteTitles;
@property (nonatomic) NSMutableArray *noteIds; // Matches the indices of noteTitles

@end
