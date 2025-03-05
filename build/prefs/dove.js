//
// The Phoenix shall be followed by a Dove: one of great strength and great beauty, to help carry out its conquest.

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

pref("mail.dove.version", "2025.02.28.1", locked);

pref("mail.dove.status", "000");

// 001 TELEMETRY

pref("toolkit.telemetry.ecosystemtelemetry.enabled", false, locked); // [DEFAULT for non-Nightly...]

pref("mail.dove.status", "001");

// 002 MOZILLA CRAP

/// Disable Mozilla Email Provisioner/Creating new email addresses with their "partners"

pref("mail.provider.enabled", false);
pref("mail.provider.suppress_dialog_on_startup", true); // [HIDDEN]

/// Never check if Thunderbird is the default mail client

pref("mail.shell.checkDefaultClient", false);

/// Never check if Thunderbird is the default PDF viewer

pref("pdfjs.firstRun", false);

/// Skip onboarding
// https://searchfox.org/comm-central/source/suite/components/nsSuiteGlue.js#965

pref("browser.EULA.override", true);
pref("browser.rights.override", true);
pref("mail.rights.override", true);
pref("mailnews.start_page_override.mstone", "ignore");

/// Disable Start Page by default & switch the URL to the about:config
// This allows users to easily access the about:config via the menu bar from Go -> Mail Start Page
// Or by pressing alt + home

pref("mailnews.start_page.enabled", false);
pref("mailnews.start_page.override_url", "");
pref("mailnews.start_page.url", "about:config");

/// Disable Donate Prompts
// Please still donate to Thunderbird if you appreciate it! ;)
// https://www.thunderbird.net/?form=support

pref("app.donation.eoy.url", "", locked);
pref("app.donation.eoy.version.viewed", 99, locked);

/// Disable Filelink
// https://support.mozilla.org/kb/filelink-large-attachments

pref("mail.cloud_files.enabled", false);

/// Disable "Chat" functionality

pref("mail.chat.enabled", false);

/// Kill Add-on "Discovery" Recommendations

pref("extensions.getAddons.recommended.url", "");

/// Remove unnecessary URL params

pref("app.releaseNotesURL", "https://live.thunderbird.net/%APP%/releasenotes?locale=%LOCALE%&version=%VERSION%&channel=%CHANNEL%&os=%OS%&buildid=%APPBUILDID%");
pref("app.releaseNotesURL.aboutDialog", "https://live.thunderbird.net/%APP%/releasenotes?locale=%LOCALE%&version=%VERSION%&channel=%CHANNEL%&os=%OS%&buildid=%APPBUILDID%");
pref("app.releaseNotesURL.prompt", "https://live.thunderbird.net/%APP%/releasenotes?locale=%LOCALE%&version=%VERSION%&channel=%CHANNEL%&os=%OS%&buildid=%APPBUILDID%");
pref("extensions.getAddons.search.browseURL", "https://addons.thunderbird.net/%LOCALE%/%APP%/search/?q=%TERMS%");

/// Disable Firefox Translations
// The code is technically present in Thunderbird (ex. `about:translations` is accessible...), but it currently doesn't seem possible to actually download any language models from Remote Settings, meaning it's useless :/

pref("browser.translations.alwaysTranslateLanguages", ""); // [DEFAULT]
pref("browser.translations.automaticallyPopup", false);
pref("browser.translations.enable", false); // [DEFAULT]
pref("browser.translations.select.enable", false); // [DEFAULT]

pref("mail.dove.status", "002");

// 003 DISK AVOIDANCE

/// Disable caching

pref("mail.imap.use_disk_cache2", false);

/// Set website permissions to be session only

pref("permissions.memory_only", true); // [HIDDEN]

/// Fully disable browsing history

pref("places.history.enabled", false);

/// Sanitize data on exit...
// https://bugzilla.mozilla.org/show_bug.cgi?id=1675829

pref("network.cookie.noPersistentStorage", true);
pref("privacy.clearHistory.cookiesAndStorage", true);
pref("privacy.clearOnShutdown.cookies", true);
pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true);
pref("privacy.clearSiteData.cookiesAndStorage", true);

/// Disable logging chat history
// https://stackoverflow.com/questions/32155137/how-to-disable-chat-history-in-mozilla-thunderbird

pref("purple.logging.log_chats", false);
pref("purple.logging.log_ims", false);

/// Do not leak info in chat notifications by default

pref("mail.chat.notification_info", 2);

/// Do not leak info in email alerts/notifications by default

pref("mail.biff.alert.show_preview", false);
pref("mail.biff.alert.show_sender", false);
pref("mail.biff.alert.show_subject", false);

pref("mail.dove.status", "003");

// 004 GENERAL NETWORK HARDENING

/// Enforce using secure connections for auto config

pref("mailnews.auto_config.fetchFromISP.sslOnly", true);
pref("mailnews.auto_config.guess.requireGoodCert", true); // [DEFAULT]
pref("mailnews.auto_config.guess.sslOnly", true);

/// Disable sending usernames to your email provider when using auto config by default...
// https://searchfox.org/comm-central/source/mailnews/mailnews.js#1024

pref("mailnews.auto_config.fetchFromISP.sendEmailAddress", false);

/// Disable link previews

pref("mail.compose.add_link_preview", false);

/// Always warn when making insecure connections
// Unclear whether actually used anywhere

pref("security.warn_entering_weak", true);
pref("security.warn_leaving_secure", true);
pref("security.warn_viewing_mixed", true);

pref("mail.dove.status", "004");

// 005 UI

/// Always show full email addresses

pref("mail.addressDisplayFormat", 0); // [DEFAULT, HIDDEN] Sets preferred address display format to "Full name and email address"
pref("mail.showCondensedAddresses", false);

/// Always show email information & headers

pref("mail.show_headers", 2);
pref("mailnews.display.date_senders_timezone", true); // Display timezone of sender
pref("mailnews.headers.showMessageId", true);
pref("mailnews.headers.showOrganization", true);
pref("mailnews.headers.showReferences", true);
pref("mailnews.headers.showSender", true);
pref("mailnews.headers.showUserAgent", true);

pref("mail.dove.status", "005");

// 006 INFORMATION LEAKAGE

/// Disable sending read receipts
// https://searchfox.org/comm-central/source/mailnews/mailnews.js#292

pref("mail.mdn.report.enabled", false);
pref("mail.mdn.report.not_in_to_cc", 0);
pref("mail.mdn.report.outside_domain", 0);
pref("mail.mdn.report.other", 0);
pref("mail.server.default.mdn_not_in_to_cc", 0);
pref("mail.server.default.mdn_other", 0);
pref("mail.server.default.mdn_outside_domain", 0);
pref("mail.server.default.mdn_report_enabled", false);
pref("purple.conversations.im.send_read", false); // [CHAT]

/// Disable sending chat typing notifications

pref("purple.conversations.im.send_typing", false);

/// Disable reporting chat idle status...

pref("messenger.status.reportIdle", false);

/// Disable reporting chat status as 'away' when idle...
// Defense in depth

pref("messenger.status.awayWhenIdle", false);

/// Prevent sending user agent with emails, as it is unnecessary, not even defined in spec, & leaks information
// https://bugzilla.mozilla.org/show_bug.cgi?id=1114475

pref("mailnews.headers.sendUserAgent", false);
pref("mailnews.headers.useMinimalUserAgent", true); // [DEFAULT, DEFENSE IN DEPTH]

/// Prevent leaking system locale & date/time in replies

pref("mailnews.reply_header_authorwroteondate", "#1 wrote on #2 #3:");
pref("mailnews.reply_header_authorwrotesingle", "#1 wrote:");
pref("mailnews.reply_header_ondateauthorwrote", "On #2 #3, #1 wrote:");
pref("mailnews.reply_header_type", 1);

/// Prevent leaking spellcheck dictionary info
// https://bugzilla.mozilla.org/show_bug.cgi?id=1370217

pref("mail.suppress_content_language", true);

/// Prevent leaking locale & specific time through date header
// https://bugzilla.mozilla.org/show_bug.cgi?id=1603359

pref("mail.sanitize_date_header", true);

/// Prevent local IP address leakage via EHLO/HELO...
// https://blog.plee.me/2014/11/mozilla-thunderbird-changing-the-ehlo-helo-value-in-the-received-header-for-outgoing-mail/

pref("mail.smtpserver.default.hello_argument", "[127.0.0.1]"); // [HIDDEN]

/// Prevent leaking display names of contacts in address fields...
// https://github.com/HorlogeSkynet/thunderbird-user.js/blob/master/user.js#L1231

pref("extensions.cardbook.useOnlyEmail", true);

pref("mail.dove.status", "006");

// 007 E2EE

/// Enable advanced E2EE settings
// https://searchfox.org/comm-central/source/mail/extensions/am-e2e/prefs/e2e-prefs.js#104

pref("temp.openpgp.advancedUser", true);

/// Always notify when encryption is possible

pref("mail.openpgp.remind_encryption_possible", true); // [DEFAULT]
pref("mail.smime.remind_encryption_possible", true); // [DEFAULT]

/// Always automatically encrypt when possible

pref("mail.e2ee.auto_enable", true);

/// Never automatically disable E2EE...
// https://searchfox.org/comm-central/source/mail/extensions/am-e2e/prefs/e2e-prefs.js#67

pref("mail.e2ee.auto_disable", false, locked); // [DEFAULT]

/// Always notify when E2EE is disabled

pref("mail.e2ee.notify_on_auto_disable", true, locked); // [DEFAULT]

/// Ensure we're not accepting insecure S/MIME signatures...
// https://searchfox.org/comm-central/source/mail/extensions/am-e2e/prefs/e2e-prefs.js#95

pref("mail.smime.accept_insecure_sha1_message_signatures", false); // [DEFAULT]

/// Sign messages by default
/// https://searchfox.org/comm-central/source/mail/extensions/am-e2e/prefs/e2e-prefs.js#12

pref("mail.identity.default.sign_mail", true);

/// Use GnuPG if built-in RNP fails
// https://wiki.mozilla.org/Thunderbird:OpenPGP:Smartcards#Allow_the_use_of_external_GnuP

pref("mail.openpgp.allow_external_gnupg", true);

/// Always warn users when using a deprecated version of GnuPG...

pref("temp.openpgp.warnDeprecatedGnuPG", true); // [DEFAULT]

pref("mail.dove.status", "007");

// 008 MISC. PRIVACY

/// Never load remote content in emails
// This still allows setting exceptions.

pref("mailnews.message_display.disable_remote_image", true, locked); // [DEFAULT]

/// Disable Geolocation
// https://browserleaks.com/geo

pref("browser.geolocation.warning.infoURL", "");
pref("geo.provider.network.url", "");
pref("geo.provider.use_corelocation", false);
pref("geo.provider.use_geoclue", false);

/// Harden FPP
// As explained here: https://codeberg.org/celenity/Phoenix/issues/46
// We're adding -HttpUserAgent & -NavigatorUserAgent (compared to standard Phoenix Extended) because they try to report that we're Firefox, which causes all kinds of breakage and weird behavior (ex. on the ATO...)
// We're removing -CanvasExtractionBeforeUserInputIsBlocked as Thunderbird simply doesn't support these permission prompts for canvas data extraction...

pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme,-FrameRate,-HttpUserAgent,-NavigatorUserAgent");

/// Reset Phoenix's FPP overrides + disable Mozilla's remote overrides
// These are meant for browsers and may have undesired privacy implications for our use case...

pref("privacy.fingerprintingProtection.granularOverrides", ""); // [DEFAULT]
pref("privacy.fingerprintingProtection.remoteOverrides.enabled", false);

/// Freeze user agent to protect against fingerprinting
// As explained above, we can't use the standard RFP/FPP 'HttpUserAgent' & 'NavigatorUserAgent` targets, as Thunderbird lies and pretends to be Firefox, which causes breakage and unexpected issues
// Until Thunderbird fixes this upstream, we'll spoof it ourselves
// This matches what Firefox's RFP/FPP targets use (only difference being we switch out Firefox for Thunderbird)
// We'll keep platform always spoofed to Windows - since we block JS by default, can be useful (and I can't see this causing weird issues like we see on Firefox...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1950775

pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Thunderbird/128.0"); // [HIDDEN]

/// Disable macOS Spotlight & Windows file indexing email by default

pref("mail.spotlight.enable", false); // [DEFAULT]
pref("mail.spotlight.firstRunDone", true);
pref("mail.winsearch.enable", false); // [DEFAULT]
pref("mail.winsearch.firstRunDone", true);
pref("searchintegration.enable", false);

/// Disable automatic collection of email addresses for Thunderbird's Address Book...

pref("mail.collect_email_address_outgoing", false);

/// Alert users if they have not addressed a BCC (Blind Carbon Copy) warning

pref("mail.compose.warn_public_recipients.aggressive", true);

/// Explicitly disable legacy XMPP gateways for Facebook, Google, Twitter, and Yahoo...
// https://searchfox.org/comm-central/source/chat/chat-prefs.js#76

pref("chat.prpls.prpl-facebook.disable", true); // [DEFAULT]
pref("chat.prpls.prpl-gtalk.disable", true); // [DEFAULT]
pref("chat.prpls.prpl-twitter.disable", true); // [DEFAULT]
pref("chat.prpls.prpl-yahoo.disable", true); // [DEFAULT]

/// Prompt users on launch before going online

pref("offline.startup_state", 1);

/// Remove default Google Groups link

pref("mailnews.messageid_browser.url", "");

pref("mail.dove.status", "008");

// 009 MISC. SECURITY

/// Prevent 3rd party software from intercepting & analyzing your emails...
// This is the "Allow Antivirus clients to quarantine individual incoming messages" option within Privacy & Security settings...
// https://searchfox.org/comm-central/source/mail/components/MailGlue.sys.mjs#1299

pref("mailnews.downloadToTempFile", false, locked);

/// Sanitize HTML content
// https://www.bucksch.org/1/projects/mozilla/108153/

pref("mail.html_sanitize.drop_conditional_css", true); // [DEFAULT]
pref("mailnews.display.html_as", 3);
pref("rss.display.html_as", 3);

/// Enforce built-in phishing protection
// https://support.mozilla.org/kb/thunderbirds-scam-detection

pref("mail.phishing.detection.disallow_form_actions", true); // [DEFAULT]
pref("mail.phishing.detection.enabled", true); // [DEFAULT]
pref("mail.phishing.detection.ipaddresses", true); // [DEFAULT]
pref("mail.phishing.detection.mismatched_hosts", true); // [DEFAULT]

/// Always warn users before launching other apps...

pref("mail.external_protocol_requires_permission", true); // [HIDDEN]

/// Always alert users when downloads are initiated (and completed)
// https://searchfox.org/comm-central/source/mail/app/profile/all-thunderbird.js#505

pref("browser.download.manager.focusWhenStarting", true);
pref("browser.download.manager.showAlertOnComplete", true);
pref("browser.download.manager.showWhenStarting", true);

/// Show a progress dialog upon download
// https://searchfox.org/comm-central/source/suite/app/profile/suite-prefs.js#708

pref("browser.download.manager.behavior", 1); // [HIDDEN]

/// Limit classes that can process incoming data
// Enables a blocklist to avoid HTML, inline images, and other unknown content types
// https://searchfox.org/comm-central/source/mailnews/mailnews.js#728

pref("mailnews.display.disallow_mime_handlers", 3);
pref("rss.display.disallow_mime_handlers", 3);

/// Disable SVG
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg

pref("svg.disabled", true);

/// Disable WebRTC
// We already take care of privacy concerns here; this is for attack surface reduction...
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=webrtc
// https://x.com/GrapheneOS/status/1728921946396725618

pref("media.peerconnection.enabled", false);

/// If WASM (WebAssembly) is disabled (which we do by default), also disable it for extensions
// https://bugzilla.mozilla.org/show_bug.cgi?id=1576254
// Note: This breaks Firefox Translations - but that's currently broken on Thunderbird anyways, so we don't need to worry about it

pref("javascript.options.wasm_trustedprincipals", false);

/// Disable Gecko Media Plugins

pref("media.gmp-provider.enabled", false);

/// Disable FFmpeg
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=ffmpeg

pref("media.ffmpeg.enabled", false);
pref("media.ffmpeg.encoder.enabled", false); // [DEFAULT]
pref("media.ffmpeg.vaapi.enabled", false); // [DEFAULT]
pref("media.rdd-ffmpeg.enabled", false);
pref("media.utility-ffmpeg.enabled", false);

/// Disable insecure NTLMv1
// Fedora's Thunderbird package overrides this to `true`... :/
// https://www.janbambas.cz/ntlm-v1-and-firefox/
// https://bugzilla.mozilla.org/show_bug.cgi?id=828183
// https://bugzilla.redhat.com/show_bug.cgi?id=1110291

pref("network.negotiate-auth.allow-insecure-ntlm-v1", false); // [DEFAULT, HIDDEN]

/// Ensure we're using mozilla::pkix certificate verification
// Fedora's Thunderbird package overrides this to `false`... :/
// https://wiki.mozilla.org/SecurityEngineering/mozpkix-testing

pref("security.use_mozillapkix_verification", true); // [DEFAULT, HIDDEN]

pref("mail.dove.status", "009");

// 010 MISC.

/// Send emails in plaintext by default
// https://drewdevault.com/2016/04/11/Please-use-text-plain-for-emails.html

pref("mail.default_send_format", 1);
pref("mail.html_compose", false);
pref("mail.identity.default.compose_html", false);

/// Prefer viewing emails in plaintext by default

pref("mailnews.display.prefer_plaintext", true);

/// Prefer viewing RSS feeds in plaintext by default

pref("rss.display.prefer_plaintext", true);

/// Load summary of RSS feeds instead of the full webpage by default

pref("rss.show.summary", 1);

/// Open RSS webpages in your web browser instead of Thunderbird...
// https://support.mozilla.org/kb/how-subscribe-news-feeds-and-blogs

pref("rss.show.content-base", 3);

/// Prevent selection of RSS messages from automatically loading the web page...
// https://support.mozilla.org/kb/how-subscribe-news-feeds-and-blogs

pref("rss.message.loadWebPageOnSelect", 0);

/// Do not allow calendar to extract data from emails by default

pref("calendar.extract.service.enabled", false); // [DEFAULT]

/// Always allow installing "incompatible" add-ons - REQUIRED FOR UBLOCK ORIGIN

pref("extensions.strictCompatibility", false, locked);

/// Allow running uBlock Origin on sites with restrictions (Quarantined domains)
// Necessary since it isn't 'recommended' like it is on Firefox...

pref("extensions.quarantineIgnoredByUser.uBlock0@raymondhill.net", true);

/// Block DKIM Verifier from accessing quarantined domains...

pref("extensions.quarantineIgnoredByUser.dkim_verifier@pl", false);

/// Prevent status bar spoofing
// https://searchfox.org/comm-central/source/mail/app/profile/all-thunderbird.js#542

pref("dom.disable_window_status_change", true); // [DEFAULT]

/// Re-enable Password Manager by default
// This is useful & important for Thunderbird, since it's the only way to store account passwords...
// Also no UI toggle for it :/

pref("signon.rememberSignons", true); // [DEFAULT]

/// Add our own extension recommendations...

pref("extensions.getAddons.discovery.api_url", "https://dove.celenity.dev/extensions/recommendations.json"); // https://searchfox.org/mozilla-central/source/testing/profiles/common/user.js
pref("extensions.recommendations.privacyPolicyUrl", "https://dove.celenity.dev/privacy#extension-recommendations");

/// Don't warn on `mailto:`...
// Override from Phoenix

pref("network.protocol-handler.warn-external.mailto", false); // [DEFAULT, HIDDEN]

pref("mail.dove.status", "010");

// 011 Personal Touch 💜

/// Things that are nice to have™
// Not directly privacy & security related

/// Enable inline spellcheck when composing messages & check before sending by default

pref("mail.spellcheck.inline", true); // [DEFAULT]
pref("mail.SpellCheckBeforeSend", true);

/// Enable dark theme for the message pane

pref("mail.dark-reader.enabled", true);
pref("mail.dark-reader.show-toggle", true); // [HIDDEN] Enables the UI toggle https://searchfox.org/comm-central/source/mail/base/content/msgHdrView.js#2787

/// By default, when saving a message to a file, use underscores instead of spaces in the file name...

pref("mail.save_msg_filename_underscores_for_space", true);

/// Show progress when saving/sending a message...

pref("mailnews.show_send_progress", true); // [DEFAULT]

/// Allow reporting malicious add-ons/themes to Mozilla

pref("extensions.abuseReport.enabled", true);

/// Allow inspecting/debugging local tabs
// Extremely useful for Thunderbird, as it gives us a URL bar...
// Can be accessed via `Tools` -> `Developer Tools` -> `Debug Add-ons` (`about:debugging`), simply choose `Inspect` next to any tab of your choice and profit...

pref("devtools.aboutdebugging.local-tab-debugging", true);

pref("mail.dove.status", "011");

// 012 DO NOT TOUCH

pref("browser.privatebrowsing.autostart", false, locked); // Breaks uBlock Origin & all other extensions... also unnecessary since we always sanitize data anyways
pref("mailnews.oauth.usePrivateBrowser", false, locked); // Breaks uBlock Origin & all other extensions... also unnecessary since we always sanitize data anyways

pref("mail.dove.status", "012");

// 013 Enable support for custom/specialized configs... // [NO-OSX]

pref("general.config.filename", "dove.cfg"); // [NO-OSX]
pref("general.config.vendor", "dove"); // [NO-OSX]
pref("general.config.obscure_value", 0); // [NO-OSX]

pref("mail.dove.status", "013"); // [NO-OSX]

pref("mail.dove.status", "successfully applied :D", locked);
