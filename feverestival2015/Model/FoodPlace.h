//
//  FoodPlace.h
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FoodPlace : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * site;

@end
