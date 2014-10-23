//
//  MasterViewController.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *item = self.vcItemsArray[indexPath.row];
        [[segue destinationViewController] setDetailItem:item];
    }
    
    //have to tell AddItemViewController that (the MasterViewController) is its delegate:
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        AddItemViewController *addItemViewController = [navigationController viewControllers][0];
        addItemViewController.delegate = self;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcItemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = (ItemCell*)[tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
//    cell.tag = indexPath.row; //////get the cell's index path #
    cell.delegate = self;
    
    ToDo *toDoItem = (self.vcItemsArray)[indexPath.row];

    NSDictionary* attributes = @{
                                 NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]
                                 };
    
    NSAttributedString* attrTitle = [[NSAttributedString alloc]
                                    initWithString:toDoItem.title attributes:attributes];
    NSAttributedString* attrDescrip = [[NSAttributedString alloc]
                                    initWithString:toDoItem.descrip attributes:attributes];
    NSAttributedString* attrPriority = [[NSAttributedString alloc]
                                    initWithString:toDoItem.priorityNumber attributes:attributes];

    
    if (toDoItem.isCompleted) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.titleLabel.attributedText = attrTitle;
        cell.descripLabel.attributedText = attrDescrip;
        cell.priorityLabel.attributedText = attrPriority;
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = toDoItem.title;
        cell.descripLabel.text = toDoItem.descrip;
        cell.priorityLabel.text = toDoItem.priorityNumber;
    }
    return cell;
}

//

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES; // you have to ensure the existing UIPanGestureRecognizer — which lets you swipe to show the delete button — is disabled. Otherwise that gesture recognizer will collide with the custom one you’re adding to your project.
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.vcItemsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
}


//implement the methods from the AddItemViewControllerDelegate

- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil]; //just go back to previous screen
}

- (void)addItemViewController:(AddItemViewController *)controller didAddItem:(ToDo *)item {
    [self.vcItemsArray addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.vcItemsArray count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil]; //then go back to previous screen
}

//implement the methods from the ItemCellDelegate

- (void)didSwipeItemCellToRight:(ItemCell*)item {
    
    //tableview indexpathforcell //never use in cellforrowindexpath b/c cyclical (nikita)
    
    //int indexNumber = (int)item.tag; <<< this doesn't work because index numbers change when delete item
    NSIndexPath *indexPath = [self.tableView indexPathForCell:item];
    int indexPathNo = (int)[indexPath row];
    ToDo *thisItem = (self.vcItemsArray)[(int)indexPathNo];
    thisItem.isCompleted = YES;
    [self.tableView reloadData];
}

- (void)didSwipeItemCellToLeft:(ItemCell*)item {
    //int indexNumber = (int)item.tag;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:item];
    int indexPathNo = (int)[indexPath row];
    ToDo *thisItem = (self.vcItemsArray)[(int)indexPathNo];
    thisItem.isCompleted = NO;
    [self.tableView reloadData];
}
@end
