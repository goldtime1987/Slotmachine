//
//  ScoreLabel.h
//  SlotMania
//
//  Created by admin on 12/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SCSprite.h"

@interface ScoreLabel : CCSprite {
    CCLabelTTF* m_lbl;
    int m_nValCoin;
    int m_nDestVal;
    int m_nIncrease;
}

+ (id) createWithVal:(int)nVal;
- (void) createLabel:(int)nVal;
- (void) setVal:(int) nCurVal prevVal:(int)nPrevVal;
- (void) setValWithEffect:(int)nCoinF dest:(int)nCoinL;
@end
