//
//  Event.h
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 27/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    EVENT_TYPE_EXHIBITION = 0,
    EVENT_TYPE_WORKSHOP,
    EVENT_TYPE_SPECIAL,
    EVENT_TYPE_STORYTELLING,
    EVENT_TYPE_MEETING_POINT
} EventType;

typedef enum {
    EVENT_CATEGORY_ADULT = 0,
    EVENT_CATEGORY_CHILDREN,
    EVENT_CATEGORY_STREET,
    EVENT_CATEGORY_UNICAMP,
    EVENT_CATEGORY_CLOWNFERENCE,
    EVENT_CATEGORY_URBAN_INVASION,
    EVENT_CATEGORY_POCKET_SHOW,
    EVENT_CATEGORY_TRUEQUE,
    EVENT_CATEGORY_CABARET,
    EVENT_CATEGORY_GENERAL
} EventCategory;

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

-(NSString*)dateStr;
-(NSString*)timeStr;

@end
