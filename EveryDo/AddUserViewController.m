//
//  AddUserViewController.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-28.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import "AddUserViewController.h"
#import "UsersManagedObject.h" //to access the model


@interface AddUserViewController ()

@end

@implementation AddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nameTextField.delegate = self;
    
    if (self.user !=nil) {
        self.nameTextField.text = self.user.name;
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
    if (self.user !=nil) {
        [self updateUser];
    } else {
        [self insertUser];
    }
    [self dismissSelf];
}

- (IBAction) clickedBackground
{
    [self.view endEditing:YES]; //make the view end editing!
}

-(void) updateUser {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    self.user.name = self.nameTextField.text;
    [coreDataStack saveContext];
}

-(void)insertUser{
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    UsersManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"UsersManagedObject" inManagedObjectContext:coreDataStack.managedObjectContext];
    user.name = self.nameTextField.text;
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
