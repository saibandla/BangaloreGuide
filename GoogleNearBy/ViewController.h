//
//  ViewController.h
//  GoogleNearBy
//
//  Created by Geniusport on 1/2/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *latitude,*longitude;
@interface ViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITextField *address;
    IBOutlet UITableView *resultList;
    IBOutlet UITextField *destination;
    IBOutlet UITableView *resultList2;

    IBOutlet UIView *view1;
    
}
-(IBAction)startSesrch:(id)sender;
+(void)setLatitude:(NSString *)lat andLongitude:(NSString*)longi;
-(void)getJsonData;
+(id)sharedInsta;
-(void)setDestination:(NSString *)destaddr;
- (void)fetchedData:(NSData *)responseData;
@end
