#import <Foundation/Foundation.h>
#import "VSRecorder.h"

@interface VSRecordSessionManager : NSObject

- (void)saveRecordSession:(VSRecordSession *)recordSession;

- (void)removeRecordSession:(VSRecordSession *)recordSession;

- (BOOL)isSaved:(VSRecordSession *)recordSession;

- (void)removeRecordSessionAtIndex:(NSInteger)index;

- (NSArray *)savedRecordSessions;

+ (VSRecordSessionManager *)sharedInstance;

@end
