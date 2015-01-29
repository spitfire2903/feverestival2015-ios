//
//  ExhibitionViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "ExhibitionViewController.h"
#import "EventManager.h"
#import "ExhibitionTableViewCell.h"
#import "ExhibitionInfoViewController.h"

static NSString* const EXHIBITION_CELL_IDENTIFIER = @"exhibitionCell";
static NSString* const EXHIBITION_INFO_SEGUE = @"exhibitionInfoSegue";

@interface ExhibitionViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray* eventList;
@property (nonatomic) Event* selectedEvent;

@end

@implementation ExhibitionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventList = [EventManager exhibitions];
    
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
    
    if ([[segue identifier] isEqualToString:EXHIBITION_INFO_SEGUE]) {
        
        ExhibitionInfoViewController *info = [segue destinationViewController];
        info.eventObj = self.selectedEvent;
    }
}

#pragma mark - tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExhibitionTableViewCell *cell = nil;
    Event* event = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:EXHIBITION_CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[ExhibitionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:EXHIBITION_CELL_IDENTIFIER];
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
    
    [self performSegueWithIdentifier:EXHIBITION_INFO_SEGUE sender:self];
}


@end
