//
//  EventManager.h
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 27/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface EventManager : NSObject

+(BOOL)clearData;

+(NSArray*)meetingPoints;
+(BOOL)clearMeetingPoints;
+(BOOL)generateMeetingPoints;

+(NSArray*)workshops;
+(BOOL)clearWorkshops;
+(BOOL)generateWorkshops;

+(NSArray*)specials;
+(BOOL)clearSpecials;
+(BOOL)generateSpecials;

+(NSArray*)storytellings;
+(BOOL)clearStorytellings;
+(BOOL)generateStorytellings;

+(NSArray*)exhibitions;
+(BOOL)clearExhibition;
+(BOOL)generateExhibition;

+(BOOL)isEventFavorited:(Event*)event;
+(void)setEventFavorited:(Event*)event isFavorited:(BOOL)isFavorited;

+(NSArray*)myCalendarEvents;

+(void)fixEvents;

@end
