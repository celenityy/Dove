//
// The Phoenix shall be followed by a Dove: one of great strength and great beauty, to help carry out its conquest.

// Built from Phoenix (Hardened)

pref("mail.dove.version", "2025.01.22.1", locked);

pref("mail.dove.status", "000");

// 001 TELEMETRY

pref("toolkit.telemetry.ecosystemtelemetry.enabled", false, locked); // [DEFAULT for non-Nightly...]

pref("mail.dove.status", "001");

// 002 MOZILLA CRAP

/// Disable Mozilla Email Provisioner/Creating new email addresses with their "partners"

pref("mail.provider.enabled", false);

/// Never check default mail client

pref("mail.shell.checkDefaultClient", false);

/// Skip Onboarding

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

pref("mail.dove.status", "002");

// 003 DISK AVOIDANCE

/// Disable caching

pref("mail.imap.use_disk_cache2", false);

/// Set website permissions to be session only

pref("permissions.memory_only", true);

/// Fully disable browsing history

pref("places.history.enabled", false);

/// Sanitize cookies on exit
// https://bugzilla.mozilla.org/show_bug.cgi?id=1675829

pref("network.cookie.noPersistentStorage", true);

/// Disable logging chat history
// https://stackoverflow.com/questions/32155137/how-to-disable-chat-history-in-mozilla-thunderbird

pref("purple.logging.log_chats", false);
pref("purple.logging.log_ims", false);

/// Do not leak info in chat notifications by default

pref("mail.chat.notification_info", 2);

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

pref("mail.showCondensedAddresses", false);

/// Always show email information & headers

pref("mail.show_headers", 2);
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

/// Disable reporting chat idle status

pref("messenger.status.reportIdle", false);

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

pref("browser.geolocation.warning.infoURL", "");
pref("geo.enabled", false);
pref("geo.provider.network.url", "");
pref("geo.provider.use_corelocation", false);
pref("geo.provider.use_geoclue", false);

/// Harden FPP
// As explained here: https://codeberg.org/celenity/Phoenix/issues/46
// We're adding -HttpUserAgent & -NavigatorUserAgent (compared to standard Phoenix Extended) because they try to report that we're Firefox, which causes all kinds of breakage and weird behavior (ex. on the ATO...)

pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-HttpUserAgent,-NavigatorUserAgent");

/// Reset Phoenix's FPP overrides + disable Mozilla's remote overrides
// These are meant for browsers and may have undesired privacy implications for our use case...

pref("privacy.fingerprintingProtection.granularOverrides", ""); // [DEFAULT]
pref("privacy.fingerprintingProtection.remoteOverrides.enabled", false);

/// Strip referers, but allow toggling per session, since they may be needed on rare occasions.

pref("network.http.referer.XOriginPolicy", 2, sticky);

/// Prevent leaking sensitive information from the Cardbook extension
// https://github.com/HorlogeSkynet/thunderbird-user.js/blob/master/user.js#L1231

pref("extensions.cardbook.useOnlyEmail", true);

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

lockPref("mail.dove.status", "009");

// 010 MISC.

/// Send emails in plaintext by default
// https://drewdevault.com/2016/04/11/Please-use-text-plain-for-emails.html

pref("mail.default_send_format", 1);
pref("mail.html_compose", false);
pref("mail.identity.default.compose_html", false);

/// By default, load summary of RSS feeds instead of the full webpage & prevent loading additional webpage content

pref("rss.message.loadWebPageOnSelect", 0);
pref("rss.show.summary", 1);

/// Do not allow calendar to extract data from emails by default

pref("calendar.extract.service.enabled", false); // [DEFAULT]

/// Disable Web Notifications

pref("dom.webnotifications.enabled", false);

/// Kill Gecko Media Plugins

pref("media.gmp-gmpopenh264.enabled", false);
pref("media.gmp-gmpopenh264.provider.enabled", false);
pref("media.gmp-gmpopenh264.visible", false);
pref("media.gmp-provider.enabled", false);

/// Always allow installing "incompatible" add-ons - REQUIRED FOR UBLOCK ORIGIN

pref("extensions.strictCompatibility", false, locked);

/// Allow running uBlock Origin on sites with restrictions (Quarantined domains)
// Necessary since it isn't 'recommended' like it is on Firefox...

pref("extensions.quarantineIgnoredByUser.uBlock0@raymondhill.net", true);

/// Disable SVG
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg

pref("svg.disabled", true);

pref("mail.dove.status", "010");

// 011 Personal Touch 💜

/// Things that are nice to have™
// Not directly privacy & security related

/// Enable inline spellcheck when composing messages & check before sending by default

pref("mail.spellcheck.inline", true); // [DEFAULT]
pref("mail.SpellCheckBeforeSend", true);

/// Enable dark theme for the message pane

pref("mail.dark-reader.enabled", true);

pref("mail.dove.status", "011");

// 012 DO NOT TOUCH

pref("browser.privatebrowsing.autostart", false, locked); // Breaks uBlock Origin & all other extensions... also unnecessary since we always sanitize data anyways
pref("mailnews.oauth.usePrivateBrowser", false, locked); // Breaks uBlock Origin & all other extensions... also unnecessary since we always sanitize data anyways

pref("mail.dove.status", "012");

// 013 Enable support for custom/specialized configs...

pref("general.config.filename", "dove.cfg");
pref("general.config.vendor", "dove");
pref("general.config.obscure_value", 0);

pref("mail.dove.status", "013");

pref("mail.dove.status", "successfully applied :D", locked);
