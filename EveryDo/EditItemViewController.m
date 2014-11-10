//
//  AddItemViewController.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import "EditItemViewController.h"
#import "ToDoManagedObject.h" //to access the model


@interface EditItemViewController () <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    NSArray *arrayOfNames;
}

@end

@implementation EditItemViewController{
    NSArray* arrayOfFetchedUsers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    arrayOfNames = [self namesInDatabase];

    _titleTextField.delegate = self;
    _descripTextView.delegate = self;
    _priorityTextField.delegate = self;
    
    if (self.entry !=nil) {
        self.titleTextField.text = self.entry.title;
        self.descripTextView.text = self.entry.descrip;
        self.priorityTextField.text = self.entry.priorityNumber;
        
        CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
        NSError* err;
        NSFetchRequest* request   = [NSFetchRequest fetchRequestWithEntityName:@"UsersManagedObject"];
        NSArray* arrayOfFetchUsers = [coreDataStack.managedObjectContext executeFetchRequest:request error:&err];
        
        int userCounter = 0;
        for (UsersManagedObject *user in arrayOfFetchUsers) {
            if ([user isEqual:self.entry.user]) break;
            userCounter ++;
        }
        
        [self.pickerView selectRow:userCounter inComponent:0 animated:YES];
        
        if([self.entry.isCompleted boolValue])
        {
            self.isCompletedSegmentedControl.selectedSegmentIndex = 0;
            
        } else //if(self.entry.isCompleted == [NSNumber numberWithBool:NO])
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
        self.entry.isCompleted = [NSNumber numberWithBool:YES];
        
    } else if(self.isCompletedSegmentedControl.selectedSegmentIndex == 1)
    {
        self.entry.isCompleted = [NSNumber numberWithBool:NO];
    }
    
    NSString *selectedName = [arrayOfNames objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    
    NSError* err;
    NSFetchRequest* request   = [NSFetchRequest fetchRequestWithEntityName:@"UsersManagedObject"];
    arrayOfFetchedUsers = [coreDataStack.managedObjectContext executeFetchRequest:request error:&err];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", selectedName];
    NSArray *filteredArray = [arrayOfFetchedUsers filteredArrayUsingPredicate:predicate];
    UsersManagedObject *finalUser = [filteredArray objectAtIndex:0];
    
    self.entry.user = finalUser;
    
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
        entry.isCompleted = [NSNumber numberWithBool:YES];
        
    } else if(self.isCompletedSegmentedControl.selectedSegmentIndex == 1)
    {
        entry.isCompleted = [NSNumber numberWithBool:NO];
    }
    NSString *selectedName = [arrayOfNames objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    
    NSError* err;
    NSFetchRequest* request   = [NSFetchRequest fetchRequestWithEntityName:@"UsersManagedObject"];
    NSArray* arrayOfFetchedUsers = [coreDataStack.managedObjectContext executeFetchRequest:request error:&err];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", selectedName];
    NSArray *filteredArray = [arrayOfFetchedUsers filteredArrayUsingPredicate:predicate];
    UsersManagedObject *finalUser = [filteredArray objectAtIndex:0];
    
    entry.user = finalUser;

    [coreDataStack saveContext];
}

- (void)dismissSelf {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSFetchedResultsController

-(NSArray*)namesInDatabase {
    NSError* err;
    NSFetchRequest* request   = [NSFetchRequest fetchRequestWithEntityName:@"UsersManagedObject"];
    request.resultType        = NSDictionaryResultType;
    request.propertiesToFetch = [NSArray arrayWithObject:@"name"];
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSArray* arrayOfDictionaries = [coreDataStack.managedObjectContext executeFetchRequest:request error:&err];
    NSArray *names = [arrayOfDictionaries valueForKeyPath:@"@unionOfObjects.name"];
    return names;
}


#pragma mark - UIPickerViewDataSource

// number of "wheels" in the picker view
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// number of rows in a given "wheel"
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *arrayOfNames = [self namesInDatabase];
    return [arrayOfNames count];
}

#pragma mark - UIPickerViewDelegate

// display string for each row (model) in a given "wheel"
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {

    return [arrayOfNames objectAtIndex:row];
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
