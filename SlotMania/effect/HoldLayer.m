//
//  HoldLayer.m
//  SlotMania
//
//  Created by admin on 12/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HoldLayer.h"
#import "ResourceManager.h"

@implementation HoldLayer

-(id) init {
    if (self = [super init]) {
        [self initImg];
    }
    return self;
}

-(void) initVariables {
    m_bShowAction = false;
    m_bHideAction = false;
    m_nIncrease = 0;
}

-(void) initImg {
    NSString* strFileName = [[ResourceManager sharedResourceManager] makeFileName:@"hold" ext:@"png"];
    m_sprHold = [CCSprite spriteWithSpriteFrameName:strFileName];
    [self addChild:m_sprHold];
    m_sprHold.opacity = 0;
    //sprHold.visible = false;
}

-(void) appear {
    m_nIncrease = 30;
    if (!m_bShowAction) {
        m_bShowAction = true;
        m_bHideAction = false;
        [self unschedule:@selector(onTime)];
        [self schedule:@selector(onTime) interval:1.0f / 60.0f];
    }    
}

-(void) disappear {
    m_nIncrease = -30;
    if (!m_bHideAction) {
        m_bHideAction = true;
        m_bShowAction = false;
        [self unschedule:@selector(onTime)];
        [self schedule:@selector(onTime) interval:1.0f / 60.0f];
    }
}

-(void) onTime {
    if ( (m_sprHold.opacity+m_nIncrease) < 0)
        m_sprHold.opacity = 0;
    else if((m_sprHold.opacity+m_nIncrease) > 255)
        m_sprHold.opacity = 255;
    else
        m_sprHold.opacity += m_nIncrease;
    if (m_sprHold.opacity == 0 || m_sprHold.opacity == 255) {
        m_nIncrease = 0;
        [self unschedule:@selector(onTime)];
    }
}

-(void) dealloc {
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
