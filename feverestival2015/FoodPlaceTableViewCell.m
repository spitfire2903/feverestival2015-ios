//
//  FoodPlaceTableViewCell.m
//  feverestival2015
//
//  Created by Ricardo Nunes de Miranda on 29/01/15.
//  Copyright (c) 2015 Ricardo Nunes de Miranda. All rights reserved.
//

#import "FoodPlaceTableViewCell.h"

@interface FoodPlaceTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblSite;

@end

@implementation FoodPlaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFoodPlace:(FoodPlace *)foodPlace{
    _foodPlace = foodPlace;
    
    self.lblName.text = foodPlace.name;
    self.lblAddress.text = foodPlace.address;
    self.lblPhone.text = foodPlace.phone;
    self.lblSite.text = foodPlace.site;
}

@end
