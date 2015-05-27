//
//  StadiumViewController.m
//  NFL
//
//  Created by Mike_Gazdich_rMBP on 10/20/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import "StadiumViewController.h"

@interface StadiumViewController ()

@end

@implementation StadiumViewController

- (void)viewDidLoad {
    
    self.title = self.teamFullName;
    
    // The URL cannot have spaces; therefore replace each space in the stadium name with the + sign.
    // Example: The stadium name "Hubert H. Humphrey Metrodome" needs to be converted to "Hubert+H.+Humphrey+Metrodome"
    NSString *teamStadiumNameWithNoSpaces = [self.stadiumName stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    // The ampersand & symbol cannot be used in a URL. It needs to be encoded as %26
    // See URL Encoding Reference at http://www.w3schools.com/tags/ref_urlencode.asp
    
    NSString *teamStadiumNameQuery = [teamStadiumNameWithNoSpaces stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    
    // Compose the query URL for Google's map API
    NSString *query = [NSString stringWithFormat:@"http://maps.google.com/?q=%@", teamStadiumNameQuery];
    
    // Asks the web view object to display the Google map for the given query
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]];    
    [super viewDidLoad];   // Inform Super
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
