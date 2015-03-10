//
//  ListTableViewController.h
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 03/01/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ListTableViewController : UITableViewController
{
    NSDictionary *data;
}
@property(nonatomic,strong)NSDictionary *data;
@end
