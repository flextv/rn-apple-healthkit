//
//  RCTAppleHealthKit+Methods_Workout.m
//  RCTAppleHealthKit

#import "RCTAppleHealthKit+Methods_Workout.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Workout)

- (void)workout_getWorkoutSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];


    [self fetchWorkoutSamplesForPredicate:predicate limit:limit
    completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting workout samples: %@", error);
            callback(@[RCTMakeError(@"error getting workout samples", nil, nil)]);
            return;
        }
    }];
}

- (void)workout_startWatchApp:(NSDictionary *)configuration callback:(RCTResponseSenderBlock)callback
{
  HKWorkoutConfiguration* config = [[HKWorkoutConfiguration alloc] init];
  config.activityType = HKWorkoutActivityTypeHighIntensityIntervalTraining;
  config.locationType = HKWorkoutSessionLocationTypeIndoor;

  [self.healthStore startWatchAppWithWorkoutConfiguration:config completion:^(BOOL success, NSError * _Nullable error) {
    if (success || error == nil) {
      callback(@[[NSNull null]]);
    } else {
      callback(@[RCTMakeError(error.localizedDescription, nil, nil)]);
    }
  }];
}


@end
