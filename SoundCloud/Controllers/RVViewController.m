//
//  RVViewController.m
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVViewController.h"

#import "SCUI.h"

// Model
#import "RVTrack.h"
#import "RVUser.h"

// API
#import "RVTracksAPI.h"
#import "RVImageAPI.h"
#import "RVUserAPI.h"

// View
#import "RVTrackCell.h"

@interface RVViewController ()

@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) RVUser *user;


-(void)refreshUI;

// API
- (void)retrieveWaveforms;
- (void)retrieveTracks;
- (void)retrieveInfosForUser;

@end

@implementation RVViewController

/**************************************************************************************************/
#pragma mark - View management

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RVDragGestureRecognizer *dragGesture = [[RVDragGestureRecognizer alloc] init];
    dragGesture.dragDelegate = self;
    [self.tracksView addGestureRecognizer:dragGesture];
    
    SCAccount *account = [SCSoundCloud account];
    
    DLog(@"account %@", account);

    if (account)
    {
        [self retrieveTracks];
        [self retrieveInfosForUser];
        
    }
}

-(void)refreshUI
{
    SCAccount *account = [SCSoundCloud account];
    NSString *title = account == nil ? @"LOGIN" : @"LOGOUT";
    [self.loginButton setTitle:title forState:UIControlStateNormal];
    
    NSString *welcomeTitle = self.user.username != nil ? [self.user.username uppercaseString] : @"";
    self.welcomeLabel.text = welcomeTitle;
    
    UIImageView *userPicture = [[UIImageView alloc] initWithFrame:self.userPictureImageView.frame];
    [userPicture setContentMode:UIViewContentModeScaleAspectFit];
   
    if (self.user.picture)
    {
        userPicture.image = self.user.picture;
    }
    else
    {
        userPicture.image = [UIImage imageNamed:@"SoundCloud_logo (1).png"];
    }
    
    
    
    [UIView transitionFromView:self.userPictureImageView
                        toView:userPicture
                      duration:0.3
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                        self.userPictureImageView = userPicture;
                    }];
    
}

/**************************************************************************************************/
#pragma mark - Drag gesture delegate


- (void)moveTo:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self.view];
        
    point.y = point.y < 0 ? 0 : point.y;
    
    if (point.y < CGRectGetHeight(self.view.frame) - 44)
    {
        CGRect trackViewFrame = self.tracksView.frame;
        trackViewFrame.origin.y = point.y;
        self.tracksView.frame = trackViewFrame;
    }
}

- (void)dragEndedGoingTop:(BOOL)isGoingTop
{
    CGFloat lastPosition = isGoingTop ? 0 : CGRectGetHeight(self.view.frame) - 44;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect trackViewFrame = self.tracksView.frame;
        trackViewFrame.origin.y = lastPosition;
        self.tracksView.frame = trackViewFrame;
    }];
}

/**************************************************************************************************/
#pragma mark - API

-(void)retrieveWaveforms
{
    for (RVTrack *track in self.tracks)
    {
        [RVImageAPI getImageAtURL:track.waveFormURL
                        succeeded:^(UIImage *image) {

                            track.waveform = image;
                            
                        } failed:^(NSError *error) {
                            DLog(@"fail to get waveform image : %@",error);
                        }];
    }
}
- (void)retrieveTracks
{
    [RVTracksAPI getTracksSucceeded:^(NSArray *inTracks) {
        
        // TODO: remove all 44
        CGFloat yTracksView = self.view.frame.size.height - 44;
        [self.tracksView setFrame:CGRectMake(0,
                                             yTracksView,
                                             CGRectGetWidth(self.tracksView.frame),
                                             CGRectGetHeight(self.tracksView.frame))];
        
        [self.view addSubview:self.tracksView];
        self.tracks = inTracks;
        [self retrieveWaveforms];
        [self.tableView reloadData];
        
    } Failed:^(NSError *error) {
        DLog(@"fail to get tracks : %@",error);
    }];
}

- (void)retrieveInfosForUser
{
    [RVUserAPI getInfoForUserSucceeded:^(RVUser *inUser) {
        
        self.user = inUser;
        [self getPictureForLoggedUser];
    } failed:^(NSError *error) {
        DLog(@"fail to retrieve user : %@", error);
    }];
}

- (void)getPictureForLoggedUser
{
    [RVImageAPI getImageAtURL:self.user.pictureURL
                    succeeded:^(UIImage *image) {
                        
                        self.user.picture = image;
                        [self refreshUI];
                        
                    } failed:^(NSError *error) {
                        DLog(@"fail to get waveform image : %@",error);
                    }];
}

- (void)login
{
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        
        if (SC_CANCELED(error)) {
            [self refreshUI];
            NSLog(@"Canceled!");
        } else if (error) {
            [self refreshUI];
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            NSLog(@"Login Done!");
            [self retrieveInfosForUser];
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

/**************************************************************************************************/
#pragma mark - Actions

- (IBAction)login:(id)sender
{
    if ([SCSoundCloud account])
    {
        [SCSoundCloud removeAccess];
        self.user = nil;
        [self refreshUI];
    }
    else
    {
        [self login];
    }
}
/**************************************************************************************************/
#pragma mark - UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tracks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusableID = [RVTrackCell reusableIdentifier];
    RVTrackCell *cell = (RVTrackCell *)[tableView dequeueReusableCellWithIdentifier:reusableID];
    
    if (!cell)
    {
        cell = [RVTrackCell cell];
    }

    if (indexPath.row < [self.tracks count])
    {
        RVTrack *track = [self.tracks objectAtIndex:indexPath.row];
        [cell updateUIWithTrack:track];
    }
    
    return cell;
}

/**************************************************************************************************/
#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RVTrackCell heightOfRow];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
