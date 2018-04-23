#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Workout)

- (void)workout_getWorkoutSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)workout_startWatchApp:(NSDictionary *)configuration callback:(RCTResponseSenderBlock)callback;

@end

