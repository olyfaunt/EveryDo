//
//  AddItemViewController.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import "EditItemViewController.h"
#import "ToDoManagedObject.h" //to access the model


@interface EditItemViewController ()

@end

@implementation EditItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titleTextField.delegate = self;
    _descripTextView.delegate = self;
    _priorityTextField.delegate = self;
    
    if (self.entry !=nil) {
        self.titleTextField.text = self.entry.title;
        self.descripTextView.text = self.entry.descrip;
        self.priorityTextField.text = self.entry.priorityNumber;
        if(self.entry.isCompleted == YES)
        {
            self.isCompletedSegmentedControl.selectedSegmentIndex = 0;
            
        } else if(self.entry.isCompleted == NO)
        {
            self.isCompletedSegmentedControl.selectedSegmentIndex = 1;
        }

    }
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
    [self dismissSelf];
}
- (IBAction)done:(id)sender
{
    if (self.entry !=nil) {
        [self updateEntry];
    } else {
        [self insertToDoItem];
    }
    [self dismissSelf];
}

- (IBAction) clickedBackground
{
    [self.view endEditing:YES]; //make the view end editing!
}

-(void) updateEntry {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    self.entry.title = self.titleTextField.text;
    self.entry.descrip = self.descripTextView.text;
    self.entry.priorityNumber = self.priorityTextField.text;
    if(self.isCompletedSegmentedControl.selectedSegmentIndex == 0)
    {
        self.entry.isCompleted = YES;
        
    } else if(self.isCompletedSegmentedControl.selectedSegmentIndex == 1)
    {
        self.entry.isCompleted = NO;
    }
    
    [coreDataStack saveContext];
}

-(void)insertToDoItem{
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    ToDoManagedObject *entry = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoManagedObject" inManagedObjectContext:coreDataStack.managedObjectContext];
    entry.title = self.titleTextField.text;
    entry.descrip = self.descripTextView.text;
    entry.priorityNumber = self.priorityTextField.text;
    if(self.isCompletedSegmentedControl.selectedSegmentIndex == 0)
    {
        entry.isCompleted = YES;
        
    } else if(self.isCompletedSegmentedControl.selectedSegmentIndex == 1)
    {
        entry.isCompleted = NO;
    }
    [coreDataStack saveContext];
}

- (void)dismissSelf {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
