//
// And so, it was told that the Phoenix shall be followed by a Dove; one of great strength and great beauty, to help carry out its conquest.

//
// Copyright (C) 2024-2026 celenity
//
// This file is part of Dove.
//
// Dove is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
// Dove is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with Dove. If not, see https://www.gnu.org/licenses/.
//

// Built from Phoenix (Extended)

pref("mail.dove.version", "{DOVE_VERSION}", locked);

/// Add custom branding at `about:support`
pref("app.support.vendor", "Dove: {DOVE_VERSION} | Phoenix: {PHOENIX_VERSION}"); // [HIDDEN]

/// Add custom branding under `Thunderbird Updates` at `about:preferences#general`
pref("distribution.about", "Dove for Mozilla Thunderbird - {DOVE_VERSION} 💜", locked); // [HIDDEN]
pref("distribution.id", "default", locked); // [HIDDEN]
pref("distribution.version", "default", locked); // [HIDDEN]

/* INDEX 

001: DATA COLLECTION
002: MOZILLA CRAP™
003: TRACKING PROTECTION
004: INFORMATION LEAKAGE
005: FINGERPRINTING PROTECTION
006: DISK AVOIDANCE
007: DOWNLOADS
008: E2EE
009: NETWORKING
010: UI
011: ATTACK SURFACE REDUCTION
012: PASSWORDS & AUTHENTICATION
013: EXTENSIONS
014: CARDBOOK
015: MISC. PRIVACY + SECURITY
016: MISC. PRIVACY
017: MISC. SECURITY
018: MISC.
019: Personal Touch 💜
020: SPECIALIZED/CUSTOM CONFIGS

*/

/* KEY

Unspecified = This preference should be set EVERYWHERE

[LINUX-ONLY] = This preference should ONLY be set for GNU/Linux
[FLATPAK-LINUX-ONLY] = This preference should ONLY be set for GNU/Linux (Flatpak)
[INTEL-OSX-ONLY] = This preference should ONLY be set for macOS on Intel
[LINUX-NON-FLATPAK-ONLY] = This preference should ONLY be set for GNU/Linux (non-Flatpak)
[OSX-ONLY] = This preference should ONLY be set for macOS
[SILICON-OSX-ONLY] = This preference should ONLY be set for macOS on Apple Silicon
[WINDOWS-ONLY] = This preference should ONLY be set for Windows

[NO-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (Flatpak)
[NO-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux
[NO-NON-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (non-Flatpak)
[NO-OSX] = This preference should be set everywhere, EXCEPT for macOS
[NO-INTEL-OSX] = This preference should be set everywhere, EXCEPT for macOS on Intel
[NO-SILICON-OSX] = This preference should be set everywhere, EXCEPT for macOS on Apple Silicon
[NO-WINDOWS] = This preference should be set everywhere, EXCEPT for Windows

*/

pref("mail.dove.status", "000");

/*** 001 DATA COLLECTION ***/

/// Disable Ecosystem Telemetry
// https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/obsolete/ecosystem-telemetry.html
pref("toolkit.telemetry.ecosystemtelemetry.enabled", false, locked); // [DEFAULT - non-Nightly]

pref("mail.dove.status", "001");

/*** 002 MOZILLA CRAP™ ***/

/// Clear unnecessary/undesired Mozilla URLs
pref("mail.pgpmime.addon_url", ""); // Contains a link to Enigmail - a now dead extension that used to provide E2EE for Thunderbird (before it was built-in like it is nowadays...) - Likely not used anywhere
pref("toolkit.crashreporter.infoURL", "");

/// Disable Donation Prompts
// Please still donate to Thunderbird if you appreciate it! ;)
// https://www.thunderbird.net/?form=support
pref("app.donation.eoy.url", "", locked);
pref("app.donation.eoy.version.viewed", 99, locked);

/// Disable the Email Provisioner
// Used for creating new email addresses with Mozilla's "partners"
pref("mail.provider.enabled", false);
pref("mail.provider.suppress_dialog_on_startup", true); // [HIDDEN]

/// Disable Filelink
// https://support.mozilla.org/kb/filelink-large-attachments
pref("mail.cloud_files.enabled", false);

/// Disable 'In-App Notifications'
// https://searchfox.org/comm-central/source/mail/components/inappnotifications/docs/index.md
pref("mail.inappnotifications.blog_enabled", false, locked); // [NIGHTLY] Surveys
pref("mail.inappnotifications.donation_enabled", false, locked); // [NIGHTLY] Donation prompts/fundraisers
pref("mail.inappnotifications.enabled", false);
pref("mail.inappnotifications.message_enabled", false); // [NIGHTLY] Updates

/// Disable onboarding
// https://searchfox.org/comm-central/source/suite/components/nsSuiteGlue.js#965
pref("browser.EULA.override", true);
pref("browser.rights.override", true);
pref("mail.rights.override", true); // [DEFAULT - Debug/non-MOZILLA_OFFICIAL builds]
pref("mailnews.start_page_override.mstone", "ignore", locked);

/// Disable recommendations
pref("extensions.getAddons.recommended.url", "");

/// Disable start page by default and switch the URL to `about:config`
// This allows users to easily access `about:config` via the menu bar from `Go` -> `Mail Start Page`
// Or by pressing alt + home
pref("mailnews.start_page.enabled", false);
pref("mailnews.start_page.override_url", "");
pref("mailnews.start_page.url", "about:config");

/// Disable surveys
pref("app.survey.version.viewed", 99, locked); // [HIDDEN]

/// Prevent checking if Thunderbird is the default mail client
pref("mail.shell.checkDefaultClient", false);

/// Prevent checking if Thunderbird is the default PDF viewer
pref("pdfjs.firstRun", false);

/// Remove Mozilla partner/search parameter
// https://searchfox.org/comm-central/source/mozilla/toolkit/components/search/AppProvidedSearchEngine.sys.mjs
// https://searchfox.org/comm-central/source/mail/branding/include/release-prefs.js
pref("browser.search.param.ms-pc", "", locked);

/// Remove tracking parameters from Mozilla URLs + prevent exposing locale & unnecessary information
// For info on the extension update (`extensions.update.`) URL parameters, see https://devdoc.net/web/developer.mozilla.org/en-US/docs/Install_Manifests.html & https://mozilla-balrog.readthedocs.io/en/latest/database.html
pref("app.releaseNotesURL", "https://www.thunderbird.net/releases", locked);
pref("app.releaseNotesURL.aboutDialog", "https://www.thunderbird.net/releases", locked);
pref("app.releaseNotesURL.prompt", "https://www.thunderbird.net/releases", locked);
pref("app.vendorURL", "https://www.thunderbird.net/", locked);
pref("browser.dictionaries.download.url", "https://addons.thunderbird.net/language-tools/");
pref("extensions.getAddons.compatOverides.url", "https://services.addons.thunderbird.net/api/v4/addons/compat-override/?guid=%IDS%"); // Also updates to the newer v4 API (default is still v3...) - https://mozilla.github.io/addons-server/topics/api/overview.html#api-versions - though I doubt this URL is used anywhere
pref("extensions.getAddons.link.url", "https://addons.thunderbird.net/");
pref("extensions.getAddons.search.browseURL", "https://addons.thunderbird.net/search/?q=%TERMS%");
pref("extensions.getAddons.search.url", "https://services.addons.thunderbird.net/api/%API_VERSION%/search/%TERMS%/all/%MAX_RESULTS%/");
pref("extensions.update.background.url", "https://versioncheck-bg.addons.thunderbird.net/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&currentAppVersion=%CURRENT_APP_VERSION%&updateType=%UPDATE_TYPE%"); // Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), and compatibility mode (compatMode)
pref("extensions.update.url", "https://versioncheck.addons.thunderbird.net/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&currentAppVersion=%CURRENT_APP_VERSION%&updateType=%UPDATE_TYPE%"); // Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), and compatibility mode (compatMode)
pref("mail.cloud_files.learn_more_url", "https://support.mozilla.org/kb/filelink-large-attachments");
pref("mail.ignore_thread.learn_more_url", "https://support.mozilla.org/kb/ignore-threads");
pref("spellchecker.dictionaries.download.url", "https://addons.thunderbird.net/language-tools/");

pref("mail.dove.status", "002");

/*** 003 TRACKING PROTECTION ***/

/// Ensure no domains can bypass privacy controls (like mailnews.message_display.disable_remote_image) by default
// https://searchfox.org/comm-central/rev/ed9d9054/mailnews/mailnews.js#802
pref("mail.trusteddomains", ""); // [DEFAULT]

/// Prevent messages from loading remote content
// This still allows adding exceptions
// https://support.mozilla.org/kb/remote-content-in-messages
pref("mailnews.message_display.disable_remote_image", true, locked); // [DEFAULT]

pref("mail.dove.status", "003");

/*** 004 INFORMATION LEAKAGE ***/

/// Disable CLIENTID
// https://bugzilla.mozilla.org/show_bug.cgi?id=1565379
// https://searchfox.org/comm-central/rev/19254da8/mailnews/mailnews.js#499
// https://searchfox.org/comm-central/rev/19254da8/mailnews/mailnews.js#496
pref("mail.server.default.clientid", ""); // [DEFAULT]
pref("mail.server.default.clientidEnabled", false); // [DEFAULT]
pref("mail.smtpserver.default.clientid", ""); // [DEFAULT]
pref("mail.smtpserver.default.clientidEnabled", false); // [DEFAULT]

/// Disable reporting chat idle status [CHAT]
pref("messenger.status.reportIdle", false); // [CHAT]

/// Disable reporting chat status as 'away' when idle [CHAT]
// Defense in depth
pref("messenger.status.awayWhenIdle", false); // [CHAT]

/// Disable sending chat typing notifications [CHAT]
pref("purple.conversations.im.send_typing", false); // [CHAT]

/// Disable sending read receipts
pref("mail.mdn.report.enabled", false);
pref("mail.mdn.report.not_in_to_cc", 0);
pref("mail.mdn.report.outside_domain", 0);
pref("mail.mdn.report.other", 0);
pref("mail.server.default.mdn_not_in_to_cc", 0);
pref("mail.server.default.mdn_other", 0);
pref("mail.server.default.mdn_outside_domain", 0);
pref("mail.server.default.mdn_report_enabled", false);
pref("purple.conversations.im.send_read", false); // [CHAT]

/// Disable sending user agent with emails
// Unnecessary, not defined in spec, and leaks information
// https://bugzilla.mozilla.org/show_bug.cgi?id=1114475
pref("mailnews.headers.sendUserAgent", false);
pref("mailnews.headers.useMinimalUserAgent", true); // [DEFENSE IN DEPTH] [DEFAULT]

/// Disable submission of IMAP RFC 2971 ID info
// https://datatracker.ietf.org/doc/html/rfc2971
// Used for analytics/data collection by design:
// "The ID extension to the Internet Message Access Protocol - Version4rev1(IMAP4rev1) protocol allows the server and client to exchange identification information on their implementation in order to make bug reports and usage statistics more complete."
// https://searchfox.org/comm-central/rev/19254da8/mailnews/mailnews.js#548
pref("mail.server.default.send_client_info", false);

/// Prevent leaking local IP addresses with emails via EHLO/HELO
// https://blog.plee.me/2014/11/mozilla-thunderbird-changing-the-ehlo-helo-value-in-the-received-header-for-outgoing-mail/
pref("mail.smtpserver.default.hello_argument", "[127.0.0.1]"); // [HIDDEN]

/// Prevent leaking locale and date/time in email replies
pref("mailnews.reply_header_authorwroteondate", "#1 wrote on #2 #3:");
pref("mailnews.reply_header_authorwrotesingle", "#1 wrote:");
pref("mailnews.reply_header_ondateauthorwrote", "On #2 #3, #1 wrote:");
pref("mailnews.reply_header_type", 1);

/// Prevent leaking locale and time with emails through the date header
// https://bugzilla.mozilla.org/show_bug.cgi?id=1603359
pref("mail.sanitize_date_header", true);

/// Prevent leaking spellcheck dictionary info with emails
// https://bugzilla.mozilla.org/show_bug.cgi?id=1370217
pref("mail.suppress_content_language", true);

/// Prevent sending usernames to your email provider as part of Autoconfiguration
// https://searchfox.org/comm-central/source/mailnews/mailnews.js#1024
pref("mailnews.auto_config.fetchFromISP.sendEmailAddress", false);

pref("mail.dove.status", "004");

/*** 005 FINGERPRINTING PROTECTION ***/

/// Ensure we always report "video-dynamic-range" as "standard"
// This does the same thing as the 'CSSVideoDynamicRange' RFP/FPP target (so it shouldn't interfere with FPP/RFP) - but I also want to set this here to ensure users are always protected if they disable FPP for whatever reason, and because we simply don't need this functionality at all for our use case...
// https://searchfox.org/mozilla-central/rev/20fc11f1/layout/style/nsMediaFeatures.cpp#345
// https://developer.mozilla.org/docs/Web/CSS/@media/video-dynamic-range
pref("layout.css.video-dynamic-range.allows-high", false); // [DEFAULT - Windows]

/// Harden FPP
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Features#fingerprinting
// and here: https://codeberg.org/celenity/Phoenix/wiki/Extended.md#fingerprinting
// We're removing -CanvasExtractionBeforeUserInputIsBlocked as Thunderbird simply doesn't support these permission prompts for canvas data extraction...
// (We're setting -EfficientCanvasRandomization for now to work-around an upstream bug that prevents randomization from applying everywhere as expected: https://bugzilla.mozilla.org/show_bug.cgi?id=2013976)
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme,-EfficientCanvasRandomization,-FrameRate");

/// Set FPP granular overrides
// This currently:
// Resets Phoenix's overrides (Meant for browsers, may have undesired implications for our use case - we can add back ones actually relevant to us though as needed...)
// Spoofs 'CSSPrefersColorScheme' (+CSSPrefersColorScheme) for 'thunderbird.net' - doesn't support dark mode, so unnecessary...
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain":"thunderbird.net","overrides":"+CSSPrefersColorScheme"}]');

pref("mail.dove.status", "005");

/*** 006 DISK AVOIDANCE ***/

/// Disable browsing history
pref("places.history.enabled", false);

/// Disable disk cache
// https://searchfox.org/comm-central/rev/19254da8/mailnews/mailnews.js#1072
pref("mail.imap.use_disk_cache2", false);

/// Disable the display of "recent" directories in the folder picker
// https://searchfox.org/comm-central/rev/19254da8/mailnews/mailnews.js#194
pref("mail.folder_widget.max_recent", 0);

/// Disable favicons
pref("browser.chrome.favicons", false);
pref("browser.chrome.guess_favicon", false);
pref("browser.chrome.site_icons", false);

/// Disable frecency
pref("places.frecency.unvisitedBookmarkBonus", 0); // [HIDDEN]

/// Disable logging chat history [CHAT]
// https://stackoverflow.com/questions/32155137/how-to-disable-chat-history-in-mozilla-thunderbird
pref("purple.logging.log_chats", false); // [CHAT]
pref("purple.logging.log_ims", false); // [CHAT]

/// Disable logging E2EE messages (OTR) [CHAT]
pref("chat.otr.default.allowMsgLog", false); // [CHAT]

/// Disable session restore
pref("browser.sessionhistory.max_entries", 0); // [HIDDEN]
pref("browser.sessionstore.debug.no_auto_updates", true);
pref("browser.sessionstore.restore_windows_to_virtual_desktop", false);

/// Prevent permission manager from writing to disk
pref("permissions.memory_only", true); // [HIDDEN]

/// Prevent leaking info in chat notifications [CHAT]
pref("mail.chat.notification_info", 2); // [CHAT]

/// Prevent leaking info in email alerts/notifications
pref("mail.biff.alert.show_preview", false);
pref("mail.biff.alert.show_sender", false);
pref("mail.biff.alert.show_subject", false);

/// Prevent storing cookies persistently
// Unfortunately, Private Browsing mode currently breaks extensions (unless they're manually added to policies...)
// So for now, this is best option we have; treats cookies the same way as they are in private browsing, by preventing them from being stored persistently
// https://bugzilla.mozilla.org/show_bug.cgi?id=1675829
pref("network.cookie.noPersistentStorage", true);

pref("mail.dove.status", "006");

/*** 007 DOWNLOADS ***/

/// Alert users when downloads are initiated (and completed)
// https://searchfox.org/comm-central/source/mail/app/profile/all-thunderbird.js#505
pref("browser.download.manager.focusWhenStarting", true);
pref("browser.download.manager.showAlertOnComplete", true);
pref("browser.download.manager.showWhenStarting", true);

/// Show a progress dialog for downloads
// https://searchfox.org/comm-central/source/suite/app/profile/suite-prefs.js#708
pref("browser.download.manager.behavior", 1); // [HIDDEN]

pref("mail.dove.status", "007");

/*** 008 E2EE ***/

/// Automatically encrypt when possible
pref("mail.e2ee.auto_enable", true);

/// Enable advanced E2EE settings
// https://searchfox.org/comm-central/source/mail/extensions/am-e2e/prefs/e2e-prefs.js#104
pref("temp.openpgp.advancedUser", true);

/// Enable Off-the-record messaging (OTR) [CHAT]
// https://wikipedia.org/wiki/Off-the-Record_Messaging
// https://wiki.mozilla.org/Thunderbird:OTR
// https://searchfox.org/comm-central/source/mail/locales/en-US/messenger/otr/am-im-otr.ftl
pref("chat.otr.enable", true); // [DEFAULT] [CHAT]

/// Never automatically disable E2EE...
// https://searchfox.org/comm-central/source/mail/extensions/am-e2e/prefs/e2e-prefs.js#67
pref("mail.e2ee.auto_disable", false, locked); // [DEFAULT]

/// Notify when E2EE is disabled
pref("mail.e2ee.notify_on_auto_disable", true, locked); // [DEFAULT]

/// Notify when E2EE is possible
pref("mail.openpgp.remind_encryption_possible", true); // [DEFAULT]
pref("mail.smime.remind_encryption_possible", true); // [DEFAULT]

/// Prevent accepting insecure S/MIME signatures
// https://searchfox.org/comm-central/source/mail/extensions/am-e2e/prefs/e2e-prefs.js#95
pref("mail.smime.accept_insecure_sha1_message_signatures", false); // [DEFAULT]

/// Remind users to verify unverified contacts (OTR) [CHAT]
// https://searchfox.org/comm-central/source/mail/locales/en-US/messenger/otr/am-im-otr.ftl
pref("chat.otr.default.verifyNudge", true); // [DEFAULT] [CHAT]

/// Require E2EE for chat conversations by default (OTR) [CHAT]
// https://searchfox.org/comm-central/source/mail/locales/en-US/messenger/otr/am-im-otr.ftl
pref("chat.otr.default.requireEncryption", true); // [CHAT]

/// Sign messages by default
/// https://searchfox.org/comm-central/source/mail/extensions/am-e2e/prefs/e2e-prefs.js#12
pref("mail.identity.default.sign_mail", true);

/// Use GnuPG if built-in RNP fails
// https://wiki.mozilla.org/Thunderbird:OpenPGP:Smartcards#Allow_the_use_of_external_GnuP
pref("mail.openpgp.allow_external_gnupg", true);

/// Warn users when using a deprecated version of GnuPG
pref("temp.openpgp.warnDeprecatedGnuPG", true); // [DEFAULT]

pref("mail.dove.status", "008");

/*** 009 NETWORKING ***/

/// Block Private Network Access requests unconditionally
pref("network.lna.blocking", true);

/// Customize list of built-in DoH resolvers
pref("network.trr.resolvers", '[{"url":"https://base.dns.mullvad.net/dns-query","name":"Mullvad (Base) 🇸🇪"},{"url":"https://mozilla.cloudflare-dns.com/dns-query","name":"Cloudflare 🇺🇸"},{"url":"https://security.cloudflare-dns.com/dns-query","name":"Cloudflare (Malware Protection) 🇺🇸"},{"url":"https://noads.joindns4.eu/dns-query","name":"DNS4EU (Ad Blocking) 🇨🇿"},{"url":"https://protective.joindns4.eu/dns-query","name":"DNS4EU (Protective) 🇨🇿"},{"url":"https://unfiltered.joindns4.eu/dns-query","name":"DNS4EU (Unfiltered) 🇨🇿"},{"url":"https://dns.mullvad.net/dns-query","name":"Mullvad (Unfiltered) 🇸🇪"}]'); // [HIDDEN] [ESR] - Thunderbird now uses the same pref as Firefox (`doh-rollout.provider-list`), which is set by Phoenix

/// Disable link previews
pref("mail.compose.add_link_preview", false);

/// Disable network connectivity status monitoring
// (Ex. used for automatically switching between offline & online mode)
pref("offline.autoDetect", false);

/// Disable origin headers
pref("network.http.sendOriginHeader", 0);

/// Disable referers
pref("network.http.referer.defaultPolicy", 0);
pref("network.http.referer.defaultPolicy.pbmode", 0);
pref("network.http.referer.defaultPolicy.trackers", 0);
pref("network.http.referer.defaultPolicy.trackers.pbmode", 0);
pref("network.http.referer.sendFromRefresh", false);
pref("network.http.referer.trimmingPolicy", 2);
pref("network.http.sendRefererHeader", 0);

/// Enable + hard-fail OCSP revocation checks
// We unfortunately still need this, since CRLite is currently broken on Thunderbird for users not using Firefox's Remote Settings instance (which requires setting the `MOZ_REMOTE_SETTINGS_DEVTOOLS` environment variable for non-Nightly builds)
// We need to find a way to set that variable for Thunderbird by default - and once we do (or, ideally, once Mozilla actually fixes CRLite for Thunderbird...), I'll remove this - but we'll keep for now due to that reason
// NOTE: We do have checks in `dove-user-pref.cfg` to disable OCSP (the following prefs) if the Remote Settings instance is set correctly
// https://wikipedia.org/wiki/Online_Certificate_Status_Protocol
// https://github.com/arkenfox/user.js/issues/1576
pref("security.OCSP.enabled", 1); // [DEFAULT]
pref("security.OCSP.require", true);

/// Prompt before going online on Thunderbird's launch
pref("offline.startup_state", 1);

/// Use secure connections for Autoconfiguration
// https://www.bucksch.org/1/projects/thunderbird/autoconfiguration/
pref("mailnews.auto_config.fetchFromISP.sslOnly", true);
pref("mailnews.auto_config.guess.requireGoodCert", true); // [DEFAULT]
pref("mailnews.auto_config.guess.sslOnly", true);

/// Warn on insecure connections
// Unclear whether used
pref("security.warn_entering_weak", true);
pref("security.warn_leaving_secure", true);
pref("security.warn_viewing_mixed", true);

pref("mail.dove.status", "009");

/*** 010 UI ***/

/// Enable the menu item to display a message body as all body parts
// (Located at View > Message body as > All body parts)
pref("mailnews.display.show_all_body_parts_menu", true);

/// Show email information + headers
pref("mail.show_headers", 2);
pref("mailnews.display.date_senders_timezone", true); // Displays timezone of sender
pref("mailnews.headers.showArchivedAt", true);
pref("mailnews.headers.showListArchive", true);
pref("mailnews.headers.showListHelp", true);
pref("mailnews.headers.showListOwner", true);
pref("mailnews.headers.showListPost", true);
pref("mailnews.headers.showListSubscribe", true);
pref("mailnews.headers.showListUnsubscribe", true);
pref("mailnews.headers.showMessageId", true);
pref("mailnews.headers.showOrganization", true);
pref("mailnews.headers.showReferences", true);
pref("mailnews.headers.showSender", true);
pref("mailnews.headers.showUserAgent", true);

/// Show full email addresses
pref("mail.addressDisplayFormat", 0); // [HIDDEN] [DEFAULT] Sets preferred address display format to "Full name and email address"
pref("mail.showCondensedAddresses", false);

pref("mail.dove.status", "010");

/*** 011 ATTACK SURFACE REDUCTION ***/

/// Disable Android Debugging
pref("devtools.remote.adb.extensionID", "");
pref("devtools.remote.adb.extensionURL", "");

/// Disable the Audio Output Devices API
// https://developer.mozilla.org/docs/Web/API/Audio_Output_Devices_API
pref("media.setsinkid.enabled", false);
pref("permissions.default.speaker", 2); // [HIDDEN] - 0: Always ask, 2: Block

/// Disable DRM/EME
pref("media.eme.encrypted-media-encryption-scheme.enabled", false);
pref("media.eme.hdcp-policy-check.enabled", false);
pref("media.gmp-widevinecdm.visible", false);
pref("media.gmp-widevinecdm-l1.visible", false);

/// Disable FFmpeg
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=ffmpeg
pref("media.ffmpeg.enabled", false);
pref("media.ffmpeg.encoder.enabled", false); // [DEFAULT]
pref("media.ffmpeg.vaapi.enabled", false); // [DEFAULT]

/// Disable Firefox Translations
// The code is technically present in Thunderbird (ex. `about:translations` is accessible...), but it currently doesn't seem possible to actually download any language models from Remote Settings,so it's useless :/
pref("browser.ai.control.translations", "blocked");
pref("browser.translations.automaticallyPopup", false);
pref("browser.translations.enable", false); // [DEFAULT]
pref("browser.translations.select.enable", false); // [DEFAULT]
pref("browser.translations.simulateUnsupportedEngine", true);

/// Disable GMP decoding
pref("media.gmp.decoder.enabled", false);

/// Disable media control
// https://searchfox.org/firefox-main/source/dom/media/mediacontrol/MediaControlKeyManager.cpp
// https://support.mozilla.org/kb/control-audio-or-video-playback-your-keyboard
pref("media.hardwaremediakeys.enabled", false);

/// Disable Media Source Extensions
// This API is used to support advanced media playback (ex. adaptive streaming) via JavaScript
// https://wikipedia.org/wiki/Media_Source_Extensions
// https://developer.mozilla.org/docs/Web/API/Media_Source_Extensions_API
// https://www.w3.org/TR/media-source/
// https://docs.webkit.org/Deep%20Dive/Modules/MediaSourceExtensions.html
pref("media.mediasource.enabled", false);
pref("media.mediasource.experimental.enabled", false); // [DEFAULT]
pref("media.mediasource.mp4.enabled", false);
pref("media.mediasource.vp9.enabled", false);
pref("media.mediasource.webm.enabled", false);

/// Disable Narrator
// Broken on Thunderbird
pref("narrate.enabled", false);

/// Disable Reader Mode
// Broken on Thunderbird
pref("reader.parse-on-load.enabled", false);

/// Disable shared memory and atomics (for JavaScript/WASM)
// Helps mitigate against Spectre-like attacks
// NOTE: This breaks Firefox Translations - which is fine here because we don't support it
// https://jsschools.com/web_dev/webassemblys-shared-memory-unleash-desktop-level/
// https://searchfox.org/firefox-main/rev/52e25e8b/js/src/shell/js.cpp#12887
// https://searchfox.org/firefox-main/rev/52e25e8b/js/moz.configure#798
pref("javascript.options.shared_memory", false);

/// Disable the Web Audio API
// https://developer.mozilla.org/docs/Web/API/Web_Audio_API
// We don't want/meed audio or the capabilities exposed by this...
pref("dom.webaudio.enabled", false);

/// Disable the WebCodecs API
// This API provides low-level access to platform media codecs
// https://developer.mozilla.org/docs/Web/API/WebCodecs_API
// https://w3c.github.io/webcodecs/#security-considerations
// https://w3c.github.io/webcodecs/#privacy-considerations
pref("dom.media.webcodecs.enabled", false);
pref("dom.media.webcodecs.h265.enabled", false); // [DEFAULT - non-Nightly]
pref("dom.media.webcodecs.image-decoder.enabled", false);

/// Disable WebRTC
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=webrtc
// https://x.com/GrapheneOS/status/1728921946396725618
pref("media.peerconnection.enabled", false);

/// Disable Windows Media Foundation Media Engine [WINDOWS-ONLY]
// By default, it's enabled for protected content (DRM) [WINDOWS-ONLY]
// https://learn.microsoft.com/windows/win32/medfound/about-the-media-foundation-sdk [WINDOWS-ONLY]
pref("media.wmf.media-engine.enabled", 0); // [WINDOWS-ONLY]

pref("mail.dove.status", "011");

/*** 012 PASSWORDS & AUTHENTICATION ***/

/// Allow cross-origin sub-resources to open HTTP authentication dialogs
// Required for password-protected CalDAV sync
// https://codeberg.org/celenity/Dove/issues/25
// Test: https://www.caldavserver.com/DAV
// We still at least prevent cross-origin images from opening these dialogs... (network.auth.subresource-img-cross-origin-http-auth-allow)
pref("network.auth.non-web-content-triggered-resources-http-auth-allow", true); // [DEFAULT]
pref("network.auth.subresource-http-auth-allow", 2); // [DEFAULT]

/// Disable support for Firefox Relay
// Unwanted/unused here
pref("signon.firefoxRelay.base_url", "");
pref("signon.firefoxRelay.feature", "not available");
pref("signon.firefoxRelay.learn_more_url", "");
pref("signon.firefoxRelay.manage_url", "");
pref("signon.firefoxRelay.privacy_policy_url", "");
pref("signon.firefoxRelay.terms_of_service_url", "");

/// Disable unused/unwanted password manager/autofill functionality
// We only want to use the password manager here for ex. saving log-ins to email providers - we don't want/need it trying to interact with webpages
// and we don't need anything with addresses/credit cards/etc.
pref("extensions.formautofill.addresses.capture.enabled", false);
pref("extensions.formautofill.addresses.experiments.enabled", false); // [DEFAULT]
pref("extensions.formautofill.addresses.supported", "off");
pref("extensions.formautofill.addresses.supportedCountries", "");
pref("extensions.formautofill.creditCards.hideui", true); // [HIDDEN] https://searchfox.org/firefox-release/rev/9d94f5e3/toolkit/components/formautofill/FormAutofill.sys.mjs#29
pref("extensions.formautofill.creditCards.supported", "off");
pref("extensions.formautofill.creditCards.supportedCountries", "");
pref("signon.backup.enabled", false);
pref("signon.capture.inputChanges.enabled", false);
pref("signon.formRemovalCapture.enabled", false);
pref("signon.generation.available", false);
pref("signon.generation.enabled", false);
pref("signon.passwordEditCapture.enabled", false);
pref("signon.recipes.path", "");
pref("signon.relatedRealms.enabled", false); // [DEFAULT]
pref("signon.showAutoCompleteFooter", false);
pref("signon.showAutoCompleteImport", ""); // [HIDDEN] [DEFAULT]
pref("signon.suggestImportCount", 0); // [HIDDEN] [DEFAULT]
pref("signon.usernameOnlyForm.enabled", false);

/// Re-enable Password Manager by default
// This is useful and important for Thunderbird, since it's the only way to stay logged in/store account passwords...
// Also no UI toggle for it :/
pref("signon.rememberSignons", true); // [DEFAULT]

pref("mail.dove.status", "012");

/*** 013 EXTENSIONS ***/

/// Allow reporting malicious add-ons/themes to Mozilla
pref("extensions.abuseReport.enabled", true);

/// Allow ATN-XPIHandler to run on restricted/quarantined domains by default
// (Necessary for it to access addons.thunderbird.net)
pref("extensions.quarantineIgnoredByUser.atn-xpihandler@celenity.dev", true); // [HIDDEN]

/// Allow uBird (uBlock Origin builds for Thunderbird) to run on restricted/quarantined domains by default
pref("extensions.quarantineIgnoredByUser.uBird@celenity.dev", true); // [HIDDEN]

/// Allow unprivileged extensions to use experimental APIs
// Required for ex. CardBook, also used by DKIM Verifier
// https://searchfox.org/mozilla-central/source/toolkit/components/extensions/docs/basics.rst#142
pref("extensions.experiments.enabled", true); // [DEFAULT]

/// Always allow installing "incompatible" add-ons
// REQUIRED FOR UBLOCK ORIGIN
pref("extensions.strictCompatibility", false, locked); //  [DEFAULT - Nightly]

/// Block Cardbook (if installed) and DKIM Verifier from accessing restricted/quarantined domains
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantineIgnoredByUser.cardbook@vigneau.philippe", false); // [DEFAULT]
pref("extensions.quarantineIgnoredByUser.dkim_verifier@pl", false); // [DEFAULT]

/// Disable compatibility overrides
// https://mozilla.github.io/addons-server/topics/api/v3_legacy/addons.html#compat-override
pref("extensions.getAddons.compatOverides.url", "");

/// Disable installation of add-ons by default
// NOTE: Thunderbird doesn't prompt to re-enable this when mozAddonManager is enabled
// We disable mozAddonManager though, so not a problem for us
pref("xpinstall.enabled", false); // [HIDDEN]

/// Disable mozAddonManager
// This usually breaks add-on installation,
// but we're using the ATN-XPIHandler add-on to fix it
// For details, see https://codeberg.org/celenity/atn-xpihandler
pref("extensions.webapi.enabled", false);
pref("privacy.resistFingerprinting.block_mozAddonManager", true);

/// Disable recommendations for alternatives to legacy add-ons
// https://searchfox.org/comm-central/rev/3a9b412a/mail/base/content/aboutAddonsExtra.js#25
// https://searchfox.org/comm-central/rev/3a9b412a/mail/base/content/aboutAddonsExtra.js#76
pref("extensions.alternativeAddonSearch.url", "");

/// Ensure uBird (uBlock Origin builds for Thunderbird) can access all containers by default (if installed)
pref("extensions.userContextIsolation.uBird@celenity.dev.restricted", "[]"); // [HIDDEN]

/// Ensure we do not try to fetch browser mappings
// This is used for mapping Chrome extensions with Firefox ones, as part of browser migration
// https://mozilla.github.io/addons-server/topics/api/addons.html#browser-mappings
// ex. https://services.addons.mozilla.org/api/v5/addons/browser-mappings/?browser=chrome
pref("extensions.getAddons.browserMappings.url", ""); // [HIDDEN]

/// Update AMO API
// Default is still v3, which has been deprecated for quite some time...
// https://mozilla.github.io/addons-server/topics/api/overview.html#api-versions
pref("extensions.getAddons.get.url", "https://services.addons.thunderbird.net/api/v4/addons/search/?guid=%IDS%&lang=%LOCALE%");
pref("extensions.getAddons.langpacks.url", "https://services.addons.thunderbird.net/api/v4/addons/language-tools/?app=thunderbird&type=language&appversion=%VERSION%");

pref("mail.dove.status", "013");

/*** 014 CARDBOOK ***/

/// Configure CardBook (if installed)
pref("extensions.cardbook.optionsMigrated", false); // [HIDDEN]

/// Display list, public key, technical, & vCard tabs by default
pref("extensions.cardbook.keyTabView", true); // [HIDDEN] Public Keys
pref("extensions.cardbook.listTabView", true); // [HIDDEN] [DEFAULT] Lists
pref("extensions.cardbook.technicalTabView", true); // [HIDDEN] Technical
pref("extensions.cardbook.vcardTabView", true); // [HIDDEN] vCard

/// Encrypt locally cached cards
pref("extensions.cardbook.localDataEncryption", true); // [HIDDEN]

/// Prevent leaking display names of contacts in address fields with emails
// https://github.com/HorlogeSkynet/thunderbird-user.js/blob/master/user.js#L1231
pref("extensions.cardbook.useOnlyEmail", true); // [HIDDEN]

/// Use OpenStreetMap instead of Bing/Google Maps for `Show on Map` functionality
pref("extensions.cardbook.localizeEngine", "OpenStreetMap"); // [HIDDEN] [DEFAULT]

/// Warn when attempting to email contacts without an email address
pref("extensions.cardbook.warnEmptyEmails", true); // [HIDDEN] [DEFAULT]

pref("mail.dove.status", "014");

/*** 015 MISC. PRIVACY + SECURITY ***/

/// Disable WebGL
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// https://blog.browserscan.net/docs/webgl-fingerprinting
// https://security.stackexchange.com/questions/13799/is-webgl-a-security-concern
pref("webgl.disabled", true);

/// Switch Remote Settings to use Firefox's server instead of Thunderbird's
// NOTE: This will ONLY work if you set the `MOZ_REMOTE_SETTINGS_DEVTOOLS` environment variable to `1` (If `MOZ_REMOTE_SETTINGS_DEVTOOLS` isn't set, Thunderbird will just continue to use its default server)
// Thunderbird's Remote Settings instance has little to no use, hasn't been updated since ~2022, etc...
// Using Firefox's server instead of Thunderbird's allows us to download and take advantage of add-on blocklists, certificate intermediates, certificate revocations, CRLite, tracking protection lists, etc... and doesn't appear to cause issues or undesired behavior.
// For testing: https://github.com/mozilla-extensions/remote-settings-devtools
pref("services.settings.server", "https://firefox.settings.services.mozilla.com/v1", locked);

pref("mail.dove.status", "015");

/*** 016 MISC. PRIVACY ***/

/// Disable automatic collection of email addresses for Thunderbird's Address Book
pref("mail.collect_email_address_incoming", false); // [DEFAULT]
pref("mail.collect_email_address_newsgroup", false); // [DEFAULT]
pref("mail.collect_email_address_outgoing", false);

/// Disable clipboard events
// https://developer.mozilla.org/docs/Web/API/ClipboardEvent
pref("dom.allow_cut_copy", false); // `cut` and `copy` https://searchfox.org/firefox-main/rev/62066911/dom/base/Document.cpp#6157
pref("dom.event.clipboardevents.enabled", false);
pref("dom.execCommand.paste.enabled", false); // `paste` https://searchfox.org/firefox-main/rev/62066911/dom/base/Document.cpp#6151

/// Disable Geolocation
// https://browserleaks.com/geo
pref("geo.prompt.open_system_prefs", false); // Ensure users aren't prompted to open settings and enable Geolocation - https://searchfox.org/mozilla-central/rev/20fc11f1/modules/libpref/init/StaticPrefList.yaml#6406
pref("geo.provider.network.scan", false);
pref("geo.provider.network.url", "");
pref("geo.provider.use_corelocation", false); // [OSX-ONLY]
pref("geo.provider.use_geoclue", false); // [LINUX-ONLY]
pref("network.wifi.scanning_period", 0);
pref("widget.use-xdg-desktop-portal.location", 0); // [LINUX-ONLY]

/// Disable legacy XMPP gateways for Facebook, Google, Twitter, and Yahoo [CHAT]
// https://searchfox.org/comm-central/source/chat/chat-prefs.js#76
pref("chat.prpls.prpl-facebook.disable", true); // [DEFAULT] [CHAT]
pref("chat.prpls.prpl-gtalk.disable", true); // [DEFAULT] [CHAT]
pref("chat.prpls.prpl-twitter.disable", true); // [DEFAULT] [CHAT]
pref("chat.prpls.prpl-yahoo.disable", true); // [DEFAULT] [CHAT]

/// Disable macOS Spotlight file indexing for email by default [OSX-ONLY]
pref("mail.spotlight.enable", false); // [OSX-ONLY] [DEFAULT]
pref("mail.spotlight.firstRunDone", true); // [OSX-ONLY]

/// Disable OS file indexing/search integration for email by default
pref("searchintegration.enable", false);

/// Disable Windows file indexing for email by default [WINDOWS-ONLY]
pref("mail.winsearch.enable", false); // [WINDOWS-ONLY] [DEFAULT]
pref("mail.winsearch.firstRunDone", true); // [WINDOWS-ONLY]

/// Do not try to submit unrecognized search/URL strings to the default search engine
pref("keyword.enabled", false);

/// Package Thunderbird's Autoconfiguration files locally
// By default, these are typically fetched remotely from here: https://autoconfig.thunderbird.net/v1.1/
// Using these locally improves privacy by avoiding the unwanted network activity/potential leakage, and improves performance/responsiveness
// https://wiki.mozilla.org/Thunderbird:Autoconfiguration
pref("mailnews.auto_config_url", "file:///app/etc/thunderbird/Dove/assets/autoconfig/v1.1/"); // [FLATPAK-LINUX-ONLY]
pref("mailnews.auto_config_url", "file:///etc/thunderbird/Dove/assets/autoconfig/v1.1/"); // [LINUX-NON-FLATPAK-ONLY]
pref("mailnews.auto_config_url", "file:///opt/homebrew/opt/dove/assets/autoconfig/v1.1/"); // [SILICON-OSX-ONLY]
pref("mailnews.auto_config_url", "file:///usr/local/opt/dove-intel/assets/autoconfig/v1.1/"); // [INTEL-OSX-ONLY]
pref("mailnews.auto_config_url", "file:///C:/Dove/assets/autoconfig/v1.1/"); // [WINDOWS-ONLY]

/// Prevent calendar from extracting data from emails by default
pref("calendar.extract.service.enabled", false); // [DEFAULT]

/// Remove default Google Groups link
pref("mailnews.messageid_browser.url", "");

/// (Attempt to) Unbreak Tracking Protection list downloads
// The default is `moz-sbrs:://antitracking`, which fetches these lists from Remote Settings - but the problem is that Thunderbird's Remote Settings unfortunately doesn't ship the Tracking Protection lists like Firefox
// So this switches the URL to try downloading them directly from Mozilla
pref("browser.safebrowsing.provider.mozilla.updateURL", "https://shavar.services.mozilla.com/downloads?client=navclient-auto-ffox&appver=%VERSION%&pver=2.2");

/// Warn users if they have not addressed a BCC (Blind Carbon Copy) warning
pref("mail.compose.warn_public_recipients.aggressive", true);

pref("mail.dove.status", "016");

/*** 017 MISC. SECURITY ***/

/// Always warn users before launching other apps
pref("mail.external_protocol_requires_permission", true);
pref("network.protocol-handler.warn-external.http", true);
pref("network.protocol-handler.warn-external.https", true);

/// Disable chat functionality by default
// Provides attack surface reduction, and disabling chat allows us to improve security in other areas (ex. we can fully disable WASM)
// I also doubt this is widely used by our users
pref("mail.chat.enabled", false);

/// Disable WASM-Baseline JIT
// We disable WASM in all contexts, so we don't need to keep this enabled
// Phoenix disables the other JITs
pref("javascript.options.wasm_baselinejit", false);

/// Disable WebAssembly for extensions/trusted principals
// NOTE: This is required for chat functionality
pref("javascript.options.wasm_trustedprincipals", false);

/// Enable built-in phishing protection
// https://support.mozilla.org/kb/thunderbirds-scam-detection
pref("mail.phishing.detection.disallow_form_actions", true); // [DEFAULT]
pref("mail.phishing.detection.enabled", true); // [DEFAULT]
pref("mail.phishing.detection.ipaddresses", true); // [DEFAULT]
pref("mail.phishing.detection.mismatched_hosts", true); // [DEFAULT]

/// Limit classes that can process incoming data
// Enables a blocklist to avoid HTML, inline images, and other unknown content types
// https://searchfox.org/comm-central/source/mailnews/mailnews.js#728
pref("mailnews.display.disallow_mime_handlers", 3);
pref("rss.display.disallow_mime_handlers", 3);

/// Prevent 3rd party software from intercepting and analyzing emails
// This is the "Allow Antivirus clients to quarantine individual incoming messages" option within Privacy & Security settings
// https://searchfox.org/comm-central/rev/2713116a/mail/components/preferences/privacy.inc.xhtml#372
pref("mailnews.downloadToTempFile", false, locked);

/// Sanitize HTML content
// https://www.bucksch.org/1/projects/mozilla/108153/
pref("mail.html_sanitize.drop_conditional_css", true); // [DEFAULT]
pref("mail.spam.display.sanitize", true); // [DEFAULT] Always sanitize HTML for junk messages: https://searchfox.org/comm-central/rev/19254da8/mailnews/mailnews.js#645
pref("mailnews.display.html_as", 3);
pref("rss.display.html_as", 3);

pref("mail.dove.status", "017");

/*** 018 MISC. ***/

/// Allow mailboxes larger than 4GB
// https://searchfox.org/comm-central/rev/19254da8/mailnews/mailnews.js#138
pref("mailnews.allowMboxOver4GB", true); // [DEFAULT]

/// Allow users to override Oauth provider details for Microsoft Exchange Web Services by default
pref("experimental.mail.ews.overrideOAuth.enabled", true);

/// Allow using Thunderbird without a configured email account
pref("app.use_without_mail_account", true);

/// Always add the file extension (.eml) when forwarding attachments
// https://searchfox.org/comm-central/rev/19254da8/mailnews/mailnews.js#720
pref("mail.forward_add_extension", true); // [DEFAULT]

/// Disable back-up of bookmarks
// (Likely unused, but defined here, so we can set anyways)
pref("browser.bookmarks.max_backups", 0);

/// Disable context menu events
// This prevents websites from hijacking the right click/context menu
// I can't imagine a legitimate use case for this for our purposes...
// https://developer.mozilla.org/docs/Web/API/Element/contextmenu_event
pref("dom.event.contextmenu.enabled", false);

/// Disable the inference content process
// https://searchfox.org/firefox-main/rev/20a1fb35/dom/docs/ipc/process_model.rst#184
// This is used for AI/machine learning, as well as Firefox Translations,
// which we disable and aren't supported here
pref("dom.ipc.processCount.inference", 0);

/// Disable Picture-in-Picture
// Likely unused, and unwanted for our use case
pref("media.videocontrols.picture-in-picture.audio-toggle.enabled", false); // [HIDDEN] [DEFAULT]
pref("media.videocontrols.picture-in-picture.enabled", false); // [DEFAULT]
pref("media.videocontrols.picture-in-picture.urlbar-button.enabled", false); // [HIDDEN] [DEFAULT]
pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false); // [DEFAULT]

/// Disable the "Search in Private Window" URL bar result by default
// Likely unused, but this pref is referenced in code relevant to Thunderbird
pref("browser.search.separatePrivateDefault.urlbarResult.enabled", false); // [HIDDEN] [DEFAULT]

/// Disable support for web applications manifests
// Ex. used for PWAs (and PWA inspection on Firefox for Desktop)
// Unnecessary for our use case
// https://developer.mozilla.org/docs/Web/Progressive_web_apps/Manifest
// https://bugzilla.mozilla.org/show_bug.cgi?id=1603673
// https://bugzilla.mozilla.org/show_bug.cgi?id=1647858
pref("dom.manifest.enabled", false);

/// Disable Sync by default
// These are Thunderbird-specific sync engines, we disable the standard ones from Phoenix
// https://searchfox.org/comm-central/rev/d1b7a08e/mail/app/profile/all-thunderbird.js#1412
pref("services.sync.engine.addressbooks", false); // [HIDDEN - non-MOZ_SERVICES_SYNC builds] [DEFAULT - non-MOZ_SERVICES_SYNC builds]
pref("services.sync.engine.calendars", false); // [HIDDEN - non-MOZ_SERVICES_SYNC builds] [DEFAULT - non-MOZ_SERVICES_SYNC builds]
pref("services.sync.engine.identities", false); // [HIDDEN - non-MOZ_SERVICES_SYNC builds] [DEFAULT - non-MOZ_SERVICES_SYNC builds]
pref("services.sync.engine.servers", false); // [HIDDEN - non-MOZ_SERVICES_SYNC builds] [DEFAULT - non-MOZ_SERVICES_SYNC builds]

//// Disable extension storage sync
pref("webextensions.storage.sync.enabled", false); // [HIDDEN]
pref("webextensions.storage.sync.kinto", false); // [DEFAULT]
pref("webextensions.storage.sync.serverURL", "");

/// Disable text fragments
pref("dom.text_fragments.create_text_fragment.enabled", false);
pref("dom.text_fragments.enabled", false);

/// Disable tooltips
pref("browser.chrome.toolbar_tips", false);

/// Disable UI for using a different search engine in normal vs. private Windows
// Likely unused, but this pref is defined in Thunderbird, and it's referenced in code relevant to Thunderbird
pref("browser.search.separatePrivateDefault.ui.enabled", false); // [DEFAULT]

/// Disable URL fix-up
pref("browser.fixup.alternate.prefix", "");
pref("browser.fixup.alternate.protocol", "");
pref("browser.fixup.alternate.suffix", "");
pref("browser.fixup.typo.scheme", false); // [HIDDEN]
pref("browser.urlbar.dnsResolveFullyQualifiedNames", false); // [HIDDEN]
pref("security.bad_cert_domain_error.url_fix_enabled", false); // https://searchfox.org/firefox-main/rev/82e2435f/docshell/base/nsDocShell.cpp#6251

/// Do not attempt to resume background video playback upon tab hover
pref("media.resume-background-video-on-tabhover", false);

/// Enable audio focus management
// This prevents multiple audio controllers from playing at the same time
// (So, ex. - if you have multiple tabs open and playing audio at the same time, this only allows the most recent tab to play audio)
// https://searchfox.org/firefox-main/rev/5a5b3741/dom/media/mediacontrol/AudioFocusManager.cpp#41
// Ideally, we don't want audio at all - this at least restricts it
pref("media.audioFocus.management", true);

/// Enable native support for Microsoft Exchange Web Services, instead of recommending and requiring third party add-ons (like Owl)
pref("experimental.mail.ews.enabled", true); // https://searchfox.org/comm-central/rev/3a9b412a/mailnews/mailnews.js#1137
pref("mailnews.auto_config.addons_url", "data;"); // [DEFAULT: https://autoconfig.thunderbird.net/addons.json] - Setting to blank results in error on set-up stating that no URL is configured

/// Enable stricter media autoplay blocking
// https://utcc.utoronto.ca/%7Ecks/space/blog/web/FirefoxMediaAutoplaySettingsIII
// https://searchfox.org/mozilla-central/rev/3ce874dc2703831af3e5ef3a1d216ffd08057fa5/modules/libpref/init/StaticPrefList.yaml#6353-6360
pref("media.autoplay.blocking_policy", 2); // [DEFAULT: 0]

/// If Sync is enabled, disable sensitive logging by default
// https://searchfox.org/comm-central/rev/d1b7a08e/mail/app/profile/all-thunderbird.js#1412
pref("identity.fxaccounts.log.sensitive", false); // [HIDDEN - non-MOZ_SERVICES_SYNC builds] [DEFAULT - non-MOZ_SERVICES_SYNC builds]
pref("services.sync.log.appender.console", "Fatal"); // [HIDDEN - non-MOZ_SERVICES_SYNC builds] [DEFAULT - non-MOZ_SERVICES_SYNC builds] Matches Firefox

/// Load summary of RSS feeds instead of the full webpage by default
pref("rss.show.summary", 1);

/// Open RSS webpages in your web browser instead of Thunderbird
// https://support.mozilla.org/kb/how-subscribe-news-feeds-and-blogs
pref("rss.show.content-base", 3);

/// Prefer viewing emails in plaintext by default
pref("mailnews.display.prefer_plaintext", true);

/// Prefer viewing RSS feeds in plaintext by default
pref("rss.display.prefer_plaintext", true);

/// Prevent selection of RSS messages from automatically loading the web page
// https://support.mozilla.org/kb/how-subscribe-news-feeds-and-blogs
pref("rss.message.loadWebPageOnSelect", 0);

/// Prevent status bar spoofing
// https://searchfox.org/comm-central/source/mail/app/profile/all-thunderbird.js#542
pref("dom.disable_window_status_change", true); // [DEFAULT]

/// Re-enable SharedArrayBuffer using window.postMessage
// Required for password-protected CalDAV sync
// https://codeberg.org/celenity/Dove/issues/25
// Test: https://www.caldavserver.com/DAV
// We still disable it in insecure contexts (dom.postMessage.sharedArrayBuffer.bypassCOOP_COEP.insecure.enabled) - this just allows it when it meets certain conditions related to COOP and COEP
// https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer
// https://developer.mozilla.org/docs/Web/API/Window/postMessage
// https://blog.mozilla.org/security/2018/01/03/mitigations-landing-new-class-timing-attack/
// https://github.com/tc39/ecma262/issues/1435
pref("dom.postMessage.sharedArrayBuffer.withCOOP_COEP", true); // [DEFAULT]

/// Send emails in plaintext by default
// https://drewdevault.com/2016/04/11/Please-use-text-plain-for-emails.html
pref("mail.default_send_format", 1);
pref("mail.html_compose", false);
pref("mail.identity.default.compose_html", false);

/// Use a blank new tab page
// This likely isn't used anywhere, but Thunderbird does seem to define these prefs, so we can set them anyways
pref("browser.newtabpage.enabled", false);
pref("browser.startup.homepage.abouthome_cache.enabled", false);

pref("mail.dove.status", "018");

/*** 019 Personal Touch 💜 ***/

/// Things that are nice to have™
// Not directly privacy & security related

/// Disable certain UI animations by default
// Improves performance and responsiveness
pref("browser.preferences.animateFadeIn", false); // [DEFAULT - non-macOS]

/// Disable extra logging for policies by default
// This pref allows controlling the log level of policies (extremely useful for troubleshooting...), set here to the default value so that it's exposed in the about:config
// https://searchfox.org/comm-central/source/mail/components/enterprisepolicies/Policies.sys.mjs
pref("browser.policies.loglevel", "Error"); // [HIDDEN] [DEFAULT]

/// Enable the 'Bubbles' chat theme by default [CHAT]
pref("messenger.options.messagesStyle.theme", "bubbles"); // [CHAT]

/// Enable CSS Masonry Layout for the Address Book
// (For reference, Phoenix enables this for Gecko)
// https://www.smashingmagazine.com/native-css-masonry-layout-css-grid/
pref("layout.css.grid-template-masonry-value.enabled", true); // [DEFAULT]

/// Enable dark theme for the message pane
pref("mail.dark-reader.enabled", true);
pref("mail.dark-reader.show-toggle", true); // [HIDDEN] UI toggle https://searchfox.org/comm-central/rev/2713116a/mail/base/content/msgHdrView.js#2794

/// Enable the global indexer (Gloda) by default
// We still disable OS indexing/integration above, this is just for Thunderbird itself.
// This is required for searching emails - which is a critical feature for an email client IMO...
// This is typically the default, but some (ex. RedHat/Fedora) override it.
pref("mailnews.database.global.indexer.enabled", true); // [DEFAULT]

/// Enable inline spellcheck when composing messages + check before sending by default
pref("mail.spellcheck.inline", true); // [DEFAULT]
pref("mail.SpellCheckBeforeSend", true);

/// Enable the new Account Hub by default
pref("mail.accounthub.addressbook.enabled", true);
pref("mail.accounthub.enabled", true);

/// Enable taskbar lists/tasks by default [WINDOWS-ONLY]
pref("mail.taskbar.lists.enabled", true); // [WINDOWS-ONLY] [DEFAULT]
pref("mail.taskbar.lists.tasks.enabled", true); // [WINDOWS-ONLY] [DEFAULT]

/// Hide Title Bar by default
pref("mail.tabs.drawInTitlebar", true); // [DEFAULT]

/// Prevent automatically converting emoticons to emojis
pref("mail.display_glyph", false);

/// Prevent hiding the tab bar when only one tab is open
pref("mail.tabs.autoHide", false);

/// Show progress when saving/sending a message
pref("mailnews.show_send_progress", true); // [DEFAULT]

/// Use underscores instead of spaces in file names when saving messages by default
pref("mail.save_msg_filename_underscores_for_space", true);

/// Wrap lines by default
pref("mail.wrap_long_lines", true); // [DEFAULT]

pref("mail.dove.status", "019");

pref("mail.dove.status", "successfully applied :D", locked);
pref("mail.dove.applied.cfg", true, locked);
