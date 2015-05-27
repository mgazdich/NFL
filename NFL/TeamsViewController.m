//
//  ViewController.m
//  NFL
//
//  Created by Mike_Gazdich_rMBP on 10/19/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import "TeamsViewController.h"
#import "TeamCell.h"
#import "HomePageViewController.h"
#import "StadiumViewController.h"

@interface TeamsViewController ()

@property (nonatomic, strong) NSString *websiteURL;
@property (nonatomic, strong) NSString *teamFullName;
@property (nonatomic, strong) NSString *stadiumName;

@end

@implementation TeamsViewController

#pragma mark - View Life Cycle


- (void)viewDidLoad {
    
    // filePath is declared as a local variable of character string type
    NSString *filePath;   // File path to the plist file in the application's main bundle (project folder)
    
    // Obtain the file path to the accSports.plist file
    filePath = [[NSBundle mainBundle] pathForResource:@"NFL" ofType:@"plist"];
    
    // Instantiate a static dictionary object and initialize it with the content of the NFL.plist file
    self.teamDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    /*
     Send allKeys message to the dictionary object and obtain all of the keys (country codes) in an array.
     Send the sortedArrayUsingSelector: message to that array. It returns an array that lists the receiver’s
     elements in ascending order, as determined by the comparison method specified by a given selector.
     */
    self.teamNames = [[self.teamDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    [super viewDidLoad];   // Inform super
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table View Data Source Methods

// Although the default is 1; it is still good to include this method for clarity
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Asks the data source to return the number of rows in a given section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamNames count];
}

// Asks the data source to return a cell to insert in a particular table view location
- (TeamCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    NSString *teamName = [self.teamNames objectAtIndex:rowNumber];
    NSArray *teamData = [self.teamDict objectForKey:teamName];
    
    TeamCell *cell = (TeamCell *)[tableView dequeueReusableCellWithIdentifier:@"teamCellView"];
    

    cell.nameLabel.text = teamName;
    cell.teamImageView.image = [UIImage imageNamed:[teamData objectAtIndex:0]];
    cell.fullNameLabel.text = [teamData objectAtIndex:1];
    cell.divisionLabel.text = [teamData objectAtIndex:2];
    cell.stadiumLabel.text = [teamData objectAtIndex:3];
    
    return cell;
}


#pragma mark - Table View Delegate Methods

//       Asks the table view delegate to return the height of a given row.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewRowHeight;
}


//       Informs the table view delegate that the table view is about to display a cell for a particular row.
//       Just before the cell is displayed, we change the color of the cell's background.

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //   We use the modulus operator % to find the remainder of the division of row number by 2.
    //   If the remainder is 0, it is an even number (use MintCream); otherwise, it is an odd number (use OldLace).
    
    if (indexPath.row % 2 == 0) {
        // Set even numbered row background color to MintCream, #F5FFFA  245,255,250
        cell.backgroundColor = MINT_CREAM;
    } else {
        // Set odd numbered row background color to OldLace, #FDF5E6   253,245,230
        cell.backgroundColor = OLD_LACE;
    }
}


// Informs the table view delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    NSString *teamName = [self.teamNames objectAtIndex:rowNumber];
    NSArray *teamData = [self.teamDict objectForKey:teamName];
    
    self.teamFullName = [teamData objectAtIndex:1];
    self.websiteURL = [teamData objectAtIndex:4];

    // Perform the segue named homePage
    [self performSegueWithIdentifier:@"homePage" sender:self];
}


// Informs the table view delegate that the user tapped the detail accessory button
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    NSString *teamName = [self.teamNames objectAtIndex:rowNumber];
    
    NSArray *teamData = [self.teamDict objectForKey:teamName];
    
    self.teamFullName = [teamData objectAtIndex:1];
    self.stadiumName = [teamData objectAtIndex:3];
    
    // Perform the segue named stadium
    [self performSegueWithIdentifier:@"stadium" sender:self];
}


#pragma mark - Preparing for Segue

// This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
// You never call this method. It is invoked by the system.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"homePage"]) {
        
        // Obtain the object reference of the destination view controller
        HomePageViewController *homePageViewController = [segue destinationViewController];
        homePageViewController.teamFullName = self.teamFullName;
        homePageViewController.websiteURL = self.websiteURL;
        
    } else if ([[segue identifier] isEqualToString:@"stadium"]) {
        
        // Obtain the object reference of the destination view controller
        StadiumViewController *stadiumViewController = [segue destinationViewController];
        
        // Pass the data objects countryName and websiteURL to the downstream view controller CountryWebViewController
        stadiumViewController.teamFullName = self.teamFullName;
        stadiumViewController.stadiumName = self.stadiumName;
    }
}

@end

