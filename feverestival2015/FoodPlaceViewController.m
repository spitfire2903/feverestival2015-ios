//
//  FoodPlaceViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "FoodPlaceViewController.h"
#import "FoodManager.h"
#import "FoodPlaceTableViewCell.h"

static NSString* const FOOD_CELL_IDENTIFIER = @"foodCell";

@interface FoodPlaceViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray* foodPlaceList;

@end

@implementation FoodPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.foodPlaceList = [FoodManager foodPlaces];
    
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
    FoodPlaceTableViewCell *cell = nil;
    FoodPlace* place = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:FOOD_CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[FoodPlaceTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FOOD_CELL_IDENTIFIER];
    }
    
    place = [self.foodPlaceList objectAtIndex:indexPath.row];
    
    [cell setFoodPlace:place];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.foodPlaceList count];
}


@end
