//
//  MyCalendar.h
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 27/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface MyCalendar : NSManagedObject

@property (nonatomic, retain) Event *myEvent;

@end
