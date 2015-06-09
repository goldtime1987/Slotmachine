

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScaleMenu : CCMenu {
    float m_fOrginalScale;
}

-(void) addChild:(CCMenuItem*)child z:(NSInteger)z tag:(NSInteger) aTag;
-(void) processCommonScale: (CCNode*) child;
@end
