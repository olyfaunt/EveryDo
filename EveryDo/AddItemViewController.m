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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleTextField.delegate = self;
    _descripTextView.delegate = self;
    _priorityTextField.delegate = self;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
