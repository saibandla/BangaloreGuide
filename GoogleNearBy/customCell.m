//
//  customCell.m
//  CustomTable
//
//  Created by Sesha Sai Bhargav Bandla on 12/30/14.
//  Copyright (c) 2014 Sesha Sai Bhargav Bandla. All rights reserved.
//

#import "customCell.h"

@implementation customCell

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
