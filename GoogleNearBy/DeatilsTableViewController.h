//
//  DeatilsTableViewController.h
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 10/01/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeatilsTableViewController : UITableViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil headerView:(UIView *)headView routeData:(NSArray *)mainData mapdata:(NSString *)mapdata;
@end
