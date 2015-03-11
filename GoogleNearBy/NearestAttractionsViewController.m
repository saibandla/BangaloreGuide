//
//  NearestAttractionsViewController.m
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 11/03/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import "NearestAttractionsViewController.h"
#import "NearestAttractionsListTableTableViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface NearestAttractionsViewController ()

@end

@implementation NearestAttractionsViewController
NearestAttractionsViewController *sharedInst;

NSArray *Locationsarray;
NSArray *_pickerData;
NSMutableArray *placeIds;
UIView *picckerView;
UIPickerView *typePicker;
UIView *loadscreen;
UIActivityIndicatorView *Acitict;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setTitle:@"Geo Search"];
    }
    return self;
}
+(id)sharedInsta
{
    if(sharedInst==nil)
    {
        sharedInst=[[NearestAttractionsViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    }
    return sharedInst;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBarItem setImage:[UIImage imageNamed:@"ic_maps_indicator_startpoint_list copy.png"]];
    [self.tabBarItem setTitle:@"Nearest Attractions"];
    type=@"atm";
    _pickerData=@[@"accounting",
                  @"airport",
                  @"amusement_park",
                  @"aquarium",
                  @"art_gallery",
                  @"atm",
                  @"bakery",
                  @"bank",
                  @"bar",
                  @"beauty_salon",
                  @"bicycle_store",
                  @"book_store",
                  @"bowling_alley",
                  @"bus_station",
                  @"cafe",
                  @"campground",
                  @"car_dealer",
                  @"car_rental",
                  @"car_repair",
                  @"car_wash",
                  @"casino",
                  @"cemetery",
                  @"church",
                  @"city_hall",
                  @"clothing_store",
                  @"convenience_store",
                  @"courthouse",
                  @"dentist",
                  @"department_store",
                  @"doctor",
                  @"electrician",
                  @"electronics_store",
                  @"embassy",
                  @"establishment",
                  @"finance",
                  @"fire_station",
                  @"florist",
                  @"food",
                  @"funeral_home",
                  @"furniture_store",
                  @"gas_station",
                  @"general_contractor",
                  @"grocery_or_supermarket",
                  @"gym",
                  @"hair_care",
                  @"hardware_store",
                  @"health",
                  @"hindu_temple",
                  @"home_goods_store",
                  @"hospital",
                  @"insurance_agency",
                  @"jewelry_store",
                  @"laundry",
                  @"lawyer",
                  @"library",
                  @"liquor_store",
                  @"local_government_office",
                  @"locksmith",
                  @"lodging",
                  @"meal_delivery",
                  @"meal_takeaway",
                  @"mosque",
                  @"movie_rental",
                  @"movie_theater",
                  @"moving_company",
                  @"museum",
                  @"night_club",
                  @"painter",
                  @"park",
                  @"parking",
                  @"pet_store",
                  @"pharmacy",
                  @"physiotherapist",
                  @"place_of_worship",
                  @"plumber",
                  @"police",
                  @"post_office",
                  @"real_estate_agency",
                  @"restaurant",
                  @"roofing_contractor",
                  @"rv_park",
                  @"school",
                  @"shoe_store",
                  @"shopping_mall",
                  @"spa",
                  @"stadium",
                  @"storage",
                  @"store",
                  @"subway_station",
                  @"synagogue",
                  @"taxi_stand@",
                  @"train_station@",
                  @"travel_agency@",
                  @"university",
                  @"veterinary_care",
                  @"zoo"];
    placeIds=[[NSMutableArray alloc]init];
    [address setDelegate:self];
    [resultList setDataSource:self];
    [resultList setDelegate:self];
    [address setInputView:[UIView alloc]];
    resultList.layer.cornerRadius=10.0;
    resultList.layer.borderWidth=1;
    resultList.layer.borderColor=resultList.separatorColor.CGColor;
    [resultList setHidden:YES];
    picckerView=[[UIView alloc]initWithFrame:CGRectMake(0, 38, 319, 511)];
    [picckerView setBackgroundColor:[resultList separatorColor]];
    
    UIPickerView *typePicker=[[UIPickerView alloc]initWithFrame:CGRectMake(5, 131, 310, 216)];
    typePicker.layer.borderWidth=1.0;
    typePicker.layer.borderColor=[UIColor whiteColor].CGColor;
    typePicker.layer.cornerRadius=10.0;
    [typePicker setDataSource:self];
    [typePicker setDelegate:self];
    
    [typeText setDelegate:self];
    [picckerView addSubview:typePicker];
    
    UIButton *sectType=[[UIButton alloc]initWithFrame:CGRectMake(131, 370, 70, 30)];
    [sectType setTitle:@"Select" forState:UIControlStateNormal];
    [sectType setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sectType addTarget:self action:@selector(onSelectPickker) forControlEvents:UIControlEventTouchUpInside];
    [picckerView addSubview:sectType];
    [picckerView setHidden:YES];
    [self.view addSubview:picckerView];
    
    loadscreen=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    loadscreen.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    Acitict=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [Acitict setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2, 50  , 50)];
    [loadscreen addSubview:Acitict];
    // Do any additional setup after loading the view from its nib.
}
-(void)onSelectPickker
{
    //typeText.text=[_pickerData objectAtIndex:[typePicker selectedRowInComponent:0]];
    [typeText resignFirstResponder];
    [self doTransitionWithType1];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [resultList setHidden:YES];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    typeText.text=[_pickerData objectAtIndex:row];
    [NearestAttractionsViewController setType:typeText.text];
}
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (int)_pickerData.count;
}
// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}
-(void)doTransitionWithType
{
    
    [picckerView setHidden:NO];
}

// Transition from View2 to view1
-(void)doTransitionWithType1
{
    [picckerView setHidden:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag==1)
    {
        [self doTransitionWithType];
    }
    return YES;
}
-(IBAction)startSesrch:(id)sender
{
    [self getJsonData];
}
-(void)getJsonData
{
    NSURL *searchUrl=[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=%@&types=%@&key=AIzaSyB4-HKhnnbCWT6o1Q5JRBFyLk5qcTnt-Ng",latitude,longitude,radius.text,type]];
    NSLog(@"%@",searchUrl);
    
    [Acitict startAnimating];
    [self.view addSubview:loadscreen];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:searchUrl];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    address.text=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    //Getting Lattude and Longitude
    
    NSURL *searchUrl=[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyB4-HKhnnbCWT6o1Q5JRBFyLk5qcTnt-Ng",[placeIds objectAtIndex:indexPath.row] ]];
    NSLog(@"\n\nSearch URL \n%@",searchUrl);
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:searchUrl];
        [self performSelectorOnMainThread:@selector(fetchedData3:)
                               withObject:data waitUntilDone:YES];
    });
}
+(void)setType:(NSString *)type1
{
    type=type1;
}
+(void)setLatitude:(NSString *)lat andLongitude:(NSString*)longi
{
    latitude=lat;
    longitude=longi;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if([address.text isEqualToString:@""])
    {
        Locationsarray=@[];
        [resultList setHidden:YES];
    }
    else
    {
        NSURL *searchUrl=[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=address&language=en&key=AIzaSyB4-HKhnnbCWT6o1Q5JRBFyLk5qcTnt-Ng",address.text]];
        NSLog(@"%@",searchUrl);
        
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL:searchUrl];
            [self performSelectorOnMainThread:@selector(fetchedData2:)
                                   withObject:data waitUntilDone:YES];
        });
    }
    return YES;
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    NearestAttractionsListTableTableViewController *listTable=[[NearestAttractionsListTableTableViewController alloc]initWithNibName:@"NearestAttractionsListTableTableViewController" bundle:nil];
    [listTable setData:json];
    [self.navigationController pushViewController:listTable animated:YES];
    
    //    NSArray *jsonarray=[json objectForKey:@"results"];
    //
    //
    //    for(id obj in jsonarray)
    //    {
    //        NSDictionary *dic=obj;
    //        NSLog(@"\n\n%@ %@",[dic objectForKey:@"name"],[dic objectForKey:@"vicinity"]);
    //
    //    }
    [Acitict stopAnimating];
    [loadscreen removeFromSuperview];
    
}
- (void)fetchedData2:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    Locationsarray=[json objectForKey:@"predictions"];
    
    
    for(id obj in Locationsarray)
    {
        NSDictionary *dic=obj;
        NSLog(@"\n\n%@ %@",[dic objectForKey:@"description"],[dic objectForKey:@"place_id"]);
        
    }
    if([address.text isEqualToString:@""])
    {
        Locationsarray=@[];
        
        [resultList setHidden:YES];
        
    }
    [placeIds removeAllObjects];
    [resultList reloadData];
    [resultList setHidden:NO];
    
    
}
+(NSString *)getType
{
    return type;
}
- (void)fetchedData3:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    NSLog(@"%@",json );
    NSDictionary *location=[[[json objectForKey:@"result"] objectForKey:@"geometry"] objectForKey:@"location"];
    
    [NearestAttractionsViewController setLatitude:[location objectForKey:@"lat"] andLongitude:[location objectForKey:@"lng"]];
    [resultList setHidden:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Locationsarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cellObj=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cellObj==nil)
    {
        cellObj=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dic=[Locationsarray objectAtIndex:indexPath.row];
    cellObj.textLabel.text=[dic objectForKey:@"description"];
    [cellObj.textLabel setFont:[UIFont systemFontOfSize:12]];
    [cellObj.textLabel setNumberOfLines:2];
    
    NSLog(@"\n\n %li---%@",indexPath.row,[dic objectForKey:@"place_id"]);
    [placeIds addObject:[dic objectForKey:@"place_id"]];
    [cellObj.detailTextLabel setText:[dic objectForKey:@"place_id"]];
    // cellObj.detailTextLabel.hidden=YES;
    
    return cellObj;
}
@end
