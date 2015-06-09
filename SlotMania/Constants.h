#import "cocos2d.h"
//#import "DeviceSettings.h"

#define CARD_START_X    iDevPixelX(76.0f)
#define CARD_START_Y    iDevPixelY(230.0f)
#define CARD_BETWEEN_X  iDevPixelX(82.0f)
#define CARD_BETWEEN_Y  iDevPixelX(76.0f)
#define LINE_X0         34
#define LINE_X1         110
#define LINE_X2         178
#define LINE_X4         302
#define LINE_X5         370

#define CHARACTER_COUNT 11
#define DEFAULT_RINDEX  6
#define ROW_ 4
#define COL_ 5
#define RULE_LINE_COUNT 9
#define TICK            30
#define PREVTICK        8
#define PREVSTEP        iDevPixelY(4.0f)

#define MAX_VEL         iDevPixelY(36.0f)
#define MIN_VEL         iDevPixelY(8.0f)

extern NSString* strIconName[CHARACTER_COUNT];
extern NSString* strNumName[RULE_LINE_COUNT];
extern int lineY[RULE_LINE_COUNT];
