//
//  ScoreLabel.m
//  SlotMania
//
//  Created by admin on 12/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreLabel.h"


@implementation ScoreLabel

-(id) init {
    if (self = [super init]) {
    }
    return self;
}

+ (id) createWithVal:(int)val {
    ScoreLabel* score = [ScoreLabel node];
    [score createLabel: val];
    return score;
}

-(void) createLabel: (int) val{
    m_nValCoin = val;
    m_lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", val] fontName:@"Thonburi" fontSize:iDevSize(16.0f)];
    [self addChild:m_lbl];
}

-(void) setVal:(int)nCurVal prevVal:(int)nPrevVal {
    m_nValCoin = nPrevVal;
    if (nCurVal > m_nValCoin) {
        m_nDestVal = nCurVal;
        [self setValWithEffect:m_nValCoin dest:nCurVal];
    }
    else
        [m_lbl setString:[NSString stringWithFormat:@"%d", nCurVal]];
}

-(void) setValWithEffect:(int)valCoin dest:(int)nDestVal{
    m_nDestVal = nDestVal;
    float fFarme = 30.0f;
    if ((m_nDestVal - m_nValCoin) < 60) {
        m_nIncrease = 1;
        fFarme = (m_nDestVal - m_nValCoin) / 2;
    }
    else
        m_nIncrease = (m_nDestVal - m_nValCoin) / 60;
    [self schedule:@selector(onTime) interval:1.0f / fFarme];
}

-(void) onTime {
    m_nValCoin += m_nIncrease;
    if (m_nValCoin > m_nDestVal) {
        m_nValCoin = m_nDestVal;
        [m_lbl setString :[NSString stringWithFormat:@"%d",m_nValCoin]];
        [self unscheduleAllSelectors];
    }
    else
        [m_lbl setString :[NSString stringWithFormat:@"%d",m_nValCoin]];
}

-(void) dealloc {
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

@end
