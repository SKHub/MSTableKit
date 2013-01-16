//
//  MSGroupedTableViewCell.m
//  Grouped Example
//
//  Created by Eric Horacek on 1/12/13.
//  Copyright (c) 2013 Monospace Ltd. All rights reserved.
//

#import "MSGroupedTableViewCell.h"
#import "MSGroupedCellBackgroundView.h"

@interface MSGroupedTableViewCell ()

- (void)updateGroupedCellBackgroundViewType;

@end

@implementation MSGroupedTableViewCell

#pragma mark - UIView

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self updateGroupedCellBackgroundViewType];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - UITableViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self updateGroupedCellBackgroundViewType];
}

- (void)updateBackgroundState:(BOOL)darkened animated:(BOOL)animated
{
    [super updateBackgroundState:darkened animated:animated];
    
    [self configureViews];
    
    void(^updateBackgroundState)() = ^() {
        [self.groupedCellBackgroundView setNeedsDisplay];
    };
    if (animated) {
        [UIView animateWithDuration:0.3 animations:updateBackgroundState];
    } else {
        updateBackgroundState();
    }
}

#pragma mark - MSTableViewCell

- (void)initialize
{
    [super initialize];
    self.groupedCellBackgroundView = [[MSGroupedCellBackgroundView alloc] init];
    self.backgroundView = self.groupedCellBackgroundView;
    [self configureViews];
    
    self.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    self.textLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    self.detailTextLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    self.detailTextLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    self.accessoryTextLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    self.accessoryTextLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.5];
}

#pragma mark - MSGroupedTableViewCell

- (void)updateGroupedCellBackgroundViewType
{
    // Dispatch async because the indexPath is nil if we don't
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.superview isKindOfClass:UITableView.class]) {
            UITableView *enclosingTableView = (UITableView *)self.superview;
            NSIndexPath *indexPath = [enclosingTableView indexPathForCell:self];
            NSUInteger rowsForSection = [enclosingTableView numberOfRowsInSection:indexPath.section];
            if((indexPath.row == 0) && (indexPath.row == (rowsForSection - 1))) {
                self.groupedCellBackgroundView.type = MSGroupedCellBackgroundViewTypeSingle;
            } else if (indexPath.row == 0) {
                self.groupedCellBackgroundView.type = MSGroupedCellBackgroundViewTypeTop;
            } else if (indexPath.row != (rowsForSection - 1)) {
                self.groupedCellBackgroundView.type = MSGroupedCellBackgroundViewTypeMiddle;
            } else {
                self.groupedCellBackgroundView.type = MSGroupedCellBackgroundViewTypeBottom;
            }
        }
    });
}

@end