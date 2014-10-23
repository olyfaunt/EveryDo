//
//  ToDo.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//
/*
 @property (nonatomic, retain) NSString* title;
 @property (nonatomic, retain) NSString* descrip;
 @property (nonatomic, retain) NSNumber* priorityNumber;
 @property (nonatomic, assign) BOOL isCompleted;

*/

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTitle:(NSString*)title
               andDescription:(NSString*)descrip
               andPriorityNum:(NSString*)priorityNumber
               andIsCompleted:(BOOL)isCompleted
{
    self = [super init];
    if (self) {
        self.title = title;
        self.descrip = descrip;
        self.priorityNumber = priorityNumber;
        self.isCompleted = isCompleted;
    }
    return self;
}

@end
