//
//  UsersManagedObject.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-28.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import "UsersManagedObject.h"
#import "ToDoManagedObject.h"


@implementation UsersManagedObject

@dynamic name;
@dynamic toDoList;

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}
@end
