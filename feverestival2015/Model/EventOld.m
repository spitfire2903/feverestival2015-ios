//
//  Event.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 27/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "EventOld.h"


@implementation EventOld

@dynamic eventId;
@dynamic name;
@dynamic date;
@dynamic time;
@dynamic place;
@dynamic summary;
@dynamic sheet;
@dynamic duration;
@dynamic rating;
@dynamic vacancys;
@dynamic target;
@dynamic requirement;
@dynamic eventType;
@dynamic eventCategory;

-(NSString *)dateStr{
    NSDateFormatter* formatter = nil;
    
    formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    return [formatter stringFromDate:self.date];
}


-(NSString *)timeStr{
    NSDateFormatter* formatter = nil;
    
    formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"HH:mm"];
    
    return [formatter stringFromDate:self.time];
}

@end
