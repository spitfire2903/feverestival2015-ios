//
//  WorkshopViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "WorkshopViewController.h"
#import "EventManager.h"
#import "WorkshopTableViewCell.h"
#import "WorkshopInfoViewController.h"

static NSString* const WORKSHOP_CELL_IDENTIFIER = @"workshopCell";
static NSString* const WORKSHOP_INFO_SEGUE = @"workshopInfoSegue";


@interface WorkshopViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray* eventList;
@property (nonatomic) Event* selectedEvent;

@end

@implementation WorkshopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventList = [EventManager workshops];
    
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
    }
}

#pragma mark - tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkshopTableViewCell *cell = nil;
    Event* event = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:WORKSHOP_CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[WorkshopTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:WORKSHOP_CELL_IDENTIFIER];
    }
    
    event = [self.eventList objectAtIndex:indexPath.row];
    
    [cell setEventObj:event];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.eventList count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedEvent = [self.eventList objectAtIndex:indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:WORKSHOP_INFO_SEGUE sender:self];
}

@end
