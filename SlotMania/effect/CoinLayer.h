//
//  CoinLayer.h
//  SlotMania
//
//  Created by Sin on 1/25/13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SCSprite.h"

@interface CoinLayer : SCSprite {
    CCSprite*   m_sprImg;
    float       m_fVx;
    float       m_fVy;
    float       m_fGravity;
    int         m_nTime;
}

- (void) initVar;
- (void) initImg;

@end
