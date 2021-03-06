//
//  MPTableViewCellImpressionTracker.m
//  Copyright (c) 2014 MoPub. All rights reserved.
//

#import "MPTableViewCellImpressionTrackerMF.h"

@interface MPTableViewCellImpressionTrackerMF ()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) id<MPTableViewCellImpressionTrackerDelegateMF> delegate;
@property (nonatomic, retain) NSTimer *timer;

@end

#define MPTableViewCellImpressionTrackerTimeInterval 0.25

@implementation MPTableViewCellImpressionTrackerMF

- (id)initWithTableView:(UITableView *)tableView delegate:(id<MPTableViewCellImpressionTrackerDelegateMF>)delegate
{
    self = [super init];
    if (self) {
        _tableView = [tableView retain];
        _delegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [_timer invalidate];
    [_timer release];
    _delegate = nil;
    [super dealloc];
}

- (void)startTracking
{
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:MPTableViewCellImpressionTrackerTimeInterval target:self selector:@selector(tick:) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTracking
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Internal

- (void)tick:(NSTimer *)timer
{
    NSMutableArray *indexPathsForVisibleRows = [[[self.tableView indexPathsForVisibleRows] mutableCopy] autorelease];
    NSUInteger rowCount = [indexPathsForVisibleRows count];

    // For our purposes, "visible" means that more than half of the cell is on-screen.
    // Filter -indexPathsForVisibleRows to fit this definition.
    if (rowCount > 1) {
        NSIndexPath *firstVisibleRow = [indexPathsForVisibleRows objectAtIndex:0];
        if (![self isMajorityOfCellAtIndexPathVisible:firstVisibleRow]) {
            [indexPathsForVisibleRows removeObjectAtIndex:0];
        }

        NSIndexPath *lastVisibleRow = [indexPathsForVisibleRows lastObject];
        if (![self isMajorityOfCellAtIndexPathVisible:lastVisibleRow]) {
            [indexPathsForVisibleRows removeLastObject];
        }
    }

    if ([indexPathsForVisibleRows count]) {
        [self.delegate tracker:self didDetectVisibleRowsAtIndexPaths:[NSArray arrayWithArray:indexPathsForVisibleRows]];
    }
}

- (BOOL)isMajorityOfCellAtIndexPathVisible:(NSIndexPath *)indexPath
{
    CGRect cellRect = [self.tableView rectForRowAtIndexPath:indexPath];
    CGPoint cellRectMidY = CGPointMake(0, CGRectGetMidY(cellRect));
    return CGRectContainsPoint(self.tableView.bounds, cellRectMidY);
}

@end
