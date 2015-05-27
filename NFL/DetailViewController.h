//
//  DetailViewController.h
//  NFL
//
//  Created by Mike_Gazdich_rMBP on 10/20/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UISplitViewControllerDelegate, UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *websiteURL;
@property (nonatomic, strong) NSArray *dataForSelectedTeam;

@end
