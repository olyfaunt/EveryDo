//
//  AddItemViewController.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {

    // Do any additional setup after loading the view.

    
    [super viewDidLoad];
    
    _titleTextField.delegate = self;
    _descripTextView.delegate = self;
    _priorityTextField.delegate = self;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"Default Title" forKey:@"title"];
    [defaults setObject:@"Default description" forKey:@"descrip"];
    [defaults setObject:@"Default Priority" forKey:@"priorityNumber"];
    [defaults setBool:NO forKey:@"isCompleted"];
    
    [defaults synchronize];
    
    NSLog(@"Data saved");
    
}

    - (BOOL)textFieldShouldReturn:(UITextField *)textField
    {
    [textField resignFirstResponder];
    return YES;
    }

    - (BOOL)textViewShouldReturn:(UITextView *)textView
    {
    [textView resignFirstResponder];
    return YES;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self.delegate addItemViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    ToDo *item = [[ToDo alloc] init];
    item.title = self.titleTextField.text;
    item.descrip = self.descripTextView.text;
    item.priorityNumber = self.priorityTextField.text;

    if(self.isCompletedSegmentedControl.selectedSegmentIndex == 0)
    {
        item.isCompleted = YES;
        
    } else if(self.isCompletedSegmentedControl.selectedSegmentIndex == 1)
    {
        item.isCompleted = NO;
    }
    
    [self.delegate addItemViewController:self didAddItem:item];
    

}

- (IBAction) clickedBackground
{
    [self.view endEditing:YES]; //make the view end editing!
}

- (IBAction)setOurDefaults:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *defaultTitle = [defaults stringForKey:@"title"];
    NSString *defaultDescrip = [defaults stringForKey:@"descrip"];
    NSString *defaultPriority = [defaults stringForKey:@"priorityNumber"];
    BOOL defaultIsCompleted = [defaults boolForKey:@"isCompleted"];
    NSNumber *ourInt;
    
    if (defaultIsCompleted == NO) {
        ourInt = [NSNumber numberWithInt:1];
    } else if (defaultIsCompleted == YES) {
        ourInt = [NSNumber numberWithInt:0];
    }
    
    // Update the UI elements with the saved data
    _titleTextField.text = defaultTitle;
    _descripTextView.text = defaultDescrip;
    _priorityTextField.text = defaultPriority;
    _isCompletedSegmentedControl.selectedSegmentIndex = [ourInt integerValue];
}

- (NSString *) pathForDataFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder = @"~/Library/Application Support/EveryDo/";
    folder = [folder stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder] == NO)
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:nil attributes:nil error:nil];
    }
    
    NSString *fileName = @"ToDo.";
    return [folder stringByAppendingPathComponent: fileName];
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
