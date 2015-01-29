//
//  SpecialsTableViewCell.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "SpecialsTableViewCell.h"

@interface SpecialsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@end

@implementation SpecialsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEventObj:(Event *)eventObj{
    
    _eventObj = eventObj;
    
    self.lblName.text = eventObj.name;
    // FIXME: pog
    self.lblCategory.text = eventObj.vacancys;
    self.lblDateTime.text = [NSString stringWithFormat:@"%@ - %@", [eventObj dateStr], [eventObj timeStr]];
}

@end
