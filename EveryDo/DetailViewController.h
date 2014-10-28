//
//  DetailViewController.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@interface DetailViewController : UIViewController {
    NSString *_docPath;
}

@property (strong, nonatomic) ToDo* detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (copy) NSString *docPath;
- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;

//@property (nonatomic, strong) NSMutableArray *detailItemsArray;

@end

