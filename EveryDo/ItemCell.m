//
//  ItemCell.m
//  EveryDo
//
//  Created by Audrey Jun on 2014-10-22.
//  Copyright (c) 2014 audreyjun. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //add pan gesture recognizer to cell:
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
    self.panRecognizer.delegate = self;
    [self.contentView addGestureRecognizer:self.panRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)panThisCell:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint velocity = [recognizer velocityInView:self.contentView];
    
    if (velocity.x >0){   // left to right ONLY
        switch (recognizer.state) {
            case UIGestureRecognizerStateBegan:
                break;
            case UIGestureRecognizerStateChanged:
                break;
            case UIGestureRecognizerStateEnded:
                NSLog(@"Pan Ended");
                [self.delegate didSwipeItemCellToRight:self]; // isCompleted==YES if swipe L to R
                break;
            case UIGestureRecognizerStateCancelled:
                break;
            default:
                break;
        }
    } else if (velocity.x <0) // right to left
    {    switch (recognizer.state) {
            case UIGestureRecognizerStateBegan:
                break;
            case UIGestureRecognizerStateChanged:
                break;
            case UIGestureRecognizerStateEnded:
                NSLog(@"Pan Ended");
                [self.delegate didSwipeItemCellToLeft:self]; // isCompleted==NO if swipe R to L            break;
            case UIGestureRecognizerStateCancelled:
                break;
            default:
                break;
        }
}
}


@end
