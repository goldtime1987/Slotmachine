

#import "ScaleMenu.h"

@implementation ScaleMenu

/*
 * override add:
 */
-(void) addChild:(CCMenuItem*)child z:(NSInteger)z tag:(NSInteger) aTag
{
    m_fOrginalScale = 1.0f;
	[super addChild:child z:z tag:aTag];
	[self processCommonScale:child];
}

-(void) processCommonScale: (CCNode*) child {
    if ([child isKindOfClass:[CCMenuItem class]] || [child isKindOfClass:[CCMenuItemToggle class]]) {
        if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
            if (CC_CONTENT_SCALE_FACTOR() != 2.0f) {
                child.scaleX *= 0.5f;
                child.scaleY *= 0.5f;
                m_fOrginalScale = 0.5f;
            }
            /*else {
                child.scaleX *= 0.5f;
                child.scaleY *= 0.5f;
                m_fOrginalScale = 0.5f;

            }*/
                
        }else{
            /*if( [[UIScreen mainScreen] scale] != 2.0f ){
                child.scaleX *= 0.5f;
                child.scaleY *= 0.5f;
                m_fOrginalScale = 0.5f;
            }*/
        }
    }
}
@end
