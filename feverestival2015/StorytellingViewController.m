//
//  StorytellingViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "StorytellingViewController.h"
#import "EventManager.h"
#import "StorytellingTableViewCell.h"
#import "StorytellingInfoViewController.h"

static NSString* const STORYTELLING_CELL_IDENTIFIER = @"storytellingCell";
static NSString* const STORYTELLING_INFO_SEGUE = @"storytellingInfoSegue";


@interface StorytellingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray* eventList;
@property (nonatomic) Event* selectedEvent;

@end

@implementation StorytellingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventList = [EventManager storytellings];
    
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
    
    if ([[segue identifier] isEqualToString:STORYTELLING_INFO_SEGUE]) {
        
        StorytellingInfoViewController *info = [segue destinationViewController];
        info.eventObj = self.selectedEvent;
    }
}

#pragma mark - tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StorytellingTableViewCell *cell = nil;
    Event* event = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:STORYTELLING_CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[StorytellingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:STORYTELLING_CELL_IDENTIFIER];
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
    
    [self performSegueWithIdentifier:STORYTELLING_INFO_SEGUE sender:self];
}


@end
