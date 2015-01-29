//
//  MeetingPointViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "MeetingPointViewController.h"
#import "EventManager.h"
#import "MeetingPointTableViewCell.h"

static NSString* const MEETING_POINT_CELL_IDENTIFIER = @"meetingPointCell";

@interface MeetingPointViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray* eventList;

@end

@implementation MeetingPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventList = [EventManager meetingPoints];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeetingPointTableViewCell *cell = nil;
    Event* event = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:MEETING_POINT_CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[MeetingPointTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MEETING_POINT_CELL_IDENTIFIER];
    }
    
    event = [self.eventList objectAtIndex:indexPath.row];
    
    [cell setEventObj:event];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.eventList count];
}

@end
