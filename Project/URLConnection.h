

#import <Foundation/Foundation.h>

@interface URLConnection : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
NSMutableData *responseData;
    NSDictionary *JSON;
      NSString *responseString;
}
enum HTTP_METHOD {GET,PUT,POST,DELETE};
typedef  void (^didResponseReceived)(NSString *respose);
@property didResponseReceived globalResponseBlock;
@property(nonatomic,strong) NSString *responseString ;
-(void)initRequestWithURL:(NSString*)URLString method:(enum HTTP_METHOD)method onResponseReceived:(didResponseReceived) responseBlock;
@end
