//
//  StorytellingTableViewCell.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "StorytellingTableViewCell.h"

@interface StorytellingTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTimePlace;

@end

@implementation StorytellingTableViewCell

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
    self.lblDateTimePlace.text = [NSString stringWithFormat:@"(%@ %@) %@", [eventObj dateStr], [eventObj timeStr], eventObj.place];
}

@end
