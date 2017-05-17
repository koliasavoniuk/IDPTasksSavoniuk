//
//  IDPCashFlow.h
//  Objc Task3
//
//  Created by Student002 on 5/11/17.
//  Copyright © 2017 Student002. All rights reserved.
//

@protocol IDPCashFlow <NSObject>
@property (nonatomic, readonly) NSUInteger money;

@optional
- (NSUInteger)giveMoney;
- (void)takeMoney:(NSUInteger)money;
- (void)takeMoneyFromObject:(id<IDPCashFlow>)object;

@end
