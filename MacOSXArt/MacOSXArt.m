#import "MacOSXArt.h"

CTFontRef FontCreateWithFontDescriptorNew(CTFontDescriptorRef _Nonnull descriptor, CGFloat size, const CGAffineTransform * _Nullable matrix) {
    // Read descriptor
    CFDictionaryRef dictionary = CTFontDescriptorCopyAttributes(descriptor);
    NSString *fontName = CFDictionaryGetValue(dictionary, (__bridge CFStringRef)NSFontNameAttribute);
    NSString *uiAttr = CFDictionaryGetValue(dictionary, @"NSCTFontUIUsageAttribute");
    if (uiAttr || !fontName || ([fontName containsString:@"AppleSystemUIFont"] &&
         !([[[NSBundle mainBundle] bundleIdentifier] containsString:@"Passwords"]
            || [[[NSBundle mainBundle] bundleIdentifier] containsString:@"Safari"] ))) {
            // Update descriptor
            NSMutableDictionary *mutableDictionary = [(__bridge NSDictionary *)dictionary mutableCopy];
            [mutableDictionary removeObjectForKey:@"NSCTFontTraitsAttribute"];
            [mutableDictionary removeObjectForKey:@"NSCTFontUIUsageAttribute"];
        [mutableDictionary setValue: ([fontName containsString:@"Bold"]) ? @"LucidaGrandeUI-Bold" : @"LucidaGrandeUI" forKey:NSFontNameAttribute];
            
            descriptor = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)mutableDictionary);
    }
    
    return _FontCreateWithFontDescriptorOld(descriptor, size, matrix);
}

bool AppKitFlagTrue(void) {
    return true;
}

bool AppKitFlagFalse(void) {
    return false;
}

__attribute__((constructor)) void InitTweak(void) {
    bundle = [NSBundle bundleWithPath:@"/private/var/ammonia/core/tweaks/MacOSXArt.bundle"];
    if(bundle){
        aqua = [[NSAppearance alloc] initWithAppearanceNamed:@"SystemAppearance" bundle:bundle];
        darkAqua = [[NSAppearance alloc] initWithAppearanceNamed:@"DarkAquaAppearance" bundle:bundle];
        graphiteAqua = [[NSAppearance alloc] initWithAppearanceNamed:@"GraphiteAppearance" bundle:bundle];
        graphiteDarkAqua = [[NSAppearance alloc] initWithAppearanceNamed:@"GraphiteDarkAquaAppearance" bundle:bundle];
        vibrantAqua = [[NSAppearance alloc] initWithAppearanceNamed:@"VibrantLightAppearance" bundle:bundle];
        vibrantDarkAqua = [[NSAppearance alloc] initWithAppearanceNamed:@"DarkAppearance" bundle:bundle];
        vibrantGraphiteDarkAqua = [[NSAppearance alloc] initWithAppearanceNamed:@"GraphiteDarkAppearance" bundle:bundle];
        accessibilitySystemAppearance = [[NSAppearance alloc] initWithAppearanceNamed:@"AccessibilitySystemAppearance" bundle:bundle];
        accessibilityAppearance = [[NSAppearance alloc] initWithAppearanceNamed:@"AccessibilityAppearance" bundle:bundle];
        accessibilityDarkAquaAppearance = [[NSAppearance alloc] initWithAppearanceNamed:@"AccessibilityDarkAquaAppearance" bundle:bundle];
        accessibilityGraphiteAppearance = [[NSAppearance alloc] initWithAppearanceNamed:@"AccessibilityGraphiteAppearance" bundle:bundle];
        accessibilityGraphiteDarkAquaAppearance = [[NSAppearance alloc] initWithAppearanceNamed:@"AccessibilityGraphiteDarkAquaAppearance" bundle:bundle];
        accessibilityVibrantLightAppearance = [[NSAppearance alloc] initWithAppearanceNamed:@"AccessibilityVibrantLightAppearance" bundle:bundle];
        accessibilityDarkAppearance = [[NSAppearance alloc] initWithAppearanceNamed:@"AccessibilityDarkAppearance" bundle:bundle];
        accessibilityDarkGraphiteAppearance = [[NSAppearance alloc] initWithAppearanceNamed:@"AccessibilityDarkGraphiteAppearance" bundle:bundle];
        MenuBar = [bundle imageForResource:@"MenuBar"];
        AppleLogo = [bundle imageForResource:@"Apple"];
        CFErrorRef error;
        CTFontManagerRegisterFontsForURL(CFURLCreateWithString(NULL, CFSTR("/private/var/ammonia/core/tweaks/MacOSXArt.bundle/Contents/Resources/LucidaGrandeUI.ttf"), NULL), kCTFontManagerScopeProcess, &error);
        CTFontManagerRegisterFontsForURL(CFURLCreateWithString(NULL, CFSTR("/private/var/ammonia/core/tweaks/MacOSXArt.bundle/Contents/Resources/LucidaGrandeUI-Bold.ttf"), NULL), kCTFontManagerScopeProcess, &error);
        TemplateMap = @{
            @"chevron.backward": SafeLoadBundleTemplateImage(@"BackarrowTemplate", bundle),
            @"chevron.left": SafeLoadBundleTemplateImage(@"BackarrowTemplate", bundle),
            @"chevron.forward": SafeLoadBundleTemplateImage(@"ForwardarrowTemplate", bundle),
            @"chevron.right": SafeLoadBundleTemplateImage(@"ForwardarrowTemplate", bundle),
            @"sidebar.left": SafeLoadBundleTemplateImage(@"TB_SidebarTemplate", bundle),
            @"sidebar.leading": SafeLoadBundleTemplateImage(@"TB_SidebarTemplate", bundle),
            @"sidebar.right": SafeLoadBundleTemplateImage(@"TB_RightSidebarTemplate", bundle),
            @"sidebar.trailing": SafeLoadBundleTemplateImage(@"TB_RightSidebarTemplate", bundle),
            @"square.and.arrow.up": SafeLoadBundleTemplateImage(@"shareTemplate", bundle),
            @"rectangle.split.3x1": SafeLoadBundleTemplateImage(@"ViewSwitcherColumnsTemplate", bundle),
            @"ellipsis.circle": SafeLoadBundleTemplateImage(@"GearTemplate", bundle),
            @"folder.badge.plus": SafeLoadBundleTemplateImage(@"newFolderTemplate", bundle),
            @"square.and.pencil": SafeLoadBundleTemplateImage(@"TB_NewTemplate", bundle),
            @"textformat.size.smaller": SafeLoadBundleTemplateImage(@"textSmallerTemplate", bundle),
            @"textformat.size.larger": SafeLoadBundleTemplateImage(@"textBiggerTemplate", bundle),
            @"magnifyingglass": SafeLoadBundleTemplateImage(@"SearchMagGlassTemplate", bundle),
            @"info.circle": SafeLoadBundleTemplateImage(@"getInfoTemplate", bundle),
            @"eye": SafeLoadBundleTemplateImage(@"InvokeQuickLookTemplate", bundle),
            @"plus": [NSBundle.mainBundle.bundleIdentifier isEqualToString:@"com.apple.Safari"] ?  SafeLoadBundleTemplateImage(@"ToolbarNewTabTemplate", bundle) : SafeLoadBundleTemplateImage(@"plusTemplate", bundle),
            @"minus": SafeLoadBundleTemplateImage(@"minusTemplate", bundle),
            @"play.fill": SafeLoadBundleTemplateImage(@"PlayTemplate", bundle),
            @"pause.fill": SafeLoadBundleTemplateImage(@"PauseTemplate", bundle),
            @"arrow.clockwise": SafeLoadBundleTemplateImage(@"RefreshButtonTemplate", bundle),
            @"squares.below.rectangle": SafeLoadBundleTemplateImage(@"ToolbarGalleryViewTemplate", bundle),
            @"square.grid.2x2": SafeLoadBundleTemplateImage(@"ToolbarIconViewTemplate", bundle),
            @"square.grid.3x2": SafeLoadBundleTemplateImage(@"ToolbarIconViewTemplate", bundle),
            @"square.grid.3x1.below.line.grid.1x2": SafeLoadBundleTemplateImage(@"ToolbarArrangeByTemplate", bundle),
            @"square.grid.4x3.fill": SafeLoadBundleTemplateImage(@"ToolbarTopSitesTemplate", bundle),
            @"list.bullet": [NSBundle.mainBundle.bundleIdentifier isEqualToString:@"com.apple.mail"] ?  SafeLoadBundleTemplateImage(@"TB_ListsTemplate", bundle) : SafeLoadBundleTemplateImage(@"ViewSwitcherListTemplate", bundle),
            @"tag": SafeLoadBundleTemplateImage(@"ToolbarTagIconTemplate", bundle),
            @"arrow.down.circle": SafeLoadBundleTemplateImage(@"ToolbarDownloadsTemplate", bundle),
            @"arrow.down": SafeLoadBundleTemplateImage(@"ToolbarDownloadsArrowTemplate", bundle),
            @"square.on.square": SafeLoadBundleTemplateImage(@"ToolbarButtonTabOverviewTemplate", bundle),
            @"star": SafeLoadBundleTemplateImage(@"ToolbarBookmarksBarTemplate", bundle),
            @"printer": SafeLoadBundleTemplateImage(@"printTemplate", bundle),
            @"rectangle.and.pencil.and.ellipsis": SafeLoadBundleTemplateImage(@"autofillTemplate", bundle),
            @"house": SafeLoadBundleTemplateImage(@"ToolbarHomepageTemplate", bundle),
            @"gearshape": SafeLoadBundleTemplateImage(@"GearTemplate", bundle),
            @"icloud": SafeLoadBundleTemplateImage(@"ToolbarCloudTabsTemplate", bundle),
            @"envelope": SafeLoadBundleTemplateImage(@"ToolbarMailTemplate", bundle),
            @"clock": SafeLoadBundleTemplateImage(@"ToolbarHistoryTemplate", bundle),
            @"plus.circle": SafeLoadBundleTemplateImage(@"plusEnclosedTemplate", bundle),
            @"speaker.wave.2.fill": SafeLoadBundleTemplateImage(@"SpeakerWithSoundStrokeTemplate", bundle),
            @"arrowshape.turn.up.backward": SafeLoadBundleTemplateImage(@"ToolbarReplyTemplate", bundle),
            @"arrowshape.turn.up.backward.2": SafeLoadBundleTemplateImage(@"ToolbarReplyAllTemplate", bundle),
            @"arrowshape.turn.up.forward": SafeLoadBundleTemplateImage(@"ToolbarForwardTemplate", bundle),
            @"mail.stack": SafeLoadBundleTemplateImage(@"TB_RelatedMessagesTemplate", bundle),
            @"pencil.tip.crop.circle": SafeLoadBundleTemplateImage(@"MarkupTemplate", bundle),
            @"highlighter": SafeLoadBundleTemplateImage(@"TB_annotMarkupHighlightTemplate", bundle),
            @"rotate.left": SafeLoadBundleTemplateImage(@"ToolbarRotateLeftTemplate", bundle),
            @"plus.magnifyingglass": SafeLoadBundleTemplateImage(@"TB_zoomInTemplate", bundle),
            @"minus.magnifyingglass": SafeLoadBundleTemplateImage(@"TB_zoomOutTemplate", bundle),
            @"1.magnifyingglass": SafeLoadBundleTemplateImage(@"TB_actualSizeTemplate", bundle),
            @"trash": SafeLoadBundleTemplateImage(@"deleteTemplate", bundle),
            @"photo.on.rectangle": SafeLoadBundleTemplateImage(@"TB_MediaBrowserTemplate", bundle),
            @"textformat": SafeLoadBundleTemplateImage(@"TB_FontsTemplate", bundle),
            @"paperclip": SafeLoadBundleTemplateImage(@"TB_AttachTemplate", bundle),
            @"paperplane": SafeLoadBundleTemplateImage(@"TB_SendTemplate", bundle),
            @"hand.thumbsdown": SafeLoadBundleTemplateImage(@"TB_JunkTemplate", bundle),
            @"hand.thumbsup": SafeLoadBundleTemplateImage(@"TB_NotJunkTemplate", bundle),
            @"xmark.bin": SafeLoadBundleTemplateImage(@"TB_JunkTemplate", bundle),
            @"archivebox": SafeLoadBundleTemplateImage(@"TB_ArchiveTemplate", bundle),
            @"xmark.octagon": SafeLoadBundleTemplateImage(@"toolbar_stopTemplate", bundle),
            @"folder": SafeLoadBundleTemplateImage(@"TB_MoveTemplate", bundle),
            @"plus.rectangle.on.folder": SafeLoadBundleTemplateImage(@"TB_CopyTemplate", bundle),
            @"plus.square.on.square": SafeLoadBundleTemplateImage(@"TB_CopyTemplate", bundle),
            @"arrowshape.zigzag.right": SafeLoadBundleTemplateImage(@"TB_RedirectTemplate", bundle),
            @"arrowshape.zigzag.forward": SafeLoadBundleTemplateImage(@"TB_RedirectTemplate", bundle),
            @"mail.and.text.magnifyingglass": SafeLoadBundleTemplateImage(@"TB_ShowHeadersTemplate", bundle),
            @"envelope.badge": SafeLoadBundleTemplateImage(@"TB_UnreadTemplate", bundle),
            @"envelope.open": SafeLoadBundleTemplateImage(@"TB_ReadTemplate", bundle),
            @"bolt.horizontal.fill": SafeLoadBundleTemplateImage(@"TB_OfflineTemplate", bundle),
            @"person.crop.circle.badge.plus": SafeLoadBundleTemplateImage(@"TB_AddToAddressBookTemplate", bundle),
            @"person.crop.circle": SafeLoadBundleTemplateImage(@"TB_AddressBookTemplate", bundle),
            @"arrow.up.right.and.arrow.down.left.rectangle": SafeLoadBundleTemplateImage(@"TB_ThreadsTemplate", bundle),
            @"append.page": SafeLoadBundleTemplateImage(@"TB_AppendTemplate", bundle),
            @"rectangle.and.paperclip": SafeLoadBundleTemplateImage(@"TB_IncludeAttachmentsTemplate", bundle),
            @"text.page": SafeLoadBundleTemplateImage(@"TB_MakePlainTemplate", bundle),
            @"richtext.page": SafeLoadBundleTemplateImage(@"TB_MakeRichTemplate", bundle),
            @"list.dash.header.rectangle": SafeLoadBundleTemplateImage(@"TB_ShowHeadersTemplate", bundle),
            @"link.badge.plus": SafeLoadBundleTemplateImage(@"TB_EditLinkTemplate", bundle),
            @"list.bullet.indent": SafeLoadBundleTemplateImage(@"PathPopupGlyphTemplate", bundle),
            @"eject": SafeLoadBundleTemplateImage(@"ejectTemplate", bundle),
            @"burn": SafeLoadBundleTemplateImage(@"ToolbarBurnTemplate", bundle),
            @"rectangle.connected.to.line.below": SafeLoadBundleTemplateImage(@"ToolbarConnectTemplate", bundle),
            @"airdrop": SafeLoadBundleTemplateImage(@"AirDropTemplate", bundle),
        };
        PrefsIconMap = [NSBundle.mainBundle.bundleIdentifier isEqualToString:@"com.apple.Terminal"] ? @{
            @"gearshape": SafeLoadBundleImage(@"Startup", bundle),
            @"document.badge.gearshape": SafeLoadBundleImage(@"WindowSettings", bundle),
            @"rectangle.3.group": SafeLoadBundleImage(@"WindowGroups", bundle),
            @"globe": SafeLoadBundleImage(@"Encodings", bundle),
        } : @{
            @"gearshape": SafeLoadBundleImage(@"General", bundle),
            @"slider.horizontal.3": SafeLoadBundleImage(@"General", bundle),
            @"sidebar.left": SafeLoadBundleImage(@"SidebarPrefs", bundle),
            @"sidebar.leading": SafeLoadBundleImage(@"SidebarPrefs", bundle),
            @"tag": SafeLoadBundleImage(@"PrefToolbarTagsIcon_32", bundle),
            @"gearshape.2": SafeLoadBundleImage(@"ToolbarAdvanced", bundle),
            @"wrench.and.screwdriver": SafeLoadBundleImage(@"ToolbarCustomizeIcon", bundle),
            @"at": SafeLoadBundleImage(@"Accounts", bundle),
            @"folder": SafeLoadBundleImage(@"GenericFolderIcon", bundle),
            @"bell": SafeLoadBundleImage(@"Actions", bundle),
            @"info.circle": SafeLoadBundleImage(@"ToolbarInfo", bundle),
            @"info.circle.fill": SafeLoadBundleImage(@"ToolbarInfo", bundle),
            @"lock": SafeLoadBundleImage(@"SecurityPreferences", bundle),
            @"square.on.square": SafeLoadBundleImage(@"TabsPreferences", bundle),
            @"puzzlepiece.extension": SafeLoadBundleImage(@"ExtensionsPrefIcon32", bundle),
            @"key": SafeLoadBundleImage(@"PasswordsPreferences", bundle),
            @"hand.raised": SafeLoadBundleImage(@"UserIcon", bundle),
            @"rectangle.and.pencil.and.ellipsis": SafeLoadBundleImage(@"AutoFillPreferences", bundle),
            @"magnifyingglass": SafeLoadBundleImage(@"MagnifyingGlassIcon", bundle),
            @"globe": SafeLoadBundleImage(@"BookmarkIcon", bundle),
            @"person": SafeLoadBundleImage(@"VCard", bundle),
            @"person.crop.square.filled.and.at.rectangle": SafeLoadBundleImage(@"VCard", bundle),
            @"flag.and.flag.filled.crossed": SafeLoadBundleImage(@"BugIcon_NonFinalArt", bundle),
            @"play.circle": SafeLoadBundleImage(@"PlaybackPrefs", bundle),
            @"xmark.bin": SafeLoadBundleImage(@"junkmail", bundle),
            @"textformat": SafeLoadBundleImage(@"ProfileFontAndColor", bundle),
            @"eyeglasses": SafeLoadBundleImage(@"ViewerPreferences", bundle),
            @"square.and.pencil": SafeLoadBundleImage(@"ComposingPreferences", bundle),
            @"square.and.arrow.down": SafeLoadBundleImage(@"ToolbarDownloadsFolderIcon", bundle),
            @"signature": SafeLoadBundleImage(@"SignaturePreferences", bundle),
            @"envelope.arrow.triangle.branch": SafeLoadBundleImage(@"MailSorter", bundle),
            @"envelope.and.arrow.trianglehead.branch": SafeLoadBundleImage(@"MailSorter", bundle),
            @"square.and.at.rectangle": SafeLoadBundleImage(@"ABTemplatePreferencesModule", bundle),
            @"person.crop.square.fill.and.at.rectangle": SafeLoadBundleImage(@"ABVCardPreferencesModule", bundle),
            @"icloud": SafeLoadBundleImage(@"iCloud", bundle),
            @"book": SafeLoadBundleImage(@"iBooksAppIcon", bundle),
            @"photo.on.rectangle": SafeLoadBundleImage(@"TB_PrefsImages", bundle),
            @"text.document": SafeLoadBundleImage(@"TB_PrefsPDF", bundle),
            @"cross.circle": SafeLoadBundleImage(@"FirstAid", bundle),
            @"document.badge.gearshape": SafeLoadBundleImage(@"Profiles", bundle),
            @"display": SafeLoadBundleImage(@"Devices", bundle),
            @"camera.filters": SafeLoadBundleImage(@"Filters", bundle),
            @"calculator": SafeLoadBundleImage(@"Calculator", bundle),
            @"number": SafeLoadBundleImage(@"NumberPreferences", bundle),
            @"sum": SafeLoadBundleImage(@"EquationPreferences", bundle),
            @"pencil": SafeLoadBundleImage(@"SEEditingPreferences", bundle),
            @"clock": SafeLoadBundleImage(@"SEHistoryPreferences", bundle),
            @"hifispeaker.2": SafeLoadBundleImage(@"SoundPref", bundle),
            @"shareplay": SafeLoadBundleImage(@"SoundPref", bundle),
            @"person.2": SafeLoadBundleImage(@"GroupIcon", bundle),
            @"person.crop.circle.badge.xmark": SafeLoadBundleImage(@"GroupIcon", bundle),
            @"hand.raised.slash": SafeLoadBundleImage(@"UserIcon", bundle),
            @"printer": SafeLoadBundleImage(@"Printer", bundle),
            @"printer.dotmatrix": SafeLoadBundleImage(@"Printer", bundle),
            @"network": SafeLoadBundleImage(@"Network", bundle),
        };
        FinderIconMap = @{
            @"appstore": SafeLoadBundleImage(@"ToolbarAppsFolderIcon", bundle),
            @"house": SafeLoadBundleImage(@"HomeFolderIcon", bundle),
            @"music": SafeLoadBundleImage(@"ToolbarMusicFolderIcon", bundle),
            @"film": SafeLoadBundleImage(@"ToolbarMovieFolderIcon", bundle),
            @"camera": SafeLoadBundleImage(@"ToolbarPicturesFolderIcon", bundle),
            @"figure.walk.diamond": SafeLoadBundleImage(@"ToolbarPublicFolderIcon", bundle),
            @"document": SafeLoadBundleImage(@"ToolbarDocumentsFolderIcon", bundle),
        };
    }
    
    CGFloat radius = 6.5;
    CGFloat dimension = 2 * radius + 1;
    NSSize size = NSMakeSize(dimension, dimension);
    cornerImage = [NSImage imageWithSize:size flipped:false drawingHandler:^BOOL(NSRect dstRect) {
        NSBezierPath *bezierPath = [NSBezierPath bezierPath];
        [bezierPath moveToPoint:NSMakePoint(NSMinX(dstRect), NSMaxY(dstRect))];
        [bezierPath lineToPoint:NSMakePoint(NSMinX(dstRect), NSMinY(dstRect) + radius)];
        [bezierPath curveToPoint:NSMakePoint(NSMinX(dstRect) + radius, NSMinY(dstRect)) controlPoint:NSMakePoint(NSMinX(dstRect), NSMinY(dstRect))];
        [bezierPath lineToPoint:NSMakePoint(NSMaxX(dstRect) - radius, NSMinY(dstRect))];
        [bezierPath curveToPoint:NSMakePoint(NSMaxX(dstRect), NSMinY(dstRect) + radius) controlPoint:NSMakePoint(NSMaxX(dstRect), NSMinY(dstRect))];
        [bezierPath lineToPoint:NSMakePoint(NSMaxX(dstRect),  NSMaxY(dstRect))];
        [bezierPath closePath];
        [[NSColor blackColor] set];
        [bezierPath fill];
        return true;
    }];
    [cornerImage setCapInsets:NSEdgeInsetsMake(radius, radius, radius, radius)];
    [cornerImage setResizingMode:NSImageResizingModeStretch];
    
    DobbyHook(DobbySymbolResolver(NULL, "CTFontCreateWithFontDescriptor"), FontCreateWithFontDescriptorNew, (void**)&_FontCreateWithFontDescriptorOld);
    
    DobbyHook(DobbySymbolResolver("AppKit", "_NSToolbarItemViewerCompatabilitySelectionWidgetDefaultValueFunction"), AppKitFlagTrue, (void**)&CompatWidgetOld);
    
    DobbyHook(DobbySymbolResolver("AppKit", "_NSBoxUseLegacyMetricsDefaultValueFunction"), AppKitFlagTrue, (void**)&BoxOld);
    
    DobbyHook(DobbySymbolResolver("AppKit", "_NSCellUseLegacyFontSizeDefaultValueFunction"), AppKitFlagTrue, (void**)&CellOld);
    
    DobbyHook(DobbySymbolResolver("AppKit", "_NSButtonAdjustAlignmentRectInsetsForGladeArtworkDefaultValueFunction"), AppKitFlagTrue, (void**)&ControlOld);
    
    DobbyHook(DobbySymbolResolver("AppKit", "_NSToolbarItemViewerSupportsSelectionRolloverDefaultValueFunction"), AppKitFlagFalse, (void**)&SelectionRolloverOld);
    
    DobbyHook(DobbySymbolResolver("AppKit", "_NSToolbarCompatibilityExpansionMetricsDefaultValueFunction"), AppKitFlagFalse, (void**)&ToolbarMetricsOld);
    
    DobbyHook(DobbySymbolResolver("AppKit", "_NSSidebarUsesGoldenMetrics"), AppKitFlagFalse, (void**)&SidebarGoldenMetricsOld);
    
    if(![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Music"]) {
        DobbyHook(DobbySymbolResolver("AppKit", "_NSTableViewCanUseGoldenStylesDefaultValueFunction"), AppKitFlagFalse, (void**) &TableViewGoldenStylesOld);
    }
    
    DobbyHook(DobbySymbolResolver("AppKit", "_NSScrollViewUseLegacyScrollingDefaultValueFunction"), AppKitFlagTrue, (void**)&LegacyScrollingOld);
}

hook(NSMenuBarRepresentation)
-(id)_rootBackingView {
    id orig = ZKOrig(id);
    NSMutableArray *_backingViews = [self valueForKey:@"_backingViews"];
    if(![[_backingViews[1] layer] contents])
        [[_backingViews[1] layer] setContents:MenuBar];
    if(![[_backingViews[0] layer] contents])
        [[_backingViews[0] layer] setContents:MenuBar];
        
    return orig;
}
endhook

hook(NSMenuBarPresentationInstance)
+(bool)_isMenuBarTransparencyEnabled {
    return false;
}
endhook

hook(NSMenuBarItemView)
-(NSAppearance*)appearance {
    return [NSAppearance appearanceNamed:NSAppearanceNameAqua];
}

-(id)_applicableTitle {
    if (![(NSMenuBarItemView*)self _isAppleMenu])
        return ZKOrig(id);
    return nil;
}
endhook

hook(NSMenuItem)
-(NSImage*)image {
    if ([(NSMenuItem*)self _isAppleMenuItem]) {
        return AppleLogo;
    }
    return ZKOrig(NSImage*);
}

-(NSInteger)indentationLevel {
    return MAX(1, ZKOrig(NSInteger));
}

+ (id)standardImportFromDeviceMenuItem {
    return nil;
}
endhook

hook(NSPopupMenuWindow)
- (NSImage *)_cornerMask {
    NSMenu* menu = [[(NSPopupMenuWindow*)self associatedImpl] menu];
    if ([[menu supermenu] isMainMenu] || [menu _isAppleMenu]) {
        [[(NSWindow*)self contentView] setValue:@(0) forKey:@"_materialCornerRadius"];
        return cornerImage;
    }
    return ZKOrig(NSImage*);
}
endhook

hook(NSContextMenuImpl)
- (double)markWidthsForItem:(id)a0 {
    return 4.0;
}

- (double)_targetWidth {
    return ZKOrig(double) - ([[self valueForKey:@"_maxModifiersWidth"] doubleValue] > 0 ? 26.0 : 0.0);
}

- (CGRect)_selectionLayerFrameForView:(id)a0 {
    CGRect orig = ZKOrig(CGRect, a0);
    orig.size = [a0 bounds].size;
    orig.origin.x = 0;
    NSVisualEffectView * backing = [[(NSContextMenuImpl*)self selectionMaterialView] valueForKey:@"_backingView"];
    [backing setValue:@(0) forKey:@"_materialCornerRadius"];
    return orig;
}

- (double)_targetHeight:(bool)a0 {
    double height = ZKOrig(double, a0);
    NSInteger num = [[(NSContextMenuImpl*)self menu] numberOfItems];
    for(NSInteger i = 0; i < num ; i++) {
        double prefHeight = [self preferredViewHeightForMenuItemAtIndex:i];
        if((prefHeight > 19.0) && (prefHeight < 20.0))
            height -= 1000 * (prefHeight - 19.0);
    }
    return height;
}

- (double)preferredViewHeightForMenuItemAtIndex:(unsigned long long)a0 {
    double orig = ZKOrig(double, a0);
    return (orig > 19.0) && (orig < 27.0) ? 19.0 + (orig - 19.0)/1000 : orig;
}

- (int)_backgroundStyle {
    return 0;
}
endhook

hook(NSAppearance)
+ (NSAppearance *)_aquaAppearance {
    NSCompositeAppearance *composite = ZKOrig(NSCompositeAppearance *);
    NSMutableArray *appearances = [[composite appearances] mutableCopy];
    bool useAccessibility = [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldIncreaseContrast];
    bool useGraphite = NSColorControlAccentIsGraphite();
    aqua ? [appearances insertObject:aqua atIndex:0] : nil;
    if (useGraphite) {
        graphiteAqua ? [appearances insertObject:graphiteAqua atIndex:0] : nil;
    }
    
    if (useAccessibility) {
        accessibilitySystemAppearance ? [appearances insertObject:accessibilitySystemAppearance atIndex:0] : nil;
        accessibilityAppearance ? [appearances insertObject:accessibilityAppearance atIndex:0] : nil;
        
        if (useGraphite) {
            accessibilityGraphiteAppearance ? [appearances insertObject:accessibilityGraphiteAppearance atIndex:0] : nil;
        }
    }

    composite = [[NSClassFromString(@"NSCompositeAppearance") alloc] initWithAppearances:appearances];
    [composite setName:@"NSAppearanceNameAqua"];
    return composite;
}

+ (NSAppearance*)_aquaAppearanceWithAccessibility:(bool)accessibility {
    NSCompositeAppearance* composite = _orig(NSCompositeAppearance*, accessibility);
    NSMutableArray* appearances = [[composite appearances] mutableCopy];
    bool useGraphite = NSColorControlAccentIsGraphite();
    if (useGraphite) {
        graphiteAqua ? [appearances insertObject:graphiteAqua atIndex:0] : nil;
    }
    if (accessibility) {
        accessibilitySystemAppearance ? [appearances insertObject:accessibilitySystemAppearance atIndex:0] : nil;
        accessibilityAppearance ? [appearances insertObject:accessibilityAppearance atIndex:0] : nil;
        
        if (useGraphite) {
            accessibilityGraphiteAppearance ? [appearances insertObject:accessibilityGraphiteAppearance atIndex:0] : nil;
        }
    }
    composite = [[NSClassFromString(@"NSCompositeAppearance") alloc] initWithAppearances:appearances];
    return composite;
}

+ (NSAppearance *)_darkAquaAppearance {
    NSCompositeAppearance *composite = ZKOrig(NSCompositeAppearance *);
    NSMutableArray *appearances = [[composite appearances] mutableCopy];
    bool useAccessibility = [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldIncreaseContrast];
    bool useGraphite = NSColorControlAccentIsGraphite();
    darkAqua ? [appearances insertObject:darkAqua atIndex:0] : nil;
    if (useGraphite) {
        graphiteDarkAqua ? [appearances insertObject:graphiteDarkAqua atIndex:0] : nil;
    }
    
    if (useAccessibility) {
        accessibilitySystemAppearance ? [appearances insertObject:accessibilitySystemAppearance atIndex:0] : nil;
        accessibilityDarkAquaAppearance ? [appearances insertObject:accessibilityDarkAquaAppearance atIndex:0] : nil;
        
        if (useGraphite) {
            accessibilityGraphiteDarkAquaAppearance ? [appearances insertObject:accessibilityGraphiteDarkAquaAppearance atIndex:0] : nil;
        }
    }
    
    composite = [[NSClassFromString(@"NSCompositeAppearance") alloc] initWithAppearances:appearances];
    [composite setName:@"NSAppearanceNameDarkAqua"];
    return composite;
}

+ (NSAppearance*)_darkAquaAppearanceWithAccessibility:(bool)accessibility {
    NSCompositeAppearance* composite = _orig(NSCompositeAppearance*, accessibility);
    NSMutableArray* appearances = [[composite appearances] mutableCopy];
    bool useGraphite = NSColorControlAccentIsGraphite();
    
    if (accessibility) {
        accessibilitySystemAppearance ? [appearances insertObject:accessibilitySystemAppearance atIndex:0] : nil;
        accessibilityDarkAquaAppearance ? [appearances insertObject:accessibilityDarkAquaAppearance atIndex:0] : nil;
    }
    
    if (useGraphite) {
        graphiteDarkAqua ? [appearances insertObject:graphiteDarkAqua atIndex:0] : nil;
        
        if (accessibility) {
            accessibilityGraphiteDarkAquaAppearance ? [appearances insertObject:accessibilityGraphiteDarkAquaAppearance atIndex:0] : nil;
        }
    }
    
    composite = [[NSClassFromString(@"NSCompositeAppearance") alloc] initWithAppearances:appearances];
    return composite;
}

+ (NSAppearance *)_vibrantLightAppearance {
    NSCompositeAppearance *composite = ZKOrig(NSCompositeAppearance *);
    NSMutableArray *appearances = [[composite appearances] mutableCopy];
    bool useAccessibility = [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldIncreaseContrast];
    bool useGraphite = NSColorControlAccentIsGraphite();
    aqua ? [appearances insertObject:aqua atIndex:0] : nil;
    if (useGraphite) {
        graphiteAqua ? [appearances insertObject:graphiteAqua atIndex:0] : nil;
    }
    if (useAccessibility) {
        accessibilitySystemAppearance ? [appearances insertObject:accessibilitySystemAppearance atIndex:0] : nil;
        accessibilityAppearance ? [appearances insertObject:accessibilityAppearance atIndex:0] : nil;
        
        if (useGraphite) {
            accessibilityGraphiteAppearance ? [appearances insertObject:accessibilityGraphiteAppearance atIndex:0] : nil;
        }
    }
    vibrantAqua ? [appearances insertObject:vibrantAqua atIndex:0] : nil;
    if (useAccessibility) {
        accessibilityVibrantLightAppearance ? [appearances insertObject:accessibilityVibrantLightAppearance atIndex:0] : nil;
    }
    composite = [[NSClassFromString(@"NSCompositeAppearance") alloc] initWithAppearances:appearances];
    [composite setName:@"NSAppearanceNameVibrantLight"];
    return composite;
}

+ (NSAppearance *)_vibrantDarkAppearance {
    NSCompositeAppearance *composite = ZKOrig(NSCompositeAppearance *);
    NSMutableArray *appearances = [[composite appearances] mutableCopy];
    bool useAccessibility = [[NSWorkspace sharedWorkspace] accessibilityDisplayShouldIncreaseContrast];
    bool useGraphite = NSColorControlAccentIsGraphite();
    darkAqua ? [appearances insertObject:darkAqua atIndex:0] : nil;
    if (useGraphite) {
        graphiteDarkAqua ? [appearances insertObject:graphiteDarkAqua atIndex:0] : nil;
    }
    vibrantDarkAqua ? [appearances insertObject:vibrantDarkAqua atIndex:0] : nil;
    if (useGraphite) {
        vibrantGraphiteDarkAqua ? [appearances insertObject:vibrantGraphiteDarkAqua atIndex:0] : nil;
    }
    if (useAccessibility) {
        accessibilitySystemAppearance ? [appearances insertObject:accessibilitySystemAppearance atIndex:0] : nil;
        accessibilityDarkAquaAppearance ? [appearances insertObject:accessibilityDarkAquaAppearance atIndex:0] : nil;
        
        if (useGraphite) {
            accessibilityDarkGraphiteAppearance ? [appearances insertObject:accessibilityDarkGraphiteAppearance atIndex:0] : nil;
        }
        
        accessibilityDarkAppearance ? [appearances insertObject:accessibilityDarkAppearance atIndex:0] : nil;
        
        if (useGraphite) {
            accessibilityDarkGraphiteAppearance ? [appearances insertObject:accessibilityDarkGraphiteAppearance atIndex:0] : nil;
        }
    }
    composite = [[NSClassFromString(@"NSCompositeAppearance") alloc] initWithAppearances:appearances];
    [composite setName:@"NSAppearanceNameVibrantDark"];
    return composite;
}

+ (NSAppearance *)_fauxVibrantLightAppearance {
    return [self _vibrantLightAppearance];
}

+ (NSAppearance *)_fauxVibrantDarkAppearance {
    return [self _vibrantDarkAppearance];
}

- (bool)_allowsSystemControlTintColors {
    return false;
}
endhook

hook(NSCompositeAppearance)
- (NSAppearance*)_appearanceForVibrantContent {
    return [[(NSCompositeAppearance*)self name] containsString:@"Dark"] ? [NSAppearance appearanceNamed:@"NSAppearanceNameVibrantDark"] : [NSAppearance appearanceNamed:@"NSAppearanceNameVibrantLight"];
}

- (NSAppearance*)_appearanceForNonVibrantContent {
    return [[(NSCompositeAppearance*)self name] containsString:@"Dark"] ? [NSAppearance appearanceNamed:@"NSAppearanceNameDarkAqua"] : [NSAppearance appearanceNamed:@"NSAppearanceNameAqua"];
}

- (bool)_usesMetricsAppearance {
    return false;
}
endhook

hook(NSVibrantDarkAppearance)
- (bool)_usesMetricsAppearance {
    return false;
}
endhook

hook(NSVibrantLightAppearance)
- (bool)_usesMetricsAppearance {
    return false;
}
endhook

hook(NSAquaAppearance)
- (bool)_usesMetricsAppearance {
    return false;
}
endhook

hook(NSDarkAquaAppearance)
- (bool)_usesMetricsAppearance {
    return false;
}
endhook

hook(NSAlert)
- (void)_resetLayoutDone {
    ZKOrig(void);
    int *layoutStyle = &ZKHookIvar(self, int, "_layoutStyle");
    if (layoutStyle) {
        *layoutStyle = 3;
    }
}

- (void)_buildLayoutConstraintsForWideAppearance:(id)arg0 views:(id)arg1 metrics:(NSDictionary *)arg2 title:(id)arg3 formattedMessage:(id)arg4 numButtons:(NSUInteger)arg5 hasSecond:(bool)arg6 {
    ZKOrig(void, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    CGFloat *minPanelWidth = &ZKHookIvar(self, CGFloat, "_minPanelWidth");
    if (minPanelWidth) {
        *minPanelWidth = 450;
    }
}
endhook

hook(NSWindow)
- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingStoreType defer:(bool)flag {
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleIdentifier isEqualToString:@"com.apple.finder"] && [[(NSWindow*)self className] containsString:@"BrowserWindow"]) {
        NSRect newBrowserContentRect = NSMakeRect(contentRect.origin.x, contentRect.origin.y, 770, 383);
        return ZKOrig(id, newBrowserContentRect, style & ~NSWindowStyleMaskFullSizeContentView, backingStoreType, flag);
    }
    if ([bundleIdentifier isEqualToString:@"com.apple.iCal"]
        || [bundleIdentifier isEqualToString:@"com.apple.MobileSMS"]
        || [bundleIdentifier isEqualToString:@"com.apple.AppStore"]
        || [bundleIdentifier isEqualToString:@"com.apple.AddressBook"]) {
        style &= ~NSWindowStyleMaskFullSizeContentView;
    }
    return ZKOrig(id, contentRect, style, backingStoreType, flag);
}

-(void)setToolbarStyle:(NSWindowToolbarStyle)style {
    return;
}

-(id)contentLayoutGuide {
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleIdentifier isEqualToString:@"com.apple.finder"] && [[(NSWindow*)self className] containsString:@"BrowserWindow"]) {
        return nil;
    }
    return ZKOrig(id);
}

-(NSWindowTitleVisibility)titleVisibility {
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Music"]) {
        return ZKOrig(NSWindowTitleVisibility);
    }
    return NSWindowTitleVisible;
}

-(bool)titlebarAppearsTransparent {
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.MobileSMS"]
        || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.AddressBook"]
        || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.AppStore"]
        || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.iBooksX"]
        || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.findmy"]
        || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.reminders"]
        || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.helpviewer"]
        || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.weather"]) {
        return false;
    }
    return ZKOrig(bool);
}

- (NSTitlebarSeparatorStyle)titlebarSeparatorStyle {
    return NSTitlebarSeparatorStyleNone;
}

- (NSTitlebarSeparatorStyle)contentTitlebarSeparatorStyle {
    return NSTitlebarSeparatorStyleNone;
}

- (id)_sidebarTrackingAdapter {
    return nil;
}

- (id)_trailingSidebarTrackingAdapter {
    return nil;
}

- (NSUInteger)sheetBehavior {
    return 3;
}

- (void)setTitlebarHeight:(CGFloat)value {
    if (![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Music"]) {
        return;
    }
    ZKOrig(void, value);
}

-(void)setTitle:(NSString*)title {
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.AddressBook"] && [title isEqual:@""]) {
        return ZKOrig(void, [[NSRunningApplication currentApplication] localizedName]);
    }
    return ZKOrig(void, title);
}

-(bool)_zoomButtonIsFullScreenButton {
    return false;
}
endhook

hook(_NSTitlebarDecorationView)
- (void)setDrawsBottomSeparator:(bool)flag {
    return ZKOrig(void,![[(NSView*)self window] titlebarAppearsTransparent]);
}
- (void)_updateBottomSeparatorLayer {
    return;
}
endhook


hook(NSToolbar)
-(void)_userRemoveItemAtIndex:(long long)arg1 {
    ZKOrig(void, arg1);
    NSShowAnimationEffect(NSAnimationEffectPoof, [NSEvent mouseLocation], NSZeroSize, nil, nil, nil);
}
-(BOOL)allowsDisplayModeCustomization {
    return [(NSToolbar*)self allowsUserCustomization];
}
endhook

hook(NSToolbarItem)
-(id)_partitionAdapter {
    return nil;
}
- (id)initWithItemIdentifier:(id)identifier {
    return ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Mail"] && [identifier isEqualToString:@"toggleMessageListFilter:"]) ? nil : ZKOrig(id, identifier);
}
endhook

hook(NSTrackingSeparatorToolbarItem)
- (bool)_isPartitionItem {
    return false;
}
endhook

hook(NSSeparatorToolbarItemView)
- (bool)isHidden {
    return true;
}
endhook

hook(NSToolbarItemViewer)
-(CGSize)minSize {
    return [[[[(NSView*)self subviews] firstObject] className] containsString:@"NSSeparatorToolbarItemView"] ? CGSizeZero : ZKOrig(CGSize);
}
-(CGSize)maxSize {
    return [[[[(NSView*)self subviews] firstObject] className] containsString:@"NSSeparatorToolbarItemView"] ? CGSizeZero : ZKOrig(CGSize);
}
-(bool)wantsToBeCentered {
    if(([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Safari"] && [[(NSObject*)[[(NSView*)self window] delegate] className] isEqualToString:@"PreferencesUIController"])
       || ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Photos"] && [[[(NSView*)self window] frameAutosaveName] isEqualToString:@"Preferences"])
       || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.mail"]
       || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.AddressBook"]
       || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.MobileSMS"]
       || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.iBooksX"]
       || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Maps"]
       || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.shortcuts"])
        return false;
    return ZKOrig(bool);
}
endhook

hook(NSTabBarNewTabButton)
-(CGRect)frame {
    CGRect frame = ZKOrig(CGRect);
    frame.size.width = 27;
    return frame;
}
endhook

hook(NSTabBar)
-(CGRect)frame {
    CGRect frame = ZKOrig(CGRect);
    CGRect frame2 = [[(NSView*)self superview] frame];
    frame.size.height = frame2.size.height = 24;
    [[(NSView*)self superview] setFrame:frame2];
    return frame;
}
endhook

hook(NSTitlebarAccessoryViewController)
-(double)fullScreenMinHeight {
    return MIN(ZKOrig(double), [[(NSTitlebarAccessoryViewController*)self view] frame].size.height);
}
endhook

hook(NSSheetMoveHelper)
- (id)initWithSheet:(id)sheet {
    id helper = ZKOrig(id, sheet);
    NSInteger *animationStyle = &ZKHookIvar(helper, NSInteger, "_animationStyle");
    *animationStyle = 0;
    return helper;
}
endhook

hook(NSSplitViewItem)
- (bool)revealsOnEdgeHoverInFullscreen {
    return false;
}
endhook

hook(NSSplitView)
- (bool)_canDoSidebarProactivePeek {
    return false;
}
- (bool)_canDoInspectorProactivePeek {
    return false;
}
endhook

hook(NSStatusItem)
-(void)setVisible:(bool)visible {
    if ([[(NSStatusItem*)self autosaveName] isEqual:@"BentoBox"])
        return ZKOrig(void, false);
    else
        return ZKOrig(void, visible);
}

- (bool)_allowItemDragging {
    return true;
}

-(NSAppearance*)appearance {
    NSAppearance* orig = ZKOrig(NSAppearance*);
    return [[orig name] containsString:@"Dark"] ? [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight] : orig;
}
endhook

hook(NSStatusBarWindow)
-(void)setHasCAShadow:(bool)flag {
    return ZKOrig(void, false);
}
endhook

hook(NSUserNotification)
- (void)setSoundName:(NSString *)soundName {
    if ([soundName isEqual:NSUserNotificationDefaultSoundName])
        return ZKOrig(void, @"Tri-tone");
    return ZKOrig(void, soundName);
}

endhook

hook(UNNotificationSound)
+ (id)_soundWithAlertType:(long long)a0 audioVolume:(id)a1 critical:(bool)a2 toneFileName:(id)a3 {
    if(a3 == nil)
        return ZKOrig(id, a0, a1, a2, @"Tri-Tone");
    return ZKOrig(id, a0, a1, a2, a3);
}

endhook

hook(NSTableView)
- (NSSize)intercellSpacing {
    NSSize orig = ZKOrig(NSSize);
    if (orig.width == 17 && orig.height == 0)
        return NSMakeSize(3,2);
    return orig;
}

- (CGFloat)rowHeight {
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.ActivityMonitor"])
        return 17.0;
    switch ([(id)self effectiveRowSizeStyle]) {
        case NSTableViewRowSizeStyleSmall:
            return 20.0;
        case NSTableViewRowSizeStyleMedium:
            return 24.0;
        case NSTableViewRowSizeStyleLarge:
            return 34.0;
        default:
            return ZKOrig(CGFloat);
    }
}
endhook

hook(NSTableHeaderView)
- (bool)_canSupportTallerHeight {
    return false;
}
-(CGRect)frame {
    CGRect frame = ZKOrig(CGRect);
    frame.size.height = MIN(frame.size.height, 17);
    return frame;
}
endhook

hook(NSThemeFrame)
- (bool)_isUtility {
    return [[(NSView*)self identifier] isEqual:@"AquaMacOSXAbout"] ? true : ZKOrig(bool);
}

- (CGPoint)_closeButtonOrigin {
    CGPoint origin = ZKOrig(CGPoint);
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Music"])
        origin.y = NSMaxY([(NSView*)self frame]) - 19;
    return origin;
}

- (CGPoint)_fullScreenButtonOrigin {
    CGPoint origin = ZKOrig(CGPoint);
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Music"])
        origin.y = NSMaxY([(NSView*)self frame]) - 21;
    return origin;
}

+(double)_windowTitlebarTitleMinHeight:(unsigned long long)a0 {
    return MIN(ZKOrig(double, a0), 22.0);
}

+(double)_windowTitlebarTitleMinHeight:(unsigned long long)a0 hasSolariumAppearance:(bool)flag {
    return MIN(ZKOrig(double, a0, flag), 22.0);
}

-(double)_minYTitlebarButtonsOffset {
    return -2.0;
}

- (CGRect)_maxTitlebarTitleRect {
    CGRect frame = ZKOrig(CGRect);
    frame.size.height -= 2;
    return frame;
}

-(double)_toolbarOffsetIfTitleIsHidden {
    return -2.5;
}

-(double)_distanceFromToolbarBaseToTitlebar {
    if ([[[(NSView*)self window] toolbar] isVisible] ){
        if([[[(NSView*)self window] titlebarAccessoryViewControllers] count] >=0 && ([[[(NSView*)self window] titlebarAccessoryViewControllers] indexOfObjectPassingTest:^BOOL(__kindof NSTitlebarAccessoryViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return ![obj isHidden];
        }] != NSNotFound)) {
            return ZKOrig(double) + 4.0;
        } else {
            return ZKOrig(double) + 5.0;
        }
    }
    else {
        return ZKOrig(double);
    }
}
-(double)_toolbarLeadingSpace {
    return ZKOrig(double) + 2.5;
}

-(double)_toolbarTrailingSpace {
    return ZKOrig(double) + 2.5;
}
endhook

hook(_NSThemeWidgetCell)
-(CGSize)cellSizeForBounds:(CGRect)arg1 {
    CGSize size = ZKOrig(CGSize);
    if (size.height == 9)
        size.height = 13;
    return size;
}
endhook

hook(NSControl)
- (void)setControlSize:(NSControlSize)controlSize {
    return controlSize == NSControlSizeLarge ? ZKOrig(void, NSControlSizeRegular) : ZKOrig(void, controlSize);
}

- (NSControlSize)controlSize {
    NSControlSize controlSize = ZKOrig(NSControlSize);
    return controlSize == NSControlSizeLarge ? NSControlSizeRegular : controlSize;
}
endhook

hook(NSButtonCell)
- (NSControlSize)controlSize {
    NSControlSize controlSize = ZKOrig(NSControlSize);
    return controlSize == NSControlSizeLarge ? NSControlSizeRegular : controlSize;
}

-(void)_setState:(long long)arg1 animated:(char)arg2 {
    return ZKOrig(void, arg1, true);
}

-(void)_setHighlighted:(char)arg1 animated:(char)arg2 {
    return ZKOrig(void, arg1, true);
}
endhook

hook(NSSplitDividerView)
- (void)setStyle:(long long)style {
    return ZKOrig(void, 4);
}
endhook

hook(NSSegmentItemImageView)
- (NSImage*)image {
    NSImage* orig = ZKOrig(NSImage*);
    if (![orig _isSymbolImage]) {
        return orig;
    }
    
    NSString* identifier = [[[[orig representations] firstObject] valueForKey:@"_vectorGlyph"] valueForKey:@"_name"];
    
    MacOSXArtTemplateImage* image = TemplateMap[identifier];
    return (image && image != (id)[NSNull null]) ? image : orig;
}
- (void)setFrame:(CGRect)frame {
    NSImage* image = [self image];
    double widthForCalc = [image size].width;
    double heightForCalc = [image size].height;
    
    CGPoint center = CGPointMake(frame.origin.x - 0.5 * (widthForCalc - frame.size.width), 0.5 * ([[(NSView*)self superview] frame].size.height - heightForCalc));
    if ([(NSSegmentedControl*)[(id)self superview] controlSize] == NSControlSizeRegular)
        center.y -= 1;
    
    return ZKOrig(void, CGRectMake(center.x, center.y, widthForCalc, heightForCalc));
}
endhook

hook(NSButtonImageView)
- (NSImage*)image {
    NSImage* orig = ZKOrig(NSImage*);
    if (![orig _isSymbolImage]) {
        return orig;
    }
    
    NSString* identifier = [[[[orig representations] firstObject] valueForKey:@"_vectorGlyph"] valueForKey:@"_name"];
    
    MacOSXArtTemplateImage* image = TemplateMap[identifier];
    return (image && image != (id)[NSNull null]) ? image : orig;
}
- (void)setFrame:(CGRect)frame {
    NSImage* image = [self image];
    if (![[image className] isEqualTo:@"MacOSXArtTemplateImage"]) {
        return ZKOrig(void, frame);
    }
    
    double widthForCalc = [image size].width;
    double heightForCalc = [image size].height;
    
    CGPoint center = CGPointMake(frame.origin.x - 0.5 * (widthForCalc - frame.size.width), 0.5 * ([[(NSView*)self superview] frame].size.height - heightForCalc));
    if ([(NSButton*)[(id)self superview] bezelStyle] == NSBezelStyleToolbar)
        center.y -= 1;
    
    return ZKOrig(void, CGRectMake(center.x, center.y, widthForCalc, heightForCalc));
}
endhook

hook(NSToolbarButton)
-(void)setImage:(NSImage*)orig {
    if (![orig _isSymbolImage]) {
        return ZKOrig(void, orig);
    }
    
    NSString* identifier = [[[[orig representations] firstObject] valueForKey:@"_vectorGlyph"] valueForKey:@"_name"];
    
    MacOSXArtImage* image = PrefsIconMap[identifier];
    return (image && image != (id)[NSNull null]) ? ZKOrig(void, image) : ZKOrig(void, orig);
}

-(void)setBordered:(BOOL)flag {
    if(flag) {
        NSImage* image = [(NSButton*)self image];
        if ([[image className] isEqualTo:@"MacOSXArtImage"]) {
            [self setImage:TemplateMap[[[PrefsIconMap allKeysForObject:image] firstObject]]];
        }
    }
    ZKOrig(void, flag);
}
endhook

//finder

hook(TBrowserContentViewController)
- (NSLayoutConstraint *)makeStatusBarLeadingConstraint {
    NSLayoutConstraint* constraint = [[ZKOrig(NSLayoutConstraint*) firstAnchor] constraintEqualToAnchor:[[(NSViewController*)self view] leadingAnchor]];
    return constraint;
}
endhook

hook(TSidebarViewController)
- (void)outlineView:(id)view draggingEndedAt:(CGPoint)at operation:(unsigned long long)operation {
    if([(TSidebarViewController*)self dragShouldRemove])
        NSShowAnimationEffect(NSAnimationEffectPoof, [NSEvent mouseLocation], NSZeroSize, nil, nil, nil);
    ZKOrig(void, view, at, operation);
}
endhook

hook(TTextField)
- (void)setFrameOrigin:(NSPoint)origin {
    if ([[self valueForKey:@"identifier"] isEqualToString:@"xSidebarHeader"]) {
        origin.x = 6.0;
    }
    return ZKOrig(void, origin);
}
endhook

hook(TToolbarItemDropTargetView)
-(void)setImage:(NSImage*)orig {
    if (![orig _isSymbolImage]) {
        return ZKOrig(void, orig);
    }
    
    NSString* identifier = [[[[orig representations] firstObject] valueForKey:@"_vectorGlyph"] valueForKey:@"_name"];
    
    MacOSXArtTemplateImage* image = FinderIconMap[identifier];
    [image setSize:NSMakeSize(32, 32)];
    return (image && image != (id)[NSNull null]) ? ZKOrig(void, image) : ZKOrig(void, orig);
}
endhook
//end finder

//safari
hook(_TtC6Safari31CompletionListURLCompletionData)
-(long long)type {
    return 0;
}
-(NSString*)subtitle {
    return nil;
}
endhook

hook(_TtC6Safari24CompletionListActionData)
-(long long)type {
    return 0;
}
-(NSString*)subtitle {
    return nil;
}
endhook

hook(_TtC6Safari31CompletionListSuggestedSiteData)
-(long long)type {
    return 0;
}
-(NSString*)subtitle {
    return nil;
}
endhook

hook(_TtC6Safari36CompletionListQuickWebsiteSearchData)
-(long long)type {
    return 0;
}
-(NSString*)subtitle {
    return nil;
}
endhook

hook(_TtC6Safari35CompletionListPegasusSuggestionData)
-(long long)type {
    return 0;
}
-(NSString*)subtitle {
    return nil;
}
endhook

hook(_TtC6Safari40CompletionListSearchEngineSuggestionData)
-(NSString*)subtitle {
    return nil;
}
endhook

hook(_TtC6Safari24CompletionListBannerData)
-(long long)type {
    return 0;
}
-(NSString*)subtitle {
    return nil;
}
endhook

hook(_TtCC6Safari32CompletionListCollectionViewItem4View)
-(void)setFrame:(CGRect)frame {
    frame.origin.x -= 16;
    frame.size.width += 32;
    frame.size.height = 24;
    return ZKOrig(void, frame);
}
endhook

hook(BrowserWindow)
-(NSThemeFrame*)_themeFrame {
    return ZKOrig(NSThemeFrame*);
}

-(void)layoutIfNeeded {
    ZKOrig(void);
    [[[self _themeFrame] _titleTextField] setStringValue:[(NSWindow*)self title]];
}

-(void)updateCGSWindowTitle {
    ZKOrig(void);
    [[[self _themeFrame] _titleTextField] setStringValue:[(NSWindow*)self title]];
}

-(bool)_inLiveResize {
    NSRect titleBarRect = [[[self _themeFrame] titlebarView] frame];
    [[[self _themeFrame] _titleTextField] setFrameSize:[[[self _themeFrame] _titleTextField] sizeThatFits:NSMakeSize(titleBarRect.size.width - 111, 18)]];
    NSRect titleRect = [[[self _themeFrame] _titleTextField] frame];
    [[[self _themeFrame] _titleTextField] setFrameOrigin:NSMakePoint(MAX(titleBarRect.size.width * 0.5 - titleRect.size.width * 0.5, 68), titleRect.origin.y)];
    return ZKOrig(bool);
}
endhook

hook(FavoritesBarView)
- (void)_layOutButtons {
    ZKOrig(void);
    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Safari"]) {
        NSMutableArray *_buttons = [self valueForKey:@"_buttons"];
        for (NSButton* button in _buttons) {
            if ([_buttons indexOfObject:button] == 0) {
                [button setFrameOrigin:NSMakePoint(37, 5.5)];
            }
            else {
                NSButton *prevButton = [_buttons objectAtIndex:[_buttons indexOfObject:button] - 1];
                [button setFrameOrigin:NSMakePoint(NSMaxX([prevButton frame]), 5.5)];
            }
        }
    }
}
-(CGRect)frame {
    CGRect frame = ZKOrig(CGRect);
    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Safari"]) {
        CGRect frame2 = [[(NSView*)self superview] frame];
        frame2.size.height = 16;
        [[(NSView*)self superview] setFrame:frame2];
    }
    return frame;
}
endhook

hook(NSToolbarView)
-(void)setFrame:(CGRect)frame {
    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.Safari"] && frame.size.height == 34) {
        frame.size.height = 28;
    }
    return ZKOrig(void,frame);
}
endhook

hook(StartPageCollectionViewLayout)
-(void)setCenterContentVerticallyIfPossible:(bool)flag {
    return ZKOrig(void,false);
}
endhook

hook(TabBarView)
-(CGRect)frame {
    CGRect frame = ZKOrig(CGRect);
    frame.size.height = 24;
    return frame;
}
endhook

hook(ToolbarDownloadsButton)
- (void)layout {
    ZKOrig(void);
    NSView *progressBar = ZKHookIvar(self, NSView *, "_progressBar");
    NSRect frame = progressBar.frame;
    frame.origin.y = frame.origin.y - 5;
    progressBar.frame = frame;
}
endhook

hook(ToolbarButtonPlus)
-(void)setImage:(NSImage*)orig {
    if (![orig _isSymbolImage]) {
        return ZKOrig(void, orig);
    }
    
    NSString* identifier = [[[[orig representations] firstObject] valueForKey:@"_vectorGlyph"] valueForKey:@"_name"];
    
    MacOSXArtTemplateImage* image = TemplateMap[identifier];
    return (image && image != (id)[NSNull null]) ? ZKOrig(void, image) : ZKOrig(void, orig);
}
endhook

hook(TopSitesButton)
-(void)setFrame:(CGRect)frame {
    if([(NSButton*)self bezelStyle] != NSBezelStyleToolbar)
        frame.origin.y = 8;
    return ZKOrig(void,frame);
}
endhook

hook(UnifiedField)
- (CGRect)_adjustedProgressBarRectForValue:(double)value {
    CGRect rect = ZKOrig(CGRect, value);
    rect.size.height = 20.5;
    return rect;
}
- (double)_progressBarDrawingOffset {
    return -1.5;
}
- (id)_progressBarColor {
    return [[NSColor systemBlueColor] colorWithAlphaComponent:0.5];
}
- (double)_progressBarCornerRadius {
    return 0.0;
}
- (bool)_shouldLeftAlignContent {
    return true;
}
- (bool)_shouldSeparateTabBarAssistantButtonBeVisible {
    return false;
}
- (bool)_canShowOneStepBookmarkingButton {
    return false;
}
- (bool)_isMagnifyingGlassButtonVisible {
    return ZKOrig(bool);
}
- (bool)_shouldReserveSpaceForOneStepBookmarkingButton {
    return ![self _isMagnifyingGlassButtonVisible];
}
- (void)setBrowsingMode:(NSUInteger)flag {
    return;
}
- (CGFloat)_urlTextYOffset {
    return -3;
}
- (CGFloat)_defaultButtonYOffset {
    return -3;
}
- (CGFloat)_siteIconYOffset {
    return 1.5;
}
- (CGFloat)_urlTextHeight {
    return 22;
}
- (CGFloat)_urlFieldHeight {
    return 22;
}
-(void)setFrame:(CGRect)frame {
    frame.size.height = 22.0;
    frame.origin.y += 0.5;
    return ZKOrig(void,frame);
}
-(void)setBezelStyle:(NSTextFieldBezelStyle)style {
    return ZKOrig(void, NSBezelStyleTexturedRounded);
}
endhook

hook(UnifiedFieldBezelView)
- (void)_updateBackingMaterial {
    return;
}
-(void)setBrowsingMode:(NSUInteger)flag {
    return;
}
-(void)setBezelStyle:(NSTextFieldBezelStyle)style {
    return ZKOrig(void, NSBezelStyleTexturedRounded);
}
-(void)setFrame:(CGRect)frame {
    frame.size.height = 22.0;
    frame.origin.y += 0.5;
    return ZKOrig(void,frame);
}
- (void)drawRect:(NSRect)rect {
    ZKSuper(void, rect);
}
endhook
//end safari

//begin helpviewer
hook(DDMContext)
-(id)environmentName {
    return nil;
}
endhook
//end helpviewer

//mail
hook(MailBarContainerView)
-(CGRect)frame {
    CGRect frame = ZKOrig(CGRect);
    frame.size.height = 25;
    return frame;
}
endhook
//end mail

//ASP
hook(SPImageView)
-(bool)isHorizontalContentSizeConstraintActive {
    return false;
}
-(bool)isVerticalContentSizeConstraintActive {
    return false;
}
-(id)initWithFrame:(CGRect)frame {
    MacOSXLogo = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 216, 124)];
    [MacOSXLogo setImage:[bundle imageForResource:@"MacOSX"]];
    return ZKOrig(id, frame);
}
-(void)setFrame:(CGRect)rect {
    rect.size.height = 124;
    rect.origin.x = 32;
    rect.origin.y -= 14.5;
    [[[(NSView*)self subviews] firstObject] setHidden:true];
    [(NSView*)self addSubview:MacOSXLogo];
    [[(NSView*)self window] setStyleMask:[[(NSView*)self window] styleMask] & ~NSWindowStyleMaskFullSizeContentView];
    CGSize size = [[[(NSView*)self window] contentView] frame].size;
    size.height = 354;
    [[(NSView*)self window] setContentSize:size];
    [[(NSView*)self window] setTitle:@"About This Mac"];
    [[[(NSView*)self window] _themeFrame] setIdentifier:@"AquaMacOSXAbout"];
    [(NSVisualEffectView*)[[(NSView*)self window] contentView] setMaterial:NSVisualEffectMaterialWindowBackground];
    NSStackView* stackView = [[[(NSView*)self superview] subviews] objectAtIndex:1];
    NSTextField* mac = [[stackView subviews] firstObject];
    [mac setHidden:true];
    NSTextField* ver = [[stackView subviews] objectAtIndex:1];
    NSOperatingSystemVersion osver = [[NSProcessInfo processInfo] operatingSystemVersion];
    [ver setStringValue:[NSString stringWithFormat:@"Version %li.%li.%li", osver.majorVersion, osver.minorVersion, osver.patchVersion]];
    NSStackView* stackView2 = [[[(NSView*)self superview] subviews] objectAtIndex:2];
    NSStackView* badver = [[stackView2 subviews] objectAtIndex:4];
    [badver setHidden:true];
    
    return ZKOrig(void, rect);
}
endhook
//end ASP

//begin ichat
hook(CKUIBehaviorMac)
- (double)snapToMinConversationListCellWidth {
    return 250;
}
- (double)snapToMinConversationListWidth {
    return 270;
}
- (double)defaultConversationListWidth {
    return 270;
}
endhook

hook(IMFeatureFlags)
- (bool)macToolbarEnabled {
    return false;
}
endhook

hook(CKComposeRecipientView)
-(void)setFrame:(CGRect)frame {
    frame.origin.y -= 6;
    return ZKOrig(void, frame);
}
endhook

hook(CKNavigationBarCanvasView)
- (CGSize)sizeThatFits:(CGSize)a3 {
    CGSize orig = ZKOrig(CGSize);
    orig.height = 38;
    return orig;
}
- (void)setFrame:(CGRect)frame {
    return ZKOrig(void, frame);
}
- (CGRect)frame {
    return ZKOrig(CGRect);
}
- (void)layoutSubviews {
    CGRect frame = [self frame];
    frame.origin.y = -14;
    [self setFrame:frame];
    ZKOrig(void);
}
- (void)drawRect:(CGRect)rect{
    [self layoutSubviews];
    return ZKOrig(void, rect);
}
endhook

hook(_UIBarBackground)
-(void)setHidden:(bool)flag {
    return ZKOrig(void, ([[[(UIView*)self superview] className] isEqualToString:@"CKAvatarNavigationBar"] && [[[[(UIView*)self subviews] firstObject] className] isEqualToString:@"UIImageView"]) ? true : flag);
}

-(void)setFrame:(CGRect)frame {
    if([[[(UIView*)self superview] className] isEqualToString:@"CKAvatarNavigationBar"])
        frame.size.height -= 5;
    return ZKOrig(void, frame);
}
endhook

hook(CKLabel)
-(void)setFont:(UIFont*)font {
    if([[[(UIView*)self superview] className] isEqualToString:@"CKNavigationBarCanvasView"])
        return;
    return ZKOrig(void, font);
}
endhook
//end ichat
