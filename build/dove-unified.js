//
// And so, it was told that the Phoenix shall be followed by a Dove; one of great strength and great beauty, to help carry out its conquest.

//
// Copyright (C) 2024-2025 celenity
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

pref("mail.dove.version", "2025.06.10.1", locked);

/// Add custom branding under `Thunderbird Updates` at `about:preferences#general`
// This will unfortunately only display if the version of Thunderbird you're using is repackaged (ex. Flatpaks/Linux distros)
pref("distribution.about", "Dove for Mozilla Thunderbird - 2025.06.10.1 💜", locked);

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
[OSX-ONLY] = This preference should ONLY be set for macOS
[WINDOWS-ONLY] = This preference should ONLY be set for Windows

[NO-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux
[NO-OSX] = This preference should be set everywhere, EXCEPT for macOS
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
pref("mail.pgpmime.addon_url", ""); // Contains a dead link to Enigmail - a now dead extension that used to provide E2EE for Thunderbird (before it was built-in like it is nowadays...) - Likely not used anywhere

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
pref("mail.inappnotifications.enabled", false); // [DEFAULT - non-Nightly]
pref("mail.inappnotifications.message_enabled", false); // [NIGHTLY] Updates

/// Disable onboarding
// https://searchfox.org/comm-central/source/suite/components/nsSuiteGlue.js#965
pref("browser.EULA.override", true);
pref("browser.rights.override", true);
pref("mail.rights.override", true);
pref("mailnews.start_page_override.mstone", "ignore", locked);

/// Disable recommendations
pref("extensions.getAddons.recommended.url", "");

/// Disable Start Page by default and switch the URL to the about:config
// This allows users to easily access the about:config via the menu bar from Go -> Mail Start Page
// Or by pressing alt + home
pref("mailnews.start_page.enabled", false);
pref("mailnews.start_page.override_url", "");
pref("mailnews.start_page.url", "about:config");

/// Disable Surveys
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

/// Prevent messages from loading remote content
// This still allows adding exceptions
// https://support.mozilla.org/kb/remote-content-in-messages
pref("mailnews.message_display.disable_remote_image", true, locked); // [DEFAULT]

pref("mail.dove.status", "003");

/*** 004 INFORMATION LEAKAGE ***/

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
//  Unnecessary, not defined in spec, and leaks information
// https://bugzilla.mozilla.org/show_bug.cgi?id=1114475
pref("mailnews.headers.sendUserAgent", false);
pref("mailnews.headers.useMinimalUserAgent", true); // [DEFAULT, DEFENSE IN DEPTH]

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

/// Freeze user agent to protect against fingerprinting
// As explained below, we can't use the standard RFP/FPP 'HttpUserAgent' & 'NavigatorUserAgent` targets, as Thunderbird lies and pretends to be Firefox, which ex. breaks the ATN (and it's unfortunately not currently possible to set granular overrides here: https://bugzilla.mozilla.org/show_bug.cgi?id=1968080)
// Until Thunderbird fixes this upstream, we'll spoof it ourselves
// This matches what Firefox's RFP/FPP targets use (only difference being we switch out Firefox for Thunderbird)
// We'll keep platform always spoofed to Windows - since we block JS by default, can be useful (and I can't see this causing weird issues like we see on Firefox...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1950775
pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Thunderbird/128.0"); // [HIDDEN]

/// Harden FPP
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Features#fingerprinting
// and here: https://codeberg.org/celenity/Phoenix/wiki/Extended.md#fingerprinting
// We're adding -HttpUserAgent & -NavigatorUserAgent (compared to standard Phoenix Extended) because they try to report that we're Firefox, which ex. breaks the ATN (and it's unfortunately not currently possible to set granular overrides here: https://bugzilla.mozilla.org/show_bug.cgi?id=1968080)
// We're removing -CanvasExtractionBeforeUserInputIsBlocked as Thunderbird simply doesn't support these permission prompts for canvas data extraction...
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme,-FrameRate,-HttpUserAgent,-NavigatorUserAgent");
pref("privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts", true); // [ESR] [DEFAULT] (This is the equivalent of the `+CanvasExtractionBeforeUserInputIsBlocked` target)

/// Set FPP granular overrides
// This currently:
// Resets Phoenix's overrides (Meant for browsers, may have undesired implications for our use case - we can add back ones actually relevant to us though as needed...)
// Spoofs 'CSSPrefersColorScheme' (+CSSPrefersColorScheme) for 'thunderbird.net' - doesn't support dark mode, so unnecessary...
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain":"thunderbird.net","overrides":"+CSSPrefersColorScheme"}]');

pref("mail.dove.status", "005");

/*** 006 DISK AVOIDANCE ***/

/// Disable browsing history
pref("places.history.enabled", false);

/// Disable disk caching
pref("mail.imap.use_disk_cache2", false);

/// Disable favicons
pref("browser.chrome.favicons", false);
pref("browser.chrome.site_icons", false);

/// Disable logging chat history [CHAT]
// https://stackoverflow.com/questions/32155137/how-to-disable-chat-history-in-mozilla-thunderbird
pref("purple.logging.log_chats", false); // [CHAT]
pref("purple.logging.log_ims", false); // [CHAT]

/// Disable logging E2EE messages (OTR) [CHAT]
pref("chat.otr.default.allowMsgLog", false); // [CHAT]

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

/// Disable link previews
pref("mail.compose.add_link_preview", false);

/// Disable network connectivity status monitoring
// (Ex. used for automatically switching between offline & online mode)
pref("offline.autoDetect", false);

/// Improve list of built-in DoH resolvers
pref("network.trr.resolvers", '[{"url":"https://dns.quad9.net/dns-query","name":"Quad9 - Real-time Malware Protection - 🇨🇭"},{"url":"https://zero.dns0.eu","name":"DNS0 (ZERO) - Hardened Real-time Malware Protection - 🇫🇷"},{"url":"https://dns0.eu","name":"DNS0 - Real-time Malware Protection - 🇫🇷"},{"url":"https://base.dns.mullvad.net/dns-query","name":"Mullvad (Base) - Ad/Tracking/Limited Malware Protection - 🇸🇪"},{"url":"https://dns.adguard-dns.com/dns-query","name":"AdGuard (Public) - Ad/Tracking Protection - 🇨🇾"},{"url":"https://dns.mullvad.net/dns-query","name":"Mullvad - Unfiltered - 🇸🇪"},{"url":"https://wikimedia-dns.org/dns-query","name":"Wikimedia - Unfiltered - 🇺🇸"},{"url":"https://firefox.dns.nextdns.io/","name":"NextDNS (Public) - Unfiltered - 🇺🇸"},{"url":"https://unfiltered.adguard-dns.com/dns-query","name":"AdGuard (Public) - Unfiltered - 🇨🇾"},{"url":"https://kids.dns0.eu","name":"DNS0 - Kids"},{"url":"https://family.dns.mullvad.net/dns-query","name":"Mullvad (Family)"},{"url":"https://family.adguard-dns.com/dns-query","name":"AdGuard (Public) - Family Protection - 🇨🇾"},{"url":"https://extended.dns.mullvad.net/dns-query","name":"Mullvad (Extended) - Ad/Tracking/Limited Malware/Social Media Protection - 🇸🇪"},{"url":"https://all.dns.mullvad.net/dns-query","name":"Mullvad (All) - Ad/Tracking/Limited Malware/Social Media/Adult/Gambling Protection - 🇸🇪"},{"url":"https://security.cloudflare-dns.com/dns-query","name":"Cloudflare - Malware Protection - 🇺🇸"},{"url":"https://mozilla.cloudflare-dns.com/dns-query","name":"Cloudflare - Unfiltered (Stricter privacy policy) - 🇺🇸"},{"url":"https://family.cloudflare-dns.com/dns-query","name":"Cloudflare - Adult Content/Malware Protection - 🇺🇸"}]'); // [HIDDEN]

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

/// Show email information + headers
pref("mail.show_headers", 2);
pref("mailnews.display.date_senders_timezone", true); // Displays timezone of sender
pref("mailnews.headers.showMessageId", true);
pref("mailnews.headers.showOrganization", true);
pref("mailnews.headers.showReferences", true);
pref("mailnews.headers.showSender", true);
pref("mailnews.headers.showUserAgent", true);

/// Show full email addresses
pref("mail.addressDisplayFormat", 0); // [DEFAULT] [HIDDEN] Sets preferred address display format to "Full name and email address"
pref("mail.showCondensedAddresses", false);

pref("mail.dove.status", "010");

/*** 011 ATTACK SURFACE REDUCTION ***/

/// Disable Android Debugging
pref("devtools.remote.adb.extensionID", "");
pref("devtools.remote.adb.extensionURL", "");

/// Disable DRM/EME
pref("media.eme.encrypted-media-encryption-scheme.enabled", false);
pref("media.eme.hdcp-policy-check.enabled", false);

/// Disable FFmpeg
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=ffmpeg
pref("media.ffmpeg.enabled", false);
pref("media.ffmpeg.encoder.enabled", false); // [DEFAULT]
pref("media.ffmpeg.vaapi.enabled", false); // [DEFAULT]
pref("media.rdd-ffmpeg.enabled", false);
pref("media.utility-ffmpeg.enabled", false);

/// Disable Firefox Translations
// The code is technically present in Thunderbird (ex. `about:translations` is accessible...), but it currently doesn't seem possible to actually download any language models from Remote Settings,so it's useless :/
pref("browser.translations.automaticallyPopup", false);
pref("browser.translations.enable", false); // [DEFAULT]
pref("browser.translations.select.enable", false); // [DEFAULT]

/// Disable Narrator
// Broken on Thunderbird
pref("narrate.enabled", false);

/// Disable Reader Mode
// Broken on Thunderbird
pref("reader.parse-on-load.enabled", false);

/// Disable SVG
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg
pref("svg.disabled", true);

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

/// Re-enable Password Manager by default
// This is useful & important for Thunderbird, since it's the only way to stay logged in/store account passwords...
// Also no UI toggle for it :/
pref("signon.rememberSignons", true); // [DEFAULT]

pref("mail.dove.status", "012");

/*** 013 EXTENSIONS ***/

/// Allow reporting malicious add-ons/themes to Mozilla
pref("extensions.abuseReport.enabled", true);

/// Always allow installing "incompatible" add-ons
// REQUIRED FOR UBLOCK ORIGIN
pref("extensions.strictCompatibility", false, locked); //  [DEFAULT - Nightly]

/// Allow unprivileged extensions to use experimental APIs
// Required for ex. CardBook, also used by DKIM Verifier
// https://searchfox.org/mozilla-central/source/toolkit/components/extensions/docs/basics.rst#142
pref("extensions.experiments.enabled", true); // [DEFAULT]

/// Block Cardbook (if installed) and DKIM Verifier from accessing restricted/quarantined domains
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantineIgnoredByUser.cardbook@vigneau.philippe", false); // [DEFAULT]
pref("extensions.quarantineIgnoredByUser.dkim_verifier@pl", false); // [DEFAULT]

/// Disable installation of add-ons + only allow enabling it per-session
// Includes extensions and themes
// This doesn't impact already installed add-ons and add-ons installed by policies
// Thunderbird will prompt to re-enable this when necessary
// We're also setting this as a user pref, which is quite nice from a security perspective - as it allows users to enable this functionality only when it's necessary...
// Ex: A user attempts to install an extension, sees the extra prompt/warning, and selects `Enable` (which temporarily sets this pref to `true`...). The user then proceeds to install the extension. On the next launch of Thunderbird, this pref is reset back to `false`, meaning the ability to install extensions is fully disabled without them even thinking about it
pref("xpinstall.enabled", false); // [HIDDEN] So the default is `false`
pref("xpinstall.enabled", false, sticky); // [HIDDEN] So it's converted to a user pref and applied per-session

/// Disable mozAddonManager
// mozAddonManager has various privacy (fingerprinting) and security (added attack surface) concerns.
// It also bypasses the permission prompt to install add-ons, and prevents add-ons (like uBlock Origin) from working on `addons.thunderbird.net`.
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
pref("extensions.webapi.enabled", false);
pref("privacy.resistFingerprinting.block_mozAddonManager", true);

/// Disable recommendations for alternatives to legacy add-ons
// https://searchfox.org/comm-central/rev/3a9b412a/mail/base/content/aboutAddonsExtra.js#25
// https://searchfox.org/comm-central/rev/3a9b412a/mail/base/content/aboutAddonsExtra.js#76
pref("extensions.alternativeAddonSearch.url", "");

/// Unbreak installation of add-ons from ATN (`addons.thunderbird.net`) if mozAddonManager is disabled
// For context, when mozAddonManager is disabled on Firefox, AMO will fallback and successfully install add-ons without fail out of the box. This is unfortunately NOT the case for ATN currently.
// HOWEVER, ATN DOES still have a fallback when mozAddonManager is disabled, via the legacy InstallTrigger interface (which is disabled by default nowadays).
// So essentially, we're going to re-enable InstallTrigger so ATN can fallback, but to avoid fingerprinting, we're stubbing it with uBlock Origin for every website EXCEPT `addons.thunderbird.net`.
// For `addons.thunderbird.net`, we're also stubbing`window.InstallTrigger.enabled` and `window.InstallTrigger.updateEnabled`with uBlock Origin, to prevent exposing whether the user has enabled or disabled the installation of add-ons (via the `xpinstall.enabled` pref).
// This effectively allows users to install add-ons from ATN, but without compromising their privacy and security.
// https://github.com/thunderbird/addons-server/issues/332
// https://devdoc.net/web/developer.mozilla.org/en-US/docs/XPInstall_API_Reference/InstallTrigger_Object.html
// https://searchfox.org/mozilla-central/source/dom/webidl/InstallTrigger.webidl
pref("extensions.InstallTrigger.enabled", true); // [DEFAULT]
pref("extensions.InstallTriggerImpl.enabled", true);

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
pref("security.content.signature.root_hash", "C8:A8:0E:9A:FA:EF:4E:21:9B:6F:B5:D7:A7:1D:0F:10:12:23:BA:C5:00:1A:C2:8F:9B:0D:43:DC:59:A1:06:DB");
pref("services.settings.default_bucket", "main");
pref("services.settings.server", "https://firefox.settings.services.mozilla.com/v1", locked);

pref("mail.dove.status", "015");

/*** 016 MISC. PRIVACY ***/

/// Disable automatic collection of email addresses for Thunderbird's Address Book
pref("mail.collect_email_address_outgoing", false);

/// Disable Geolocation
// https://browserleaks.com/geo
pref("geo.prompt.open_system_prefs", false); // Ensure users aren't prompted to open settings and enable Geolocation - https://searchfox.org/mozilla-central/rev/20fc11f1/modules/libpref/init/StaticPrefList.yaml#6406
pref("geo.provider.network.scan", false);
pref("geo.provider.network.url", "");
pref("geo.provider.use_corelocation", false);
pref("geo.provider.use_geoclue", false);
pref("geo.provider.use_mls", false); // [HIDDEN]
pref("network.wifi.scanning_period", 0);

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

/// Prevent calendar from extracting data from emails by default
pref("calendar.extract.service.enabled", false); // [DEFAULT]

/// Remove default Google Groups link
pref("mailnews.messageid_browser.url", "");

/// Warn users if they have not addressed a BCC (Blind Carbon Copy) warning
pref("mail.compose.warn_public_recipients.aggressive", true);

pref("mail.dove.status", "016");

/*** 017 MISC. SECURITY ***/

/// Always warn users before launching other apps
pref("mail.external_protocol_requires_permission", true); // [HIDDEN]

/// Disable insecure NTLMv1 [LINUX-ONLY]
// Fedora's Thunderbird package overrides this to `true`... :/ [LINUX-ONLY]
// https://www.janbambas.cz/ntlm-v1-and-firefox/ [LINUX-ONLY]
// https://bugzilla.mozilla.org/show_bug.cgi?id=828183 [LINUX-ONLY]
// https://bugzilla.redhat.com/show_bug.cgi?id=1110291 [LINUX-ONLY]
pref("network.negotiate-auth.allow-insecure-ntlm-v1", false); // [LINUX-ONLY] [HIDDEN] [DEFAULT]

/// Enable built-in phishing protection
// https://support.mozilla.org/kb/thunderbirds-scam-detection
pref("mail.phishing.detection.disallow_form_actions", true); // [DEFAULT]
pref("mail.phishing.detection.enabled", true); // [DEFAULT]
pref("mail.phishing.detection.ipaddresses", true); // [DEFAULT]
pref("mail.phishing.detection.mismatched_hosts", true); // [DEFAULT]

/// Enable mozilla::pkix certificate verification [LINUX-ONLY]
// Fedora's Thunderbird package overrides this to `false`... :/ [LINUX-ONLY]
// https://wiki.mozilla.org/SecurityEngineering/mozpkix-testing [LINUX-ONLY]
pref("security.use_mozillapkix_verification", true); // [LINUX-ONLY] [HIDDEN] [DEFAULT]

/// Limit classes that can process incoming data
// Enables a blocklist to avoid HTML, inline images, and other unknown content types
// https://searchfox.org/comm-central/source/mailnews/mailnews.js#728
pref("mailnews.display.disallow_mime_handlers", 3);
pref("rss.display.disallow_mime_handlers", 3);

/// Prevent 3rd party software from intercepting & analyzing emails
// This is the "Allow Antivirus clients to quarantine individual incoming messages" option within Privacy & Security settings
// https://searchfox.org/comm-central/rev/2713116a/mail/components/preferences/privacy.inc.xhtml#372
pref("mailnews.downloadToTempFile", false, locked);

/// Sanitize HTML content
// https://www.bucksch.org/1/projects/mozilla/108153/
pref("mail.html_sanitize.drop_conditional_css", true); // [DEFAULT]
pref("mailnews.display.html_as", 3);
pref("rss.display.html_as", 3);

pref("mail.dove.status", "017");

/*** 018 MISC. ***/

/// Allow using Thunderbird without a configured email account
pref("app.use_without_mail_account", true);

/// Disable `mailto:` warning...
// Override from Phoenix
pref("network.protocol-handler.warn-external.mailto", false); // [HIDDEN] [DEFAULT]

/// Disable support for web applications manifests
// Ex. used for PWAs (& PWA inspection on desktop)
// Unnecessary for our use case
// https://developer.mozilla.org/docs/Web/Progressive_web_apps/Manifest
// https://bugzilla.mozilla.org/show_bug.cgi?id=1603673
// https://bugzilla.mozilla.org/show_bug.cgi?id=1647858
pref("dom.manifest.enabled", false);

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
// This likely isn't used anywhere, but Thunderbird does seem to pull in this component and this setting appears in the `about:config`, so we can set it anyways
pref("browser.newtabpage.enabled", false);

pref("mail.dove.status", "018");

/*** 019 Personal Touch 💜 ***/

/// Things that are nice to have™
// Not directly privacy & security related

/// Disable extra logging for policies by default
// This pref allows controlling the log level of policies (extremely useful for troubleshooting...), set here to the default value so that it's exposed in the about:config
// https://searchfox.org/comm-central/source/mail/components/enterprisepolicies/Policies.sys.mjs
pref("browser.policies.loglevel", "Error"); // [HIDDEN] [DEFAULT]

/// Enable the 'Bubbles' chat theme by default [CHAT]
pref("messenger.options.messagesStyle.theme", "bubbles"); // [CHAT]

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
pref("mail.accounthub.enabled", true);

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

pref("mail.dove.status", "019");

/*** 020 SPECIALIZED/CUSTOM CONFIGS [LINUX-ONLY] ***/

/// Enable support for custom/specialized configs... [LINUX-ONLY]
pref("general.config.filename", "dove.cfg"); // [LINUX-ONLY]
pref("general.config.vendor", "dove"); // [LINUX-ONLY]
pref("general.config.obscure_value", 0); // [LINUX-ONLY]

pref("mail.dove.status", "020"); // [LINUX-ONLY]

pref("mail.dove.status", "successfully applied :D", locked);
