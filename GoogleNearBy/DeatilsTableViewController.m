//
//  DeatilsTableViewController.m
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 10/01/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import "DeatilsTableViewController.h"
#import "customCell.h"
#import "MapViewViewController.h"
@interface DeatilsTableViewController ()

@end

@implementation DeatilsTableViewController
UIView *headV;
NSArray *data;
NSString *mapdatau;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil headerView:(UIView *)headView routeData:(NSArray *)mainData mapdata:(NSString *)mapdata
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self!=nil)
    {
        headV=headView;
        data=mainData;
        mapdatau=mapdata;
        NSLog(@"%@",mapdata);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *mapButton=[[UIBarButtonItem alloc]initWithTitle:@"Show Map" style:UIBarButtonItemStylePlain target:self action:@selector(showMapView)];
    self.navigationItem.rightBarButtonItem=mapButton;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showMapView
{
    MapViewViewController *mapView=[[MapViewViewController alloc]initWithNibName:@"MapView" bundle:nil];
    mapView.mapdata=mapdatau;
    mapView.source=_source;
    mapView.dest=_dest;
    [self.navigationController pushViewController:mapView animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return data.count;
}
- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    return (UITableViewHeaderFooterView *)headV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    NSString *mode=[[data objectAtIndex:indexPath.row] objectForKey:@"mode"];
    if([mode isEqualToString:@"start"])
        height=52;
    if([mode isEqualToString:@"end"])
        height=52;
    if([mode isEqualToString:@"location_name"])
        height=44;
    if([mode isEqualToString:@"bus"])
        height=93;

    if([mode isEqualToString:@"walk"])
        height=91;

    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *startIdentifier=@"startlocationCell";

    static NSString *endidentifer=@"endlocationCell";
    static NSString* walkidentifer=@"walkCell";
    static NSString *busidentifier=@"busCell";
    static NSString *locationIdentifer=@"locationCell";
    NSString *mode=[[data objectAtIndex:indexPath.row] objectForKey:@"mode"];
    customCell *cell;
    if([mode isEqualToString:@"start"])
    {
    cell=[tableView dequeueReusableCellWithIdentifier:startIdentifier];
        if(cell==nil)
        {
            NSArray *toplevelObject=[[NSBundle mainBundle]loadNibNamed:@"customCell" owner:self options:nil];
            for(id currentObj in toplevelObject)
            {
                if([currentObj isKindOfClass:[UITableViewCell class]]&&[[currentObj reuseIdentifier] isEqualToString:startIdentifier])
                {
                    
                    cell=(customCell *)currentObj;
                }
            }
        }
    
    }
    if([mode isEqualToString:@"end"])
    {
        cell=[tableView dequeueReusableCellWithIdentifier:endidentifer];
        if(cell==nil)
        {
            NSArray *toplevelObject=[[NSBundle mainBundle]loadNibNamed:@"customCell" owner:self options:nil];
            for(id currentObj in toplevelObject)
            {
                if([currentObj isKindOfClass:[UITableViewCell class]]&&[[currentObj reuseIdentifier] isEqualToString:endidentifer])
                {
                    
                    cell=(customCell *)currentObj;
                }
            }
        }
        
    }
    if([mode isEqualToString:@"location_name"])
    {
        cell=[tableView dequeueReusableCellWithIdentifier:locationIdentifer];
        if(cell==nil)
        {
            NSArray *toplevelObject=[[NSBundle mainBundle]loadNibNamed:@"customCell" owner:self options:nil];
            for(id currentObj in toplevelObject)
            {
                if([currentObj isKindOfClass:[UITableViewCell class]]&&[[currentObj reuseIdentifier] isEqualToString:locationIdentifer])
                {
                    
                    cell=(customCell *)currentObj;
                }
            }
        }
        cell.locationName.text=[[data objectAtIndex:indexPath.row] objectForKey:@"name"];
        
    }
    if([mode isEqualToString:@"bus"])
    {
        cell=[tableView dequeueReusableCellWithIdentifier:busidentifier];
        if(cell==nil)
        {
            NSArray *toplevelObject=[[NSBundle mainBundle]loadNibNamed:@"customCell" owner:self options:nil];
            for(id currentObj in toplevelObject)
            {
                if([currentObj isKindOfClass:[UITableViewCell class]]&&[[currentObj reuseIdentifier] isEqualToString:busidentifier])
                {
                    
                    cell=(customCell *)currentObj;
                }
            }
        }
        cell.busDeptTime.text=[[data objectAtIndex:indexPath.row] objectForKey:@"dept_time"];
        cell.busArrTime.text=[[data objectAtIndex:indexPath.row] objectForKey:@"arrival_time"];
        cell.busInstruc.text=[[data objectAtIndex:indexPath.row] objectForKey:@"bus_directions"];
        cell.busDuration.text=[[data objectAtIndex:indexPath.row] objectForKey:@"dist_dur"];

        
    }
    if([mode isEqualToString:@"walk"])
    {
        cell=[tableView dequeueReusableCellWithIdentifier:walkidentifer];
        if(cell==nil)
        {
            NSArray *toplevelObject=[[NSBundle mainBundle]loadNibNamed:@"customCell" owner:self options:nil];
            for(id currentObj in toplevelObject)
            {
                if([currentObj isKindOfClass:[UITableViewCell class]]&&[[currentObj reuseIdentifier] isEqualToString:walkidentifer])
                {
                    
                    cell=(customCell *)currentObj;
                }
            }
        }
       
        cell.walkInstruc.text=[[data objectAtIndex:indexPath.row] objectForKey:@"walk_directions"];
        cell.walkDuration.text=[[data objectAtIndex:indexPath.row] objectForKey:@"dist_dur"];
        
        
    }
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
