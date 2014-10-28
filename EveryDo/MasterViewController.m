//
//  MasterViewController.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property NSMutableArray *objects;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.fetchedResultsController performFetch:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"EditSegue"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        UINavigationController *navigationController = segue.destinationViewController;
        EditItemViewController *editItemViewController = (EditItemViewController *)[navigationController topViewController];
        editItemViewController.entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    
    //have to tell AddItemViewController that (the MasterViewController) is its delegate:
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        EditItemViewController *editItemViewController = [navigationController viewControllers][0];
//        editItemViewController.delegate = self;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //each section in our table view is represented by a sectionInfo object that conforms to the <SectionInfo> protocol. We grab that specific sectionInfo object and return from it the number of objects in that section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
//    return self.vcItemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ItemCell";
    ItemCell *cell = (ItemCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    ToDoManagedObject *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.delegate = self;
    
    NSDictionary* attributes = @{
                                 NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]
                                 };
    
    NSAttributedString* attrTitle = [[NSAttributedString alloc]
                                     initWithString:entry.title attributes:attributes];
    NSAttributedString* attrDescrip = [[NSAttributedString alloc]
                                       initWithString:entry.descrip attributes:attributes];
    NSAttributedString* attrPriority = [[NSAttributedString alloc]
                                        initWithString:entry.priorityNumber attributes:attributes];
    
    
    if (entry.isCompleted) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.titleLabel.attributedText = attrTitle;
        cell.descripLabel.attributedText = attrDescrip;
        cell.priorityLabel.attributedText = attrPriority;
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = entry.title;
        cell.descripLabel.text = entry.descrip;
        cell.priorityLabel.text = entry.priorityNumber;
    }
    return cell;
}
    
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
    
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoManagedObject *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [[coreDataStack managedObjectContext] deleteObject:entry];
    [coreDataStack saveContext];
}

- (void)didSwipeItemCellToRight:(ItemCell*)item {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:item];
    ToDoManagedObject *thisItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
    thisItem.isCompleted = YES;
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
    [self.tableView reloadData];
}

- (void)didSwipeItemCellToLeft:(ItemCell*)item {

    NSIndexPath *indexPath = [self.tableView indexPathForCell:item];
    ToDoManagedObject *thisItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
    thisItem.isCompleted = NO;
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
    [self.tableView reloadData];
}

#pragma mark - Core Data Fetch

- (NSFetchRequest *)entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ToDoManagedObject"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    
    return fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

@end
