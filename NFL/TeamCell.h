//
//  TeamCell.h
//  NFL
//
//  Created by Mike_Gazdich_rMBP on 10/20/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *teamImageView;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *divisionLabel;
@property (strong, nonatomic) IBOutlet UILabel *stadiumLabel;


@end
