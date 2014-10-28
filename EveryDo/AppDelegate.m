//
//  AppDelegate.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
// Instantiate several Todo objects, and fill out their values with some tasks of your choice. Put them all into an array.

#import "AppDelegate.h"
#import "DetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
    NSMutableArray *_itemsArray;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    _itemsArray = [NSMutableArray arrayWithCapacity:20];
    
//    ToDo *item = [[ToDo alloc] initWithTitle:@"Laundry"
//                              andDescription:@"Wash and dry linens."
//                              andPriorityNum:@"Priority: 1"
//                              andIsCompleted:NO];
//    [_itemsArray addObject:item];
//    
//    item = [[ToDo alloc] initWithTitle:@"Dishes"
//                        andDescription:@"Wash and dry dirty dishes. Wash and dry dirty dishes. Wash and dry dirty dishes. Wash and dry dirty dishes. Wash and dry dirty dishes. Wash and dry dirty dishes. Wash and dry dirty dishes. Wash and dry dirty dishes. Wash and dry dirty dishes."
//                        andPriorityNum:@"Priority: 2"
//                        andIsCompleted:YES];
//    [_itemsArray addObject:item];
//    
//    item = [[ToDo alloc] initWithTitle:@"Homework"
//                        andDescription:@"Review class notes and complete assignments. Review class notes and complete assignments. Review class notes and complete assignments. Review class notes and complete assignments. Review class notes and complete assignments. Review class notes and complete assignments."
//                        andPriorityNum:@"Priority: 3"
//                        andIsCompleted:NO];
//    [_itemsArray addObject:item];
//    
//    item = [[ToDo alloc] initWithTitle:@"Grocery Shopping"
//                        andDescription:@"Buy groceries from Safeway."
//                        andPriorityNum:@"Priority: 4"
//                        andIsCompleted:YES];
//    [_itemsArray addObject:item];
//
//    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
//    MasterViewController *masterViewController = [navigationController viewControllers][0];
//    masterViewController.vcItemsArray = _itemsArray;
    
//    DetailViewController *detailViewController = [masterViewController childViewControllers][0];
//    detailViewController.detailItemsArray = _itemsArray;
//    //

    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    
    

    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MasterViewController *masterViewController = [navigationController viewControllers][0];

    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if ([savedData objectForKey:@"items"] != nil) {
        _itemsArray = [[NSMutableArray alloc] initWithArray:[savedData objectForKey:@"items"]];
        
        //NSMutableArray *loadedItems = [ToDoDatabase loadToDoDocs];
        masterViewController.vcItemsArray = _itemsArray;
        
        }
        
    } else {
        _itemsArray = [[NSMutableArray alloc] init];
                masterViewController.vcItemsArray = _itemsArray;
    }
    return YES;
}

- (void) saveData {
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithCapacity:20];
    if (_itemsArray != nil) {
        [dataDict setObject:_itemsArray forKey:@"items"];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    
    [NSKeyedArchiver archiveRootObject:dataDict toFile:filePath];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self saveData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveData];
}

@end
