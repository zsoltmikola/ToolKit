#import <CommonCrypto/CommonDigest.h>
#import "NSString+ToolKit.h"

static inline NSString *NSStringCCHashFunction(unsigned char *(function)(const void *data, CC_LONG len, unsigned char *md), CC_LONG digestLength, NSString *string)
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[digestLength];
    
    function(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:digestLength * 2];
    
    for (int i = 0; i < digestLength; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@implementation NSString (Hashes)

- (NSString *)md5
{
    return NSStringCCHashFunction(CC_MD5, CC_MD5_DIGEST_LENGTH, self);
}

- (NSString *)sha1
{
    return NSStringCCHashFunction(CC_SHA1, CC_SHA1_DIGEST_LENGTH, self);
}

- (NSString *)sha224
{
    return NSStringCCHashFunction(CC_SHA224, CC_SHA224_DIGEST_LENGTH, self);
}

- (NSString *)sha256
{
    return NSStringCCHashFunction(CC_SHA256, CC_SHA256_DIGEST_LENGTH, self);
}

- (NSString *)sha384
{
    return NSStringCCHashFunction(CC_SHA384, CC_SHA384_DIGEST_LENGTH, self);
}
- (NSString *)sha512
{
    return NSStringCCHashFunction(CC_SHA512, CC_SHA512_DIGEST_LENGTH, self);
}

+ (NSString*)stringWithRandomStringWithLength:(NSUInteger)length{
    
    if (!length) {
        return @"";
    }
    
    static NSArray* array;
    if (!array) {
        array = @[@"euismod", @"rutrum", @"dignissim", @"ipsum", @"convallis", @"dui", @"purus", @"vulputate", @"a", @"erat", @"urna", @"gravida", @"ullamcorper", @"tristique", @"laoreet", @"scelerisque", @"velit", @"elementum", @"conubia", @"sit", @"aptent", @"nullam", @"mus", @"netus", @"mollis", @"pharetra", @"montes", @"etiam", @"cursus", @"egestas", @"lacinia", @"mi", @"habitasse", @"eros", @"faucibus", @"aliquet", @"posuere", @"auctor", @"volutpat", @"ridiculus", @"natoque", @"mauris", @"pulvinar", @"platea", @"dapibus", @"efficitur", @"facilisis", @"venenatis", @"senectus", @"eleifend", @"vestibulum", @"vitae", @"nam", @"donec", @"vel", @"primis", @"ultricies", @"nascetur", @"aliquam", @"ornare", @"est", @"commodo", @"duis", @"quis", @"finibus", @"ac", @"ad", @"tortor", @"at", @"nunc", @"felis", @"inceptos", @"elit", @"orci", @"sagittis", @"porta", @"adipiscing", @"penatibus", @"molestie", @"odio", @"dictumst", @"cum", @"taciti", @"hendrerit", @"vivamus", @"aenean", @"amet", @"lorem", @"class", @"accumsan", @"maximus", @"sapien", @"blandit", @"morbi", @"parturient", @"facilisi", @"justo", @"dolor", @"risus", @"magna", @"tellus", @"ante", @"quam", @"nostra", @"quisque", @"dis", @"mattis", @"praesent", @"sed", @"sem", @"ultrices", @"turpis", @"leo", @"semper", @"litora", @"fames", @"et", @"eu", @"tempor", @"ex", @"magnis", @"cubilia", @"cras", @"dictum", @"fermentum", @"curae", @"nisi", @"nisl", @"malesuada", @"feugiat", @"massa", @"fusce", @"sociis", @"integer", @"diam", @"ut", @"lectus", @"consectetur", @"ligula", @"arcu", @"placerat", @"sociosqu", @"condimentum", @"congue", @"consequat", @"metus", @"maecenas", @"nec", @"suscipit", @"libero", @"iaculis", @"augue", @"tempus", @"bibendum", @"pellentesque", @"curabitur", @"eget", @"phasellus", @"pretium", @"neque", @"nibh", @"tincidunt", @"potenti", @"viverra", @"interdum", @"lobortis", @"enim", @"nulla", @"hac", @"varius", @"id", @"habitant", @"in", @"suspendisse", @"torquent", @"per", @"fringilla", @"imperdiet", @"vehicula", @"rhoncus", @"himenaeos", @"sodales", @"luctus", @"lacus", @"sollicitudin", @"non", @"porttitor", @"proin"];
    }
    
    NSString* randomString = array[arc4random_uniform(array.count)];
    NSMutableArray* returnArray = [NSMutableArray arrayWithObject: randomString];
    NSUInteger generatedLength = randomString.length;
    
    while(generatedLength < length){
        randomString = array[arc4random_uniform(array.count)];
        [returnArray addObject:randomString];
        generatedLength = generatedLength + randomString.length + 1;
    }
    
    return [[returnArray componentsJoinedByString:@" "] substringToIndex:length];
}

@end
