//
//  RVViewController.m
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVViewController.h"

#import "SCUI.h"

#import "RVTrack.h"

@interface RVViewController ()

@property (nonatomic, strong) NSMutableArray *tracks;

@end

@implementation RVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tracks = [NSMutableArray array];
    SCAccount *account = [SCSoundCloud account];
    
    DLog(@"account %@", account);
    
    if (account)
    {
        SCRequestResponseHandler handler;
        handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
            NSError *jsonError = nil;
            NSJSONSerialization *jsonResponse = [NSJSONSerialization
                                                 JSONObjectWithData:data
                                                 options:0
                                                 error:&jsonError];
            if (!jsonError && [jsonResponse isKindOfClass:[NSArray class]]) {

                DLog(@"response : %@",jsonResponse);
                for (NSDictionary *dict in jsonResponse)
                {
                    if ([dict isKindOfClass:[NSDictionary class]])
                    {
                        RVTrack *track = [RVTrack trackWithJSONDict:dict];
                        [self.tracks addObject:track];
                    }
                }
                
                DLog(@" tracks count : %d",[self.tracks count]);
            }            
        };
     
        NSString *resourceURL = @"https://api.soundcloud.com/tracks.json";
        [SCRequest performMethod:SCRequestMethodGET
                      onResource:[NSURL URLWithString:resourceURL]
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:handler];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) login:(id) sender
{
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Canceled!");
        } else if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            NSLog(@"Done!");
        }
    };
    
    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
        SCLoginViewController *loginViewController;
        
        loginViewController = [SCLoginViewController
                               loginViewControllerWithPreparedURL:preparedURL
                               completionHandler:handler];

        [self presentViewController:loginViewController animated:YES completion:NULL];
    }];
}


@end
