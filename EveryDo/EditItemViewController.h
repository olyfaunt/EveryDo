//
//  AddItemViewController.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "ToDoManagedObject.h"
#import "UsersManagedObject.h"

@class EditItemViewController;
@class ToDoManagedObject;

//define a new delegate protocol that we can use to communicate from the Add Item screen to the Master View Controller screen when the user taps Cancel or Done
//@protocol AddItemViewControllerDelegate <NSObject>
//- (void)addItemViewControllerDidCancel:(EditItemViewController *)controller;
//- (void)addItemViewController:(EditItemViewController *)controller didAddItem:(ToDo *)item;
//@end

@interface EditItemViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) ToDoManagedObject *entry;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descripTextView;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *isCompletedSegmentedControl;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

- (IBAction) clickedBackground;

@end
