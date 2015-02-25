//
//  EventManager.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 27/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "EventManager.h"
#import "AppDelegate.h"
#import "Event.h"
#import "MyCalendar.h"
#import <FormatterKit/TTTTimeIntervalFormatter.h>
#import "NSDate+FEIA.h"

@implementation EventManager


+(BOOL)clearData{
    BOOL result = YES;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSArray* events = nil;
    NSPredicate* predicate = nil;
    NSFetchRequest *request = nil;
    NSEntityDescription* entityDescription = nil;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    // Clear event data
    entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
    request = [[NSFetchRequest alloc] init];

    [request setEntity:entityDescription];

    events = [context executeFetchRequest:request error:&error];
    
    for (Event* event in events) {
        [context deleteObject:event];
    }
    
    [context save:&error];
    
    if (error) {
        result = NO;
    }
    
    // Clear calendar data
    entityDescription = [NSEntityDescription entityForName:CALENDAR_ENTITY inManagedObjectContext:context];
    request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    events = [context executeFetchRequest:request error:&error];
    
    for (MyCalendar* calendar in events) {
        [context deleteObject:calendar];
    }
    
    [context save:&error];
    
    if (error) {
        result = NO;
    }
    
    return result;
}

+(NSArray*)eventsByEventType:(EventType)eventType{
    NSArray* events = nil;
    NSPredicate* predicate = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSFetchRequest *request = nil;
    NSSortDescriptor* dateDescr = nil;
    NSSortDescriptor* timeDescr = nil;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
    request = [[NSFetchRequest alloc] init];
    
    predicate = [NSPredicate predicateWithFormat:@"eventType = %@", [NSNumber numberWithInt:eventType]];//@"%@ = %d", EVENT_ID_PROPERTY, [eventId intValue]];
    
    [request setEntity:entityDescription];
    [request setPredicate:predicate];
    
    events = [context executeFetchRequest:request error:&error];
    
    dateDescr = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    timeDescr = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    
    events = [events sortedArrayUsingDescriptors:@[dateDescr, timeDescr]];
    
    return ([events count] > 0 ? events : nil);
}

+(BOOL)clearDataByEventType:(EventType)eventType{
    BOOL result = YES;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    for (Event* event in [self eventsByEventType:eventType]) {
        [context deleteObject:event];
    }
    
    [context save:&error];
    
    if (error) {
        result = NO;
    }
    
    return result;
}

#pragma mark - Meeting points methods

+(BOOL)generateMeetingPoints{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    
    //if (![self meetingPoints]) {
    [self clearMeetingPoints];
    
        appDelegate = [[UIApplication sharedApplication] delegate];
        
        context = [appDelegate managedObjectContext];
        
        entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
        
        fileContents = [[NSBundle mainBundle] pathForResource:@"meetingPoints" ofType:@"json"];
        
        jsonEvents = [[NSMutableArray alloc] init];
        
        fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            result = NO;
        } else{
            data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
            
            jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error) {
                result = NO;
            } else{
                events = [jsonDict objectForKey:@"events"];
                
                formatter = [[NSDateFormatter alloc] init];
                
                for (NSObject* object in events) {
                    event = nil;
                    
                    event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                    
                    event.eventType = [NSNumber numberWithInt:EVENT_TYPE_MEETING_POINT];
                    
                    event.name = [object valueForKey:@"summary"];
                    
                    [formatter setDateFormat:@"dd/MM/yyyy"];
                    
                    event.date = [formatter dateFromString:[object valueForKey:@"date"]];

                    [formatter setDateFormat:@"HH:mm"];
                    
                    event.time = [formatter dateFromString:[object valueForKey:@"time"]];
                    event.place = [object valueForKey:@"place"];
                    event.summary = [object valueForKey:@"promotion"];
                    
                    [context save:&error];
                }
                
            }
        }
        
    //}
    
    return result;
}

+(NSArray*)meetingPoints{
    return [self eventsByEventType:EVENT_TYPE_MEETING_POINT];
}

+(BOOL)clearMeetingPoints{
    return [self clearDataByEventType:EVENT_TYPE_MEETING_POINT];
}

#pragma mark - Workshop methods

+(BOOL)generateWorkshops{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    
    if (![self workshops]) {
        appDelegate = [[UIApplication sharedApplication] delegate];
        
        context = [appDelegate managedObjectContext];
        
        entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
        
        fileContents = [[NSBundle mainBundle] pathForResource:@"workshops" ofType:@"json"];
        
        jsonEvents = [[NSMutableArray alloc] init];
        
        fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            result = NO;
        } else{
            data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
            
            jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error) {
                result = NO;
            } else{
                events = [jsonDict objectForKey:@"events"];
                
                formatter = [[NSDateFormatter alloc] init];
                
                for (NSObject* object in events) {
                    event = nil;
                    
                    event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                    
                    event.eventType = [NSNumber numberWithInt:EVENT_TYPE_WORKSHOP];
                    
                    event.name = [object valueForKey:@"name"];
                    event.summary = [NSString stringWithFormat:@"Ministrante: %@\n\n%@", [object valueForKey:@"owner"], [object valueForKey:@"summary"]];
                    event.sheet = [NSString stringWithFormat:@"%@ - %@", [object valueForKey:@"date"], [object valueForKey:@"time"]];

                    event.place = [object valueForKey:@"place"];
                    event.duration = [object valueForKey:@"duration"];
                    event.vacancys = [object valueForKey:@"vacancys"];
                    event.target = [object valueForKey:@"target"];
                    event.requirement = [object valueForKey:@"requirements"];
                    
                    [context save:&error];
                }
                
            }
        }
        
    }
    
    return result;
}

+(NSArray*)workshops{
    return [self eventsByEventType:EVENT_TYPE_WORKSHOP];
}

+(BOOL)clearWorkshops{
    return [self clearDataByEventType:EVENT_TYPE_WORKSHOP];
}

#pragma mark - Storytelling methods

+(BOOL)generateStorytellings{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    
    if (![self storytellings]) {
        appDelegate = [[UIApplication sharedApplication] delegate];
        
        context = [appDelegate managedObjectContext];
        
        entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
        
        fileContents = [[NSBundle mainBundle] pathForResource:@"storytelling" ofType:@"json"];
        
        jsonEvents = [[NSMutableArray alloc] init];
        
        fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            result = NO;
        } else{
            data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
            
            jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error) {
                result = NO;
            } else{
                events = [jsonDict objectForKey:@"events"];
                
                formatter = [[NSDateFormatter alloc] init];
                
                for (NSObject* object in events) {
                    event = nil;
                    
                    event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                    
                    event.eventType = [NSNumber numberWithInt:EVENT_TYPE_STORYTELLING];
                    
                    event.name = [object valueForKey:@"name"];
                    event.summary =  [object valueForKey:@"summary"];
                    event.sheet = [object valueForKey:@"sheet"];
                    
                    [formatter setDateFormat:@"dd/MM/yyyy"];
                    
                    event.date = [formatter dateFromString:[object valueForKey:@"date"]];
                    
                    [formatter setDateFormat:@"HH:mm"];
                    
                    event.time = [formatter dateFromString:[object valueForKey:@"time"]];
                    
                    event.place = [object valueForKey:@"place"];
                    event.duration = [object valueForKey:@"duration"];
                    
                    [context save:&error];
                }
                
            }
        }
        
    }
    
    return result;
}

+(NSArray*)storytellings{
    return [self eventsByEventType:EVENT_TYPE_STORYTELLING];
}

+(BOOL)clearStorytellings{
    return [self clearDataByEventType:EVENT_TYPE_STORYTELLING];
}

#pragma mark - Specials methods

+(BOOL)generateExhibition{
    return [self generateAdult];// && [self generateChildren] && [self generateStreet] && [self generateUnicamp];
}

+(BOOL)generateAdult{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    
    if (![self exhibitions]) {
        appDelegate = [[UIApplication sharedApplication] delegate];
        
        context = [appDelegate managedObjectContext];
        
        entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
        
        fileContents = [[NSBundle mainBundle] pathForResource:@"adultShow" ofType:@"json"];
        
        jsonEvents = [[NSMutableArray alloc] init];
        
        fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            result = NO;
        } else{
            data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
            
            jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error) {
                result = NO;
            } else{
                events = [jsonDict objectForKey:@"events"];
                
                formatter = [[NSDateFormatter alloc] init];
                
                for (NSObject* object in events) {
                    event = nil;
                    
                    event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                    
                    event.eventType = [NSNumber numberWithInt:EVENT_TYPE_EXHIBITION];
                    
                    event.name = [object valueForKey:@"name"];
                    
                    [formatter setDateFormat:@"dd/MM/yyyy"];
                    
                    event.date = [formatter dateFromString:[object valueForKey:@"date"]];
                    
                    [formatter setDateFormat:@"HH:mm"];
                    
                    if ([object valueForKey:@"time"] && ((NSString*)[object valueForKey:@"time"]).length > 0) {
                        event.time = [formatter dateFromString:[object valueForKey:@"time"]];
                    }
                    
                    event.place = [object valueForKey:@"place"];
                    event.summary = [object valueForKey:@"summary"];
                    event.sheet = [object valueForKey:@"sheet"];
                    
                    event.duration = [object valueForKey:@"duration"];
                    event.rating = [object valueForKey:@"rating"];
                    event.vacancys = @"Espetáculo Adulto";
                    
                    [context save:&error];
                }
                
            }
            
        }
        
        result = result && [self generateChildren];
        
    }
    
    return result;
}


+(BOOL)generateChildren{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    

    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
    
    fileContents = [[NSBundle mainBundle] pathForResource:@"childrenShow" ofType:@"json"];
    
    jsonEvents = [[NSMutableArray alloc] init];
    
    fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        result = NO;
    } else{
        data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
        
        jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            result = NO;
        } else{
            events = [jsonDict objectForKey:@"events"];
            
            formatter = [[NSDateFormatter alloc] init];
            
            for (NSObject* object in events) {
                event = nil;
                
                event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                
                event.eventType = [NSNumber numberWithInt:EVENT_TYPE_EXHIBITION];
                
                event.name = [object valueForKey:@"name"];
                
                [formatter setDateFormat:@"dd/MM/yyyy"];
                
                event.date = [formatter dateFromString:[object valueForKey:@"date"]];
                
                [formatter setDateFormat:@"HH:mm"];
                
                if ([object valueForKey:@"time"] && ((NSString*)[object valueForKey:@"time"]).length > 0) {
                    event.time = [formatter dateFromString:[object valueForKey:@"time"]];
                }
                
                event.place = [object valueForKey:@"place"];
                event.summary = [object valueForKey:@"summary"];
                event.sheet = [object valueForKey:@"sheet"];
                
                event.duration = [object valueForKey:@"duration"];
                event.rating = [object valueForKey:@"rating"];
                event.vacancys = @"Espetáculo Infantil";
                
                [context save:&error];
            }
            
        }
        
    }
    
    result = result && [self generateStreet];
    
    
    return result;
}


+(BOOL)generateStreet{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    

    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
    
    fileContents = [[NSBundle mainBundle] pathForResource:@"streetShow" ofType:@"json"];
    
    jsonEvents = [[NSMutableArray alloc] init];
    
    fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        result = NO;
    } else{
        data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
        
        jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            result = NO;
        } else{
            events = [jsonDict objectForKey:@"events"];
            
            formatter = [[NSDateFormatter alloc] init];
            
            for (NSObject* object in events) {
                event = nil;
                
                event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                
                event.eventType = [NSNumber numberWithInt:EVENT_TYPE_EXHIBITION];
                
                event.name = [object valueForKey:@"name"];
                
                [formatter setDateFormat:@"dd/MM/yyyy"];
                
                event.date = [formatter dateFromString:[object valueForKey:@"date"]];
                
                [formatter setDateFormat:@"HH:mm"];
                
                if ([object valueForKey:@"time"] && ((NSString*)[object valueForKey:@"time"]).length > 0) {
                    event.time = [formatter dateFromString:[object valueForKey:@"time"]];
                }
                
                event.place = [object valueForKey:@"place"];
                event.summary = [object valueForKey:@"summary"];
                event.sheet = [object valueForKey:@"sheet"];
                
                event.duration = [object valueForKey:@"duration"];
                event.rating = [object valueForKey:@"rating"];
                event.vacancys = @"Espetáculo de Rua";
                
                [context save:&error];
            }
            
        }
        
    }
    
    result = result && [self generateUnicamp];

    
    return result;
}


+(BOOL)generateUnicamp{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
    
    fileContents = [[NSBundle mainBundle] pathForResource:@"unicamp" ofType:@"json"];
    
    jsonEvents = [[NSMutableArray alloc] init];
    
    fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        result = NO;
    } else{
        data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
        
        jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            result = NO;
        } else{
            events = [jsonDict objectForKey:@"events"];
            
            formatter = [[NSDateFormatter alloc] init];
            
            for (NSObject* object in events) {
                event = nil;
                
                event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                
                event.eventType = [NSNumber numberWithInt:EVENT_TYPE_EXHIBITION];
                
                event.name = [object valueForKey:@"name"];
                
                [formatter setDateFormat:@"dd/MM/yyyy"];
                
                event.date = [formatter dateFromString:[object valueForKey:@"date"]];
                
                [formatter setDateFormat:@"HH:mm"];
                
                if ([object valueForKey:@"time"] && ((NSString*)[object valueForKey:@"time"]).length > 0) {
                    event.time = [formatter dateFromString:[object valueForKey:@"time"]];
                }
                
                event.place = [object valueForKey:@"place"];
                event.summary = [object valueForKey:@"summary"];
                event.sheet = [object valueForKey:@"sheet"];
                
                event.duration = [object valueForKey:@"duration"];
                event.rating = [object valueForKey:@"rating"];
                event.vacancys = @"Mostra UNICAMP";
                
                [context save:&error];
            }
            
        }

    }
    
    return result;
}

+(NSArray*)exhibitions{
    return [self eventsByEventType:EVENT_TYPE_EXHIBITION];
}

+(BOOL)clearExhibition{
    return [self clearDataByEventType:EVENT_TYPE_EXHIBITION];
}

#pragma mark - Specials methods

+(BOOL)generateSpecials{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    
    if (![self specials]) {
        appDelegate = [[UIApplication sharedApplication] delegate];
        
        context = [appDelegate managedObjectContext];
        
        entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
        
        fileContents = [[NSBundle mainBundle] pathForResource:@"specialShow" ofType:@"json"];
        
        jsonEvents = [[NSMutableArray alloc] init];
        
        fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            result = NO;
        } else{
            data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
            
            jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error) {
                result = NO;
            } else{
                events = [jsonDict objectForKey:@"events"];
                
                formatter = [[NSDateFormatter alloc] init];
                
                for (NSObject* object in events) {
                    event = nil;
                    
                    event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                    
                    event.eventType = [NSNumber numberWithInt:EVENT_TYPE_SPECIAL];
                    
                    event.name = [object valueForKey:@"name"];
                    
                    [formatter setDateFormat:@"dd/MM/yyyy"];
                    
                    event.date = [formatter dateFromString:[object valueForKey:@"date"]];
                    
                    [formatter setDateFormat:@"HH:mm"];
                    
                    if ([object valueForKey:@"time"] && ((NSString*)[object valueForKey:@"time"]).length > 0) {
                        event.time = [formatter dateFromString:[object valueForKey:@"time"]];
                    }

                    event.place = [object valueForKey:@"place"];
                    //event.summary = [object valueForKey:@"promotion"];
                    event.summary = [object valueForKey:@"summary"];
                    event.sheet = [object valueForKey:@"sheet"];

                    event.duration = [object valueForKey:@"duration"];
                    event.rating = [object valueForKey:@"rating"];
                    event.vacancys = [object valueForKey:@"category"];
                    
                    [context save:&error];
                }
                
            }
            
            result = result && [self generateSpecialsPocket];
        }
        
    }
    
    return result;
}

+(BOOL)generateSpecialsPocket{
    BOOL result = YES;
    NSArray* events = nil;
    NSMutableArray* jsonEvents = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    Event* event = nil;
    NSDateFormatter* formatter = nil;
    
    //if (![self specials]) {
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:EVENT_ENTITY inManagedObjectContext:context];
    
    fileContents = [[NSBundle mainBundle] pathForResource:@"pocketShow" ofType:@"json"];
    
    jsonEvents = [[NSMutableArray alloc] init];
    
    fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        result = NO;
    } else{
        data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
        
        jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            result = NO;
        } else{
            events = [jsonDict objectForKey:@"events"];
            
            formatter = [[NSDateFormatter alloc] init];
            
            for (NSObject* object in events) {
                event = nil;
                
                event = [[Event alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                
                event.eventType = [NSNumber numberWithInt:EVENT_TYPE_SPECIAL];
                
                event.name = [object valueForKey:@"name"];
                
                [formatter setDateFormat:@"dd/MM/yyyy"];
                
                event.date = [formatter dateFromString:[object valueForKey:@"date"]];
                
                [formatter setDateFormat:@"HH:mm"];
                
                event.time = [formatter dateFromString:[object valueForKey:@"time"]];
                
                event.place = [NSString stringWithFormat:@"%@ - %@", [object valueForKey:@"place"], [object valueForKey:@"address"]];
                event.summary = [NSString stringWithFormat:@"Ministrante: %@\n\n%@", [object valueForKey:@"owner"], [object valueForKey:@"summary"]];
                event.sheet = [object valueForKey:@"sheet"];
                
                event.duration = [object valueForKey:@"duration"];
                event.rating = [object valueForKey:@"rating"];
                event.vacancys = @"Mostra de Bolso";
                
                [context save:&error];
            }
            
        }
    }
    
    //}
    
    return result;
}


+(NSArray*)specials{
    return [self eventsByEventType:EVENT_TYPE_SPECIAL];
}

+(BOOL)clearSpecials{
    return [self clearDataByEventType:EVENT_TYPE_SPECIAL];
}

#pragma mark - My Calendar methods

+(BOOL)isEventFavorited:(Event*)event{
    BOOL result = NO;
    
    NSArray* events = nil;
    NSPredicate* predicate = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSFetchRequest *request = nil;
 
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:CALENDAR_ENTITY inManagedObjectContext:context];
    request = [[NSFetchRequest alloc] init];
    
    predicate = [NSPredicate predicateWithFormat:@"myEvent = %@", event];//@"%@ = %d", EVENT_ID_PROPERTY, [eventId intValue]];
    
    [request setEntity:entityDescription];
    [request setPredicate:predicate];
    
    events = [context executeFetchRequest:request error:&error];
    
    result = ([events count] > 0 ? YES : NO);
    
    return result;
}

+(void)setEventFavorited:(Event*)event isFavorited:(BOOL)isFavorited{
    NSArray* events = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    MyCalendar* calendar = nil;
    NSFetchRequest *request = nil;
    NSPredicate* predicate = nil;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:CALENDAR_ENTITY inManagedObjectContext:context];
    
    if (isFavorited) {
        calendar = [[MyCalendar alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
        
        calendar.myEvent = event;
        
        [context save:&error];

    } else{
        request = [[NSFetchRequest alloc] init];
        
        predicate = [NSPredicate predicateWithFormat:@"myEvent = %@", event];//@"%@ = %d", EVENT_ID_PROPERTY, [eventId intValue]];
        
        [request setEntity:entityDescription];
        [request setPredicate:predicate];
        
        events = [context executeFetchRequest:request error:&error];
        
        for (NSManagedObject* event in events) {
            [context deleteObject:event];
            
            [context save:&error];
        }
    }
        
}

+(NSArray*)myCalendarEvents{
    NSArray* events = nil;
    NSPredicate* predicate = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSFetchRequest *request = nil;
    NSSortDescriptor* dateDescr = nil;
    NSSortDescriptor* timeDescr = nil;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:CALENDAR_ENTITY inManagedObjectContext:context];
    request = [[NSFetchRequest alloc] init];
    
    //predicate = [NSPredicate predicateWithFormat:@"eventType = %@", [NSNumber numberWithInt:eventType]];//@"%@ = %d", EVENT_ID_PROPERTY, [eventId intValue]];
    
    [request setEntity:entityDescription];
    //[request setPredicate:predicate];
    
    events = [context executeFetchRequest:request error:&error];
    
    dateDescr = [[NSSortDescriptor alloc] initWithKey:@"myEvent.date" ascending:YES];
    timeDescr = [[NSSortDescriptor alloc] initWithKey:@"myEvent.time" ascending:YES];
    
    events = [events sortedArrayUsingDescriptors:@[dateDescr, timeDescr]];
    
    return ([events count] > 0 ? events : nil);
}

#pragma mark - POG

+(void)fixEvents{
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSError* error = nil;
    NSDateFormatter* formatter = nil;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    formatter = [[NSDateFormatter alloc] init];
    
    for (Event* e in [self eventsByEventType:EVENT_TYPE_EXHIBITION]) {
        if ([e.name containsString:@"Sala de Banho"]) {
            if ([e.place containsString:@"Terminal"]) {
                e.place = @"Terminal Barão Geraldo";
            } else{
                e.place = @"Coreto da Praça Castro Mendes";
            }
            
            [context save:&error];
        }
    }
    
    for (Event* e in [self eventsByEventType:EVENT_TYPE_SPECIAL]) {
        if ([e.name containsString:@"Quem com porcos se mistura"]) {
            e.name = @"Quem com porcos se mistura, farelo come, Grupo VÃO (São Paulo/SP)";
            
            [context save:&error];
            
        } else if ([e.name containsString:@"A natureza da vida"]){
            [formatter setDateFormat:@"HH:mm"];
            
            e.time = [formatter dateFromString:@"17:30"];
            e.place = @"Ciclo Básico Unicamp";
            
            [context save:&error];
        }
    }
}

@end
