//
//  ViewController.m
//  GoogleNearBy
//
//  Created by Geniusport on 1/2/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "ViewController.h"
#import "ListTableViewController.h"
@interface ViewController ()

@end
ViewController *sharedInst;
@implementation ViewController
NSArray *Locationsarray;
NSArray *_pickerData;
NSMutableArray *placeIds;
UIView *picckerView;
UIPickerView *typePicker;
UIView *loadscreen;
UIActivityIndicatorView *Acitict;
UIAlertView *alert;
static int textFlag;
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
        sharedInst=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    }
    return sharedInst;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
       placeIds=[[NSMutableArray alloc]init];
    [address setDelegate:self];
    [destination setDelegate:self];
    [resultList setDataSource:self];
    [resultList setDelegate:self];
    [resultList2 setDataSource:self];
    [resultList2 setDelegate:self];
    resultList.layer.cornerRadius=10.0;
    resultList.layer.borderWidth=1;
    resultList.layer.borderColor=resultList.separatorColor.CGColor;
    [resultList setHidden:YES];
    resultList2.layer.cornerRadius=10.0;
    resultList2.layer.borderWidth=1;
    resultList2.layer.borderColor=resultList.separatorColor.CGColor;
    [resultList2 setHidden:YES];
    self.tabBarItem.image=[UIImage imageNamed:@"mode_transit_icon copy.png"];
    self.tabBarItem.title=@"BMTC";
   
    
    loadscreen=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    loadscreen.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    Acitict=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [Acitict setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2, 50  , 50)];
    [loadscreen addSubview:Acitict];
    
    alert=[[UIAlertView alloc]initWithTitle:@"Message From Server" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)setDestination:(NSString *)destaddr
{
    address.text=destaddr;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [resultList setHidden:YES];
    [resultList2 setHidden:YES];
    [address resignFirstResponder];
    [destination resignFirstResponder];
    
}

-(IBAction)startSesrch:(id)sender
{
    [self getJsonData];
}
-(void)getJsonData
{
    
    if(![address.text isEqualToString:@""] &&![destination.text isEqualToString:@""])
    {
        
        NSString *str=[[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&key=AIzaSyDrlg-8NIkc-Eziz1Wkb3uV_890Y5XLpeo&mode=transit&departure_time=now&alternatives=true",address.text,destination.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        

        NSURL *searchUrl=[NSURL URLWithString:str];
        
        NSLog(@"%@",str);
        [Acitict startAnimating];
        [self.view addSubview:loadscreen];
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL:searchUrl];
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    }
    else
    {
        [alert setTitle:@"Notification"];
        [alert setMessage:@"Please enter all the details"];
        [alert show];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(textFlag==5)
    {
        
        address.text=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [address resignFirstResponder];
    }
    else if(textFlag==4)
    {
        destination.text=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [address resignFirstResponder];
    }
    [tableView setHidden:YES];
    
}

+(void)setLatitude:(NSString *)lat andLongitude:(NSString*)longi
{
    latitude=lat;
    longitude=longi;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textFlag=(int)textField.tag;
    if([textField.text isEqualToString:@""])
    {
        Locationsarray=@[];
        if(textField.tag==5)
            [resultList setHidden:YES];
        else
            [resultList2 setHidden:YES];
    }
    else
    {
        NSURL *searchUrl=[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=address&language=en&key=AIzaSyB4-HKhnnbCWT6o1Q5JRBFyLk5qcTnt-Ng",textField.text]];
        NSLog(@"%@",searchUrl);
        
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL:searchUrl];
            //  NSArray *arr=@[textField.tag,data];
            [self performSelectorOnMainThread:@selector(fetchedData2:)
                                   withObject:data waitUntilDone:YES];
        });
    }
    return YES;
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    if(responseData!=nil)
    {
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData //1
                              
                              options:kNilOptions
                              error:&error];
        
        if([json valueForKey:@"routes"]!=nil)
        {
            NSArray *resultarray=[json objectForKey:@"routes"];
            if(resultarray.count>0)
            {
                ListTableViewController *listTable=[[ListTableViewController alloc]initWithNibName:@"ListTableViewController" bundle:nil];
                [listTable setData:json];
                [self.navigationController pushViewController:listTable animated:YES];
            }
            else
            {
                [alert setTitle:@"Message From Server"];
                [alert setMessage:[NSString stringWithFormat:@"No s found in specified region"]];
                [alert show];
            }
        }
        else
        {
            [alert setTitle:@"Message From Server"];
            
            [alert setMessage:@"Internal Server Error, Please try after some time"];
            [alert show];
        }
        
        [Acitict stopAnimating];
        [loadscreen removeFromSuperview];
    }
    else
    {
        [Acitict stopAnimating];
        [loadscreen removeFromSuperview];
        [alert setTitle:@"Message From Server"];
        
        [alert setMessage:@"Internal Server Error, Please try after some time"];
        [alert show];
    }
}
- (void)fetchedData2:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    if(responseData!=nil)
    {
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
        if([address.text isEqualToString:@""]&&textFlag==5)
        {
            
            Locationsarray=@[];
            
            [resultList setHidden:YES];
            
        }
        if([destination.text isEqualToString:@""]&&textFlag==4)
        {
            Locationsarray=@[];
            
            [resultList2 setHidden:YES];
        }
        [placeIds removeAllObjects];
        if (textFlag==5) {
            [resultList reloadData];
            [resultList setHidden:NO];
        }
        else if(textFlag==4)
        {
            [resultList2 reloadData];
            [resultList2 setHidden:NO];
        }
        
    }
    
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
