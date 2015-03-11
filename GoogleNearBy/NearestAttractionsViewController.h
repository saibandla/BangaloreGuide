//
//  NearestAttractionsViewController.h
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 11/03/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *latitude,*longitude,*type;

@interface NearestAttractionsViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UITextField *address;
    IBOutlet UITextField *radius;
    IBOutlet UITextField *typeText;
    IBOutlet UITableView *resultList;
    IBOutlet UIView *view1;
    
}
-(IBAction)startSesrch:(id)sender;
+(void)setLatitude:(NSString *)lat andLongitude:(NSString*)longi;
+(void)setType:(NSString*)type1;
-(void)getJsonData;
+(NSString *)getType;
+(id)sharedInsta;
- (void)fetchedData:(NSData *)responseData;
@end
