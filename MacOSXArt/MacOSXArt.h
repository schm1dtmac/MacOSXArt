@import Cocoa;
#import "ZKSwizzle.h"
#import "dobby.h"

@interface NSImage ()
@property (getter=_isSymbolImage,readonly) BOOL _symbolImage;
@end

@interface FullScreenButtonCell : NSButtonCell
-(void)drawBezelWithFrame:(CGRect)arg1 inView:(id)arg2;
@end

@implementation FullScreenButtonCell : NSButtonCell
-(void)drawBezelWithFrame:(CGRect)arg1 inView:(id)arg2 {}
@end

@interface MacOSXArtImage : NSImage
@end
@implementation MacOSXArtImage
@end

@interface MacOSXArtTemplateImage : NSImage
@end
@implementation MacOSXArtTemplateImage
@end

@interface NSThemeFrame : NSView
- (NSTextField*)_titleTextField;
- (NSView*)titlebarView;
@end

@interface NSMenu ()
- (BOOL)_isAppleMenu;
-(BOOL)isMainMenu;
@end

@interface NSMenuItem ()
-(BOOL)_isAppleMenuItem;
@end

@interface NSTableRowView ()
-(BOOL)_needsSelectionBlurBackgroundView;
@end

@interface NSWindow ()
-(NSThemeFrame*)_themeFrame;
@end

@interface NSContextMenuImpl : NSResponder
-(NSMenu*)menu;
-(NSObject*)selectionMaterialView;
@end

@interface NSMenuBarItemView : NSView
-(BOOL)_isAppleMenu;
@end

@interface NSPopupMenuWindow : NSWindow
@property (readonly, weak) NSResponder *associatedImpl;
@end

@class NSCompositeAppearance;

@interface NSAppearance ()
+ (NSCompositeAppearance *)_aquaAppearanceWithAccessibility:(BOOL)accessibility;
+ (NSCompositeAppearance *)_darkAquaAppearanceWithAccessibility:(BOOL)accessibility;
@end

@interface NSCompositeAppearance : NSAppearance
@property (copy) NSArray *appearances;
@property (copy) NSAppearanceName name;
- (id)initWithAppearances:(NSArray *)appearances;
@end

@interface NSBuiltinAppearance : NSAppearance
- (id)_bundleResourceName;
- (id)_catalystName;
- (BOOL)_isBuiltinAppearance;
- (id)initWithBundleResourceName:(NSString *)resourceName publicName:(NSString *)publicName catalystName:(NSString *)catalystName;
@end

@interface NSSystemAppearance : NSBuiltinAppearance
@end

@interface NSAccessibilitySystemAppearance : NSBuiltinAppearance
@end

@interface NSAquaAppearance : NSBuiltinAppearance
@end

@interface NSDarkAquaAppearance : NSBuiltinAppearance
@end

@interface NSVibrantLightAppearance : NSBuiltinAppearance
@end

@interface NSVibrantDarkAppearance : NSBuiltinAppearance
@end

@interface UIView : NSObject
@property (nonatomic, readonly, nullable) UIView * superview;
@property (nonatomic, copy, readonly) NSArray<__kindof UIView *> * subviews;
@end

@interface UIFontDescriptor : NSObject
@property (nonatomic, readonly) uint32_t symbolicTraits;
@end

@interface UIFont : NSObject
@property (nonatomic, readonly) UIFontDescriptor* fontDescriptor;
@end

@interface TSidebarViewController : NSViewController
- (BOOL)dragShouldRemove;
@end

extern BOOL NSColorControlAccentIsGraphite(void);

NSBundle* bundle;
NSString* bundleIdentifier;
NSAppearance* aqua;
NSAppearance* darkAqua;
NSAppearance* graphiteAqua;
NSAppearance* graphiteDarkAqua;
NSAppearance* vibrantAqua;
NSAppearance* vibrantDarkAqua;
NSAppearance* vibrantGraphiteDarkAqua;
NSAppearance* accessibilitySystemAppearance;
NSAppearance* accessibilityAppearance;
NSAppearance* accessibilityDarkAquaAppearance;
NSAppearance* accessibilityGraphiteAppearance;
NSAppearance* accessibilityGraphiteDarkAquaAppearance;
NSAppearance* accessibilityVibrantLightAppearance;
NSAppearance* accessibilityDarkAppearance;
NSAppearance* accessibilityDarkGraphiteAppearance;
NSAppearance* sourceListAppearance;
NSImage* MenuBar;
NSImage* MenuSelection;
NSImage* AppleLogo;
NSImage* MacOSX;
NSImage* AquaProgress;
NSImageView* MacOSXLogo;
NSImage *cornerImage;
NSDictionary* TemplateMap;
NSDictionary* PrefsIconMap;
NSDictionary* FinderIconMap;

CTFontRef (*_FontCreateWithFontDescriptorOld)(CTFontDescriptorRef _Nonnull descriptor, CGFloat size, const CGAffineTransform * _Nullable matrix);
BOOL (*BoxOld)(void);
BOOL (*CellOld)(void);
BOOL (*ControlOld)(void);
BOOL (*CompatWidgetOld)(void);
BOOL (*SelectionRolloverOld)(void);
BOOL (*ToolbarMetricsOld)(void);
BOOL (*SidebarGoldenMetricsOld)(void);
BOOL (*TableViewGoldenStylesOld)(void);
BOOL (*LegacyScrollingOld)(void);

id SafeLoadBundleImage(NSString* imageName, NSBundle* bundle) {
    NSImage* image = [bundle imageForResource:imageName];
    if (image) {
        object_setClass(image, [MacOSXArtImage class]);
        return image;
    }
    return [NSNull null];
}

id SafeLoadBundleTemplateImage(NSString* imageName, NSBundle* bundle) {
    NSImage* image = [bundle imageForResource:imageName];
    if (image) {
        object_setClass(image, [MacOSXArtTemplateImage class]);
        return image;
    }
    return [NSNull null];
}
