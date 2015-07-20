/**
 * @file    TKTask.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKTask.h"
#import "TKQueue.h"
#import "TKConcurrentQueue.h"

struct BlockLiteral {
    void *isa; // initialized to &_NSConcreteStackBlock or &_NSConcreteGlobalBlock
    int flags;
    int reserved;
    void (*invoke)(void *, ...);
    struct block_descriptor {
        unsigned long int reserved;	// NULL
        unsigned long int size;         // sizeof(struct Block_literal_1)
        // optional helper functions
        void (*copy_helper)(void *dst, void *src);     // IFF (1<<25)
        void (*dispose_helper)(void *src);             // IFF (1<<25)
        // required ABI.2010.3.16
        const char *signature;                         // IFF (1<<30)
    } *descriptor;
    // imported variables
};

typedef NS_ENUM(NSUInteger, BlockDescriptionFlags)
{
    BlockDescriptionFlagsHasCopyDispose = (1 << 25),
    BlockDescriptionFlagsHasCtor = (1 << 26), // helpers have C++ code
    BlockDescriptionFlagsIsGlobal = (1 << 28),
    BlockDescriptionFlagsHasStret = (1 << 29), // IFF BLOCK_HAS_SIGNATURE
    BlockDescriptionFlagsHasSignature = (1 << 30)

};

static inline NSMethodSignature* NSMethodSignatureForBlock(id block) {
    
    BlockDescriptionFlags flags;
    unsigned long int size;
    
    struct BlockLiteral *blockRef = (__bridge struct BlockLiteral *)block;
    flags = blockRef->flags;
    size = blockRef->descriptor->size;
    
    if (!flags | !BlockDescriptionFlagsHasSignature) return nil;
    
    
    void *signatureLocation = blockRef->descriptor;
    signatureLocation += sizeof(unsigned long int);
    signatureLocation += sizeof(unsigned long int);
    
    if (flags & BlockDescriptionFlagsHasCopyDispose) {
        signatureLocation += sizeof(void(*)(void *dst, void *src));
        signatureLocation += sizeof(void (*)(void *src));
    }
    
    const char *signature = (*(const char **)signatureLocation);
    return [NSMethodSignature signatureWithObjCTypes:signature];
}

////////////////////////////////////////////////////////////////////////////////

@implementation TKTask

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    self.blockToExecute = (id)^{};
    self.isMain = NO;
    
    return self;
}

- (TKTask*(^)())run
{
    return ^(TKTask*(^blockToExecute)(id)){
        TKTask *task = [TKTask new];
        self.nextTask = task;
        task.blockToExecute = blockToExecute;
        task.isMain = YES;
        return task;
    };
}

- (TKTask*(^)())dispatch
{
    return ^(TKTask*(^blockToExecute)(id)){
        TKTask *task = [TKTask new];
        self.nextTask = task;
        task.blockToExecute = blockToExecute;
        task.isMain = NO;
        return task;
    };
}

-(void(^)(id))catch
{
    return ^(void(^errorBlock)(NSError*)){
        _errorBlock = errorBlock;
    };
}

- (void)execute{
    
    if (_isMain) {
        [TKQueue run:[self encapsulateBlock:_blockToExecute]];
    }else{
        [TKConcurrentQueue dispatch:[self encapsulateBlock:_blockToExecute]];
    }
}

- (void(^)())encapsulateBlock:(id(^)())block{
    return ^{
        
        id returnValue = [self executeBlock:_blockToExecute];
        
        if (![returnValue isKindOfClass:[NSError class]]) {
            if (_nextTask) {
                _nextTask.param = returnValue;
                [_nextTask execute];
            }
        }else{
            [self abortWithError:returnValue];
        }
    };
}

- (id)executeBlock:(id(^)())block{
    
    id returnValue = nil;
    NSMethodSignature *signature = NSMethodSignatureForBlock(_blockToExecute);
    if(signature)
    {
        const char rtype = signature.methodReturnType[0];
        
        if(rtype == 'v') {
            ((void(^)())_blockToExecute)(_param);
        } else {
            returnValue = _blockToExecute(_param);
        }
    }
    
    return returnValue;
}

- (void)abortWithError:(NSError*)error{
    if (_errorBlock) {
        _errorBlock();
    }else{
        if (_nextTask) {
            [_nextTask abortWithError:error];
        }else{
            NSLog(@"%@", error.description);
        }
    }
}

@end
