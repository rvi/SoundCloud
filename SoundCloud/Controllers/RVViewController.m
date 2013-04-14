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

// API
#import "RVTracksAPI.h"
#import "RVImageAPI.h"

// View
#import "RVTrackCell.h"

@interface RVViewController ()

@property (nonatomic, strong) NSArray *tracks;

// API
-(void)retrieveWaveforms;

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
}



/**************************************************************************************************/
#pragma mark - Drag gesture delegate


- (void)moveTo:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self.view];
    
    //DLog(@"touch : %@",[NSValue valueWithCGPoint:point]);
    
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

/**************************************************************************************************/
#pragma mark - Actions

- (IBAction)login:(id)sender
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
