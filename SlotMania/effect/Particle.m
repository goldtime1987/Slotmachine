//
//  Particle.m
//  SlotMania
//
//  Created by admin on 11/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Particle.h"
#import "Common.h"
#import "ResourceManager.h"


@implementation Particle

+(id) startAnim: (int)charIndex {
    Particle* particle = [Particle node];
    [particle initMember:charIndex];
    return particle;
}

-(void) initMember: (int)charIndex {
    NSString* strName = [NSString stringWithFormat: @"%d00",charIndex % 2 + 1];
    m_animWalkFront = [[Common getAnimate: strName count: 45 delay: 0.06] retain];
    [self runAction: [CCRepeatForever actionWithAction: m_animWalkFront]];    
}
-(void) remove {
    [m_animWalkFront release];
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup: YES];
}
-(void) dealloc {
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

@end
