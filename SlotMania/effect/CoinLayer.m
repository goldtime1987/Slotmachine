//
//  CoinLayer.m
//  SlotMania
//
//  Created by Sin on 1/25/13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoinLayer.h"
#import "Common.h"
#import "ResourceManager.h"

@implementation CoinLayer

-(id) init {
    if (self = [super init]) {
        [self initVar];
        [self initImg];
        [self schedule:@selector(firstAction) interval:1.0f / 60.0f];
    }
    return self;
}

-(void) initVar {
    int nVelXRes = iDevPixelX(3.0f);
    int nVelYRes = iDevPixelY(5.0f);
    m_fGravity  = iDevSize(3.0f);
    m_fVx       = iDevPixelX(5.0f) + (float)(rand() % nVelXRes);
    m_fVy       = iDevPixelY(20.0f) + (float)(rand() % nVelYRes);
    m_nTime     = 0;
    self.scale = 0.1;
}

-(void) initImg {
    NSString* strFileName = [[ResourceManager sharedResourceManager] makeFileName:@"coin_1" ext:@"png"];
    m_sprImg = [CCSprite spriteWithSpriteFrameName:strFileName];
    [self addChild:m_sprImg];
}

-(void) firstAction {
    m_nTime++;
    m_fVy -= m_fGravity;
    [self setPosition: ccpAdd([self position], CGPointMake(m_fVx, m_fVy))];
    self.scale += 0.02f;
    if ([self position].y < iDevPixelY(30)) {
        m_nTime = 0;
        m_fVy = - 1.7f * m_fVy;//iDevPixelY(30);
        m_fVx = - ([self position].x - iDevPixelX(120.0f)) / ((float)(SCREEN_HEIGHT - iDevPixelY(40.0f)) / m_fVy);
        [self unschedule:@selector(firstAction)];
        [self schedule:@selector(restAction) interval:1.0f / 60.0f];
    }
}

-(void) restAction {
    m_nTime++;
    if (m_nTime > 5) {
        [self unschedule:@selector(restAction)];
        [self schedule:@selector(secondAction) interval:1.0f / 60.0f];
    }
}

-(void) secondAction {
    //[self setPosition: ccpAdd([self position], CGPointMake(-iDevPixelX(18), iDevPixelY(30)))];
    //float fVy = //m_fVy * m_nTime - (m_fGravity * m_nTime * m_nTime) / 2;
    [self setPosition: ccpAdd([self position], CGPointMake(m_fVx, m_fVy))];
    if ([self position].y > SCREEN_HEIGHT - iDevPixelY(40)) {
        m_sprImg.visible = false;
        [self unschedule:@selector(secondAction)];
    }
}

-(void) dealloc {
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
