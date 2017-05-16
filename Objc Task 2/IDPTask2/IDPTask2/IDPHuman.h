#import <Foundation/Foundation.h>

@interface IDPHuman : NSObject
@property(nonatomic, readonly)          NSString        *name;
@property(nonatomic, readonly)          NSUInteger      age;
@property(nonatomic, readonly)          NSUInteger      weight;
@property(nonatomic, copy, readonly)    NSArray         *children;

+ (instancetype)objectWithName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name ;
- (void)sayHi;

- (void)addChildWithName:(NSString *)name;
- (void)removeChild:(id)child;

- (void)performGenderSpecificOperation;

@end
