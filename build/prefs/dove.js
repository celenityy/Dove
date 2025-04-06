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

pref("mail.dove.version", "2025.04.02.1", locked);

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
014: MISC. PRIVACY + SECURITY
015: MISC. PRIVACY
016: MISC. SECURITY
017: MISC.
018: Personal Touch 💜
019: SPECIALIZED/CUSTOM CONFIGS

*/

pref("mail.dove.status", "000");

/*** 001 DATA COLLECTION ***/

/// Disable Ecosystem Telemetry
// https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/obsolete/ecosystem-telemetry.html
pref("toolkit.telemetry.ecosystemtelemetry.enabled", false, locked); // [DEFAULT - non-Nightly]

pref("mail.dove.status", "001");

/*** 002 MOZILLA CRAP™ ***/

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

/// Disable Firefox Translations
// The code is technically present in Thunderbird (ex. `about:translations` is accessible...), but it currently doesn't seem possible to actually download any language models from Remote Settings, meaning it's useless :/
pref("browser.translations.automaticallyPopup", false);
pref("browser.translations.enable", false); // [DEFAULT]
pref("browser.translations.select.enable", false); // [DEFAULT]

/// Disable onboarding
// https://searchfox.org/comm-central/source/suite/components/nsSuiteGlue.js#965
pref("browser.EULA.override", true);
pref("browser.rights.override", true);
pref("mail.rights.override", true);
pref("mailnews.start_page_override.mstone", "ignore");

/// Disable recommendations
pref("extensions.getAddons.recommended.url", "");

/// Disable Start Page by default & switch the URL to the about:config
// This allows users to easily access the about:config via the menu bar from Go -> Mail Start Page
// Or by pressing alt + home
pref("mailnews.start_page.enabled", false);
pref("mailnews.start_page.override_url", "");
pref("mailnews.start_page.url", "about:config");

/// Prevent checking if Thunderbird is the default mail client
pref("mail.shell.checkDefaultClient", false);

/// Prevent checking if Thunderbird is the default PDF viewer
pref("pdfjs.firstRun", false);

/// Remove tracking parameters from Mozilla URLs
pref("app.releaseNotesURL", "https://live.thunderbird.net/%APP%/releasenotes?locale=%LOCALE%&version=%VERSION%&channel=%CHANNEL%&os=%OS%&buildid=%APPBUILDID%");
pref("app.releaseNotesURL.aboutDialog", "https://live.thunderbird.net/%APP%/releasenotes?locale=%LOCALE%&version=%VERSION%&channel=%CHANNEL%&os=%OS%&buildid=%APPBUILDID%");
pref("app.releaseNotesURL.prompt", "https://live.thunderbird.net/%APP%/releasenotes?locale=%LOCALE%&version=%VERSION%&channel=%CHANNEL%&os=%OS%&buildid=%APPBUILDID%");
pref("extensions.getAddons.search.browseURL", "https://addons.thunderbird.net/%LOCALE%/%APP%/search/?q=%TERMS%");

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

/// Freeze user agent to protect against fingerprinting
// As explained below, we can't use the standard RFP/FPP 'HttpUserAgent' & 'NavigatorUserAgent` targets, as Thunderbird lies and pretends to be Firefox, which causes breakage and unexpected issues
// Until Thunderbird fixes this upstream, we'll spoof it ourselves
// This matches what Firefox's RFP/FPP targets use (only difference being we switch out Firefox for Thunderbird)
// We'll keep platform always spoofed to Windows - since we block JS by default, can be useful (and I can't see this causing weird issues like we see on Firefox...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1950775
pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Thunderbird/128.0"); // [HIDDEN]

/// Harden FPP
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Features#fingerprinting
// and here: https://codeberg.org/celenity/Phoenix/wiki/Extended.md#fingerprinting
// We're adding -HttpUserAgent & -NavigatorUserAgent (compared to standard Phoenix Extended) because they try to report that we're Firefox, which causes all kinds of breakage and weird behavior (ex. on the ATO)
// We're removing -CanvasExtractionBeforeUserInputIsBlocked as Thunderbird simply doesn't support these permission prompts for canvas data extraction...
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme,-FrameRate,-HttpUserAgent,-JSLocale,-NavigatorUserAgent");

/// Reset Phoenix's FPP overrides + disable Mozilla's remote overrides
// These are meant for browsers and may have undesired privacy implications for our use case...
pref("privacy.fingerprintingProtection.granularOverrides", ""); // [DEFAULT]
pref("privacy.fingerprintingProtection.remoteOverrides.enabled", false);

pref("mail.dove.status", "005");

/*** 006 DISK AVOIDANCE ***/

/// Disable browsing history
pref("places.history.enabled", false);

/// Disable disk caching
pref("mail.imap.use_disk_cache2", false);

/// Disable logging chat history [CHAT]
// https://stackoverflow.com/questions/32155137/how-to-disable-chat-history-in-mozilla-thunderbird
pref("purple.logging.log_chats", false); // [CHAT]
pref("purple.logging.log_ims", false); // [CHAT]

/// Disable logging E2EE messages (OTR) [CHAT]
pref("chat.otr.default.allowMsgLog", false); // [CHAT]

/// Enable Private Browsing
// https://support.mozilla.org/kb/private-browsing-use-firefox-without-history
pref("browser.privatebrowsing.autostart", true);
pref("mailnews.oauth.usePrivateBrowser", true);

/// Prevent permission manager from writing to disk
pref("permissions.memory_only", true); // [HIDDEN]

/// Prevent leaking info in chat notifications [CHAT]
pref("mail.chat.notification_info", 2); // [CHAT]

/// Prevent leaking info in email alerts/notifications
pref("mail.biff.alert.show_preview", false);
pref("mail.biff.alert.show_sender", false);
pref("mail.biff.alert.show_subject", false);

/// Sanitization
// These are mostly just for defense in depth/useful if users disable Private Browsing
// Clears cookies on exit & prevents storing them persistently
// https://bugzilla.mozilla.org/show_bug.cgi?id=1675829
pref("network.cookie.noPersistentStorage", true);
pref("privacy.clearOnShutdown.cookies", true);
pref("privacy.clearOnShutdown.offlineApps", true); // [HIDDEN]
pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true);

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

/// Disable FFmpeg
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=ffmpeg
pref("media.ffmpeg.enabled", false);
pref("media.ffmpeg.encoder.enabled", false); // [DEFAULT]
pref("media.ffmpeg.vaapi.enabled", false); // [DEFAULT]
pref("media.rdd-ffmpeg.enabled", false);
pref("media.utility-ffmpeg.enabled", false);

/// Disable Gecko Media Plugins
// https://wiki.mozilla.org/GeckoMediaPlugins
pref("media.gmp-provider.enabled", false);

/// Disable SVG
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg
pref("svg.disabled", true);

/// Disable WebRTC
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=webrtc
// https://x.com/GrapheneOS/status/1728921946396725618
pref("media.peerconnection.enabled", false);

pref("mail.dove.status", "011");

/*** 012 PASSWORDS & AUTHENTICATION ***/

/// Re-enable Password Manager by default
// This is useful & important for Thunderbird, since it's the only way to stay logged in/store account passwords...
// Also no UI toggle for it :/
pref("signon.rememberSignons", true); // [DEFAULT]

pref("mail.dove.status", "012");

/*** 013 EXTENSIONS ***/

/// Add our own extension recommendations
// https://searchfox.org/mozilla-central/source/testing/profiles/common/user.js
pref("extensions.getAddons.discovery.api_url", "https://gitlab.com/celenityy/Dove/-/raw/pages/extensions/recommendations.json");
pref("extensions.recommendations.privacyPolicyUrl", "https://dove.celenity.dev/privacy#extension-recommendations");

/// Allow reporting malicious add-ons/themes to Mozilla
pref("extensions.abuseReport.enabled", true);

/// Allow running uBlock Origin on restricted/quarantined domains
// Necessary since uBlock Origin isn't 'recommended' like it is on Firefox...
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantineIgnoredByUser.uBlock0@raymondhill.net", true); // [HIDDEN]

/// Always allow installing "incompatible" add-ons
// REQUIRED FOR UBLOCK ORIGIN
pref("extensions.strictCompatibility", false, locked); // [DEFAULT] [HIDDEN]

/// Block DKIM Verifier from accessing restricted/quarantined domains
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantineIgnoredByUser.dkim_verifier@pl", false);

/// Prevent leaking display names of contacts in address fields with emails [CARDBOOK]
// https://github.com/HorlogeSkynet/thunderbird-user.js/blob/master/user.js#L1231
pref("extensions.cardbook.useOnlyEmail", true);

pref("mail.dove.status", "013");

/*** 014 MISC. PRIVACY + SECURITY ***/

/// Disable WebGL
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// https://blog.browserscan.net/docs/webgl-fingerprinting
// https://security.stackexchange.com/questions/13799/is-webgl-a-security-concern
pref("webgl.disabled", true);

pref("mail.dove.status", "014");

/*** 015 MISC. PRIVACY ***/

/// Disable automatic collection of email addresses for Thunderbird's Address Book
pref("mail.collect_email_address_outgoing", false);

/// Disable Geolocation
// https://browserleaks.com/geo
pref("browser.geolocation.warning.infoURL", "");
pref("geo.provider.network.url", "");
pref("geo.provider.use_corelocation", false);
pref("geo.provider.use_geoclue", false);

/// Disable legacy XMPP gateways for Facebook, Google, Twitter, and Yahoo [CHAT]
// https://searchfox.org/comm-central/source/chat/chat-prefs.js#76
pref("chat.prpls.prpl-facebook.disable", true); // [DEFAULT] [CHAT]
pref("chat.prpls.prpl-gtalk.disable", true); // [DEFAULT] [CHAT]
pref("chat.prpls.prpl-twitter.disable", true); // [DEFAULT] [CHAT]
pref("chat.prpls.prpl-yahoo.disable", true); // [DEFAULT] [CHAT]

/// Disable macOS Spotlight and Windows file indexing for email by default
pref("mail.spotlight.enable", false); // [DEFAULT]
pref("mail.spotlight.firstRunDone", true);
pref("mail.winsearch.enable", false); // [DEFAULT] [NO-OSX]
pref("mail.winsearch.firstRunDone", true); // [NO-OSX]
pref("searchintegration.enable", false);

/// Prevent calendar from extracting data from emails by default
pref("calendar.extract.service.enabled", false); // [DEFAULT]

/// Remove default Google Groups link
pref("mailnews.messageid_browser.url", "");

/// Warn users if they have not addressed a BCC (Blind Carbon Copy) warning
pref("mail.compose.warn_public_recipients.aggressive", true);

pref("mail.dove.status", "015");

/*** 016 MISC. SECURITY ***/

/// Always warn users before launching other apps
pref("mail.external_protocol_requires_permission", true); // [HIDDEN]

/// Disable insecure NTLMv1
// Fedora's Thunderbird package overrides this to `true`... :/
// https://www.janbambas.cz/ntlm-v1-and-firefox/
// https://bugzilla.mozilla.org/show_bug.cgi?id=828183
// https://bugzilla.redhat.com/show_bug.cgi?id=1110291
pref("network.negotiate-auth.allow-insecure-ntlm-v1", false); // [DEFAULT] [HIDDEN]

/// Enable built-in phishing protection
// https://support.mozilla.org/kb/thunderbirds-scam-detection
pref("mail.phishing.detection.disallow_form_actions", true); // [DEFAULT]
pref("mail.phishing.detection.enabled", true); // [DEFAULT]
pref("mail.phishing.detection.ipaddresses", true); // [DEFAULT]
pref("mail.phishing.detection.mismatched_hosts", true); // [DEFAULT]

/// Enable mozilla::pkix certificate verification
// Fedora's Thunderbird package overrides this to `false`... :/
// https://wiki.mozilla.org/SecurityEngineering/mozpkix-testing
pref("security.use_mozillapkix_verification", true);  // [DEFAULT] [HIDDEN]

/// Limit classes that can process incoming data
// Enables a blocklist to avoid HTML, inline images, and other unknown content types
// https://searchfox.org/comm-central/source/mailnews/mailnews.js#728
pref("mailnews.display.disallow_mime_handlers", 3);
pref("rss.display.disallow_mime_handlers", 3);

/// Prevent 3rd party software from intercepting & analyzing emails
// This is the "Allow Antivirus clients to quarantine individual incoming messages" option within Privacy & Security settings
// https://searchfox.org/comm-central/source/mail/components/MailGlue.sys.mjs#1299
pref("mailnews.downloadToTempFile", false, locked);

/// Sanitize HTML content
// https://www.bucksch.org/1/projects/mozilla/108153/
pref("mail.html_sanitize.drop_conditional_css", true); // [DEFAULT]
pref("mailnews.display.html_as", 3);
pref("rss.display.html_as", 3);

pref("mail.dove.status", "016");

/*** 017 MISC. ***/

/// Disable `mailto:` warning...
// Override from Phoenix
pref("network.protocol-handler.warn-external.mailto", false); // [DEFAULT] [HIDDEN]

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

/// Send emails in plaintext by default
// https://drewdevault.com/2016/04/11/Please-use-text-plain-for-emails.html
pref("mail.default_send_format", 1);
pref("mail.html_compose", false);
pref("mail.identity.default.compose_html", false);

pref("mail.dove.status", "017");

/*** 018 Personal Touch 💜 ***/

/// Things that are nice to have™
// Not directly privacy & security related

/// Allow inspecting/debugging local tabs
// Extremely useful for Thunderbird, as it gives us a URL bar...
// Can be accessed via `Tools` -> `Developer Tools` -> `Debug Add-ons` (`about:debugging`), simply choose `Inspect` next to any tab of your choice and profit...
pref("devtools.aboutdebugging.local-tab-debugging", true);

/// Enable the 'Bubbles' chat theme by default [CHAT]
pref("messenger.options.messagesStyle.theme", "bubbles"); // [CHAT]

/// Enable dark theme for the message pane
pref("mail.dark-reader.enabled", true);
pref("mail.dark-reader.show-toggle", true); // [HIDDEN] UI toggle - https://searchfox.org/comm-central/source/mail/base/content/msgHdrView.js#2787

/// Enable inline spellcheck when composing messages + check before sending by default
pref("mail.spellcheck.inline", true); // [DEFAULT]
pref("mail.SpellCheckBeforeSend", true);

/// Prevent automatically converting emoticons to emojis
pref("mail.display_glyph", false);

/// Show progress when saving/sending a message
pref("mailnews.show_send_progress", true); // [DEFAULT]

/// Use underscores instead of spaces in file names when saving messages by default
pref("mail.save_msg_filename_underscores_for_space", true);

pref("mail.dove.status", "018");

/*** 019 SPECIALIZED/CUSTOM CONFIGS [NO-OSX] ***/

/// Enable support for custom/specialized configs... [NO-OSX]
pref("general.config.filename", "dove.cfg"); // [NO-OSX]
pref("general.config.vendor", "dove"); // [NO-OSX]
pref("general.config.obscure_value", 0); // [NO-OSX]

pref("mail.dove.status", "019"); // [NO-OSX]

pref("mail.dove.status", "successfully applied :D", locked);
