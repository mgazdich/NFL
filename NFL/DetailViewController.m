//
//  DetailViewController.m
//  NFL
//
//  Created by Mike_Gazdich_rMBP on 10/20/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

// Private obj ref to a UIPopoverController object
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
// A private method
- (void)configureView;
@end

@implementation DetailViewController


#pragma mark - Managing the Data Object Passed

- (void)setDataForSelectedTeam:(NSArray *)newDataForSelectedTeam
{
    /*
     If the user taps the name of a country that is already selected, we will not redisplay
     the country map again unnecessarily for performance reasons. Therefore, the IF
     statement below configures the view only if a different country is selected.
     */
    
    // Here we must access the instance variable directly without using the getter method
    if (![_dataForSelectedTeam isEqualToArray: newDataForSelectedTeam]) {
        
        // Here we must set the instance variable value directly without using the setter method
        _dataForSelectedTeam = newDataForSelectedTeam;
        _websiteURL = [newDataForSelectedTeam objectAtIndex:4];
        
        
        [self configureView];
    }
    
    // If the popover list of country names is showing in the portrait orientation,
    // dismiss it since we will show the team's homepage on the whole screen.
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [self configureView];
    [super viewDidLoad];
}


- (void)configureView
{
    if (self.dataForSelectedTeam) {
        
        // Set the title of the navigation bar to the teamFullName
        self.title = [self.dataForSelectedTeam objectAtIndex: 1];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.websiteURL]]];
        
        [super viewDidLoad];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UISplitViewControllerDelegate Protocol Methods

/*
 When iPad rotates from landscape to portrait orientation, our app hides the master view controller
 displaying the list of topics for naval mines on the left side of the split view.
 When this happens, the button and popover controller need to be reactivated so that
 the user can select a topic from the popover menu displayed by tapping the button.
 */
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"NFL";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}


/*
 When iPad rotates from portrait to landscape orientation, our app shows its hidden master view controller
 displaying the list of topics for naval mines on the left side of the split view.
 When this happens, the button and popover controller are no longer needed and they are deactivated.
 The deactivation is done by setting the object references to nil.
 */
- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - UIWebView Delegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    // Starting to load the web page. Show the animated activity indicator in the status bar
    // to indicate to the user that the UIWebVIew object is busy loading the web page.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Finished loading the web page. Hide the activity indicator in the status bar.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    // Ignore this error if the page is instantly redirected via javascript or in another way
    if([error code] == NSURLErrorCancelled) return;
    
    // An error occurred during the web page load. Hide the activity indicator in the status bar.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // Create the error message in HTML as a character string object pointed to by errorString
    NSString *errorString = [NSString stringWithFormat:
                             @"<html><font size=+2 color='red'><p>An error occurred: %@<br />Possible causes for this error:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>",
                             error.localizedDescription];
    
    // Display the error message within the UIWebView object
    [self.webView loadHTMLString:errorString baseURL:nil];
}

@end
