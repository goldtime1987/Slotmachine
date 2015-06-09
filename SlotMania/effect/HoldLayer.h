//
//  HoldLayer.h
//  SlotMania
//
//  Created by admin on 12/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SCSprite.h"

@interface HoldLayer : SCSprite {
    CCSprite* m_sprHold;
    BOOL m_bShowAction;
    BOOL m_bHideAction;
    int m_nIncrease;
}
-(void) initVariables;
-(void) initImg;
-(void) appear;
-(void) disappear;
@end
