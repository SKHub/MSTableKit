//
//  MSGroupedTableViewCell.h
//  Grouped Example
//
//  Created by Eric Horacek on 1/12/13.
//  Copyright (c) 2013 Monospace Ltd. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSGroupedCellBackgroundView.h"

@interface MSGroupedTableViewCell : MSTableViewCell

@property (nonatomic, strong) MSGroupedCellBackgroundView *groupedCellBackgroundView;

@end
