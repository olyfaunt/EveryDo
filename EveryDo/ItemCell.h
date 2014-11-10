//
//  ItemCell.h
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemCell;
@class ToDoManagedObject;

//set up delegate in MasterViewController so when swipe, change item's isCompleted to YES or NO
@protocol ItemCellDelegate <NSObject>
- (void)didSwipeItemCellToRight:(ItemCell*)item;
- (void)didSwipeItemCellToLeft:(ItemCell*)item;
@end

@interface ItemCell : UITableViewCell <UIGestureRecognizerDelegate>

//delegate property to log action when swipe this ItemCell
@property (nonatomic, weak) id <ItemCellDelegate> delegate;

@property (nonatomic, strong) NSString *itemText;

//properties to make swipeable cell
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;


//all other properties
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descripLabel;
@property (nonatomic, weak) IBOutlet UILabel *priorityLabel;

@end