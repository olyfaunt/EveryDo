//
//  UsersViewController.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-28.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsersManagedObject.h"

@interface UsersViewController : UITableViewController

//@property (nonatomic, strong) UsersManagedObject *user;
@property (nonatomic, strong) NSMutableArray *arrayOfUsers;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
