//
//  MyCalendarViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "MyCalendarViewController.h"
#import "EventManager.h"
#import "MyCalendar.h"
#import "MyCalendarTableViewCell.h"
#import "WorkshopInfoViewController.h"
#import "SpecialsInfoViewController.h"
#import "StorytellingInfoViewController.h"
#import "ExhibitionInfoViewController.h"

static NSString* const CALENDAR_CELL_IDENTIFIER = @"calendarCell";
static NSString* const WORKSHOP_INFO_SEGUE = @"workshopInfoSegue";
static NSString* const SPECIAL_INFO_SEGUE = @"specialInfoSegue";
static NSString* const STORYTELLING_INFO_SEGUE = @"storytellingInfoSegue";
static NSString* const EXHIBITION_INFO_SEGUE = @"exhibitionInfoSegue";

@interface MyCalendarViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray* calendarList;
@property (nonatomic) Event* selectedEvent;

@end

@implementation MyCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendarList = [EventManager myCalendarEvents];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:WORKSHOP_INFO_SEGUE]) {
        WorkshopInfoViewController *info = [segue destinationViewController];
        info.eventObj = self.selectedEvent;
    } else if ([[segue identifier] isEqualToString:SPECIAL_INFO_SEGUE]){
        SpecialsInfoViewController *info = [segue destinationViewController];
        info.eventObj = self.selectedEvent;
    } else if ([[segue identifier] isEqualToString:STORYTELLING_INFO_SEGUE]){
        StorytellingInfoViewController *info = [segue destinationViewController];
        info.eventObj = self.selectedEvent;
    } else if ([[segue identifier] isEqualToString:EXHIBITION_INFO_SEGUE]){
        ExhibitionInfoViewController *info = [segue destinationViewController];
        info.eventObj = self.selectedEvent;
    }
}

#pragma mark - tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCalendarTableViewCell *cell = nil;
    MyCalendar* calendar = nil;
    Event* event = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CALENDAR_CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[MyCalendarTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CALENDAR_CELL_IDENTIFIER];
    }
    
    calendar = [self.calendarList objectAtIndex:indexPath.row];
    event = calendar.myEvent;
    
    [cell setEventObj:event];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.calendarList count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCalendar* calendar = nil;
    
    calendar = [self.calendarList objectAtIndex:indexPath.row];
    self.selectedEvent = calendar.myEvent;
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch ([self.selectedEvent.eventType intValue]) {
        case EVENT_TYPE_SPECIAL:
            [self performSegueWithIdentifier:SPECIAL_INFO_SEGUE sender:self];
            
            break;
        case EVENT_TYPE_WORKSHOP:
            [self performSegueWithIdentifier:WORKSHOP_INFO_SEGUE sender:self];
            
            break;
        case EVENT_TYPE_STORYTELLING:
            [self performSegueWithIdentifier:STORYTELLING_INFO_SEGUE sender:self];
            
            break;
        case EVENT_TYPE_EXHIBITION:
            [self performSegueWithIdentifier:EXHIBITION_INFO_SEGUE sender:self];
            
            break;
        default:
            break;
    }
    
}
@end
