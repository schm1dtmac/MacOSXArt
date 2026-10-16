@import Cocoa;
#import "ZKSwizzle.h"
#import "dobby.h"

@interface NSImage ()
@property (getter=_isSymbolImage,readonly) bool _symbolImage;
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

@interface NSWindow ()
-(NSThemeFrame*)_themeFrame;
-(NSView*)_toolbarView;
-(id)titlebarViewController;
@end

@interface NSMenu ()
- (bool)_isAppleMenu;
-(bool)isMainMenu;
@end

@interface NSContextMenuImpl : NSResponder
-(NSMenu*)menu;
-(NSObject*)selectionMaterialView;
@end

@interface NSMenuItem ()
-(bool)_isAppleMenuItem;
@end

@interface NSMenuBarItemView : NSView
-(bool)_isAppleMenu;
@end

@interface NSPopupMenuWindow : NSWindow
@property (readonly, weak) NSResponder *associatedImpl;
@end

@class NSCompositeAppearance;

@interface NSAppearance ()
+ (NSCompositeAppearance *)_aquaAppearanceWithAccessibility:(bool)accessibility;
+ (NSCompositeAppearance *)_darkAquaAppearanceWithAccessibility:(bool)accessibility;
@end

@interface NSCompositeAppearance : NSAppearance
@property (copy) NSArray *appearances;
@property (copy) NSAppearanceName name;
- (id)initWithAppearances:(NSArray *)appearances;
@end

@interface NSBuiltinAppearance : NSAppearance
- (id)_bundleResourceName;
- (id)_catalystName;
- (bool)_isBuiltinAppearance;
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
- (bool)dragShouldRemove;
@end

extern bool NSColorControlAccentIsGraphite(void);

NSBundle* bundle;
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
NSImage* MenuBar;
NSImage* AppleLogo;
NSImage* MacOSX;
NSImageView* MacOSXLogo;
NSImage *cornerImage;
NSDictionary* TemplateMap;
NSDictionary* PrefsIconMap;
NSDictionary* FinderIconMap;

CTFontRef (*_FontCreateWithFontDescriptorOld)(CTFontDescriptorRef _Nonnull descriptor, CGFloat size, const CGAffineTransform * _Nullable matrix);
bool (*BoxOld)(void);
bool (*CellOld)(void);
bool (*ControlOld)(void);
bool (*CompatWidgetOld)(void);
bool (*SelectionRolloverOld)(void);
bool (*ToolbarMetricsOld)(void);
bool (*SidebarGoldenMetricsOld)(void);
bool (*TableViewGoldenStylesOld)(void);
bool (*LegacyScrollingOld)(void);

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
