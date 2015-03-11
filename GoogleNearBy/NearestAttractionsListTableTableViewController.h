//
//  NearestAttractionsListTableTableViewController.h
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 11/03/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearestAttractionsListTableTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *data;
}
@property(nonatomic,strong)NSDictionary *data;

@end
