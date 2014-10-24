//
//  AllNotesViewController.m
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import "AllNotesViewController.h"
#import "NotesIndex.h"
#import "Note.h"

static NSString *const tableViewCellReuseIdentifier = @"kTableViewCellReuseIdentifier";

@interface AllNotesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AllNotesViewController

#pragma mark - View Controller Methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.noteTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellReuseIdentifier];
    }
    
    NSInteger row = [indexPath row];
    cell.textLabel.text = _noteTitles[row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *noteId = _noteIds[indexPath.item];
    [self.delegate loadNote:noteId];
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

@end
