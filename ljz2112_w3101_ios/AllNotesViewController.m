//
//  AllNotesViewController.m
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/24/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import "AllNotesViewController.h"
#import "Note.h"

static NSString *const kTableViewCellReuseIdentifier = @"kTableViewCellReuseIdentifier";

@interface AllNotesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *noteTitles;

@end

@implementation AllNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURL *documentsURL = [NSURL URLWithString:documentsDirectoryPath];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *documentsDirContents = [fileManager contentsOfDirectoryAtURL:documentsURL
                                               includingPropertiesForKeys:nil
                                                                  options:0
                                                                    error:&error];
    _noteTitles = [[NSMutableArray alloc] init];
    for (NSURL *url in documentsDirContents) {
        //NSLog(@"%@ is in the documents directory", url);
        
        
        NSData *data = [NSData dataWithContentsOfFile:url.path];
        Note *note  = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"Title: %@", note.title);
        [_noteTitles addObject:note.title];
    }
    
    NSLog(@"%lu", _noteTitles.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.noteTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kTableViewCellReuseIdentifier];
    }
    
    NSInteger row = [indexPath row];
    cell.textLabel.text = _noteTitles[row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Blahhhh omg");
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
