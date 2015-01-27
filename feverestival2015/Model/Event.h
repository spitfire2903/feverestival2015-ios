//
//  Event.h
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 27/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSNumber * eventId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * sheet;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * vacancys;
@property (nonatomic, retain) NSString * target;
@property (nonatomic, retain) NSString * requirement;
@property (nonatomic, retain) NSNumber * eventType;
@property (nonatomic, retain) NSNumber * eventCategory;

@end
