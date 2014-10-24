//
//  ViewController.m
//  ljz2112_w3101_ios
//
//  Created by Lauren Zou on 10/7/14.
//  Copyright (c) 2014 Lauren Zou. All rights reserved.
//

#import "NoteViewController.h"
#import "AllNotesViewController.h"
#import "Note.h"
#import "NoteUtilities.h"

@interface NoteViewController () <UITextViewDelegate>

#pragma mark - View Controller Fields
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

#pragma mark - Note Fields
@property (strong, nonatomic) Note* note;
@property (strong, nonatomic) NSDate* noteTimestamp;

@end

@implementation NoteViewController

#pragma mark - View Controller Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Remove the weird spacing in the UITextView
    _bodyTextView.contentInset = UIEdgeInsetsMake(0, -4, 0, -4);
   
    // Connect the text view with self
    _bodyTextView.delegate = self;
    
    // Autofocus onto the UITextView
    [_bodyTextView becomeFirstResponder];
    
    // Set the current timestamp
    [self updateCurrentTimestamp];
    
    // Disable the Save button because there's nothing to save
    [_saveButton setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View Controller Listener
- (IBAction)saveButtonClicked:(UIBarButtonItem *)sender {
    // Set the current timestamp
    [self updateCurrentTimestamp];
    
    // TODO: Save the contents of the note
    
    // Disable the Save button because we just saved
    [_saveButton setEnabled:NO];
}

- (IBAction)titleTextFieldEditingChanged:(UITextField *)sender {
    [_saveButton setEnabled:YES];
}

- (void) textViewDidChange:(UITextView *)textView {
    [_saveButton setEnabled:YES];
}

#pragma mark - Note Methods
- (void)updateCurrentTimestamp {
    // Set the current timestamp as the note's timestamp
    _noteTimestamp = [NSDate date];
    
    // Set the timestamp for the UILabel
    _timestampLabel.text = [NoteUtilities formatDate:_noteTimestamp];
}

- (void)saveNote {
    // Create a new Note if there isn't already an existing Note object
    if (_note == nil) {
        _note = [Note alloc];
        _note.noteId = [[NSUUID UUID] UUIDString];
    }
    
    // Trim the whitespace in the title and give the note a title if it doesn't have one
    NSString *trimmedTitle = [_titleTextField.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if (trimmedTitle.length == 0) {
        _titleTextField.text = @"Untitled";
    } else {
        _titleTextField.text = trimmedTitle;
    }
    
    // Update the fields in the Note
    _note.title = _titleTextField.text;
    _note.timestamp = _noteTimestamp;
    _note.body = _bodyTextView.text;
    
    // Save the note to the file system
    NSString *noteFilePath = [NoteUtilities getNoteFilePath:_note.noteId];
    [NSKeyedArchiver archiveRootObject:_note toFile:noteFilePath];
}

- (void)loadNote:(NSString *)noteId {
    // Check if the current note is the note to load
    if (_note != nil && [_note.noteId isEqualToString:noteId]) {
        // Don't need to load anything because it's already loaded
        return;
    }
    
    // Find and load the note from the file system
    NSString *noteFilePath = [NoteUtilities getNoteFilePath:noteId];
    NSData *data = [NSData dataWithContentsOfFile:noteFilePath];
    _note = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // Fill in all the note fields
    _titleTextField.text = _note.title;
    _timestampLabel.text = [NoteUtilities formatDate:_note.timestamp];
    _bodyTextView.text = _note.body;
}

@end
