//
//  AddItemViewController.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"

@class UsersViewController;
@class UsersManagedObject;

//define a new delegate protocol that we can use to communicate from the Add Item screen to the Master View Controller screen when the user taps Cancel or Done
//@protocol AddItemViewControllerDelegate <NSObject>
//- (void)addItemViewControllerDidCancel:(EditItemViewController *)controller;
//- (void)addItemViewController:(EditItemViewController *)controller didAddItem:(ToDo *)item;
//@end

@interface AddUserViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UsersManagedObject *user;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
