#import "IDPHuman.h"
#import "IDPRandom.h"

#import "NSObject+IDPCategory.h"

static const char kIDPAgeMax = 100;
static const NSRange kIDPWeightRange = { 1, 150 };

@interface IDPHuman ()
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, assign)   NSUInteger      age;
@property (nonatomic, assign)   NSUInteger      weight;
@property (nonatomic, retain)   NSMutableArray  *mutableChildren;

@end

@implementation IDPHuman

@dynamic children;

+ (instancetype)objectWithName:(NSString *)name {
    return [[[IDPHuman alloc] initWithName:name] autorelease];
}

- (NSArray *) children {
    return[[self.mutableChildren copy] autorelease];
}

- (void)dealloc {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    
    self.name = name;
    self.age = IDPRandomTillNumber(kIDPAgeMax);
    self.weight = IDPRandomWithRange(kIDPWeightRange);
    self.mutableChildren = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)sayHi {
    NSLog(@"%@Hi", self.name);
    NSMutableArray *array = self.mutableChildren;
    if (array) {
        for (id temp in array) {
            [temp sayHi];
        }
    }
}

- (void)performGenderSpecificOperation {
    
}

#pragma mark -
#pragma mark Private Methods


- (void)addChildWithName:(NSString *)name {
    IDPHuman *baby = [[[IDPHuman alloc] initWithName:name] autorelease];
    [self.mutableChildren addObject:baby];
}

- (void)removeChild:(id)child {
    [self.mutableChildren removeObject:child];
}

@end
