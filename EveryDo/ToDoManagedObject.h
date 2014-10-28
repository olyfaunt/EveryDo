//
//  ToDoManagedObject.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-28.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UsersManagedObject;

@interface ToDoManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * descrip;
@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSString * priorityNumber;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) UsersManagedObject *user;

@end
