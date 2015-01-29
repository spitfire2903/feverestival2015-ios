//
//  StorytellingInfoViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "StorytellingInfoViewController.h"
#import "EventManager.h"

@interface StorytellingInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlace;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addEvent;

@end

@implementation StorytellingInfoViewController

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
        
        [self setTitle:self.eventObj.vacancys];
        
        self.lblName.text = self.eventObj.name;
        self.lblPlace.text = self.eventObj.place;
        self.lblDateTime.text = [NSString stringWithFormat:@"%@ - %@", [self.eventObj dateStr], [self.eventObj timeStr]];
        
        content = self.eventObj.summary;
        
        
        if (self.eventObj.sheet && self.eventObj.sheet.length > 0) {
            content = [content stringByAppendingFormat:@"\n\nFicha Técnica:\n%@", self.eventObj.sheet];
        }
        
        if (self.eventObj.duration && self.eventObj.duration.length > 0) {
            content = [content stringByAppendingFormat:@"\n\nDuração: %@", self.eventObj.duration];
        }
        
        if (self.eventObj.rating && self.eventObj.rating.length > 0) {
            content = [content stringByAppendingFormat:@"\n\nFaixa Etária: %@", self.eventObj.rating];
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

@end
