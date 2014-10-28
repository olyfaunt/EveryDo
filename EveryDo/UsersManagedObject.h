//
//  UsersManagedObject.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-28.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ToDoManagedObject;

@interface UsersManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *toDoList;
@end

@interface UsersManagedObject (CoreDataGeneratedAccessors)

- (void)addToDoListObject:(ToDoManagedObject *)value;
- (void)removeToDoListObject:(ToDoManagedObject *)value;
- (void)addToDoList:(NSSet *)values;
- (void)removeToDoList:(NSSet *)values;

@end
