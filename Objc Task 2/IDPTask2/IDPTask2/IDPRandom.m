#import "IDPRandom.h"

NSUInteger IDPRandomTillNumber(NSUInteger number) {
    return arc4random_uniform((uint32_t)number + 1);
}

BOOL IDPRandomBool() {
    return IDPRandomTillNumber(1);
}

NSUInteger IDPRandomWithRange(NSRange range) {
    return IDPRandomTillNumber(range.length) + range.location;
}
