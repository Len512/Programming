//
//  BNRLogger.h
//  Callbacks
//

#import <Foundation/Foundation.h>
// BNRLogger will implement methods from the NSURLConnectionDelegate
// and NSURLConnectionDataDelegate protocols
@interface BNRLogger : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
// In an asynchronous connection we need an instance of NSMutableData
{
    NSMutableData *_incomingData;
}
@property (nonatomic) NSDate *lastTime;
- (NSString *) lastTimeString;
// Action method to be triggered by the times
// Action methods always take one argument - the object that sends the action message
- (void) updateLastTime: (NSTimer *) t;
// BNR should respond to these messages as the delegate of the NSURLConnection protocols
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void) connectionDidFinishLoading:(NSURLConnection *)connection;
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
@end
