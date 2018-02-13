

#import "URLConnection.h"

@implementation URLConnection

-(void)initRequestWithURL:(NSString*)URLString method:(enum HTTP_METHOD)method onResponseReceived:(didResponseReceived) responseBlock{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                             [NSURL URLWithString:URLString]];
    //Though the NSURLConnection is deprecated, we are using as mentioned in document.
        NSURLConnection *urlConnection = [NSURLConnection alloc];
    [urlConnection initWithRequest:request delegate:self];
    _globalResponseBlock = responseBlock;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [responseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        _globalResponseBlock(responseString);
}
@end
