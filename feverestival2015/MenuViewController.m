//
//  MenuViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 27/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "MenuViewController.h"
#import "Category/UIColor+FEIA.h"
#import "Category/UIImage+FEIA.h"
#import <ChameleonFramework/Chameleon.h>

static int const MENU_WIDTH = 260;

static NSString* const MENU_CELL_IDENTIFIER = @"menuCell";

static NSString* const SEGUE_CALENDAR = @"calendarSegue";
static NSString* const SEGUE_FEVERESTIVAL = @"feverestivalSegue";
static NSString* const SEGUE_WORKSHOP = @"workshopSegue";
static NSString* const SEGUE_SPECIAL = @"specialSegue";
static NSString* const SEGUE_STORYTELLING = @"storytellingSegue";
static NSString* const SEGUE_MEETING_POINT = @"meetingPointSegue";
static NSString* const SEGUE_ADDRESS = @"addressSegue";
static NSString* const SEGUE_PARTNER = @"partnerSegue";
static NSString* const SEGUE_FOOD = @"foodSegue";
static NSString* const SEGUE_SHEET = @"sheetSegue";

@interface MenuViewController ()

//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property EventCategory eventCategory;

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:MENU_CELL_IDENTIFIER];
    UIView* view = nil;
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MENU_CELL_IDENTIFIER];
        
        //cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    cell.textLabel.text = [self getCellTitle:indexPath];
    //cell.textLabel.textColor = [UIColor whiteColor];
    view = [[UIView alloc] initWithFrame:cell.frame];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    cell.selectedBackgroundView = view;
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    //cell.backgroundColor = [UIColor clearColor];//[UIColor colorWithFlatVersionOf:[UIColor feverPurple]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int number = 0;
    
    switch (section) {
        case 0:
            number = 1;
            
            break;
        case 1:
            number = 4;
            
            break;
        case 2:
            number = 5;
            
            break;
    }
    
    return number;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg_ants_alpha"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* segueName = nil;
    
    segueName = [self getCellSegue:indexPath];
    
    [self performSegueWithIdentifier:segueName sender:self];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}


#pragma mark -
#pragma mark SASlideMenuDataSource

-(NSIndexPath*) selectedIndexPath{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}
/*
 -(NSString*) segueIdForIndexPath:(NSIndexPath *)indexPath{
 NSString* segueName = nil;
 
 segueName = [self getCellSegue:indexPath];
 
 return segueName;
 }*/

-(Boolean) allowContentViewControllerCachingForIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(Boolean) disablePanGestureForIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return YES;
    }
    return NO;
}

-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"ic_menu"] forState:UIControlStateNormal];
}

-(void) configureSlideLayer:(CALayer *)layer{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3;
    layer.shadowOffset = CGSizeMake(-5, 0);
    layer.shadowRadius = 5;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
}

-(CGFloat) leftMenuVisibleWidth{
    return MENU_WIDTH;
}
/*
-(void) prepareForSwitchToContentViewController:(UINavigationController *)content{
    UIViewController* controller = [content.viewControllers objectAtIndex:0];
    
    if ([controller isKindOfClass:[ExhibitionViewController class]]) {
        ExhibitionViewController* viewController = (ExhibitionViewController*)controller;
        viewController.category = self.eventCategory;
    }
}*/

#pragma mark -
#pragma mark SASlideMenuDelegate


-(void) slideMenuWillSlideIn:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuWillSlideIn");
}
-(void) slideMenuDidSlideIn:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuDidSlideIn");
}
-(void) slideMenuWillSlideToSide:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuWillSlideToSide");
}
-(void) slideMenuDidSlideToSide:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuDidSlideToSide");
}
-(void) slideMenuWillSlideOut:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuWillSlideOut");
}
-(void) slideMenuDidSlideOut:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuDidSlideOut");
}
-(void) slideMenuWillSlideToLeft:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuWillSlideToLeft");
}
-(void) slideMenuDidSlideToLeft:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuDidSlideToLeft");
}

#pragma mark - Helpers

-(NSString*)getCellTitle:(NSIndexPath*)indexPath{
    NSString* cellText = nil;
    
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                cellText = @"Meu Calendário";
                
                break;
        }
    } else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cellText = @"Programação";
                
                break;
            case 1:
                cellText = @"Oficinas";
                
                break;
            case 2:
                cellText = @"Eventos Especiais";
                
                break;
            case 3:
                cellText = @"Contação de Histórias";
                
                break;
                /* case 4:
                 cellText = @"Contato";
                 
                 break;*/
        }
    } else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cellText = @"Pontos de Encontro";
                
                break;
            case 1:
                cellText = @"Endereços";
                
                break;
            case 2:
                cellText = @"Parceiros";
                
                break;
            case 3:
                cellText = @"Onde Comer";
                
                break;
            case 4:
                cellText = @"Ficha Técnica";
                
                break;
        }
        
    }
    
    return cellText;
}

-(NSString*)getCellSegue:(NSIndexPath*)indexPath{
    NSString* segueName = nil;
    
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                segueName = SEGUE_CALENDAR;
                
                break;
        }
    } else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                segueName = SEGUE_FEVERESTIVAL;
                
                break;
            case 1:
                segueName = SEGUE_WORKSHOP;
                
                break;
            case 2:
                segueName = SEGUE_SPECIAL;
                
                break;
            case 3:
                segueName = SEGUE_STORYTELLING;
                
                break;
        }
    } else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                segueName = SEGUE_MEETING_POINT;

                break;
            case 1:
                segueName = SEGUE_ADDRESS;
                
                break;
            case 2:
                segueName = SEGUE_PARTNER;
                
                break;
            case 3:
                segueName = SEGUE_FOOD;
                
                break;
            case 4:
                segueName = SEGUE_SHEET;
                
                break;
        }
        
    }
    
    return segueName;
    
}

@end
