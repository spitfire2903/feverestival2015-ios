//
//  WorkshopTableViewCell.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "WorkshopTableViewCell.h"

@interface WorkshopTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlace;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@end


@implementation WorkshopTableViewCell

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
    self.lblPlace.text = eventObj.place;
    self.lblDateTime.text = eventObj.sheet;
}

@end
