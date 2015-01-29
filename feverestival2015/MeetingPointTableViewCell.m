//
//  MeetingPointTableViewCell.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "MeetingPointTableViewCell.h"

@interface MeetingPointTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlace;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPromotion;

@end

@implementation MeetingPointTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEventObj:(Event *)eventObj{

    _eventObj = eventObj;
    
    // Inverti a ordem pois tem lugares que nao vao haver shows
    self.lblName.text = eventObj.place;
    self.lblPlace.text = eventObj.name;
    self.lblDateTime.text = [NSString stringWithFormat:@"%@ - %@", [eventObj dateStr], [eventObj timeStr]];
    self.lblPromotion.text = eventObj.summary;

}

@end
