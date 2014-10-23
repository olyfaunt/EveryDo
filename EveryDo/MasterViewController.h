//
//  MasterViewController.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCell.h"
#import "ToDo.h"
#import "DetailViewController.h"
#import "AddItemViewController.h" //this is the screen we will present when we click the + button

@interface MasterViewController : UITableViewController <AddItemViewControllerDelegate, ItemCellDelegate>

//made MasterViewController the delegate of both:
    //1) AddItemController (to communicate from the Add Item screen to the Master View Controller screen when the user taps Cancel or Done)
    //2) ItemCell (to communicate action (isCompleted to YES or NO) when swipe contentView of cell)

@property (nonatomic, strong) NSMutableArray *vcItemsArray;

@end

