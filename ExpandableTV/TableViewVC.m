//
//  TableViewVC.m
//  ExpandableTV
//
//  Created by Tarun Sharma on 21/07/17.
//  Copyright © 2017 Chetaru Web LInk Private Limited. All rights reserved.
//

#import "TableViewVC.h"

@interface TableViewVC ()
{
   NSMutableArray * arrayForBool;
    NSMutableDictionary * dic_data;
}
@end

@implementation TableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Initialization

-(void)initialization
{
   arrayForBool=[[NSMutableArray alloc]init];
    dic_data =[[NSMutableDictionary alloc]init];
    [dic_data setValue:@[@"1",@"2"] forKey:@"Section"];
    [dic_data setValue:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"] forKey:@"Section1"];
    [dic_data setValue:@[@"1",@"2",@"3",@"4"] forKey:@"Section2"];
    
    for (int i=0; i<dic_data.allKeys.count; i++) {
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
    }
    NSLog(@"Array Values %@",arrayForBool);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *str =[dic_data.allKeys objectAtIndex:section];
    return [[dic_data valueForKey:str]count];
    
//    if ([[arrayForBool objectAtIndex:section] boolValue]) {
//        NSString *str =[dic_data.allKeys objectAtIndex:section];
//        return [[dic_data valueForKey:str]count];
//    }
//    else
//        return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dic_data.allKeys.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"hello";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    NSString *str =[dic_data.allKeys objectAtIndex:indexPath.section];
    
    cell.textLabel.text = [[dic_data valueForKey:str]objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*************** Close the section, once the data is selected ***********************************/
    
//    [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
//    
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
       
        NSLog(@"Height at row %d",[[arrayForBool objectAtIndex:indexPath.section] boolValue]);
         return 40;
    }
    return 0;
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - Creating View for TableView Section

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280,40)];
    sectionView.tag=section;
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width-10, 40)];
    viewLabel.backgroundColor=[UIColor clearColor];
    viewLabel.textColor=[UIColor blackColor];
    viewLabel.font=[UIFont systemFontOfSize:15];
    NSString *str =[dic_data.allKeys objectAtIndex:section];
    
    viewLabel.text=[NSString stringWithFormat:@"List of %@",str];
    [sectionView addSubview:viewLabel];
    
    /********** Add UITapGestureRecognizer to SectionView   **************/
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionView addGestureRecognizer:headerTapped];
    
    return  sectionView;
    
    
}


#pragma mark - Table header gesture tapped

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        for (int i=0; i<dic_data.allKeys.count; i++) {
            if (indexPath.section==i) {
                [arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
            }
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationBottom];
        
   }
    
}

@end
