//
//  ToDo.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
/* Create a Todo object which has the following properties:
title
description
priority number
is completed indicator */

#import <Foundation/Foundation.h>

@interface ToDo : NSObject <NSCoding>

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* descrip;
@property (nonatomic, retain) NSString* priorityNumber;
@property (nonatomic, assign) BOOL isCompleted;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSMutableDictionary *itemsDict;

- (instancetype)initWithTitle:(NSString*)title
               andDescription:(NSString*)descrip
               andPriorityNum:(NSString*)priorityNumber
               andIsCompleted:(BOOL)isCompleted;

@end
