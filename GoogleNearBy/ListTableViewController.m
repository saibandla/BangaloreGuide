//
//  ListTableViewController.m
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 03/01/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import "ListTableViewController.h"
#import "ViewController.h"
#import "customCell.h"
#import "DeatilsTableViewController.h"
#import "MapLocator.h"
#import "MyLocaion.h"
@interface ListTableViewController ()

@end

@implementation ListTableViewController
@synthesize data;
NSArray *resultSet;

NSMutableArray *imagesdata;
NSMutableArray *routeseleted;
- (void)viewDidLoad {
    [super viewDidLoad];
    // [self.navigationItem setTitle:[NSString stringWithFormat:@"List of %@s",[ViewController getType]]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    resultSet=[data objectForKey:@"routes"] ;
    imagesdata=[[NSMutableArray alloc]init];
    routeseleted=[[NSMutableArray alloc]init];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    //    [imagesdata removeAllObjects];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return resultSet.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [routeseleted removeAllObjects];
    [routeseleted addObject:@{@"mode":@"start"}];
    NSDictionary *routeData=[resultSet objectAtIndex:indexPath.row];
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
     NSArray *steps=[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"steps"];
    MyLocation *sourceAnnotaion=[[MyLocation alloc]initWithName:[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"start_address"] address:[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"start_address"]  coordinate:CLLocationCoordinate2DMake([[[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"start_location"] objectForKey:@"lat"] doubleValue], [[[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"start_location"] objectForKey:@"lng"] doubleValue])];
    MyLocation *destAnnotaion=[[MyLocation alloc]initWithName:[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"end_address"]  address:[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"end_address"]  coordinate:CLLocationCoordinate2DMake([[[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"start_location"] objectForKey:@"lat"] doubleValue], [[[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"end_location"] objectForKey:@"lng"] doubleValue])];
    for(id step in steps)
    {
        NSString *travel_mode=[step objectForKey:@"travel_mode"];
        if([travel_mode isEqualToString:@"WALKING"])
        {
            [routeseleted addObject:@{@"mode":@"walk",@"walk_directions":[step objectForKey:@"html_instructions"],@"dist_dur":[NSString stringWithFormat:@"%@ (%@)",[[step objectForKey:@"distance"] objectForKey:@"text"]  ,[[step objectForKey:@"duration"] objectForKey:@"text"] ]}];
            NSString *des=[step objectForKey:@"html_instructions"];
            if([steps indexOfObject:step]!=(steps.count-1))
            {
            NSMutableArray *m=[NSMutableArray arrayWithArray:[des componentsSeparatedByString:@" "]];
            [m removeObjectAtIndex:0];
            [m removeObjectAtIndex:0];
            des=[m componentsJoinedByString:@" "];
            [routeseleted addObject:@{@"mode":@"location_name",@"name":des}];
            }
            else
            {
                NSMutableArray *m1=[NSMutableArray arrayWithArray:[des componentsSeparatedByString:@","]];
                NSMutableArray *m=[NSMutableArray arrayWithArray:[[m1 objectAtIndex:0] componentsSeparatedByString:@" "]];
                [m removeObjectAtIndex:0];
                [m removeObjectAtIndex:0];
                des=[m componentsJoinedByString:@" "];
                [routeseleted addObject:@{@"mode":@"end",@"name":des}];
            }
        }
        else
        {
            NSString *gj=[[[step objectForKey:@"transit_details"] objectForKey:@"line"] objectForKey:@"short_name"];
            if(gj==nil)
            {
                gj=[[[step objectForKey:@"transit_details"] objectForKey:@"line"] objectForKey:@"name"];

            }
            NSMutableString *htl=[[NSMutableString alloc]initWithString:[step objectForKey:@"html_instructions"]];

            [htl deleteCharactersInRange:NSMakeRange(0, 3)];
            [htl insertString:gj atIndex:0];
            [htl insertString:@"Board " atIndex:0];
            [routeseleted addObject:@{@"mode":@"bus",@"bus_directions":htl,@"dist_dur":[NSString stringWithFormat:@"%@ (%@)",[[step objectForKey:@"distance"] objectForKey:@"text"]  ,[[step objectForKey:@"duration"] objectForKey:@"text"]],@"dept_time":[[[step objectForKey:@"transit_details"] objectForKey:@"departure_time"] objectForKey:@"text"] ,@"arrival_time":[[[step objectForKey:@"transit_details"] objectForKey:@"arrival_time"] objectForKey:@"text"]}];
            
            [routeseleted addObject:@{@"mode":@"location_name",@"name":[[[step objectForKey:@"transit_details"] objectForKey:@"arrival_stop"] objectForKey:@"name"]}];

        }
    }
    NSLog(@"/n/n/n%@",routeseleted);
    DeatilsTableViewController *obj=[[DeatilsTableViewController alloc] initWithNibName:@"DeatilsTableViewController" bundle:nil headerView:selectedCell.contentView routeData:routeseleted mapdata:[[routeData objectForKey:@"overview_polyline"] objectForKey:@"points"]];
    obj.source=sourceAnnotaion;
    obj.dest=destAnnotaion;
    [self.navigationController pushViewController:obj animated:YES];
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *routeData=[resultSet objectAtIndex:indexPath.row];
    customCell *cell;
    NSArray *steps=[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"steps"];
    if(steps.count<=3)
    {
        static NSString *cellIdentifier = @"customCell1";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *toplevelObject=[[NSBundle mainBundle]loadNibNamed:@"customCell" owner:self options:nil];
            for(id currentObj in toplevelObject)
            {
                if([currentObj isKindOfClass:[UITableViewCell class]]&&[[currentObj reuseIdentifier] isEqualToString:cellIdentifier])
                {
                    
                    cell=(customCell *)currentObj;
                }
            }
        }
        cell.arrival_time.text= [[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"arrival_time"] objectForKey:@"text"];
        cell.departure_time.text= [[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"departure_time"] objectForKey:@"text"];
        NSMutableString *dur_txt=[NSMutableString stringWithString:[[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"duration"] objectForKey:@"text"]];
        [dur_txt replaceOccurrencesOfString:@"mins" withString:@"m" options:NSCaseInsensitiveSearch range:NSMakeRange(0, dur_txt.length)];
        [dur_txt replaceOccurrencesOfString:@"hour" withString:@"h" options:NSCaseInsensitiveSearch range:NSMakeRange(0, dur_txt.length)];
        [dur_txt insertString:@"( " atIndex:0];
        [dur_txt appendString:@" )"];

        cell.duration.text= dur_txt;
        NSArray *steps=[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"steps"];
        for(int i=0;i<steps.count;i++)
        {
            NSString *travel_mode=[[steps objectAtIndex:i] objectForKey:@"travel_mode"];
            if([travel_mode isEqualToString:@"TRANSIT"])
            {
                NSString *busname=[[[[steps objectAtIndex:i] objectForKey:@"transit_details"] objectForKey:@"line"] objectForKey:@"short_name"];
                if(busname==nil)
                {
                    busname=[[[[steps objectAtIndex:i] objectForKey:@"transit_details"] objectForKey:@"line"] objectForKey:@"name"];
                }
                if(i==1)
                {
                    cell.firstBus.text=busname;
                }
                else
                {
                    cell.secondBus.text=busname;
                }
            }
        }
    }
    else
    {
    static NSString *cellIdentifier = @"customCell2";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *toplevelObject=[[NSBundle mainBundle]loadNibNamed:@"customCell" owner:self options:nil];
        for(id currentObj in toplevelObject)
        {
            if([currentObj isKindOfClass:[UITableViewCell class]]&&[[currentObj reuseIdentifier] isEqualToString:cellIdentifier])
            {
                
                cell=(customCell *)currentObj;
            }
        }
    }
    cell.arrival_time.text= [[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"arrival_time"] objectForKey:@"text"];
    cell.departure_time.text= [[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"departure_time"] objectForKey:@"text"];
        NSMutableString *dur_txt=[NSMutableString stringWithString:[[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"duration"] objectForKey:@"text"]];
        [dur_txt replaceOccurrencesOfString:@"mins" withString:@"m" options:NSCaseInsensitiveSearch range:NSMakeRange(0, dur_txt.length)];
        [dur_txt replaceOccurrencesOfString:@"hour" withString:@"h" options:NSCaseInsensitiveSearch range:NSMakeRange(0, dur_txt.length)];
        [dur_txt insertString:@"( " atIndex:0];
        [dur_txt appendString:@" )"];
        cell.duration.text= dur_txt;
    NSArray *steps=[[[routeData objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"steps"];
        for(int i=0;i<steps.count;i++)
    {
        NSString *travel_mode=[[steps objectAtIndex:i] objectForKey:@"travel_mode"];
        if([travel_mode isEqualToString:@"TRANSIT"])
        {
            NSString *busname=[[[[steps objectAtIndex:i] objectForKey:@"transit_details"] objectForKey:@"line"] objectForKey:@"short_name"];
            if(busname==nil)
            {
                busname=[[[[steps objectAtIndex:i] objectForKey:@"transit_details"] objectForKey:@"line"] objectForKey:@"name"];
            }
            if(i==1)
            {
            cell.firstBus.text=busname;
            }
            else
            {
                cell.secondBus.text=busname;
            }
        }
    }
    }
    return cell;
}
-(void)fetchedData:(NSArray *)data2
{
    [imagesdata addObject:[data2 objectAtIndex:0]];
    [[data2 objectAtIndex:1] setImage:[data2 objectAtIndex:0]];
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
