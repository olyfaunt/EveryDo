//
//  AddItemViewController.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@class AddItemViewController;

//define a new delegate protocol that we can use to communicate from the Add Item screen to the Master View Controller screen when the user taps Cancel or Done
@protocol AddItemViewControllerDelegate <NSObject>
- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller;
- (void)addItemViewController:(AddItemViewController *)controller didAddItem:(ToDo *)item;
@end

@interface AddItemViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) id <AddItemViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descripTextView;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *isCompletedSegmentedControl;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

- (IBAction) clickedBackground;

@end
