//
//  FoodManager.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "FoodManager.h"
#include "AppDelegate.h"
#include "FoodPlace.h"

@implementation FoodManager

+(NSArray*)foodPlaces{
    NSArray* foodPlaces = nil;
    NSPredicate* predicate = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSFetchRequest *request = nil;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:FOOD_ENTITY inManagedObjectContext:context];
    request = [[NSFetchRequest alloc] init];
    
    //predicate = [NSPredicate predicateWithFormat:@"eventId = %d", [eventId intValue]];//@"%@ = %d", EVENT_ID_PROPERTY, [eventId intValue]];
    
    [request setEntity:entityDescription];
    //[request setPredicate:predicate];
    
    foodPlaces = [context executeFetchRequest:request error:&error];
    
    return ([foodPlaces count] > 0 ? foodPlaces : nil);
}

+(BOOL)clearData{
    BOOL result = YES;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = [appDelegate managedObjectContext];
    
    for (FoodPlace* place in [self foodPlaces]) {
        [context deleteObject:place];
    }
    
    [context save:&error];
    
    if (error) {
        result = NO;
    }
    
    return result;
}

+(BOOL)generateFoodPlaces{
    BOOL result = YES;
    NSArray* foods = nil;
    NSMutableArray* jsonFoods = nil;
    NSError *error = nil;
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSEntityDescription *entityDescription = nil;
    NSString* fileContents = nil;
    NSDictionary* jsonDict = nil;
    NSData* data = nil;
    FoodPlace* foodPlace = nil;
    
    if (![self foodPlaces]) {
        appDelegate = [[UIApplication sharedApplication] delegate];
        
        context = [appDelegate managedObjectContext];
        
        entityDescription = [NSEntityDescription entityForName:FOOD_ENTITY inManagedObjectContext:context];
        
        fileContents = [[NSBundle mainBundle] pathForResource:@"foodPlaces" ofType:@"json"];
        
        jsonFoods = [[NSMutableArray alloc] init];
        
        fileContents = [NSString stringWithContentsOfFile:fileContents encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            result = NO;
        } else{
            data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];

            jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error) {
                result = NO;
            } else{
                foods = [jsonDict objectForKey:@"foodPlaces"];

                
                for (NSObject* object in foods) {
                    foodPlace = nil;
                    
                    foodPlace = [[FoodPlace alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                    
                    foodPlace.name = [object valueForKey:@"place"];
                    foodPlace.address = [object valueForKey:@"address"];
                    foodPlace.phone = [object valueForKey:@"phone"];
                    foodPlace.site = [object valueForKey:@"site"];
                    
                    [context save:&error];
                }
                
            }
        }

    }
    
    return result;
}

@end
