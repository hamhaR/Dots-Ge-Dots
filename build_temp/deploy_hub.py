# -*- coding: utf-8 -*-
#
# (C) 2001-2012 Marmalade. All Rights Reserved.
#
# This document is protected by copyright, and contains information
# proprietary to Marmalade.
#
# This file consists of source code released by Marmalade under
# the terms of the accompanying End User License Agreement (EULA).
# Please do not use this program/source code before you have read the
# EULA and have agreed to be bound by its terms.
#
import deploy_config

config = deploy_config.config
cmdline = deploy_config.cmdline
mkb = deploy_config.mkb
mkf = deploy_config.mkf

assets = deploy_config.assets

class HubConfig(deploy_config.DefaultConfig):
    android_icon_group = {}
    android_external_res = [ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3efacebook/third-party/facebook-android-sdk/facebook/res", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3eandroidgoogleplaybilling/source/android/res", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/source/android/res"]
    android_install_location = 1
    android_pkgname = r"com.mokz.DotsGeDots"
    assets = assets["Default"]
    config = [ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/resources/common.icf", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/resources/app.icf"]
    name = ur"DotsGeDots"
    caption = ur"DotsGeDots"
    provider = ur"mokz"
    copyright = ur"(C) mokz"
    version = [0, 0, 1]
    android_extra_manifest = [ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3eandroidgoogleplaybilling/source/android/ExtraManifests.xml", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/source/android/ExtraManifests.xml", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/fortumo/extras.manifest.txt"]
    android_extra_application_manifest = [ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3efacebook/source/android/extra_app_manifest.xml", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3eamazoninapppurchasing/source/android/AmazonInAppPurchasingManifestSnippet.xml", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3eandroidmarketbilling/s3eAndroidMarketBillingManifest.xml", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3eandroidgoogleplaybilling/source/android/ExtraAppManifests.xml", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/s3esamsunginapppurchasing/source/android/ExtraAppManifests.xml", ur"C:/Users/mokz/Desktop/DotsGeDots/DotsGeDots/../../../../../program files/marmalade/7.4/extensions/fortumo/extras.application.txt"]
    android_extra_strings = ur"(app_id,fb_app_id)"
    pass

default = HubConfig()
