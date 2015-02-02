# -*- coding: utf-8 -*-
# Deployment settings for c:\program files\marmalade\7.4\quick\target\win\quick_prebuilt.
# This file is autogenerated by the mkb system and used by the s3e deployment
# tool during the build process.

config = {}
cmdline = ['C:/Program Files/Marmalade/7.4/s3e/makefile_builder/mkb.py', 'c:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/DotsGeDots.mkb', '--deploy-only', '--hub-data', 'C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/project_DotsGeDots/mkb-quick.txt', '--buildenv=QUICK', '--use-prebuilt']
mkb = 'c:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/DotsGeDots.mkb'
mkf = ['c:\\program files\\marmalade\\7.4\\s3e\\s3e-default.mkf', 'c:\\program files\\marmalade\\7.4\\quick\\quick_prebuilt.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3efacebook\\s3efacebook.mkf', 'c:\\program files\\marmalade\\7.4\\modules\\iwutil\\iwutil.mkf', 'c:\\program files\\marmalade\\7.4\\modules\\third_party\\libjpeg\\libjpeg.mkf', 'c:\\program files\\marmalade\\7.4\\modules\\third_party\\libpng\\libpng.mkf', 'c:\\program files\\marmalade\\7.4\\modules\\third_party\\zlib\\zlib.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3ewebview\\s3ewebview.mkf', 'c:\\program files\\marmalade\\7.4\\modules\\iwbilling\\iwbilling.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3eamazoninapppurchasing\\s3eamazoninapppurchasing.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3eandroidmarketbilling\\s3eandroidmarketbilling.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3eandroidgoogleplaybilling\\s3eandroidgoogleplaybilling.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3ebbappworldbilling\\s3ebbappworldbilling.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3eiosappstorebilling\\s3eiosappstorebilling.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3ewindowsstorebilling\\s3ewindowsstorebilling.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3esamsunginapppurchasing\\s3esamsunginapppurchasing.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\fortumo\\fortumo.mkf', 'c:\\program files\\marmalade\\7.4\\extensions\\s3eflurry\\s3eflurry.mkf', 'c:\\program files\\marmalade\\7.4\\quick\\quick_prebuilt_options.mkf']

class DeployConfig(object):
    pass

######### ASSET GROUPS #############

assets = {}

assets['Default'] = [
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/s3eWebView.js', 's3eWebView.js', 0),
    ('c:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/resources', '.', 0),
]

assets['WebView32Assets'] = [
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/locales', 'locales', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/avcodec-53.dll', 'avcodec-53.dll', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/avformat-53.dll', 'avformat-53.dll', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/avutil-51.dll', 'avutil-51.dll', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/chrome.pak', 'chrome.pak', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/d3dcompiler_43.dll', 'd3dcompiler_43.dll', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/d3dx9_43.dll', 'd3dx9_43.dll', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/icudt.dll', 'icudt.dll', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/libcef.dll', 'libcef.dll', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/libEGL.dll', 'libEGL.dll', 0),
    ('c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/libGLESv2.dll', 'libGLESv2.dll', 0),
]

######### DEFAULT CONFIG #############

class DefaultConfig(DeployConfig):
    embed_icf = -1
    name = 'DotsGeDots'
    pub_sign_key = 0
    priv_sign_key = 0
    caption = 'DotsGeDots'
    long_caption = 'DotsGeDots'
    version = [0, 0, 1]
    config = ['c:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/resources/common.icf', 'c:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/resources/app.icf']
    data_dir = 'c:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/resources'
    mkb_dir = 'c:/Users/mokz/Desktop/DotsGeDots/DotsGeDots'
    iphone_link_lib = ['s3eFacebook', 's3eWebView', 's3eIOSAppStoreBilling', 'FlurryAnalytics', 's3eFlurry']
    osx_ext_dll = ['c:/program files/marmalade/7.4/extensions/s3ewebview/lib/osx/libs3eWebView.dylib', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/osx/libs3eFlurry.dylib']
    wp81_extra_pri = []
    ws8_ext_capabilities = []
    android_external_res = ['c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook-android-sdk/facebook/res', 'c:/program files/marmalade/7.4/extensions/s3eandroidgoogleplaybilling/source/android/res', 'c:/program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/source/android/res']
    win32_ext_dll = ['c:/program files/marmalade/7.4/extensions/s3ewebview/lib/win32/s3eWebView.dll', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/win32/s3eFlurry.dll']
    wp8_ext_capabilities = []
    ws8_extra_res = []
    ws81_ext_managed_dll = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/ws81/s3eFacebookManaged.winmd', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_ws81_lib/Facebook.Client.dll', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_ws8_lib/Facebook.dll', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/ws81/s3eWebViewManaged.winmd']
    iphone_link_libdir = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/iphone', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/iphone', 'c:/program files/marmalade/7.4/extensions/s3eiosappstorebilling/lib/iphone', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/iphone']
    wp81_ext_capabilities = []
    android_extra_application_manifest = ['c:/program files/marmalade/7.4/extensions/s3efacebook/source/android/extra_app_manifest.xml', 'c:/program files/marmalade/7.4/extensions/s3eamazoninapppurchasing/source/android/AmazonInAppPurchasingManifestSnippet.xml', 'c:/program files/marmalade/7.4/extensions/s3eandroidmarketbilling/s3eAndroidMarketBillingManifest.xml', 'c:/program files/marmalade/7.4/extensions/s3eandroidgoogleplaybilling/source/android/ExtraAppManifests.xml', 'c:/program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/source/android/ExtraAppManifests.xml', 'c:/program files/marmalade/7.4/extensions/fortumo/extras.application.txt']
    ws8_ext_native_dll = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/ws8/s3eFacebookExtension.dll', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/ws8/s3eWebViewExtension.dll']
    android_external_assets = []
    blackberry_extra_descriptor = []
    android_extra_manifest = ['c:/program files/marmalade/7.4/extensions/s3eandroidgoogleplaybilling/source/android/ExtraManifests.xml', 'c:/program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/source/android/ExtraManifests.xml', 'c:/program files/marmalade/7.4/extensions/fortumo/extras.manifest.txt']
    wp81_ext_sdk_ref = []
    iphone_link_libdirs = []
    wp81_ext_device_capabilities = []
    icon = 'c:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/resources/gfx/app_icon/icon.png'
    linux_ext_lib = []
    ws8_ext_managed_dll = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/ws8/s3eFacebookManaged.winmd', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_ws8_lib/Facebook.Client.dll', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_ws8_lib/Facebook.dll', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/ws8/s3eWebViewManaged.winmd']
    ws8_ext_sdk_manifest_part = []
    ws8_ext_device_capabilities = []
    ws81_extra_pri = []
    android_external_jars = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/android/s3eFacebook.jar', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook-android-sdk/libs/android-support-v4.jar', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook-android-sdk/libs/bolts.jar', 'c:/program files/marmalade/7.4/extensions/s3efacebook/lib/android/annotations-4.1.1.4.jar', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/android/s3eWebView.jar', 'c:/program files/marmalade/7.4/extensions/s3eamazoninapppurchasing/lib/android/s3eAmazonInAppPurchasing.jar', 'c:/program files/marmalade/7.4/extensions/s3eamazoninapppurchasing/lib/android/in-app-purchasing-1.0.3.jar', 'c:/program files/marmalade/7.4/extensions/s3eandroidmarketbilling/lib/android/s3eAndroidMarketBilling.jar', 'c:/program files/marmalade/7.4/extensions/s3eandroidgoogleplaybilling/lib/android/s3eAndroidGooglePlayBilling.jar', 'c:/program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/lib/android/s3eSamsungInAppPurchasing.jar', 'c:/program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/lib/android/iap2.0_lib.jar', 'c:/program files/marmalade/7.4/extensions/fortumo/lib/android/Fortumo.jar', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/android/s3eFlurry.jar', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/android/FlurryAgent.jar']
    win8_winrt_extra_res = ['c:/program files/marmalade/7.4/extensions/s3ewebview/source/ws8/WebViewModal.xaml=>']
    wp81_ext_sdk_manifest_part = []
    android_supports_gl_texture = []
    wp81_extra_res = ['c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_wp81_lib/Facebook.Client']
    wp81_ext_managed_dll = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/wp81/s3eFacebookManaged.winmd', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_wp81_lib/Facebook.Client.dll', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_wp81_lib/Facebook.dll', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/wp81/s3eWebViewManaged.winmd']
    ws81_ext_sdk_manifest_part = []
    ws81_ext_device_capabilities = []
    ws8_ext_sdk_ref = []
    iphone_extra_string = []
    tizen_so = []
    wp8_ext_native_dll = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/wp8/s3eFacebookExtension.dll', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/wp8/s3eWebViewExtension.dll', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/wp8/s3eFlurryExtension.dll']
    win8_phone_extra_res = []
    win8_store_extra_res = ['c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_ws8_lib/Facebook.Client']
    iphone_link_opts = ['-Fc:\\program files\\marmalade\\7.4/extensions/s3eFacebook/third-party/facebook-ios-sdk -framework FacebookSDK -weak_framework AdSupport -weak_framework Accounts -weak_framework Social -lsqlite3', '-framework SystemConfiguration -framework Security']
    ws81_ext_sdk_ref = []
    wp8_extra_res = ['c:/program files/marmalade/7.4/extensions/s3ewebview/source/wp8/WebBrowserModal.xaml=>']
    ws81_ext_native_dll = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/ws81/s3eFacebookExtension.dll', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/ws81/s3eWebViewExtension.dll']
    ws8_extra_pri = []
    wp8_ext_managed_dll = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/wp8/s3eFacebookManaged.dll', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_wp8_lib/Facebook.Client.dll', 'c:/program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook_wp8_lib/Facebook.dll', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/wp8/s3eWebViewManaged.dll', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/wp8/FlurryWP8SDK.dll', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/wp8/s3eFlurryManaged.dll']
    android_extra_packages = []
    android_so = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/android/libs3eFacebook.so', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/android/libs3eWebView.so', 'c:/program files/marmalade/7.4/extensions/s3eamazoninapppurchasing/lib/android/libs3eAmazonInAppPurchasing.so', 'c:/program files/marmalade/7.4/extensions/s3eandroidmarketbilling/lib/android/libs3eAndroidMarketBilling.so', 'c:/program files/marmalade/7.4/extensions/s3eandroidgoogleplaybilling/lib/android/libs3eAndroidGooglePlayBilling.so', 'c:/program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/lib/android/libs3eSamsungInAppPurchasing.so', 'c:/program files/marmalade/7.4/extensions/fortumo/lib/android/libFortumo.so', 'c:/program files/marmalade/7.4/extensions/s3eflurry/lib/android/libs3eFlurry.so']
    wp8_ext_sdk_ref = []
    osx_extra_res = []
    ws81_extra_res = []
    wp81_ext_native_dll = ['c:/program files/marmalade/7.4/extensions/s3efacebook/lib/wp81/s3eFacebookExtension.dll', 'c:/program files/marmalade/7.4/extensions/s3ewebview/lib/wp81/s3eWebViewExtension.dll']
    ws81_ext_capabilities = []
    iphone_link_libs = []
    android_extra_strings = '(app_id,fb_app_id)'
    target = {
         'gcc_x86' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\notavailable\quick_prebuilt_d.so',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\notavailable\quick_prebuilt.so',
                 },
         'gcc_x86_tizen' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\tizen\x86\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\tizen\x86\quick_prebuilt.s86',
                 },
         'wp8-arm' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\wp8\arm\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\wp8\arm\quick_prebuilt.s86',
                 },
         'firefoxos' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\notavailable\quick_prebuilt_d.js',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\notavailable\quick_prebuilt.js',
                 },
         'wp8-x86' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\wp8\x86\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\wp8\x86\quick_prebuilt.s86',
                 },
         'wp81-arm' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\wp81\arm\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\wp81\arm\quick_prebuilt.s86',
                 },
         'wp81-x86' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\wp81\x86\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\wp81\x86\quick_prebuilt.s86',
                 },
         'ws8-x86' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\ws8\x86\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\ws8\x86\quick_prebuilt.s86',
                 },
         'mips_gcc' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\android\mips\quick_prebuilt_d.so',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\android\mips\quick_prebuilt.so',
                 },
         'ws81-arm' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\ws81\arm\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\ws81\arm\quick_prebuilt.s86',
                 },
         'ws8-arm' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\ws8\arm\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\ws8\arm\quick_prebuilt.s86',
                 },
         'arm_gcc' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\arm\quick_prebuilt_d.s3e',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\arm\quick_prebuilt.s3e',
                 },
         'mips' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\android\mips\quick_prebuilt_d.so',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\android\mips\quick_prebuilt.so',
                 },
         'gcc_x86_android' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\android\x86\quick_prebuilt_d.so',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\android\x86\quick_prebuilt.so',
                 },
         'arm' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\arm\quick_prebuilt_d.s3e',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\arm\quick_prebuilt.s3e',
                 },
         'ws81-x86' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\ws81\x86\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\ws81\x86\quick_prebuilt.s86',
                 },
         'x86' : {
                   'debug'   : r'c:\program files\marmalade\7.4\quick\target\win\quick_prebuilt_d.s86',
                   'release' : r'c:\program files\marmalade\7.4\quick\target\win\quick_prebuilt.s86',
                 },
        }
    arm_arch = ''
    assets_original = assets
    assets = assets['Default']

default = DefaultConfig()

######### Configuration: Windows

c = DeployConfig()
config['Windows'] = c
c.os = ['win32']
c.arch = ['x86']
c.target_folder = 'Windows'

######### Configuration: Mac OS X

c = DeployConfig()
config['Mac OS X'] = c
c.os = ['osx']
c.arch = ['x86']
c.target_folder = 'Mac OS X'
