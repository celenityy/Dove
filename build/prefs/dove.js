//
// The Phoenix shall be followed by a Dove: one of great strength and great beauty, to help carry out its conquest.

// Built from Phoenix (Extended)

pref("mail.dove.version", "2025.01.27.1", locked);

pref("mail.dove.status", "000");

// 001 TELEMETRY

pref("toolkit.telemetry.ecosystemtelemetry.enabled", false, locked); // [DEFAULT for non-Nightly...]

pref("mail.dove.status", "001");

// 002 MOZILLA CRAP

/// Disable Mozilla Email Provisioner/Creating new email addresses with their "partners"

pref("mail.provider.enabled", false);
pref("mail.provider.suppress_dialog_on_startup", true); // [HIDDEN]

/// Never check default mail client

pref("mail.shell.checkDefaultClient", false);

/// Never check default PDF viewer

pref("pdfjs.firstRun", false);

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

/// Disable macOS Spotlight & Windows file indexing email by default

pref("mail.spotlight.enable", false); // [DEFAULT]
pref("mail.spotlight.firstRunDone", true);
pref("mail.winsearch.enable", false); // [DEFAULT]
pref("mail.winsearch.firstRunDone", true);
pref("searchintegration.enable", false);

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

pref("mail.dove.status", "009");

// 010 MISC.

/// Send emails in plaintext by default
// https://drewdevault.com/2016/04/11/Please-use-text-plain-for-emails.html

pref("mail.default_send_format", 1);
pref("mail.html_compose", false);
pref("mail.identity.default.compose_html", false);

/// Prefer viewing emails in plaintext by default

pref("mailnews.display.prefer_plaintext", true);

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

/// Disable WebRTC
// We already take care of privacy concerns here; this is for attack surface reduction...
// https://x.com/GrapheneOS/status/1728921946396725618

pref("media.peerconnection.enabled", false);

/// Prevent status bar spoofing
// https://searchfox.org/comm-central/source/mail/app/profile/all-thunderbird.js#542

pref("dom.disable_window_status_change", true); // [DEFAULT]

/// Re-enable Password Manager by default
// This is useful & important for Thunderbird, since it's the only way to store account passwords...
// Also no UI toggle for it :/

pref("signon.rememberSignons", true); // [DEFAULT]

pref("mail.dove.status", "010");

// 011 Configure DKIM Verifier...
// https://codeberg.org/celenity/Dove/issues/6
// https://github.com/lieser/dkim_verifier/issues/267
// https://github.com/lieser/dkim_verifier/issues/268
// https://github.com/lieser/dkim_verifier/wiki/Options
// https://github.com/lieser/dkim_verifier/blob/master/modules/preferences.mjs.js
// https://github.com/lieser/dkim_verifier/blob/master/_locales/en_US/messages.json

/// Verify DKIM Signatures...

pref("extensions.dkim_verifier.dkim.enable", true); // [DEFAULT]

/// By default, store DKIM keys + results for later comparison

pref("extensions.dkim_verifier.key.storing", 2);
pref("extensions.dkim_verifier.saveResult", true);

/// Enable reading the Authentication-Results header, but don't replace the extension's results...
// This allows us to look at both the header and the client-side results of DKIM Verifier for comparison/extra verification

pref("extensions.dkim_verifier.arh.read", true);
pref("extensions.dkim_verifier.arh.replaceAddonResult", false);

/// Warn on ill-formed AUID tags

pref("extensions.dkim_verifier.error.illformed_i.treatAs", 1); // [DEFAULT]

/// Warn on ill-formed selector tags

pref("extensions.dkim_verifier.error.illformed_s.treatAs", 1); // [DEFAULT]

/// Warn on DKIM keys not secured by DNSSEC

pref("extensions.dkim_verifier.error.policy.key_insecure.treatAs", 1);

/// Warn on the RSA-SHA1 algorithm

pref("extensions.dkim_verifier.error.algorithm.sign.rsa-sha1.treatAs", 1); // [DEFAULT]

/// Warn on weak RSA keys

pref("extensions.dkim_verifier.error.algorithm.rsa.weakKeyLength.treatAs", 1);

/// Show detailed error reasons...

pref("extensions.dkim_verifier.error.detailedReasons", true);

/// Switch the default DNS server from Google to Quad9...

pref("extensions.dkim_verifier.dns.nameserver", "9.9.9.9");

/// Check if emails should be signed
// https://github.com/lieser/dkim_verifier/wiki/Sign-rules

pref("extensions.dkim_verifier.policy.signRules.enable", true);

/// Use the default signing rules by default...

pref("extensions.dkim_verifier.policy.signRules.checkDefaultRules", true); // [DEFAULT]

/// Automatically add rules based on viewed DKIM-signed emails, but only if the from address is in the SDID

pref("extensions.dkim_verifier.policy.signRules.autoAddRule.enable", true);
pref("extensions.dkim_verifier.policy.signRules.autoAddRule.for", 0); // [DEFAULT]
pref("extensions.dkim_verifier.policy.signRules.autoAddRule.onlyIfFromAddressInSDID", true); // [DEFAULT]

/// For signing rules, ensure the domain/subdomain in the SSID matches

pref("extensions.dkim_verifier.policy.signRules.sdid.allowSubDomains", false);

/// Treat wrong SSIDs as errors instead of warnings...

pref("extensions.dkim_verifier.policy.signRules.error.wrong_sdid.asWarning", false); // [DEFAULT]

/// Check DMARC entries to help determine whether an email should be signed
// https://github.com/lieser/dkim_verifier/wiki/Options#use-dmarc-to-heuristically-determine-if-an-e-mail-should-be-signed

pref("extensions.dkim_verifier.policy.DMARC.shouldBeSigned.enable", true);
pref("extensions.dkim_verifier.policy.DMARC.shouldBeSigned.neededPolicy", "none"); // [DEFAULT]

/// IF a header should be signed (as defined by the criteria above), enforce signing of *all* relevant headers

pref("extensions.dkim_verifier.policy.dkim.unsignedHeadersWarning.mode", 30);

/// Always show the DKIM header & tooltip when a message is viewed...

pref("extensions.dkim_verifier.showDKIMFromTooltip", 50);
pref("extensions.dkim_verifier.showDKIMHeader", 50);

/// Enable showing favicons of known signing domains before the 'From' address by default
/// Works via BIMI & DKIM Verifier's own internal database
// https://github.com/lieser/dkim_verifier/wiki/Display-Options#show-the-favicon-of-known-signing-domains-before-the-from-address
// https://wikipedia.org/wiki/Brand_Indicators_for_Message_Identification

pref("extensions.dkim_verifier.display.favicon.show", true); // [DEFAULT]

/// Indicate when a DKIM key is successfully validated by DNSSEC...
// https://github.com/lieser/dkim_verifier/wiki/Options#indicate-successful-dnssec-validation-with-a-lock-after-the-sdid

pref("extensions.dkim_verifier.display.keySecure", true); // [DEFAULT]

/// Ensure debugging is disabled by default...

pref("extensions.dkim_verifier.debug", false); // [DEFAULT]

pref("mail.dove.status", "011");

// 012 Personal Touch 💜

/// Things that are nice to have™
// Not directly privacy & security related

/// Enable inline spellcheck when composing messages & check before sending by default

pref("mail.spellcheck.inline", true); // [DEFAULT]
pref("mail.SpellCheckBeforeSend", true);

/// Enable dark theme for the message pane

pref("mail.dark-reader.enabled", true);

/// By default, when saving a message to a file, use underscores instead of spaces in the file name...

pref("mail.save_msg_filename_underscores_for_space", true);

pref("mail.dove.status", "012");

// 013 DO NOT TOUCH

pref("browser.privatebrowsing.autostart", false, locked); // Breaks uBlock Origin & all other extensions... also unnecessary since we always sanitize data anyways
pref("mailnews.oauth.usePrivateBrowser", false, locked); // Breaks uBlock Origin & all other extensions... also unnecessary since we always sanitize data anyways

pref("mail.dove.status", "013");

// 014 Enable support for custom/specialized configs...

pref("general.config.filename", "dove.cfg");
pref("general.config.vendor", "dove");
pref("general.config.obscure_value", 0);

pref("mail.dove.status", "014");

pref("mail.dove.status", "successfully applied :D", locked);
