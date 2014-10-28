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

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.descrip forKey:@"descrip"];
    [aCoder encodeObject:self.priorityNumber forKey:@"priorityNumber"];
    [aCoder encodeBool:self.isCompleted forKey:@"isCompleted"];
    [aCoder encodeObject:self.items forKey:@"items"];
    [aCoder encodeObject:self.itemsDict forKey:@"itemsDict"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (!self) return nil;
    NSString* title = [aDecoder decodeObjectForKey:@"title"];
    NSString* descrip = [aDecoder decodeObjectForKey:@"descrip"];
    NSString* priorityNumber = [aDecoder decodeObjectForKey:@"priorityNumber"];
    BOOL isCompleted = [aDecoder decodeBoolForKey:@"isCompleted"];
//
//    NSDictionary *itemsDict = [aDecoder decodeObjectForKey:@"items"];
//    self.itemsDict = [[NSMutableDictionary alloc] initWithDictionary:itemsDict copyItems:YES];
    
    return [self initWithTitle:title andDescription:descrip andPriorityNum:priorityNumber andIsCompleted:isCompleted];
}

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
