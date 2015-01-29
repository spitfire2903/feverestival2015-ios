//
//  MenuViewController.h
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 27/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "BaseViewController.h"
#import "Model/Event.h"
#import "Model/MyCalendar.h"
#import <SASlideMenu/SASlideMenuViewController.h>
#import <SASlideMenu/SASlideMenuDataSource.h>
#import <SASlideMenu/SASlideMenuDelegate.h>

@interface MenuViewController : SASlideMenuViewController<SASlideMenuDataSource,SASlideMenuDelegate>

@end
