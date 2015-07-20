/**
 * @file    TKSerializer.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKSerializer.h"

@implementation TKStringSerializer

- (NSData *)serialize:(NSString *)string withEncoding:(NSStringEncoding)encoding{
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData*)serialize:(NSString*)string{
    if (self.encoding) {
        return [self serialize:string withEncoding:self.encoding];
    }else{
        return [self serialize:string withEncoding:NSUTF8StringEncoding];
    }

}

- (NSString*)unserialize:(NSData*)data{
    if (self.encoding) {
        return [self unserialize:data withEncoding:self.encoding];
    }else{
        return [self unserialize:data withEncoding:NSUTF8StringEncoding];
    }
}

- (NSString*)unserialize:(NSData*)data withEncoding:(NSStringEncoding)encoding{
    return [[NSString alloc] initWithData:data encoding:encoding];
}

@end

@implementation TKJSONSerializer

- (NSData*)serialize:(id)jsonObject{
    return [NSJSONSerialization dataWithJSONObject:jsonObject options:(NSJSONWritingOptions)0 error:nil];
}

- (id)unserialize:(NSData*)data{
    if (self.encoding) {
        return [self unserialize:data withEncoding:self.encoding];
    }else{
        return [self unserialize:data withEncoding:NSUTF8StringEncoding];
    }
    
}

- (id)unserialize:(NSData*)data withEncoding:(NSStringEncoding)encoding{
    TKStringSerializer* serializer = [TKStringSerializer new];
    if (self.encoding) {
        serializer.encoding = _encoding;
    }
    
    return [NSJSONSerialization JSONObjectWithData:[[serializer unserialize:data] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}

@end

@implementation TKPropertyListSerializer

- (NSData*)serialize:(id)propertyList{
    return [NSPropertyListSerialization dataWithPropertyList:propertyList format:NSPropertyListXMLFormat_v1_0 options:0 error:nil];
}

- (id)unserialize:(NSData*)data{
    return [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:nil];
}

@end

