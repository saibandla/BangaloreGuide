//
//  customCell.h
//  CustomTable
//
//  Created by Sesha Sai Bhargav Bandla on 12/30/14.
//  Copyright (c) 2014 Sesha Sai Bhargav Bandla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCell : UITableViewCell
{
    
}
@property(nonatomic,strong)IBOutlet UILabel *lbl1;
@property(nonatomic,strong)IBOutlet UILabel *lbl2;

@property(nonatomic,strong)IBOutlet UIImageView *imgV;
@property(nonatomic,strong)IBOutlet UILabel *departure_time;
@property(nonatomic,strong)IBOutlet UILabel *arrival_time;
@property(nonatomic,strong)IBOutlet UILabel *duration;
@property(nonatomic,strong)IBOutlet UILabel *firstBus;
@property(nonatomic,strong)IBOutlet UILabel *secondBus;
@property(nonatomic,strong)IBOutlet UILabel *thirdBus;
@property(atomic,strong)IBOutlet UILabel *locationName;
@property(atomic,strong)IBOutlet UILabel *busDeptTime;
@property(atomic,strong)IBOutlet UILabel *busArrTime;
@property(atomic,strong)IBOutlet UILabel *busInstruc;
@property(atomic,strong)IBOutlet UILabel *busDuration;
@property(atomic,strong)IBOutlet UILabel *walkDeptTime;
@property(atomic,strong)IBOutlet UILabel *walkArrTime;
@property(atomic,strong)IBOutlet UILabel *walkInstruc;
@property(atomic,strong)IBOutlet UILabel *walkDuration;
//@property(nonatomic,strong)IBOutlet UIImageView *imgV;
//@property(nonatomic,strong)IBOutlet UILabel *lbl11;
//@property(nonatomic,strong)IBOutlet UILabel *lbl22;
//@property(nonatomic,strong)IBOutlet UILabel *lbl33;
//@property(nonatomic,strong)IBOutlet UILabel *lbl44;
//@property(nonatomic,strong)IBOutlet UIImageView *imgVV;
@end
