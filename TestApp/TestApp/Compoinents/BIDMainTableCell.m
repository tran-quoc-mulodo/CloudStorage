//
//  BIDMainTableCell.m
//  TestApp
//
//  Created by Anh Quoc on 7/11/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import "BIDMainTableCell.h"

@implementation BIDMainTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
