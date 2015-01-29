//
//  WorkshopInfoViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "WorkshopInfoViewController.h"
#import "EventManager.h"

@interface WorkshopInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlace;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addEvent;

@end

@implementation WorkshopInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString* content = nil;
    
    if (self.eventObj) {
        if ([EventManager isEventFavorited:self.eventObj]) {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        self.lblName.text = self.eventObj.name;
        self.lblPlace.text = self.eventObj.place;
        self.lblDateTime.text = self.eventObj.sheet;
        
        content = self.eventObj.summary;
        
        content = [content stringByAppendingFormat:@"\n\nDuração: %@", self.eventObj.duration];
        
        content = [content stringByAppendingFormat:@"\nVagas: %@", self.eventObj.vacancys];
        
        content = [content stringByAppendingFormat:@"\nPúblico alvo: %@", self.eventObj.target];

        if (self.eventObj.requirement && self.eventObj.requirement.length > 0) {
            content = [content stringByAppendingFormat:@"\n\nPré Requisitos: %@", self.eventObj.requirement];
        }
        
        self.lblContent.text = content;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addEventToMyCalendar:(id)sender {
    [EventManager setEventFavorited:self.eventObj isFavorited:YES];
    self.navigationItem.rightBarButtonItem = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
