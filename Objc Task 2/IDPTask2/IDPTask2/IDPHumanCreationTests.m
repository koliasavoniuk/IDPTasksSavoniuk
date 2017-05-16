#import"IDPHumanCreationTests.h"
#import "IDPHuman.h"
#import "IDPMale.h"
#import "IDPFemale.h"
#import "IDPRandom.h"

#import "NSObject+IDPCategory.h"
#import "NSArray+IDPCategory.h"

static const char countObjects = 7;

typedef id(^IDPObject)();

#pragma mark -
#pragma mark Private Declaration

static
void IDPObjCHumanCreationTesting();

#pragma mark -
#pragma mark Public Implementation

void IDPObjCHumanCreationTests() {
    IDPObjCHumanCreationTesting();
}

#pragma mark -
#pragma mark Private Implementation

void IDPObjCHumanCreationTesting() {
    IDPObject generator = ^{
        return IDPRandomBool() ? [IDPMale object] : [IDPFemale object];
    };
    
    [NSObject objectsWithCount:countObjects];
    [NSArray objectsWithCount:countObjects factoryBlock:generator];
}
