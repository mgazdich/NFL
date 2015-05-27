//
//  TeamCell.m
//  NFL
//
//  Created by Mike_Gazdich_rMBP on 10/20/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import "TeamCell.h"

@implementation TeamCell

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