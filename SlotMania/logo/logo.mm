
#import "logo.h"
#import "TitleLayer.h"
#import "ResourceManager.h"
#import "SoundManager.h"
#import "DeviceSettings.h"

@implementation logo

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
        [self initImage];
        [self loadData];
        [[SoundManager sharedSoundManager] setEffectVolume: 1.0f];
		[self schedule:@selector(logoTimer:) interval:3];
	}
	
	return self;
}

-(void) initImage {
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite* s = [CCSprite spriteWithFile: IS_IPHONE5()?HD_568(@"splash.png"):SD_OR_PD(@"splash.png")];
    [s setPosition: ccp(winSize.width/2, winSize.height/2)];
    [self addChild: s];
    /*
    CCSprite *sprite = [[ResourceManager sharedResourceManager] getSpriteWithName:@"splash"];
    [sprite setPosition:ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    [self addChild:sprite];
    sprite.scale *= 2.0f;
     */
}

-(void) loadData {
    [[ResourceManager sharedResourceManager] loadData: @"comp"];
    [[ResourceManager sharedResourceManager] loadData: @"ruleLine"];
    [[ResourceManager sharedResourceManager] loadData: @"particle"];
}

-(void) logoTimer: (ccTime) dt{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:LOGO_LAYER_DURATION scene:[TitleLayer node]]];
}

- (void) dealloc
{
    [self unscheduleAllSelectors];
	[self removeAllChildrenWithCleanup:YES];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
	[super dealloc];
}
@end
