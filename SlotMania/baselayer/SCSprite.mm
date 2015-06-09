//
//  ScaleSprite.m
//  OutZone_iphone
//
//  Created by admin on 1/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SCSprite.h"
#import "DeviceSettings.h"

@implementation SCSprite
-(id) init {
    if((self = [super init])){
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        if (winSize.width == 480 && CC_CONTENT_SCALE_FACTOR() != 2.0f) {
            self.scaleX *= 0.5f;
            self.scaleY *= 0.5f;
            //m_fScaleX = 0.5f;
            //m_fScaleY = 0.5f;
        }
        if (winSize.width == 568) {
            self.scaleX *= 568.0f/480.0f;
            //m_fScaleX = 568.0f/480.0f;
            //m_fScaleY = 1.0f;
        }
        //else {
            //m_fScaleX = 1.0f;
            //m_fScaleY = 1.0f;
        //}
    }
    return self;
}
@end
