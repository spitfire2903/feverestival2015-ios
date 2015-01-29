//
//  MyCalendarTableViewCell.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "MyCalendarTableViewCell.h"

@interface MyCalendarTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlace;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end

@implementation MyCalendarTableViewCell

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

    switch ([eventObj.eventType intValue]) {
        case EVENT_TYPE_WORKSHOP:
            self.lblDate.text = eventObj.sheet;
            self.lblPlace.text = eventObj.place;
            break;
        case EVENT_TYPE_SPECIAL:
            self.lblDate.text = [NSString stringWithFormat:@"%@ - %@", [eventObj dateStr], [eventObj timeStr]];
            self.lblPlace.text = eventObj.vacancys;
            break;
        case EVENT_TYPE_EXHIBITION:
            self.lblDate.text = [NSString stringWithFormat:@"%@ - %@ - %@", [eventObj dateStr], [eventObj timeStr], eventObj.place];
            self.lblPlace.text = eventObj.vacancys;
            break;

        default:
            self.lblDate.text = [NSString stringWithFormat:@"%@ - %@", [eventObj dateStr], [eventObj timeStr]];
            self.lblPlace.text = eventObj.place;
            break;
    }

}

@end
