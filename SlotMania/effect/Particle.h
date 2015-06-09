//
//  Particle.h
//  SlotMania
//
//  Created by admin on 11/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SCSprite.h"

@interface Particle : SCSprite {
    CCAnimate*      m_animWalkFront; 
}

+(id) startAnim: (int) charIndex;
-(void) initMember: (int) charIndex;
-(void) remove;

@end

