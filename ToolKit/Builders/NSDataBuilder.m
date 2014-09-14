/**
 * @file    NSDataBuilder.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

@interface NSDataBuilder ()

@property (nonatomic, copy) void(^completionBlock)(id);
@property (nonatomic, strong) NSMutableData* data;

@end

@implementation NSDataBuilder

- (void)buildFromURLRequest:(NSMutableURLRequest*)request withCompletionBlock:(void(^)(NSData*))block;{
    
    static NSURLSessionConfiguration *configuration;
    static dispatch_once_t onceToken; // <- Makes sure that the instance is initiated once and only once (threads!)
    dispatch_once(&onceToken, ^{
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.URLCache = NULL;
    });
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request]; // or downloadtask, or upload task!!
    
    _completionBlock = block;
   
    [dataTask resume];
    
}

- (NSMutableURLRequest *)JSONMutableURLRequest{
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.HTTPShouldUsePipelining = YES;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    return request;
}

#pragma mark - NSURLSessionTaskDelegate

 - (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
     self.determinateProgress(100);
     
     self.error = error;
     
     _completionBlock(_data);
 }

/*

– URLSession:task:didReceiveChallenge:completionHandler:
– URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:
– URLSession:task:needNewBodyStream:
– URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:

*/

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    _data = [NSMutableData dataWithCapacity:0];
    self.indeterminateProgress(0);
    self.determinateProgress(0);
    completionHandler(NSURLSessionResponseAllow);
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [_data appendData:data];
    self.indeterminateProgress([_data length]);
}

/*
#pragma mark - NSURLSessionDownloadDelegate
– URLSession:downloadTask:didResumeAtOffset:expectedTotalBytes:  required method
– URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:  required method
– URLSession:downloadTask:didFinishDownloadingToURL:  required method
*/
@end
