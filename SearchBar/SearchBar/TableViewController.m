//
//  TableViewController.m
//  SearchBar
//
//  Created by KaL on 6/3/15.
//  Copyright (c) 2015 KaL. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController () <UISearchResultsUpdating>

@end

@implementation TableViewController
{
    NSArray *favoriteFoods;
    
    UISearchController *mySearchController; // declare this global also gets you the animation
    NSArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // create a path for the plist
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Items" ofType:@"plist"];
    
    // retrieve the dictionary by init with the path from the plist
    NSDictionary *plistDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // retrieve food array
    favoriteFoods = [plistDic objectForKey:@"Food"];
    
    // create the search bar
    mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [mySearchController.searchBar sizeToFit]; // shows the search bar
    self.tableView.tableHeaderView = mySearchController.searchBar;
    self.definesPresentationContext = YES;
    mySearchController.dimsBackgroundDuringPresentation = NO;
    mySearchController.searchResultsUpdater = self;
    
}

- (void)filterContentForSearch:(NSString *)searchText
{
    // create a new string using the Predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[c] %@",searchText]; // use self, instead of name
    
    // filter the array using the predicate in another array
    searchResults = [favoriteFoods filteredArrayUsingPredicate:predicate];
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self filterContentForSearch:searchController.searchBar.text];
    [self.tableView reloadData];
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
    
    
    if (mySearchController.isActive) {
        return searchResults.count;
    } else {
        return favoriteFoods.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdenitifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenitifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenitifier];
    }
    
    if (mySearchController.isActive){
        cell.textLabel.text = searchResults[indexPath.row];
    } else {
        cell.textLabel.text = favoriteFoods[indexPath.row];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
