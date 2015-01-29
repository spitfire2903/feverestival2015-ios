//
//  AddressViewController.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*** Init the scrollview and the label ***/
    //UIScrollView *scrollView= [UIScrollView new];
    //self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //[self.view addSubview:scrollView];
    
    //UILabel *scrollViewLabel = [[UILabel alloc] init];
    self.lblAddress.numberOfLines = 0;
    //self.lblAddress.translatesAutoresizingMaskIntoConstraints = NO;
    //[scrollView addSubview:scrollViewLabel];
    
    
    /*** Auto Layout ***/
    
   /* NSDictionary *views = NSDictionaryOfVariableBindings(_scrollView, _lblAddress);
    
    NSArray *scrollViewLabelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_lblAddress(_scrollView)]" options:0 metrics:nil views:views];
    [self.scrollView addConstraints:scrollViewLabelConstraints];
    
    scrollViewLabelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_lblAddress]|" options:0 metrics:nil views:views];
    [self.scrollView addConstraints:scrollViewLabelConstraints];
    
    NSArray *scrollViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_scrollView]-|" options:0 metrics:nil views:views];
    [self.view addConstraints:scrollViewConstraints];
    
    scrollViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_scrollView]-|" options:0 metrics:nil views:views];
    [self.view addConstraints:scrollViewConstraints];*/
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.lblAddress.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
