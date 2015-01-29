//
//  SpecialsViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "SpecialsViewController.h"
#import "EventManager.h"
#import "SpecialsTableViewCell.h"
#import "SpecialsInfoViewController.h"

static NSString* const SPECIAL_CELL_IDENTIFIER = @"specialCell";
static NSString* const SPECIAL_INFO_SEGUE = @"specialInfoSegue";


@interface SpecialsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray* eventList;
@property (nonatomic) Event* selectedEvent;

@end

@implementation SpecialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventList = [EventManager specials];
    
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
    
    if ([[segue identifier] isEqualToString:SPECIAL_INFO_SEGUE]) {
        
        SpecialsInfoViewController *info = [segue destinationViewController];
        info.eventObj = self.selectedEvent;
    }
}

#pragma mark - tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecialsTableViewCell *cell = nil;
    Event* event = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:SPECIAL_CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[SpecialsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SPECIAL_CELL_IDENTIFIER];
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
    
    [self performSegueWithIdentifier:SPECIAL_INFO_SEGUE sender:self];
}


@end
