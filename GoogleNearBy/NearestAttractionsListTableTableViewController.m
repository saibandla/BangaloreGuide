//
//  NearestAttractionsListTableTableViewController.m
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 11/03/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import "NearestAttractionsListTableTableViewController.h"
#import "NearestAttractionsViewController.h"
#import "customCell.h"
#import "MapLocator.h"
@interface NearestAttractionsListTableTableViewController ()

@end

@implementation NearestAttractionsListTableTableViewController
@synthesize data;

NSArray *resultSet;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:[NSString stringWithFormat:@"List of %@",[NearestAttractionsViewController getType]]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    resultSet=[data objectForKey:@"results"] ;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[resultSet objectAtIndex:indexPath.row];
    NSDictionary *location=[[dic objectForKey:@"geometry"] objectForKey:@"location"];
    CLLocationCoordinate2D coordinates;
    coordinates.latitude=[[location objectForKey:@"lat"] floatValue];
    coordinates.longitude=[[location objectForKey:@"lng"] floatValue];
    NSString *name=[dic objectForKey:@"name"];
    NSString *address=[dic objectForKey:@"vicinity"];
    MapLocator *locat=[[MapLocator alloc]initWithNibName:@"MapLocator" bundle:nil LocationName:name LocationAddress:address Coordinates:coordinates];
    [self.navigationController pushViewController:locat animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"nearestAttractionsCell";
    customCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //    if (cell == nil) {
    NSArray *toplevelObject=[[NSBundle mainBundle]loadNibNamed:@"customCell" owner:self options:nil];
    for(id currentObj in toplevelObject)
    {
        if([currentObj isKindOfClass:[UITableViewCell class]]&&[[currentObj reuseIdentifier] isEqualToString:cellIdentifier])
        {
            
            cell=(customCell *)currentObj;
        }
    }
    //    }
    
    NSDictionary *dic=[resultSet objectAtIndex:indexPath.row];
    if([dic valueForKey:@"photos"]!=nil)
    {
        NSArray *photoes=[dic objectForKey:@"photos"];
        NSDictionary *temp=[photoes objectAtIndex:0];
        NSString *photoeRef=[temp objectForKey:@"photo_reference"];
        NSData* imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=80&photoreference=%@&key=AIzaSyB4-HKhnnbCWT6o1Q5JRBFyLk5qcTnt-Ng",photoeRef]]];
        
        // [cell.imgV setFrame:CGRectMake(0, 0, 71, 71)];
        // [cell.imgV setContentMode:UIViewContentModeScaleAspectFill];
        [cell.imgV clipsToBounds];
        [cell.imgV setImage:[UIImage imageWithData:imgdata ]];
        
    }
    else
    {
        NSData* imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"icon"]]];
        [cell.imgV setContentMode:UIViewContentModeScaleAspectFill];
        [cell.imgV setImage:[UIImage imageWithData:imgdata]];
        
    }
    cell.lbl1.text=[dic objectForKey:@"name"];
    [cell.lbl1 setFont:[UIFont systemFontOfSize:15]];
    cell.lbl2.text=[dic objectForKey:@"vicinity"];
    NSLog(@"Vicinity %@",[dic objectForKey:@"vicinity"]);
    [cell.lbl2 setFont:[UIFont systemFontOfSize:14]];
    return cell;
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
