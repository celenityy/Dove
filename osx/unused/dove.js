//
// The Phoenix shall rise from the ashes of what fell before it.

//
// Copyright (C) 2024-2026 celenity
//
// This file is part of Phoenix.
//
// Phoenix is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
// Phoenix is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with Phoenix. If not, see https://www.gnu.org/licenses/.
//

// Welcome to the heart of the Phoenix.
// This file contains preferences shared across all Phoenix configs, platforms (Desktop & Android), and Dove.

pref("browser.phoenix.version", "2026.02.23.1", locked);

/* INDEX 

000: ABOUT:CONFIG
001: DATA COLLECTION
002: MOZILLA CRAP™
003: TRACKING PROTECTION
004: FINGERPRINTING PROTECTION
005: DISK AVOIDANCE
006: DOWNLOADS
007: HTTP(S)
008: IMPLICIT CONNECTIONS
009: SEARCH & URL BAR
010: DNS
011: PROXIES
012: WEBRTC
013: MEDIA
014: ATTACK SURFACE REDUCTION
015: PASSWORDS & AUTHENTICATION
016: EXTENSIONS
017: AI
018: GEOLOCATION
019: PDF.js
020: SAFE BROWSING
021: MISC. PRIVACY + SECURITY
022: MISC. PRIVACY
023: MISC. SECURITY
024: MISC.
025: DEBUGGING
026: PERFORMANCE
027: Personal Touch 💜
028: UPDATES
029: FIREFOX HOME
030: FIREFOX SUGGEST (DESKTOP ONLY)
031: SYNC (DESKTOP ONLY)
032: LIBREWOLF (DESKTOP ONLY)
033: SPECIALIZED/CUSTOM CONFIGS (DESKTOP ONLY)

*/

/* KEY

Unspecified = This preference should be set EVERYWHERE

[OSX-ONLY] = This preference should ONLY be set for macOS
[SILICON-OSX-ONLY] = This preference should ONLY be set for macOS on Apple Silicon

[NO-ANDROID] = This preference should be set everywhere, EXCEPT for Android
[NO-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (Flatpak)
[NO-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux
[NO-NON-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (non-Flatpak)
[NO-INTEL-OSX] = This preference should be set everywhere, EXCEPT for macOS on Intel
[NO-WINDOWS] = This preference should be set everywhere, EXCEPT for Windows

*/

/*** BRANDING ***/



/*** 000: ABOUT:CONFIG ***/

/// Disable warning when attempting to access `about:config`
pref("browser.aboutConfig.showWarning", false); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT - Thunderbird]

/// Ensure that the `about:config` is always enabled
pref("general.aboutConfig.enable", true, locked); // [DEFAULT - non-Android]

/// Ensure our policies aren't overriden...
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/enterprisepolicies/EnterprisePoliciesParent.sys.mjs#22
pref("toolkit.policies.perUserDir", false, locked); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "000");

/*** 001 DATA COLLECTION ***/

// A lot of defense in depth...
// These also provide Attack Surface Reduction

/// Block domains
// Any domains listed here are redirected to `127.0.0.1`
// We'll use this primarily for Mozilla ad/telemetry domains, but we'll also use it for ads & trackers that appear on Mozilla properties and services, as well as ad/tracking/telemetry domains that appear on other default connections/services
// Ex. We use DuckDuckGo as our default search engine, so we'll include their analytics domains
// On IronFox, we link to our GitLab releases via the `What's New` alert, so we'll also cover their analytics domains, etc...
// But generally we'll want to keep this limited in favor of ex. uBlock Origin & other mechanisms.
pref("network.dns.localDomains", "250analytics.com,a.omappapi.com,activity-stream-icons.services.mozilla.com,ads.allizom.org,ads.mozilla.org,ads.nonprod.webservices.mozgcp.net,ads.prod.webservices.mozgcp.net,ads-img.mozilla.org,analytics.getpocket.com,analytics.google.com,analytics.withgoogle.com,anf1.fuzzing.mozilla.org,anonymco.com,api.divviup.org,asan-nightly-frontend-elb-1348905149.us-east-2.elb.amazonaws.com,braze.com,contile.services.mozilla.com,contile-images.services.mozilla.com,classify-client.nonprod.webservices.mozgcp.net,classify-client.prod.webservices.mozgcp.net,classify-client.services.mozilla.com,crash-reports.allizom.org,crash-reports.mozilla.com,crash-reports-xpsp2.mozilla.com,crash-stacks.mozilla.com,crash-stats.allizom.org,crash-stats.mozilla.com,crash-stats.mozilla.org,dap.services.mozilla.com,dap.nonprod.webservices.mozgcp.net,dap.prod.webservices.mozgcp.net,dap-09-3.api.divviup.org,data.mozilla.com,data-ingestion.prod.dataops.mozgcp.net,dataops.mozgcp.net,dataservices.mozgcp.net,debug-ping-preview.firebaseapp.com,discovery.addons.allizom.org,discovery.addons.mozilla.org,discovery.addons-dev.allizom.org,divviup.org,download-stats.mozilla.org,download-stats.r53-2.services.mozilla.com,experimenter.services.mozilla.com,experimenter.nonprod.webservices.mozgcp.net,experimenter.prod.webservices.mozgcp.net,fhr.data.mozilla.com,fhr.r53-2.services.mozilla.com,firefox-android-home-recommendations.getpocket.com,firefox-dns-perf-test.net,fuzzing.mozilla.org,google-analytics.com,google-analytics-cn.com,googleanalytics.com,googlesyndication.com,googlesyndication-cn.com,googletagmanager.com,googletagmanager-cn.com,googletagservices.com,googletagservices-cn.com,improving.duckduckgo.com,incoming.glean.example.com,incoming.telemetry.mozilla.org,incoming.thunderbird.net,incoming-telemetry.thunderbird.net,ingestion-edge.prod.dataops.mozgcp.net,location.services.mozilla.com,locprod1-elb-eu-west-1.prod.mozaws.net,locprod2-elb-us-west-2.prod.mozaws.net,metrics-content.duckduckgo.com,new-sentry.gitlab.net,nonprod.classify-client.nonprod.webservices.mozgcp.net,normandy.cdn.mozilla.net,normandy.nonprod.cloudops.mozgcp.net,normandy.prod.cloudops.mozgcp.net,normandy-cdn.services.mozilla.com,omappapi.com,pipeline-incoming-prod-elb-149169523.us-west-2.elb.amazonaws.com,prod.ads.prod.webservices.mozgcp.net,prod.classify-client.prod.webservices.mozgcp.net,prod.dap.prod.webservices.mozgcp.net,prod.data-ingestion.prod.dataops.mozgcp.net,prod.dataops.mozgcp.net,prod.experimenter.prod.webservices.mozgcp.net,prod.ingestion-edge.prod.dataops.mozgcp.net,prod.sentry.prod.cloudops.mozgcp.net,prod-classifyclient.normandy.prod.cloudops.mozgcp.net,profile.accounts.firefox.com,sdk.iad-05.braze.com,search.r53-2.services.mozilla.com,search.services.mozilla.com,self-repair.mozilla.org,self-repair.r53-2.services.mozilla.com,sentry.gitlab.net,sentry.io,sentry.nonprod.cloudops.mozgcp.net,sentry.prod.cloudops.mozgcp.net,sentry.prod.mozaws.net,sitereview.zscaler.com,snippets.allizom.org,snippets.cdn.mozilla.net,snippets.mozilla.com,snippets-prod.frankfurt.moz.works,snippets-prod.moz.works,snippets-prod.oregon-b.moz.works,snippets-stage.moz.works,snippets-stage.oregon-b.moz.works,snowplow.trx.gitlab.net,snowplowalb-1011729428.us-east-1.elb.amazonaws.com,snowplowprd.trx.gitlab.net,snowplowprdnlb-1490493263.us-east-2.elb.amazonaws.com,socorro.nonprod.webservices.mozgcp.net,socorro.prod.webservices.mozgcp.net,socorro-collector.services.mozilla.com,socorro-webapp-allizom.stage.mozaws.net,socorro-webapp.services.mozilla.com,spocs.getpocket.com,spocs.getpocket.dev,spocs.mozilla.net,ssl.google-analytics.com,ssl-google-analytics.l.google.com,stage.sentry.nonprod.cloudops.mozgcp.net,start.fedoraproject.org,start.thunderbird.net,start.ubuntu.com,start-stage.thunderbird.net,survey.mozilla.com,tagmanager.google.com,talkback.mozilla.org,talkback-public.mozilla.org,talkback-reports.mozilla.org,telemetry-coverage.mozilla.org,telemetry-coverage.r53-2.services.mozilla.com,telemetry-experiment.cdn.mozilla.net,telemetry-incoming.r53-2.services.mozilla.com,telemetry-incoming-a.r53-2.services.mozilla.com,telemetry-incoming-b.r53-2.services.mozilla.com,telemetry-prod-1054754349.us-east-1.elb.amazonaws.com,tiles-cdn.prod.ads.prod.webservices.mozgcp.net,updates.thunderbird.net,updates-stage.thunderbird.net,use-application-dns.net,vf.startpage.com,widgets.getpocket.com,www.250analytics.com,www.anonymco.com,www.google-analytics.com,www.google-analytics-cn.com,www.googleanalytics.com,www.googlesyndication.com,www.googlesyndication-cn.com,www.googletagmanager.com,www.googletagmanager-cn.com,www.googletagservices.com,www.googletagservices-cn.com,www.sentry.io,www-google-analytics.l.google.com,www-googletagmanager.l.google.com");

/// Disable automatic upload of profiler data (from `about:logging`) to Mozilla
// https://searchfox.org/firefox-main/rev/16707ce1/modules/libpref/init/all.js#3743
// https://searchfox.org/firefox-main/rev/16707ce1/modules/libpref/init/all.js#3753
// https://searchfox.org/firefox-main/rev/16707ce1/toolkit/content/aboutLogging/aboutLogging.mjs#616
// https://searchfox.org/firefox-main/rev/16707ce1/toolkit/content/aboutLogging/aboutLogging.mjs#642
// https://searchfox.org/firefox-main/rev/16707ce1/toolkit/content/aboutLogging/profileSaveUploadLogic.mjs#13
pref("toolkit.aboutLogging.uploadProfileToCloud", false); // [DEFAULT - non-Android]
pref("toolkit.aboutlogging.uploadProfileUrl", ""); // [HIDDEN]

/// Disable Browser Search/Usage Telemetry metrics
// https://searchfox.org/firefox-main/source/browser/docs/BrowserUsageTelemetry.rst
// https://searchfox.org/firefox-main/source/browser/components/search/BrowserSearchTelemetry.sys.mjs
// https://searchfox.org/firefox-main/source/browser/modules/BrowserUsageTelemetry.sys.mjs
// https://searchfox.org/firefox-main/source/toolkit/content/widgets/tabbox.js
pref("browser.engagement.ctrlTab.has-used", true, locked); // [HIDDEN - Android/Thunderbird]

/// Disable Coverage
// https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/
// https://searchfox.org/firefox-main/source/toolkit/components/telemetry/pings/CoveragePing.sys.mjs
// https://bugzilla.mozilla.org/show_bug.cgi?id=1487578
pref("toolkit.coverage.enabled", false, locked); // [DEFAULT] [HIDDEN - Android/Thunderbird]
pref("toolkit.coverage.endpoint.base", "", locked); // [DEFAULT - Android/Thunderbird] [HIDDEN - Android/Thunderbird]
pref("toolkit.coverage.log-level", 70); // [HIDDEN] Limits logging to fatal only
pref("toolkit.coverage.opt-out", true, locked); // [HIDDEN]

/// Disable Crash Reporting
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro
// https://firefox-source-docs.mozilla.org/tools/sanitizer/asan_nightly.html
// https://github.com/choller/firefox-asan-reporter
// https://searchfox.org/firefox-main/source/toolkit/modules/AsanReporter.sys.mjs
pref("asanreporter.apiurl", "", locked); // [HIDDEN - non-MOZ_ASAN_REPORTER builds] [DEFAULT - non-MOZ_ASAN_REPORTER builds]
pref("asanreporter.clientid", "unknown", locked); // [HIDDEN - non-MOZ_ASAN_REPORTER builds] [DEFAULT]
pref("asanreporter.loglevel", 70); // [HIDDEN]
pref("breakpad.reportURL", "", locked);
pref("browser.crashReports.crashPull", false, locked); // [DEFAULT] Do not request crash reports for background processes from users https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/crash-reports-ondemand/changeset?_expected=0
pref("browser.crashReports.onDemand", false, locked); // Supercedes "browser.crashReports.crashPull" - see details above
pref("browser.crashReports.requestedNeverShowAgain", true, locked); // Do not request crash reports for background processes from users https://searchfox.org/firefox-main/source/toolkit/components/crashes/RemoteSettingsCrashPull.sys.mjs
pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("browser.crashReports.unsubmittedCheck.enabled", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT - non-Nightly]
pref("toolkit.crashreporter.include_context_heap", false, locked); // [DEFAULT - non-Nightly]

/// Disable Data Reporting & Telemetry
/// We also configure "DisableTelemetry" & "ImproveSuggest" in policies on Desktop
// https://mozilla.github.io/policy-templates/#disabletelemetry 
// https://mozilla.github.io/policy-templates/#firefoxsuggest
// https://wiki.mozilla.org/QA/Telemetry
// https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
// https://searchfox.org/firefox-release/source/toolkit/components/glean/xpcom/FOG.cpp
// https://searchfox.org/firefox-release/source/toolkit/components/telemetry/app/TelemetryUtils.sys.mjs
pref("browser.safebrowsing.features.emailtracking.datacollection.update", false, locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/SafeBrowsing.sys.mjs#264
pref("captchadetection.actor.enabled", false, locked); // Disable CAPTCHA Detection Pings https://searchfox.org/firefox-main/source/toolkit/components/captchadetection/CaptchaDetectionPingUtils.sys.mjs
pref("captchadetection.hasUnsubmittedData", false, locked); // [HIDDEN] Disable CAPTCHA Detection Pings https://searchfox.org/firefox-main/source/toolkit/components/captchadetection/CaptchaDetectionPingUtils.sys.mjs
pref("captchadetection.loglevel", "Off");
pref("datareporting.dau.cachedUsageProfileID", "beefbeef-beef-beef-beef-beeefbeefbee", locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/app/ClientID.sys.mjs#45
pref("datareporting.dau.cachedUsageProfileGroupID", "b0bacafe-b0ba-cafe-b0ba-cafeb0bacafe", locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/app/ClientID.sys.mjs#46
pref("datareporting.healthreport.uploadEnabled", false, locked); // [DEFAULT - Android] Required for Firefox Labs on Desktop
pref("datareporting.policy.dataSubmissionEnabled", false, locked);
pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true, locked); // [DEFAULT - non-MOZILLA_OFFICIAL builds]
pref("datareporting.policy.firstRunURL", "", locked);
pref("datareporting.usage.uploadEnabled", false, locked); // [HIDDEN - ANDROID] [DEFAULT - Android] Disables "daily usage pings" https://support.mozilla.org/kb/usage-ping-settings
pref("dom.security.unexpected_system_load_telemetry_enabled", false, locked); // [DEFAULT - non-Nightly]
pref("extensions.dataCollectionPermissions.enabled", false, locked); // https://support.mozilla.org/kb/extension-data-collection https://extensionworkshop.com/documentation/develop/firefox-builtin-data-consent/
pref("extensions.gleanPingAddons.daily.interval", 2147483647, locked); // [HIDDEN] Disable the Glean add-on ping scheduler https://searchfox.org/firefox-main/rev/e5219f2a/toolkit/mozapps/extensions/extensions.manifest#1
pref("extensions.gleanPingAddons.updated.delay", 2147483647, locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/e5219f2a/toolkit/mozapps/extensions/AddonManager.sys.mjs#116
pref("extensions.gleanPingAddons.updated.idleTimeout", 2147483647, locked); // [HIDDEN] https://searchfox.org/firefox-main/source/toolkit/mozapps/extensions/AddonManager.sys.mjs#124
pref("extensions.gleanPingAddons.updated.testing", false, locked); // [HIDDEN] [DEFAULT] https://searchfox.org/firefox-main/source/toolkit/mozapps/extensions/AddonManager.sys.mjs#132
pref("extensions.telemetry.EnvironmentAddonBuilder", false, locked); // [HIDDEN - non-Android] [NIGHTLY] Do not use Glean for add-on telemetry https://bugzilla.mozilla.org/show_bug.cgi?id=1981496 https://searchfox.org/firefox-main/rev/d285a4fb/toolkit/mozapps/extensions/AddonManager.sys.mjs#4801
pref("network.jar.record_failure_reason", false, locked); // [DEFAULT - non-Nightly] https://searchfox.org/firefox-release/rev/9d94f5e3/modules/libpref/init/StaticPrefList.yaml#15576
pref("network.traffic_analyzer.enabled", false, locked); // https://searchfox.org/firefox-release/rev/9d94f5e3/modules/libpref/init/StaticPrefList.yaml#14262
pref("network.trr.confirmation_telemetry_enabled", false, locked);
pref("nimbus.telemetry.targetingContextEnabled", false, locked); // [HIDDEN - ANDROID/THUNDERBIRD] [DEFAULT - Artifact builds] Targeting context telemetry - https://searchfox.org/firefox-release/rev/9d94f5e3/browser/app/profile/firefox.js#2139
pref("privacy.trackingprotection.emailtracking.data_collection.enabled", false, locked);
pref("telemetry.fog.aboutGlean.debugTag", "", locked); // [NO-ANDROID] [HIDDEN] Do not set a debug ping tag https://searchfox.org/firefox-main/rev/4258ca07/toolkit/content/aboutGlean.js#122
pref("telemetry.fog.artifact_build", false, locked); // [DEFAULT - non-Artifact builds] Disable JOG to prevent runtime registration of metrics https://firefox-source-docs.mozilla.org/toolkit/components/glean/dev/jog.html https://firefox-source-docs.mozilla.org/toolkit/components/glean/dev/preferences.html#internal-preferences
pref("telemetry.fog.test.activity_limit", -1, locked); // Disable activity-based ping submission - ex. https://mozilla.github.io/glean/book/user/pings/baseline.html#scheduling
pref("telemetry.fog.test.inactivity_limit", -1, locked); // Disable inactivity-based ping submission - ex. https://mozilla.github.io/glean/book/user/pings/baseline.html#scheduling
pref("telemetry.fog.init_on_shutdown", false, locked); // Prevent Glean from initializing on shutdown https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/glean/docs/dev/preferences.md#49
pref("telemetry.fog.test.localhost_port", 70000, locked); // Force telemetry pings to be sent to localhost instead of Mozilla's servers, if they're somehow enabled... (port just has to be higher than 0, I chose 70000 as its invalid) - https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/glean/docs/dev/preferences.md#15
pref("telemetry.glean.internal.finalInactive", false, locked); // [HIDDEN] [DEFAULT] Disable early shutdown pings https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/glean/xpcom/FOG.cpp#148
pref("telemetry.glean.internal.maxPingsPerMinute", 0, locked); // [HIDDEN] Prevent Glean from sending pings https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/glean/xpcom/FOG.cpp#133
pref("telemetry.number_of_site_origin.min_interval", 2147483647, locked);
pref("toolkit.content-background-hang-monitor.disabled", true, locked); // BHR https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/backgroundhangmonitor/BackgroundHangMonitor.cpp#597
pref("toolkit.telemetry.archive.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.bhrPing.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.cachedClientID", "c0ffeec0-ffee-c0ff-eec0-ffeec0ffeec0", locked); // [HIDDEN]
pref("toolkit.telemetry.cachedProfileGroupID", "decafdec-afde-cafd-ecaf-decafdecafde", locked); // [HIDDEN]
pref("toolkit.telemetry.collectInterval", 2147483647, locked); // [HIDDEN]
pref("toolkit.telemetry.dap.helper.hpke", "", locked);
pref("toolkit.telemetry.dap.helper.url", "", locked);
pref("toolkit.telemetry.dap.leader.hpke", "", locked);
pref("toolkit.telemetry.dap.leader.url", "", locked);
pref("toolkit.telemetry.dap.logLevel", "Off");
pref("toolkit.telemetry.dap_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_task1_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_task1_taskid", "", locked); // [DEFAULT]
pref("toolkit.telemetry.dap_visit_counting_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_visit_counting_experiment_list", "[]", locked); // [DEFAULT]
pref("toolkit.telemetry.debugSlowSql", false); // [DEFAULT]
pref("toolkit.telemetry.enabled", false, locked);  // [DEFAULT - non-Nightly]
pref("toolkit.telemetry.eventping.maximumFrequency", 2147483647, locked); // [HIDDEN] Disable `event` pings
pref("toolkit.telemetry.eventping.minimumFrequency", 2147483647, locked); // [HIDDEN] Disable `event` pings
pref("toolkit.telemetry.firstShutdownPing.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.healthping.enabled", false, locked); // [HIDDEN]
pref("toolkit.telemetry.initDelay", 2147483647, locked); // [HIDDEN] Prevent the Telemetry component from initializing
pref("toolkit.telemetry.log.dump", false); // [HIDDEN] [DEFAULT] - To expose via the `about:config`
pref("toolkit.telemetry.log.level", "Fatal"); // [HIDDEN] [Default: Warn]
pref("toolkit.telemetry.minSubsessionLength", 2147483647, locked); // [HIDDEN]
pref("toolkit.telemetry.newProfilePing.delay", 2147483647, locked); // [HIDDEN]
pref("toolkit.telemetry.newProfilePing.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.overrideUpdateChannel", "release", locked); // [HIDDEN] [DEFENSE IN DEPTH] Always report channel as `release`, regardless of actual value https://docs.telemetry.mozilla.org/concepts/channels/channel_normalization
pref("toolkit.telemetry.previousBuildID", "", locked); // [HIDDEN]
pref("toolkit.telemetry.reportingpolicy.firstRun", false, locked); // [HIDDEN]
pref("toolkit.telemetry.scheduler.idleTickInterval", 2147483647, locked); // [HIDDEN]
pref("toolkit.telemetry.scheduler.tickInterval", 2147483647, locked); // [HIDDEN]
pref("toolkit.telemetry.send.overrideOfficialCheck", false, locked); // [HIDDEN] [DEFAULT] Never send pings on unofficial builds - https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
pref("toolkit.telemetry.server", "data;", locked);
pref("toolkit.telemetry.server_owner", "", locked);
pref("toolkit.telemetry.shutdownPingSender.backgroundtask.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT - Desktop Firefox]
pref("toolkit.telemetry.shutdownPingSender.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.shutdownPingSender.enabledFirstSession", false, locked); // [HIDDEN - Android] [DEFAULT]
pref("toolkit.telemetry.testing.disableFuzzingDelay", false, locked); // [HIDDEN] [DEFAULT] [DEFENSE IN DEPTH] Always delay sending pings between 0-1 AM
pref("toolkit.telemetry.testing.overridePreRelease", false, locked); // [HIDDEN] [DEFAULT] Never record extended/prelease data on release channels - https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
pref("toolkit.telemetry.testing.overrideProductsCheck", false, locked); // [DEFAULT] Limit probes to only what is supported on the current product - https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
pref("toolkit.telemetry.testing.suppressPingsender", true, locked); // [HIDDEN]
pref("toolkit.telemetry.translations.logLevel", "Off");
pref("toolkit.telemetry.unified", false, locked); // [DEFAULT - Android]
pref("toolkit.telemetry.untrustedModulesPing.frequency", 2147483647, locked); // [HIDDEN]
pref("toolkit.telemetry.updatePing.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.user_characteristics_ping.current_version", 0, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.last_version_sent", 0, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.logLevel", "Off");
pref("toolkit.telemetry.user_characteristics_ping.opt-out", true, locked);
pref("toolkit.telemetry.user_characteristics_ping.send-once", false, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.uuid", "", locked); // [DEFAULT]
pref("urlclassifier.features.emailtracking.datacollection.allowlistTables", "", locked); // https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/SafeBrowsing.sys.mjs#264
pref("urlclassifier.features.emailtracking.datacollection.blocklistTables", "", locked); // https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/SafeBrowsing.sys.mjs#264


/// Disable Experiments/Studies
// (Shield/Nimbus/Normandy)
// https://support.mozilla.org/kb/shield
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_experiments-or-studies
// https://experimenter.info/
// https://wiki.mozilla.org/Firefox/Shield/Shield_Studies
// https://mozilla.github.io/normandy/
// https://wiki.mozilla.org/Advocacy/heartbeat
// resource://nimbus/ExperimentAPI.sys.mjs
// https://searchfox.org/firefox-main/source/toolkit/components/backgroundtasks/defaults/backgroundtasks_browser.js
pref("app.normandy.run_interval_seconds", 0, locked); // [HIDDEN - Android/Thunderbird] Prevent fetching experiments - This pref is also used by Nimbus https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#801
pref("app.shield.optoutstudies.enabled", false, locked); // [HIDDEN - Android/Thunderbird] Required for Firefox Labs on Desktop
pref("messaging-system.rsexperimentloader.collection_id", ""); // [DEFAULT: `nimbus-desktop-experiments`] Required for Firefox Labs on Desktop
pref("nimbus.appId", ""); // [HIDDEN] [DEFAULT: `firefox-desktop`] Required for Firefox Labs on Desktop
pref("nimbus.profileId", "", locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/ExperimentAPI.sys.mjs#80 - We also set this as a user pref in `phoenix-user-pref.cfg`, to ensure that Firefox properly uses/recognizes it
pref("nimbus.profilesdatastoreservice.enabled", false, locked); // Disable writing to the NimbusEnrollments table database https://searchfox.org/firefox-main/rev/16707ce1/toolkit/components/nimbus/lib/Enrollments.sys.mjs#617
pref("nimbus.profilesdatastoreservice.read.enabled", false, locked); // Disable reading from the NimbusEnrollments table database https://searchfox.org/firefox-main/rev/16707ce1/toolkit/components/nimbus/lib/Enrollments.sys.mjs#628
pref("nimbus.profilesdatastoreservice.sync.enabled", false, locked); // Disable syncing NimbusEnrollments data https://searchfox.org/firefox-main/rev/16707ce1/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#425 https://searchfox.org/firefox-main/rev/16707ce1/toolkit/components/nimbus/lib/Enrollments.sys.mjs#638
pref("nimbus.rollouts.enabled", false, locked); // [HIDDEN - non-Firefox Desktop] Nimbus rollouts/"remote improvements" (A/B Testing) https://support.mozilla.org/kb/remote-improvements


/// Disable Glean redesign/navigation category at `about:glean`
// This isn't really a major issue for us, but we don't want or support Glean, so I see no reason not to set this
// https://searchfox.org/firefox-main/rev/cd6acbe9/toolkit/content/aboutGlean.js#215
pref("about.glean.redesign.enabled", false, locked); // [NO-ANDROID] [HIDDEN - non-Desktop Firefox] [DEFAULT]


/// Disable notification permission telemetry [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/28328852/browser/app/profile/firefox.js#938 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/28328852/browser/modules/PermissionUI.sys.mjs#79 [NO-ANDROID]
pref("permissions.desktop-notification.telemetry.siteCategories", "{}", locked); // [NO-ANDROID]

/// Disable Origin Trials
// https://wiki.mozilla.org/Origin_Trials
pref("dom.origin-trials.enabled", false);

/// Remove partner attribution
// These are *only* used for telemetry, and could potentially be used for fingerprinting
pref("app.distributor", "", locked); // [HIDDEN] [DEFAULT]
pref("app.distributor.channel", "", locked); // [HIDDEN] [DEFAULT]
pref("mozilla.partner.id", "", locked); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "001");

/*** 002 MOZILLA CRAP™ ***/

// Some of these also provide Attack Surface Reduction

/// Clear unnecessary/undesired Mozilla URLs
pref("app.feedback.baseURL", ""); // [NO-ANDROID]
pref("datareporting.healthreport.infoURL", ""); // [NO-ANDROID]
pref("extensions.recommendations.privacyPolicyUrl", ""); // [DEFAULT - Android]
pref("toolkit.datacollection.infoURL", ""); // [NO-ANDROID]

/// Disable `about:welcome`/onboarding
// Privacy concerns - unsolicited connections
// Also just annoying and undesired for our use case :/
// https://searchfox.org/firefox-main/source/browser/components/BrowserContentHandler.sys.mjs
pref("browser.preonboarding.enabled", false); // [HIDDEN - Android/Thunderbird] [DEFAULT - Linux] Disable the preonboarding modal https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#874 https://searchfox.org/firefox-main/rev/643d7328/toolkit/components/telemetry/app/TelemetryReportingPolicy.sys.mjs#638

/// Disable add-on/feature recommendations
// https://support.mozilla.org/kb/recommendations-firefox
// https://searchfox.org/firefox-main/source/toolkit/mozapps/extensions/content/aboutaddons.js
// https://searchfox.org/firefox-main/source/browser/components/enterprisepolicies/Policies.sys.mjs
pref("browser.discovery.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT - Android/Thunderbird]
pref("browser.translations.mostRecentTargetLanguages", "en-US"); // https://searchfox.org/firefox-main/rev/4258ca07/browser/components/enterprisepolicies/Policies.sys.mjs#2829
pref("browser.translations.panelShown", true, locked); // [HIDDEN]
pref("extensions.getAddons.browseAddons", ""); // [HIDDEN - non-Android]
pref("extensions.getAddons.discovery.api_url", "data;");
pref("extensions.getAddons.showPane", false); // [HIDDEN]
pref("extensions.htmlaboutaddons.recommendations.enabled", false);
pref("extensions.recommendations.hideNotice", true, locked); // [HIDDEN] "Some of these recommendations are personalized..." banner
pref("extensions.recommendations.themeRecommendationUrl", "");
pref("extensions.ui.lastCategory", "addons://list/extension"); // [HIDDEN] [DEFAULT = `addons://discover/`] Ensure default view of `about:addons` is always local/installed extensions
pref("extensions.webservice.discoverURL", ""); // [HIDDEN - non-Thunderbird]

/// Disable DoH Rollout/heuristics/steering
// This helps ensure Firefox doesn't override our/the user's DoH settings...
// https://searchfox.org/firefox-main/source/toolkit/components/doh/DoHConfig.sys.mjs
// https://searchfox.org/firefox-main/source/toolkit/components/doh/DoHController.sys.mjs
// https://searchfox.org/firefox-main/source/toolkit/components/doh/DoHHeuristics.sys.mjs
// https://searchfox.org/firefox-main/source/netwerk/docs/dns/dns-over-https-trr.md
pref("doh-rollout._testing", true, locked); // [HIDDEN]
pref("doh-rollout.disable-heuristics", true, locked); // [HIDDEN]
pref("doh-rollout.doneFirstRun", true, locked); // [HIDDEN]
pref("doh-rollout.doorhanger-decision", "UIDisabled", locked); // [HIDDEN]
pref("doh-rollout.enabled", false, locked); // [HIDDEN]
pref("doh-rollout.mode", 5, locked); // [HIDDEN]
pref("doh-rollout.provider-steering.enabled", false, locked); // [HIDDEN]
pref("doh-rollout.provider-steering.provider-list", "", locked); // [HIDDEN]
pref("doh-rollout.self-enabled", false, locked); // [HIDDEN]
pref("doh-rollout.skipHeuristicsCheck", true, locked); // [HIDDEN]
pref("doh-rollout.trr-selection.enabled", false, locked); // [HIDDEN]
pref("doh-rollout.trr-selection.provider-list", "", locked); // [HIDDEN]
pref("doh-rollout.uri", "", locked); // [HIDDEN]
pref("network.android_doh.autoselect_enabled", false, locked); // [HIDDEN - non-Android] https://searchfox.org/firefox-main/rev/82e2435f/mobile/android/geckoview/src/main/java/org/mozilla/geckoview/GeckoRuntimeSettings.java#1773

/// Disable DoH performance measurements
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/BrowserGlue.sys.mjs#1155
// https://searchfox.org/firefox-main/source/toolkit/components/doh/TRRPerformance.sys.mjs
pref("doh-rollout.trrRace.canonicalDomain", ""); // [HIDDEN] [Default = firefox-dns-perf-test.net]
pref("doh-rollout.trrRace.complete", true); // [HIDDEN]
pref("doh-rollout.trrRace.enabled", false); // [HIDDEN]
pref("doh-rollout.trrRace.popularDomains", ""); // [HIDDEN]
pref("doh-rollout.trrRace.randomSubdomainCount", 0); // [HIDDEN]

/// Disable 'Essential Domains Fallback'
// My concern here is the fact that this is fetched from Remote Settings - this could potentially be used to bypass our internal domain blocklist above + the firewall of users if they themselves choose to block specific domains for whatever reason
// I don't have a problem with this being a local dump though, as I can understand the usefulness of this (and being local would mitigate my concerns here) - but I'm not comfortable with the remote part
// This is currently unused anyways...
// https://searchfox.org/firefox-main/source/netwerk/base/EssentialDomainsRemoteSettings.sys.mjs
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/moz-essential-domain-fallbacks/changeset?_expected=0
pref("network.essential_domains_fallback", false); // [DEFAULT]

/// Disable Fakespot
pref("toolkit.shopping.ohttpConfigURL", "");
pref("toolkit.shopping.ohttpRelayURL", "");


/// Disable fetching Firefox Relay's "allowlist" and "denylist"
// Should reduce network activity, and also allows users of Relay to use it anywhere if desired (+ should reduce nags from the browser about it in general)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1926974
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxrelay-allowlist/changeset?_expected=0
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxrelay-denylist/changeset?_expected=0
// https://searchfox.org/firefox-main/rev/c82adde5/toolkit/components/satchel/integrations/FirefoxRelay.sys.mjs#42
pref("signon.firefoxRelay.allowListRemoteSettingsCollection", ""); // [HIDDEN]
pref("signon.firefoxRelay.denyListRemoteSettingsCollection", ""); // [HIDDEN]

/// Disable fetching Password Manager rules remotely by default
// (Used for identifying password forms on websites)
// Last update was January 2023... also included locally as a dump anyways (resource://app/defaults/settings/main/password-recipes.json), so I don't see a reason to fetch these remotely
// https://bugzilla.mozilla.org/show_bug.cgi?id=1134852
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/password-recipes/changeset?_expected=0
pref("signon.recipes.remoteRecipes.enabled", false);


/// Disable the Firefox Messaging System [NO-ANDROID]
// https://firefox-source-docs.mozilla.org/browser/components/asrouter/docs/index.html [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/ac83682a/browser/components/asrouter/modules/ASRouter.sys.mjs#1863 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/ac83682a/browser/components/asrouter/modules/ASRouterPreferences.sys.mjs#200 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/backgroundtasks/defaults/backgroundtasks_browser.js#26 [NO-ANDROID]
pref("app.update.background.messaging.targeting.snapshot.intervalSec", -1); // [NO-ANDROID] Disable targeting information background updates: https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/update/BackgroundUpdate.sys.mjs#827

/// Disable Firefox Relay by default
pref("signon.firefoxRelay.feature", "disabled"); // [HIDDEN - Thunderbird]


/// Disable "Interest-based Content Relevance Ranking and Personalization"
// https://bugzilla.mozilla.org/show_bug.cgi?id=1886207
pref("toolkit.contentRelevancy.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("toolkit.contentRelevancy.ingestEnabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("toolkit.contentRelevancy.log", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]


/// Disable Mozilla nags/promotions
pref("browser.promo.cookiebanners.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT - Desktop] https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#756
pref("browser.promo.focus.disallowed_regions", "xx");
pref("browser.promo.focus.enabled", false, locked); // [HIDDEN - Android/Thunderbird] https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#722
pref("browser.promo.pin.enabled", false, locked); // [HIDDEN - Android/Thunderbird] https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#734
pref("browser.send_to_device_locales", "", locked); // [HIDDEN - Android/Thunderbird] Disables "Send to Device" email promotions https://searchfox.org/firefox-main/rev/dc1c78e9/browser/app/profile/firefox.js#2503 https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#789 https://searchfox.org/firefox-main/rev/dc1c78e9/browser/components/preferences/moreFromMozilla.js#273
pref("browser.vpn_promo.disallowed_regions", "xx");
pref("browser.vpn_promo.enabled", false, locked); // [HIDDEN - Android/Thunderbird] https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#692
pref("privacy.trackingprotection.allow_list.hasUserInteractedWithETPSettings", true, locked); // Disables nag/onboarding to configure ETP exception lists https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/all.js#3342 https://searchfox.org/firefox-main/rev/dc1c78e9/netwerk/url-classifier/UrlClassifierExceptionListService.sys.mjs#200



/// Disable "Privacy-Preserving Attribution"
// https://support.mozilla.org/kb/privacy-preserving-attribution
pref("dom.origin-trials.private-attribution.state", 2, locked); // [DEFAULT]
pref("dom.private-attribution.submission.enabled", false, locked); // [DEFAULT]

/// Disable Remote Permissions
// This currently only allows overriding behavior for HTTPS-First + localhost
// In general, I don't think there should be remote/default overrides for a feature like this (or permissions in general...), best left up to the user
// https://searchfox.org/firefox-main/source/extensions/permissions/docs/remote.rst
// https://searchfox.org/firefox-main/source/extensions/permissions/RemotePermissionService.sys.mjs
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/remote-permissions/changeset?_expected=0
pref("permissions.manager.remote.enabled", false);

/// Disable Remote Settings 'Preview' Buckets
// Nice to expose via about:config
pref("services.settings.preview_enabled", false); // [HIDDEN] [DEFAULT]


/// Disable the Web Compatibility Reporter
// Harmless - We just don't want to waste Mozilla's time due to our custom set-up...
// Also acts as a potential performance improvement
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#4511
pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT - Release/ESR]
pref("extensions.webcompat-reporter.newIssueEndpoint", "https://phoenix.celenity.dev/issues"); // Temporarily override to our URL instead of Mozilla's to work-around upstream bug - https://bugzilla.mozilla.org/show_bug.cgi?id=1963764
pref("media.decoder-doctor.new-issue-endpoint", "https://phoenix.celenity.dev/issues"); // For decoding errors https://searchfox.org/firefox-main/rev/82e2435f/browser/actors/DecoderDoctorParent.sys.mjs#83


/// Opt out of add-on metadata updates
// Note: This prevents themes from displaying previews in `about:addons`
// https://blog.mozilla.org/addons/how-to-opt-out-of-add-on-metadata-updates/
pref("extensions.getAddons.cache.enabled", false);




/// Remove special privileges from Mozilla domains
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#privileged-mozilla-content
pref("browser.tabs.remote.separatePrivilegedMozillaWebContentProcess", false, locked); // [DEFAULT - non-Firefox Desktop]
pref("browser.tabs.remote.separatedMozillaDomains", "", locked);
pref("dom.ipc.processCount.privilegedmozilla", 0, locked);
pref("extensions.webextensions.restrictedDomains", "");
pref("permissions.manager.defaultsUrl", ""); // [HIDDEN - Android] [DEFAULT - Android]
pref("svg.context-properties.content.allowed-domains", "", locked); // [DEFAULT - Android/Thunderbird]

/// Remove tracking parameters from Mozilla URLs + prevent exposing locale & unnecessary information
// For info on the extension update (`extensions.update.`) URL parameters, see https://devdoc.net/web/developer.mozilla.org/en-US/docs/Install_Manifests.html + https://mozilla-balrog.readthedocs.io/en/latest/database.html
pref("browser.backup.template.fallback-download.aurora", "https://www.mozilla.org/firefox/channel/desktop/#developer");
pref("browser.backup.template.fallback-download.beta", "https://www.mozilla.org/firefox/channel/desktop/#beta");
pref("browser.backup.template.fallback-download.esr", "https://www.mozilla.org/firefox/enterprise/#download");
pref("browser.backup.template.fallback-download.nightly", "https://www.mozilla.org/firefox/channel/desktop/#nightly");
pref("browser.backup.template.fallback-download.release", "https://www.mozilla.org/firefox/download/thanks/?s=direct");
pref("extensions.abuseReport.amoFormURL", "https://addons.mozilla.org/feedback/addon/%addonID%/");
pref("extensions.blocklist.addonItemURL", "https://addons.mozilla.org/blocked-addon/%addonID%/%addonVersion%/");
pref("pdfjs.altTextLearnMoreUrl", "https://support.mozilla.org/kb/pdf-alt-text");
pref("pdfjs.commentLearnMoreUrl", "https://support.mozilla.org/kb/view-pdf-files-firefox-or-choose-another-viewer#w_add-a-comment-to-a-pdf");
pref("signon.firefoxRelay.learn_more_url", "https://support.mozilla.org/kb/relay-integration#w_frequently-asked-questions");
pref("signon.firefoxRelay.manage_url", "https://relay.firefox.com/accounts/profile/");
pref("signon.firefoxRelay.privacy_policy_url", "https://www.mozilla.org/privacy/subscription-services/");
pref("signon.firefoxRelay.terms_of_service_url", "https://www.mozilla.org/about/legal/terms/subscription-services/");

/// Skip Mozilla's `Privacy Notice` and `Terms of Use`
// https://github.com/mozilla/policy-templates/pull/1212
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/enterprisepolicies/Policies.sys.mjs#2806
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/docs/internals/preferences.rst#208
pref("datareporting.policy.dataSubmissionPolicyAcceptedVersion", 999, locked);
pref("datareporting.policy.dataSubmissionPolicyNotifiedTime", "32503679999000", locked);
pref("termsofuse.acceptedDate", "32503679999000", locked); // [HIDDEN - Android/Thunderbird]
pref("termsofuse.acceptedVersion", 999, locked); // [HIDDEN - Android/Thunderbird]
pref("termsofuse.bypassNotification", true, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT - builds without MOZILLA_OFFICIAL]

pref("browser.phoenix.status", "002");

/*** 003 TRACKING PROTECTION ***/

/// Allow users to add URLs to ETP via the `about:config`
// Typically hidden, but can be useful useful, so we can expose this via the `about:config` to make it easier for users to find/add entries
// https://developer.mozilla.org/docs/Web/Privacy/Guides/Storage_Access_Policy#adding_custom_domains_to_the_tracking_protection_list
pref("urlclassifier.trackingAnnotationTable.testEntries", ""); // [HIDDEN] [DEFAULT]

/// Allow users to exclude URLs from ETP via the `about:config`
// These are typically hidden, but very useful (especially for testing/working around breakage), so we can expose these via the `about:config` to make it easier for users to find/add exclusions
pref("privacy.rejectForeign.allowList", ""); // [DEFAULT]
pref("urlclassifier.features.consentmanager.annotate.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.features.cryptomining.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.features.emailtracking.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.features.fingerprinting.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.features.socialtracking.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.trackingSkipURLs", ""); // [HIDDEN] [DEFAULT]

/// Disable exceptions for minor issues by default
pref("privacy.trackingprotection.allow_list.convenience.enabled", false);

/// Enable ETP Strict
// https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop#w_strict-enhanced-tracking-protection
pref("browser.contentblocking.category", "strict", locked); // [HIDDEN]

/// Manually enable ETP/Strict protections...
// These are typically configured by ETP Strict - but unfortunately Firefox doesn't set ETP Strict on the browser's first run :/
// So we need to also manually configure them. We still also use ETP Strict (not 'Custom') due to our enforcement of it, so we should be covered by Mozilla changes/updates for protections.
// Manually specifying these is also useful for cases like Android: where all protections aren't enabled with ETP Strict, and on Thunderbird: where ETP Strict doesn't exist at all...
// We're also configuring the 'CookieBehavior' and 'EnableTrackingProtection' policies on desktop.

//// Block harmful add-on URLs
pref("privacy.trackingprotection.harmfuladdon.enabled", true); // [DEFAULT - Desktop Firefox] https://searchfox.org/firefox-main/rev/93aad2a6615f670b1279c229dd37f7397236131a/browser/app/profile/firefox.js#2434

//// Block known consent managers (CMPs)
pref("privacy.trackingprotection.consentmanager.annotate_channels", true); // [DEFAULT]
pref("privacy.trackingprotection.consentmanager.skip.enabled", false); // [DEFAULT]
pref("privacy.trackingprotection.consentmanager.skip.pbmode.enabled", false);

//// Block known cryptominers
pref("privacy.trackingprotection.cryptomining.enabled", true); // [DEFAULT - non-Thunderbird]

//// Block known email trackers
pref("privacy.trackingprotection.emailtracking.enabled", true);
pref("privacy.trackingprotection.emailtracking.pbmode.enabled", true); // [DEFAULT]

//// Block known fingerprinters
// Including ones classified as "anti-fraud": https://bugzilla.mozilla.org/show_bug.cgi?id=1962092
pref("privacy.trackingprotection.antifraud.annotate_channels", true); // [DEFAULT] [NIGHTLY]
pref("privacy.trackingprotection.antifraud.skip.enabled", false); // [DEFAULT] [NIGHTLY]
pref("privacy.trackingprotection.antifraud.skip.pbmode.enabled", false); // [NIGHTLY]
pref("privacy.trackingprotection.fingerprinting.enabled", true); // [DEFAULT - non-Thunderbird]

//// Block known social trackers
pref("privacy.trackingprotection.socialtracking.enabled", true);

//// Block known trackers
pref("privacy.trackingprotection.annotate_channels", true); // [DEFAULT]
pref("privacy.trackingprotection.enabled", true);
pref("privacy.trackingprotection.pbmode.enabled", true); // [DEFAULT - non-Android]

//// Block known trackers using the `strict` (Level 2) list
/// https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/StaticPrefList.yaml#16075
/// https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/components/nimbus/FeatureManifest.yaml#3609
pref("privacy.annotate_channels.strict_list.enabled", true); // [DEFAULT - Android]
pref("privacy.annotate_channels.strict_list.pbmode.enabled", true); // [DEFAULT]

//// Block known tracking cookies
pref("network.cookie.cookieBehavior.trackerCookieBlocking", true); // [HIDDEN - Android/Thunderbird] [DEFAULT - Desktop]
pref("privacy.socialtracking.block_cookies.enabled", true); // [DEFAULT]

//// Enable Bounce Tracking Protection
/// https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop#w_bounce-tracking-protection
/// https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/components/antitracking/bouncetrackingprotection/nsIBounceTrackingProtection.idl#10
pref("privacy.bounceTrackingProtection.mode", 1); // [DEFAULT - Nightly]
pref("privacy.bounceTrackingProtection.requireStatefulBounces", false); // [DEFAULT - Nightly] Protect against all bounce trackers, instead of just those who access cookies/storage https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/components/nimbus/FeatureManifest.yaml#4930

//// Enable Query Parameter Stripping
/// https://firefox-source-docs.mozilla.org/toolkit/components/antitracking/anti-tracking/query-stripping/index.html
pref("privacy.query_stripping.enabled", true);
pref("privacy.query_stripping.enabled.pbmode", true);
pref("privacy.query_stripping.redirect", true); // [DEFAULT]

//// Enable SmartBlock and Web Compatibility interventions by default
pref("extensions.webcompat.enable_interventions", true); // [HIDDEN] [DEFAULT - non-Thunderbird]
pref("extensions.webcompat.enable_shims", true); // [HIDDEN] [DEFAULT - non-Thunderbird]
pref("extensions.webcompat.perform_injections", true); // [HIDDEN] [DEFAULT - non-Thunderbird]
pref("extensions.webcompat.perform_ua_overrides", true); // [HIDDEN] [DEFAULT - non-Thunderbird]
pref("extensions.webcompat.smartblockEmbeds.enabled", true); // [HIDDEN - Android/Thunderbird] [DEFAULT - Desktop] - Enables Embeds/Placeholders to make certain resources click to load

//// Enable State Partitioning
pref("network.fetch.cache_partition_cross_origin", true); // [DEFAULT] Cross origin fetch/XHR requests
pref("privacy.partition.always_partition_third_party_non_cookie_storage", true); // [DEFAULT]
pref("privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage", false); // [DEFAULT]
pref("privacy.partition.bloburl_per_partition_key", true); // [DEFAULT]
pref("privacy.partition.network_state", true); // [DEFAULT]
pref("privacy.partition.network_state.ocsp_cache", true); // [DEFAULT]
pref("privacy.partition.network_state.ocsp_cache.pbmode", true); // [DEFAULT]
pref("privacy.partition.serviceWorkers", true); // [DEFAULT]

//// Enable Suspected Fingerprinters Protection (FPP)
/// https://support.mozilla.org/kb/firefox-protection-against-fingerprinting#w_suspected-fingerprinters
pref("privacy.fingerprintingProtection", true);
pref("privacy.fingerprintingProtection.pbmode", true); // [DEFAULT]
pref("privacy.reduceTimerPrecision", true); // [DEFAULT]

//// Enable TCP/dFPI
/// https://support.mozilla.org/kb/introducing-total-cookie-protection-standard-mode
/// https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/components/nimbus/FeatureManifest.yaml#3633
pref("network.cookie.cookieBehavior", 5); // [DEFAULT - non-Thunderbird]
pref("network.cookie.cookieBehavior.optInPartitioning", true);
pref("network.cookie.cookieBehavior.optInPartitioning.pbmode", true);
pref("network.cookie.cookieBehavior.pbmode", 5); // [DEFAULT - non-Thunderbird]

//// Ignore less restricted referer policies (than the default)
/// https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/StaticPrefList.yaml#13615
pref("network.http.referer.disallowCrossSiteRelaxingDefault", true); // [DEFAULT] - for cross-site requests
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode", true); // [DEFAULT] - for cross-site requests in Private Browsing
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode.top_navigation", true); // [DEFAULT] - for top navigations in Private Browsing
pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true); // for top navigations

/// Enable exceptions required to avoid major breakage by default
pref("privacy.trackingprotection.allow_list.baseline.enabled", true); // [DEFAULT]
pref("privacy.trackingprotection.allow_list.hasMigratedCategoryPrefs", true, locked); // Skip migration, so that `privacy.trackingprotection.allow_list.baseline.enabled` isn't overriden to `false` https://searchfox.org/firefox-main/rev/dc1c78e9/netwerk/url-classifier/UrlClassifierExceptionListService.sys.mjs#254

/// Lower the network priority of known trackers (if not blocked for whatever reason...)
pref("privacy.trackingprotection.lower_network_priority", true);

pref("browser.phoenix.status", "003");

/*** 004 FINGERPRINTING PROTECTION ***/

/// Add notes to help prevent users from making themselves unnecessarily fingerprintable
// We need to keep Android notes under ~50 characters to prevent them from being cut off/un-readable; isn't an issue on Desktop
pref("dom.webmidi.enabled.0.NOTE", "Changing this value is unnecessary...");
pref("dom.webmidi.enabled.1.NOTE", "and WILL aid fingerprinting.");
pref("dom.webmidi.enabled.2.NOTE", "Set 'dom.sitepermsaddon-provider.enabled' to 'false'...");
pref("dom.webmidi.enabled.3.NOTE", "and 'dom.webmidi.gated' to 'true' instead.");
pref("geo.enabled.0.NOTE", "Changing this value is unnecessary...");
pref("geo.enabled.1.NOTE", "and WILL aid fingerprinting.");
pref("pdfjs.disabled.0.NOTE", "Changing this value is unnecessary, and it WILL aid fingerprinting. To disable PDF.js, set 'browser.helperApps.showOpenOptionForPdfJS' to 'false' instead."); // [NO-ANDROID]

/// Always load fonts bundled with Firefox
// The default is -1 - which loads bundled fonts, EXCEPT on "low-memory" devices
// Hence, this could add extra entropy/add an extra fingerprinting vector for users on "low-memory" devices
// In general, this will ensure all users have the same standard behavior here
// https://bugzilla.mozilla.org/show_bug.cgi?id=1686274
// https://searchfox.org/firefox-main/rev/82e2435f/gfx/thebes/gfxFT2FontList.cpp#1625
pref("gfx.bundled-fonts.activate", 1);

/// Disable the ability to switch locales without requiring a restart [NO-ANDROID]
// Currently appears to be buggy and inconsistent - and thus could be potentially fingerprintable, so I think it's best to leave off to be safe [NO-ANDROID]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/42349#note_3057563 [NO-ANDROID]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/42771#note_3057587 [NO-ANDROID]
pref("intl.multilingual.liveReload", false); // [NO-ANDROID] [DEFAULT - non-Firefox release/beta]
pref("intl.multilingual.liveReloadBidirectional", false); // [NO-ANDROID] [DEFAULT]

/// Disable failIfMajorPerformanceCaveat in WebGL contexts
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/18603
pref("webgl.disable-fail-if-major-performance-caveat", true); // [DEFAULT]

/// Disable VP9 Benchmark
// This means that VP9 will always be enabled regardless of performance benchmarks (unless on a plaform where this isn't supported)
// This likely also results in a performance improvement, so that's nice
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/22548
pref("media.benchmark.vp9.threshold", 0);

/// Do not use the theme's toolbar color scheme for in-content pages by default
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/modules/LightweightThemeConsumer.sys.mjs#17
pref("browser.theme.unified-color-scheme", false); // [HIDDEN - non-Thunderbird] [DEFAULT - non-Thunderbird]

/// Enable fdlibm for Math.sin, Math.cos, and Math.tan
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#9422
// https://groups.google.com/a/mozilla.org/g/dev-platform/c/0dxAO-JsoXI/m/eEhjM9VsAgAJ
pref("javascript.options.use_fdlibm_for_sin_cos_tan", true); // [DEFAULT - non-Windows]

/// Enable light mode by default
// Matches with RFP & prevents exposing system theme
pref("layout.css.prefers-color-scheme.content-override", 1);



/// Harden FPP (which we enable at `003` above) to match RFP with a few exceptions...
// This also improves security - Attack Surface Reduction, reduced timer precision
// List of targets: https://searchfox.org/firefox-main/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html
// (We're setting -EfficientCanvasRandomization for now to work-around an upstream bug that prevents randomization from applying everywhere as expected: https://bugzilla.mozilla.org/show_bug.cgi?id=2013976)

/// If FPP/RFP is disabled, limit font visibility to base system fonts + fonts from optional language packs
// We could set this to 1 to only allow base system fonts - but this is already covered by FPP/RFP. So if one disables RFP/FPP or adds an override, I think it's reasonable to allow fonts from language packs - as that may be the reason they've disabled it. I see no reason to ever expose user-installed fonts though.
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#10128
pref("layout.css.font-visibility", 2);

/// Prevent enumeration of media devices
// Exceptions can be set via the `media.devices.enumerate.legacy.allowlist` pref
// https://bugzilla.mozilla.org/show_bug.cgi?id=1528042
pref("media.devices.enumerate.legacy.enabled", false); // [DEFAULT]

/// Prevent exposing WebGL Renderer Info
// This is equivalent to the RFP/FPP 'WebGLRenderInfo' target
// Useful to ensure users are protected if they disable FPP for whatever reason, or if they just disable ETP/Strict for a specific site/add an exception
// https://searchfox.org/firefox-main/source/dom/canvas/SanitizeRenderer.cpp
pref("webgl.enable-renderer-query", false); // Spoofs "Vendor" and "Renderer" to "Mozilla" (Like the `WebGLRenderInfo` target does)
pref("webgl.override-unmasked-renderer", "Mozilla"); // Spoofs "Unmasked Renderer" Debug info to "Mozilla" (like FPP/RFP does for the WebGL renderer query)
pref("webgl.override-unmasked-vendor", "Mozilla"); // Spoofs "Unmasked Vendor" Debug info to "Mozilla" (like FPP/RFP does for the WebGL renderer query)
pref("webgl.sanitize-unmasked-renderer", false); // Prevents the "Unmasked Renderer" under Debug Info from being set to "Generic Renderer"; we instead set it to "Mozilla" to always match FPP/RFP

/// Prevent pre-allocating content processes
// These can cause certain values/settings to persist, even after a user changes them - which could result in leakage/fingerprinting concerns
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#preallocated-content
pref("dom.ipc.processPrelaunch.enabled", false);
pref("dom.ipc.processPrelaunch.fission.number", 0);

/// Prevent using system accent colors
pref("widget.non-native-theme.use-theme-accent", false); // [DEFAULT - non-Thunderbird Windows]

/// Prevent using system colors
// The `ui.use_standins_for_native_colors` pref does the same thing as the 'UseStandinsForNativeColors' RFP/FPP target (so it shouldn't interfere with FPP/RFP)
// But I also want to set this here to ensure users are protected if they disable FPP for whatever reason, or if they disable ETP/Strict for a specific site/add an exception
// https://searchfox.org/firefox-main/rev/82e2435f/layout/style/PreferenceSheet.cpp#69
pref("browser.display.document_color_use", 1); // [DEFAULT - non-Windows] Contrast Control, supersedes `browser.display.use_system_colors` https://github.com/arkenfox/user.js/issues/1965
pref("browser.display.use_system_colors", false); // [DEFAULT - non-Windows]
pref("ui.use_standins_for_native_colors", true);

/// Prompt to spoof locale to en-US
pref("privacy.spoof_english", 0); // [DEFAULT]

/// Provide example templates to make it easier for users to set custom FPP overrides if needed
pref("privacy.fingerprintingProtection.granularOverrides.0.example", '[{"firstPartyDomain":"example1.invalid","overrides":"+ProtectionIWantToEnableOnThisWebsite,-ProtectionIWantToDisableOnThisWebsite"},{"firstPartyDomain":"*","thirdPartyDomain":"example2.invalid","overrides":"+ThirdPartyDomainsAreSupportedToo"}]');
pref("privacy.fingerprintingProtection.overrides.0.example", "+ProtectionIWantToEnableGlobally,-ProtectionIWantToDisableGlobally");

/// Reset the fingerprinting randomization key daily (in addition to per-session/when the browser restarts)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1816064
pref("privacy.resistFingerprinting.randomization.daily_reset.enabled", true);
pref("privacy.resistFingerprinting.randomization.daily_reset.private.enabled", true);

/// Round window sizes
// Also ensure we always skip earlyBlankFirstPaint to ensure windows are properly sized: https://bugzilla.mozilla.org/show_bug.cgi?id=1448423
pref("browser.startup.blankWindow", false); // [DEFAULT - non-Windows, non-Linux Nightly]
pref("privacy.window.maxInnerHeight", 900); // [DEFAULT - non-Android/Thunderbird]
pref("privacy.window.maxInnerWidth", 1600);

/// Set a fixed temporary storage limit
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/41065
// https://bugzilla.mozilla.org/show_bug.cgi?id=1781277
pref("dom.quotaManager.temporaryStorage.fixedLimit", 52428800); // Ex. matches what Tor Browser uses & what Firefox uses by default in most cases

/// Set FPP granular overrides (if the related target is enabled...)
// See here for details: https://codeberg.org/celenity/Phoenix/wiki/FPP-Overrides

/// Set target video resolution to 1080p
pref("privacy.resistFingerprinting.target_video_res", 1080); // [DEFAULT]

/// Set zoom levels on a per-site basis
// Changing the zoom level globally can be fingerprintable
// Note: We also set the "SiteSpecificZoom" FPP/RFP target
pref("browser.zoom.siteSpecific", true); // [DEFAULT - non-Android]

/// So people don't freak out when they see RFP isn't enabled...
// We need to keep Android notes under ~50 characters to prevent them from being cut off/un-readable; isn't an issue on Desktop
pref("privacy.resistFingerprinting.0.NOTE", "RFP is disabled on purpose.");
pref("privacy.resistFingerprinting.1.NOTE", "We use a hardened configuration of FPP instead.");
pref("privacy.resistFingerprinting.2.NOTE", "Using RFP is not recommended or supported.");

pref("browser.phoenix.status", "004");

/*** 005 DISK AVOIDANCE ***/

/// Allow permission manager to write to disk
// This is already Firefox's default - but it's hidden, so this exposes it via the `about:config`
// https://searchfox.org/firefox-main/rev/82e2435f/extensions/permissions/PermissionManager.cpp#765
pref("permissions.memory_only", false); // [HIDDEN] [DEFAULT]

/// Allow users to automatically delete files downloaded in Private Browsing
// (browser.download.deletePrivate controls the functionality itself)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1790641
pref("browser.download.enableDeletePrivate", true); // [DEFAULT] https://bugzilla.mozilla.org/show_bug.cgi?id=1981504

/// Check the boxes for clearing browsing data when navigating to `about:preferences#privacy` -> `Cookies and Site Data` -> `Manage Data...` by default [NO-ANDROID]
pref("privacy.clearHistory.browsingHistoryAndDownloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.clearHistory.cache", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.clearHistory.formdata", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearSiteData.browsingHistoryAndDownloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearSiteData.cache", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.clearSiteData.formdata", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearSiteData.historyFormDataAndDownloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.cpd.cache", true); // [NO-ANDROID] [DEFAULT]
pref("privacy.cpd.downloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.cpd.formdata", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.cpd.history", true); // [NO-ANDROID] [DEFAULT]
pref("privacy.cpd.sessions", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]

//// Except for cookies... (as this ignores `Allow` exceptions) [NO-ANDROID]
pref("privacy.clearHistory.cookiesAndStorage", false); // [NO-ANDROID]
pref("privacy.clearSiteData.cookiesAndStorage", false); // [NO-ANDROID]
pref("privacy.cpd.cookies", false); // [NO-ANDROID]
pref("privacy.cpd.offlineApps", false); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]

//// and passwords... [NO-ANDROID]
pref("privacy.cpd.passwords", false); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]

/// Clear browsing history, download history, and sessions on exit by default [NO-ANDROID]
pref("privacy.clearOnShutdown.downloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearOnShutdown.history", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearOnShutdown.sessions", true); // [NO-ANDROID] [HIDDEN - Thunderbird]

/// Clear cache on exit by default
// We also disable disk cache entirely below...
pref("privacy.clearOnShutdown.cache", true);
pref("privacy.clearOnShutdown_v2.cache", true); // [DEFAULT - Desktop Firefox]
pref("privacy.sanitize.sanitizeOnShutdown", true);


/// Disable back/forward cache (bfcache)
// This helps ensure that sensitive data/user state is discarded as soon as possible
// https://web.dev/articles/bfcache
// https://github.com/uazo/cromite/blob/master/docs/FEATURES.md
// https://github.com/uazo/cromite/issues/1649
// https://kb.mozillazine.org/Browser.sessionhistory.max_total_viewers#Possible_values_and_their_effects
pref("browser.sessionhistory.max_total_viewers", 0); // (Default = -1 (Automatic) - which is 8 unless you're using a device with under 1GB of RAM)
pref("fission.bfcacheInParent", false);

/// Disable collection/generation of background thumbnails
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/thumbnails/PageThumbs.sys.mjs#631
pref("browser.pagethumbnails.capturing_disabled", true); // [HIDDEN]

/// Disable collection/generation of wireframes
// https://searchfox.org/firefox-main/source/browser/components/sessionstore/PageWireframes.sys.mjs
pref("browser.history.collectWireframes", false); // [DEFAULT]

/// Disable coloring visited links
pref("layout.css.visited_links_enabled", false);

/// Disable disk cache
pref("browser.cache.disk.enable", false);
pref("browser.cache.disk_cache_ssl", true); // [DEFAULT] Controls disk cache for secure (HTTPS) resources, depends on `browser.cache.disk.enable` (which is why we're keeping this on by default)

/// Disable favicons in shortcuts [NO-ANDROID]
// Prevents .ico files from persisting, even after deletion [NO-ANDROID]
pref("browser.shell.shortcutFavicons", false); // [NO-ANDROID] [HIDDEN - Thunderbird]

/// Disable frecency
// This also prevents random recently visited sites from being pinned to the homepage on Desktop
// https://firefox-source-docs.mozilla.org/browser/urlbar/ranking.html#frecency-implementation
// https://devdoc.net/web/developer.mozilla.org/en-US/docs/The_Places_frecency_algorithm.html
// NOTE: `places.frecency.unvisitedBookmarkBonus` is required for bookmark URL bar suggestions on Desktop:
// https://codeberg.org/celenity/Phoenix/issues/218
// https://www.labnol.org/software/browsers/prevent-firefox-showing-bookmarks-address-location-bar/3636#:~:text=Option%20C%3A%20Remove%20Bookmarks%20Completely%20from%20Address%20Bar
pref("places.frecency.bookmarkVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 75]
pref("places.frecency.defaultVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.downloadVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.embedVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.framedLinkVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.linkVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 100]
pref("places.frecency.permRedirectVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Firefox Desktop] [Default on Firefox Desktop: 50]
pref("places.frecency.redirectSourceVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.reloadVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [Default on Firefox Desktop: 0]
pref("places.frecency.tempRedirectVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Firefox Desktop] [Default on Firefox Desktop: 40]
pref("places.frecency.typedVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 2000]
pref("places.frecency.unvisitedTypedBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 200]



pref("browser.contentblocking.database.enabled", false); // [DEFAULT - Android/Thunderbird]

/// Disable Search & Form History
// Can be leaked to sites...
// https://blog.mindedsecurity.com/2011/10/autocompleteagain.html
pref("browser.formfill.enable", false);


/// Disable WebRTC history
// History will still gather when `about:webrtc` is open
// Also likely improves performance...
pref("media.aboutwebrtc.hist.enabled", false); // [DEFAULT - non-Nightly]

/// Disable window state restoration
// https://searchfox.org/firefox-main/rev/16707ce1/xpfe/appshell/AppWindow.cpp#2404
pref("browser.restoreWindowState.disabled", true);



/// Increase the interval between between Session Store save operations
// Also improves performance
// (Default = 10000 (10 secs) for Android, 15000 (15 secs) elsewhere)
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/sessionstore/docs/utils.rst#20
pref("browser.sessionstore.interval", 60000); // 1 minute


/// Prevent clearing cookies by default

/// Prevent clearing passwords & site settings by default
pref("privacy.clearOnShutdown.siteSettings", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("privacy.clearOnShutdown_v2.siteSettings", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]



/// Prevent storing unnecessary extra session data
pref("browser.sessionstore.privacy_level", 2); // [HIDDEN - Thunderbird]

/// Prevent writing media cache (ex. for video streaming) to disk in private windows
pref("browser.privatebrowsing.forceMediaMemoryCache", true);

/// Remove cached files from browser windows opened with external applications
// https://bugzilla.mozilla.org/buglist.cgi?bug_id=302433,1738574
pref("browser.download.start_downloads_in_tmp_dir", true);
pref("browser.helperApps.deleteTempFileOnExit", true); // [DEFAULT - Thunderbird]


/// Set default time range when manually clearing data to "everything" [NO-ANDROID]
pref("privacy.sanitize.timeSpan", 0); // [NO-ANDROID]


pref("browser.phoenix.status", "005");

/*** 006 DOWNLOADS ***/

/// Block insecure downloads
pref("dom.block_download_insecure", true); // [DEFAULT]

/// Disable extra download logging by default
// This lets us expose it in the about:config for Android/Thunderbird
pref("browser.download.loglevel", "Error"); // [DEFAULT, HIDDEN - Android/Thunderbird]

/// Notify when downloading files
pref("browser.download.alwaysOpenPanel", true); // [DEFAULT - Desktop] [HIDDEN - Android/Thunderbird]

/// Prevent adding downloads to "recent documents"...
pref("browser.download.manager.addToRecentDocs", false);

/// Prompt before downloading files
pref("browser.download.always_ask_before_handling_new_types", true);
pref("browser.download.useDownloadDir", false); // [DEFAULT - Thunderbird]

pref("browser.phoenix.status", "006");

/*** 007 HTTP(S) ***/

/// Allow users to bypass invalid certificate errors by default
// (To expose the preference via the `about:config`)
pref("security.certerror.hideAddException", false); // [HIDDEN] [DEFAULT]

/// Always preload intermediates
// https://wiki.mozilla.org/Security/CryptoEngineering/Intermediate_Preloading
pref("security.remote_settings.intermediates.enabled", true); // [DEFAULT]

/// Always warn on insecure webpages
pref("security.insecure_connection_text.enabled", true);
pref("security.insecure_connection_text.pbmode.enabled", true);
pref("security.ssl.treat_unsafe_negotiation_as_broken", true);

/// Always warn when submitting a form from HTTP to HTTPS, even on local IP addresses
pref("security.insecure_field_warning.ignore_local_ip_address", false);
pref("security.warn_submit_secure_to_insecure", true); // [DEFAULT]

/// Disable the automatic import of OS client authentication certificates
// (Ex. smart cards)
// This prevents loading Mozilla's PKCS#11 module (which then loads these certificates from the OS store).
// AFAICT this functionality is quite obscure, use is seemingly nonexistent outside of very specific environments (ex. enterprise/government).
// Those who do actually use this functionality may also not want the browser to automatically import/expose these certificates, as they have many other uses.
// These certificates can also still be imported in browser settings anyways, so those who do need to use this functionality still can that way.
// So I no reason to leave this enabled by default - disabling it reduces attack surface and gives more control to users.
// (For reference, Tor Browser also disables this)
// https://blog.mozilla.org/security/2020/04/14/expanding-client-certificates-in-firefox-75/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1637807
pref("security.osclientcerts.autoload", false); // [DEFAULT - Thunderbird]

/// Disable downgrades to insecure TLS 1.0/1.1
pref("security.tls.insecure_fallback_hosts", ""); // [DEFAULT]
pref("security.tls.version.enable-deprecated", false, locked); // [DEFAULT]

/// Disable insecure ciphers (Like Chromium & Tor Browser)
// https://gitlab.torproject.org/tpo/applications/mullvad-browser/-/issues/361#note_3089049
// https://bugzilla.mozilla.org/show_bug.cgi?id=1600437
// https://bugzilla.mozilla.org/show_bug.cgi?id=1036765
pref("security.ssl3.dhe_rsa_aes_128_sha", false); // [DEFAULT]
pref("security.ssl3.dhe_rsa_aes_256_sha", false); // [DEFAULT]
pref("security.ssl3.ecdhe_ecdsa_aes_128_sha", false); // [DEFAULT - Nightly] TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
pref("security.ssl3.ecdhe_ecdsa_aes_256_sha", false); // [DEFAULT - Nightly] TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA

/// Disable OCSP revocation checks
//
// So, my current understanding:
// According to Mozilla blog: "With CRLite, Firefox periodically downloads a compact encoding of the set of all revoked certificates that appear in Certificate Transparency logs. Firefox stores this encoding locally, updates it every 12 hours, and queries it privately every time a new TLS connection is created."
// and: "Of course, no browser is performing daily downloads of all CRLs. For a more meaningful comparison, we can consider Chrome’s CRLSets. These are hand-picked sets of revocations that are delivered to Chrome users daily. Recent CRLSets weigh in at 600 kB and include about 1% of all revocations (thirty-five thousand of the four million total). Firefox’s CRLite implementation uses half the bandwidth, updates twice as frequently, and includes all revocations."
// According to MDN: "Firefox desktop from version 135 requires CT log inclusion for all certificates issued by certificate authorities in Mozilla's Root CA Program".
//
// What this means for us:
// 1. We enforce Certificate Transparency (CT) below (security.pki.certificate_transparency.mode -> 2)
// 2. Mozilla requires CAs in their program to implement CT, and we disable using the system's root CAs below (security.certerrors.mitm.auto_enable_enterprise_roots + security.enterprise_roots.enabled)
// 3. We enable + enforce CRLite below (security.pki.crlite_mode -> 2, security.remote_settings.crlite_filters.enabled -> true)
// 4. CRLite works by using CT logs, AND includes ALL revocations from those logs
// 5. Therefore, since we're only trusting CAs that use CT, and since CRLite is covering ALL revocations from CT, we can reasonably conclude that CRLite is covering all revocatons, and thus, OCSP should be superfluous
// So, I'm comfortable finally retiring OCSP... :) - Great to see how far this has come
// https://wikipedia.org/wiki/Online_Certificate_Status_Protocol
// https://hacks.mozilla.org/2025/08/crlite-fast-private-and-comprehensive-certificate-revocation-checking-in-firefox/
// https://developer.mozilla.org/docs/Web/Security/Certificate_Transparency#browser_requirements
// https://github.com/arkenfox/user.js/issues/1576

/// Disable Parental Controls
// https://searchfox.org/firefox-main/source/toolkit/components/parentalcontrols/nsIParentalControlsService.idl
// https://searchfox.org/firefox-main/rev/cb527813/netwerk/protocol/http/nsHttpHandler.cpp#537
// https://searchfox.org/firefox-main/rev/cb527813/docshell/base/CanonicalBrowsingContext.cpp#3696
// https://searchfox.org/firefox-main/source/toolkit/locales-preview/aboutRestricted.ftl
pref("network.parental_controls_cached_state", false, locked); // [DEFAULT]
pref("security.restrict_to_adults.always", false, locked); // [DEFAULT]
pref("security.restrict_to_adults.respect_platform", false, locked); // [DEFAULT]

/// Disable sending background HTTP requests to websites that do not respond quickly to check if they support HTTPS
pref("dom.security.https_only_mode_send_http_background_request", false);

/// Disable third-party/OS-level root certificates
// I've been torn on how to handle this, but IMO the safest way forward is disabling this functionality in Firefox
// This is commonly abused by malware/etc. and it's even overriden by certain software/garbage AV's...
// Ex. https://support.kaspersky.com/common/compatibility/14620#block3
// Since this is something programs actively try to override, I don't see a safe way to support this, so we'll lock it
// We still allow users to manually import certificates into Firefox... 
// So we can ensure users are aware of certificates they add and are making this decision consciously
// This is also important to ensure that Certificate Transparency is properly enforced, since it (`security.pki.certificate_transparency.mode`) only covers roots issued by Mozilla
// https://wiki.mozilla.org/SecurityEngineering/Certificate_Transparency#Certificate_Transparency_Support_in_Firefox
// We also set "ImportEnterpriseRoots" in policies [NO-ANDROID]
// https://mozilla.github.io/policy-templates/#certificates--importenterpriseroots [NO-ANDROID]
pref("security.certerrors.mitm.auto_enable_enterprise_roots", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("security.enterprise_roots.enabled", false, locked); // [NO-ANDROID]

//// Ensure HTTP/3 isn't disabled when/if third-party/OS-level root certificates are found
pref("network.http.http3.disable_when_third_party_roots_found", false);

/// Disable TLS 1.3 0-RTT
// Not forward secret
// https://github.com/tlswg/tls13-spec/issues/1001
pref("network.http.http3.enable_0rtt", false); // For HTTP3 https://bugzilla.mozilla.org/show_bug.cgi?id=1689550
pref("security.tls.enable_0rtt_data", false);

/// Enable (+ enforce) Certificate Transparency
// https://wiki.mozilla.org/SecurityEngineering/Certificate_Transparency
pref("security.pki.certificate_transparency.disable_for_hosts", ""); // [DEFAULT]
pref("security.pki.certificate_transparency.disable_for_spki_hashes", ""); // [DEFAULT]
pref("security.pki.certificate_transparency.mode", 2); // [DEFAULT - non-Nightly Android]

/// Enable CRLite revocation checks (and prioritize over OCSP)
// https://blog.mozilla.org/security/2020/01/09/crlite-part-1-all-web-pki-revocations-compressed/
pref("security.pki.crlite_channel", "default"); // [DEFAULT - non-Android] Use CRLite clubcards that contain all revocations, instead of just "priority" revocations
pref("security.pki.crlite_mode", 2); // [DEFAULT - Nightly]
pref("security.remote_settings.crlite_filters.enabled", true); // [DEFAULT - non-Android]

/// Enable Delegated Credentials
// https://wikipedia.org/wiki/Delegated_credential
pref("security.tls.enable_delegated_credentials", true); // [DEFAULT]

/// Enable MITM Detection
// https://github.com/arkenfox/user.js/issues/740
// https://bugzilla.mozilla.org/show_bug.cgi?id=1529643
pref("security.certerrors.mitm.priming.enabled", true); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Android/Thunderbird]
pref("security.certerrors.mitm.priming.endpoint", "https://mitmdetection.services.mozilla.com/"); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Android/Thunderbird]

/// Enable OCSP stapling
// https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
// https://blog.cloudflare.com/high-reliability-ocsp-stapling/#ocsp-must-staple
pref("security.ssl.enable_ocsp_must_staple", true); // [DEFAULT]
pref("security.ssl.enable_ocsp_stapling", true); // [DEFAULT]

/// Enable Post Quantum Key Agreement (Kyber)
pref("media.webrtc.enable_pq_dtls", true); // [DEFAULT]
pref("media.webrtc.enable_pq_hybrid_kex", true); // [DEFAULT]
pref("media.webrtc.send_mlkem_keyshare", true); // [DEFAULT]
pref("network.http.http3.enable_kyber", true); // [DEFAULT]
pref("security.tls.client_hello.send_p256_keyshare", true); // [DEFAULT]
pref("security.tls.enable_kyber", true); // [DEFAULT]

/// Enable prompts for unsafe HTTP redirects
// https://searchfox.org/firefox-main/rev/16707ce1/modules/libpref/init/all.js#1189
// https://bugzilla.mozilla.org/show_bug.cgi?id=677754
// https://searchfox.org/firefox-main/rev/16707ce1/netwerk/protocol/http/nsHttpChannel.cpp#3687
pref("network.http.prompt-temp-redirect", true);

/// Enforce Strict Certificate Pinning
// https://wiki.mozilla.org/SecurityEngineering/Public_Key_Pinning#How_to_use_pinning
pref("security.cert_pinning.enforcement_level", 2);

/// Enforce TLS 1.3 downgrade protection
// https://bugzilla.mozilla.org/show_bug.cgi?id=1576790
pref("security.tls.hello_downgrade_check", true); // [DEFAULT]

/// Enforce using HTTPS as much as possible
pref("dom.securecontext.allowlist", ""); // [HIDDEN] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/dom/security/nsMixedContentBlocker.cpp#270
pref("dom.security.https_first", true);
pref("dom.security.https_first_for_custom_ports", true); // [DEFAULT] DEFENSE IN DEPTH
pref("dom.security.https_first_for_local_addresses", true);
pref("dom.security.https_first_for_unknown_suffixes", true);
pref("dom.security.https_first_pbm", true); // [DEFAULT]
pref("dom.security.https_first_schemeless", true);
pref("dom.security.https_only_mode", true);
pref("dom.security.https_only_mode.upgrade_local", true);
pref("dom.security.https_only_mode_pbm", true);
pref("security.mixed_content.block_active_content", true);
pref("security.mixed_content.block_display_content", false); // [DEFAULT] Unnecessary with the "security.mixed_content.upgrade_display_content" pref - "security.mixed_content.upgrade_display_content" tries to upgrade mixed content by default and still blocks it if fails, this pref ("security.mixed_content.block_display_content") just blocks all mixed content entirely, causing unnecessary breakage for users. https://github.com/mozilla/policy-templates/issues/1141
pref("security.mixed_content.block_object_subrequest", true);
pref("security.mixed_content.upgrade_display_content", true);
pref("security.mixed_content.upgrade_display_content.audio", true); // [DEFAULT]
pref("security.mixed_content.upgrade_display_content.image", true); // [DEFAULT]
pref("security.mixed_content.upgrade_display_content.video", true); // [DEFAULT]

/// Ensure that the browser omits credentials when making network requests by default
// https://searchfox.org/firefox-main/rev/4dad4a9a/modules/libpref/init/StaticPrefList.yaml#13568
pref("network.fetch.systemDefaultsToOmittingCredentials", true); // [DEFAULT]

/// Ensure we use the HSTS preload list
// https://searchfox.org/firefox-main/rev/82e2435f/security/manager/ssl/nsSiteSecurityService.cpp#799
pref("network.stricttransportsecurity.preloadlist", true); // [DEFAULT]

/// If HTTPS-Only Mode is disabled in favor of HTTPS-First, prevent automatically exempting domains (to ensure we always try HTTPS first...)
pref("dom.security.https_first_add_exception_on_failure", false);

/// Only allow certificate error exceptions per-session
pref("security.certerrors.permanentOverride", false); // [HIDDEN - Android/Thunderbird]

/// Only load secure websockets from HTTPS pages
pref("network.websocket.allowInsecureFromHTTPS", false); // [DEFAULT]

/// Require safe renegotiations
// Disables connections to servers without RFC 5746
// https://wiki.mozilla.org/Security:Renegotiation
pref("security.ssl.require_safe_negotiation", true);

/// Show detailed information on insecure warning pages
pref("browser.xul.error_pages.expert_bad_cert", true);

/// Show suggestions when an HTTPS page can not be found 
// Ex. If 'example.com' isn't secure, it may suggest 'www.example.com'
pref("dom.security.https_only_mode_error_page_user_suggestions", true);

pref("browser.phoenix.status", "007");

/*** 008 IMPLICIT CONNECTIONS ***/

/// Disable Early Hints (Like Cromite)
// https://github.com/uazo/cromite/blob/master/build/patches/Client-hints-overrides.patch
// https://developer.mozilla.org/docs/Web/HTTP/Status/103
// https://github.com/bashi/early-hints-explainer/blob/main/explainer.md
pref("network.early-hints.enabled", false);
pref("network.early-hints.over-http-v1-1.enabled", false);
pref("network.early-hints.preconnect.enabled", false);
pref("network.early-hints.preconnect.max_connections", 0);

/// Disable Network Prefetching
// https://developer.mozilla.org/docs/Glossary/Prefetch
pref("dom.prefetch_dns_for_anchor_http_document", false); // https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/42684
pref("dom.prefetch_dns_for_anchor_https_document", false); // [DEFAULT] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/42684
pref("network.dns.disablePrefetch", true);
pref("network.dns.disablePrefetchFromHTTPS", true);
pref("network.dns.prefetch_via_proxy", false); // [DEFAULT]
pref("network.http.speculative-parallel-limit", 0); // [DEFAULT - Thunderbird]
pref("network.predictor.enable-hover-on-ssl", false); // [DEFAULT]
pref("network.predictor.enable-prefetch", false); // [DEFAULT]
pref("network.predictor.enabled", false);
pref("network.prefetch-next", false);

/// Disable Preconnect
// https://github.com/uBlockOrigin/uBlock-issues/issues/2913
// https://developer.mozilla.org/docs/Web/HTML/Attributes/rel/preconnect
pref("network.preconnect", false);



/// Prevent middle mouse clicks from pasting clipboard contents by default
// Way too easy to accidentally press...
pref("middlemouse.paste", false);

/// Prevent middle mouse clicks on new tab button opening URLs or searches from clipboard
pref("browser.tabs.searchclipboardfor.middleclick", false);
pref("middlemouse.contentLoadURL", false); // [DEFAULT]

pref("browser.phoenix.status", "008");

/*** 009 SEARCH & URL BAR ***/


/// Always show Punycode
// Protects against phishing & IDN Homograph Attacks
// https://wikipedia.org/wiki/IDN_homograph_attack
pref("network.IDN_show_punycode", true);











/// Disable search suggestions by default
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderSearchSuggestions.sys.mjs
// `browser.search.suggest.enabled` and `browser.search.suggest.enabled.private` appear to have no impact on Android & Thunderbird, but they're still defined there by default.. so we can set them anyways
pref("browser.search.suggest.enabled", false); // [DEFAULT - Android]
pref("browser.search.suggest.enabled.private", false); // [DEFAULT]






// Adds Unified Search button to easily switch search engines in URL Bar, among other tweaks




/// Enable the Rust-based Search Engine Selector
// https://bugzilla.mozilla.org/show_bug.cgi?id=1914143
pref("browser.search.rustSelector.featureGate", true); // [DEFAULT]












/// Notify users if their default search engine has been removed
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/search/SearchService.sys.mjs#2030
pref("browser.search.removeEngineInfobar.enabled", true); // [DEFAULT]


/// Use the same search engine in normal and private browsing windows by default
// (DuckDuckGo for us)
pref("browser.search.separatePrivateDefault", false);

pref("browser.phoenix.status", "009");

/*** 010 DNS ***/

/// Customize list of built-in DoH resolvers
pref("doh-rollout.provider-list", '[{"uri":"https://dns.quad9.net/dns-query","UIName":"Quad9 🇨🇭","autoDefault":true},{"uri":"https://dns.adguard-dns.com/dns-query","UIName":"AdGuard 🇨🇾","autoDefault":false},{"uri":"https://unfiltered.adguard-dns.com/dns-query","UIName":"AdGuard (Unfiltered) 🇨🇾","autoDefault":false},{"uri":"https://mozilla.cloudflare-dns.com/dns-query","UIName":"Cloudflare 🇺🇸","autoDefault":false},{"uri":"https://security.cloudflare-dns.com/dns-query","UIName":"Cloudflare (Malware Protection) 🇺🇸","autoDefault":false},{"uri":"https://noads.joindns4.eu/dns-query","UIName":"DNS4EU (Ad Blocking) 🇨🇿","autoDefault":false},{"uri":"https://protective.joindns4.eu/dns-query","UIName":"DNS4EU (Protective) 🇨🇿","autoDefault":false},{"uri":"https://unfiltered.joindns4.eu/dns-query","UIName":"DNS4EU (Unfiltered) 🇨🇿","autoDefault":false},{"uri":"https://base.dns.mullvad.net/dns-query","UIName":"Mullvad (Base) 🇸🇪","autoDefault":false},{"uri":"https://dns.mullvad.net/dns-query","UIName":"Mullvad (Unfiltered) 🇸🇪","autoDefault":false},{"uri":"https://firefox.dns.nextdns.io/","UIName":"NextDNS 🇺🇸","autoDefault":false},{"uri":"https://wikimedia-dns.org/dns-query","UIName":"Wikimedia 🇺🇸","autoDefault":false}]'); // [HIDDEN]

/// Disable DoH Connectivity Checks
pref("network.connectivity-service.DNS_HTTPS.domain", "");
pref("network.trr.confirmationNS", "skip");
pref("network.trr.skip-check-for-blocked-host", true); // https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRService.cpp#1062

/// Disable EDNS Client Subnet (ECS) to prevent leaking general location data to authoritative DNS servers...
// https://wikipedia.org/wiki/EDNS_Client_Subnet
pref("network.trr.disable-ECS", true); // [DEFAULT]

/// Disable falling back to system DNS by default
pref("network.trr.retry_on_recoverable_errors", true); // https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/nsHostResolver.cpp#1351
pref("network.trr.strict_native_fallback", true); // https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/docs/data/environment.rst#418

/// Disable nsNotifyAddrListener
// (Ex. used for disabling DoH if certain conditions are met)
// https://searchfox.org/firefox-main/source/netwerk/system/win32/nsNotifyAddrListener.cpp
pref("network.notify.changed", false);
pref("network.notify.checkForNRPT", false);
pref("network.notify.checkForProxies", false);
pref("network.notify.dnsSuffixList", false);
pref("network.notify.initial_call", false);
pref("network.notify.IPv6", false); // [DEFAULT - Windows]
pref("network.notify.resolvers", false);

/// Enable DNS Rebinding Protection
// https://bugzilla.mozilla.org/show_bug.cgi?id=1672528
pref("network.trr.allow-rfc1918", false); // [DEFAULT]

/// Enable DoH without fallback & Set to Quad9 by default
pref("network.trr.default_provider_uri", "https://dns.quad9.net/dns-query");
pref("network.trr.mode", 3);

/// Enable EncryptedClientHello
// https://blog.cloudflare.com/announcing-encrypted-client-hello
pref("network.dns.echconfig.enabled", true); // [DEFAULT]
pref("network.dns.http3_echconfig.enabled", true); // [DEFAULT]

/// Enable native DNS over HTTPS lookups
// NOTE: Native DNS over HTTPS is currently broken on Windows 10, but can be toggled anyways with the
// `network.dns.native_https_query_win10` pref: https://bugzilla.mozilla.org/show_bug.cgi?id=1873461
pref("network.dns.native_https_query", true); // [DEFAULT - non-macOS]
pref("network.dns.native_https_query_in_automation", true); // Used in automation

/// Enable TLS SNI Slicing
// Useful for circumenting certain forms of censorship, ex. from the Great Firewall of China
// https://github.com/uazo/cromite/issues/2403
// https://github.com/net4people/bbs/issues/505
// https://searchfox.org/firefox-main/diff/cb527813/modules/libpref/init/StaticPrefList.yaml#15350
pref("network.http.http3.sni-slicing", true); // [DEFAULT]

/// Ensure we clear cache upon changing DoH prefs
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRService.cpp#440
pref("network.trr.clear-cache-on-pref-change", true); // [DEFAULT]

/// Expose the DoH bootstrap pref, but don't configure by default
// This is the DNS server Firefox uses to resolve the address of your DoH server
// By default, Firefox just uses the system DNS
// This value MUST match the address of the DoH server you're using
// Ex. you could set this to "9.9.9.9" for Quad9
// We won't configure this by default to prevent unexpected breakage for users when switching DNS providers, but it's hidden - so we can at least expose it in the about:config
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRService.cpp#903
pref("network.trr.bootstrapAddr", ""); // [HIDDEN] [DEFAULT]

/// Fix IPv6 connectivity when DoH is enabled
// https://codeberg.org/divested/brace/pulls/5
pref("network.dns.preferIPv6", true);

/// Prevent bypassing DoH for /etc/HOSTS entries by default
// Protects against HOSTS file hijacking
// https://www.malwarebytes.com/blog/news/2016/09/hosts-file-hijacks
// https://www.microsoft.com/wdsi/threats/malware-encyclopedia-description?Name=SettingsModifier:Win32/HostsFileHijack
// https://www.microcenter.com/tech_center/article/6472/how-to-clean-the-windows-hosts-file-if-malware-has-tampered-with-it
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRServiceBase.cpp#359
pref("network.trr.exclude-etc-hosts", false);

/// Prevent sending headers for DoH requests
pref("network.trr.send_accept-language_headers", false); // [DEFAULT]
pref("network.trr.send_empty_accept-encoding_headers", true); // [DEFAULT]
pref("network.trr.send_user-agent_headers", false); // [DEFAULT]


pref("browser.phoenix.status", "010");

/*** 011 PROXIES ***/

/// Prevent Firefox from automatically using the system's proxy configuration by default
// This is commonly abused by content filtering/monitoring/MITM software & malware (just like third-party/OS-level root certificates...)
// There are of course legitimate use cases for proxies, but those require manual set-up anyways... let's ensure the user is always in control and making the conscious decision to use a proxy (if at all)
// Also helps with performance as a bonus
// https://bugzilla.mozilla.org/show_bug.cgi?id=500983
// https://bugzilla.mozilla.org/show_bug.cgi?id=500983#c7
// https://superuser.com/questions/169303/why-are-my-browsers-suddenly-configured-to-use-a-proxy
// The proxy type. See nsIProtocolProxyService.idl
//    PROXYCONFIG_DIRECT   = 0
//    PROXYCONFIG_MANUAL   = 1
//    PROXYCONFIG_PAC      = 2
//    PROXYCONFIG_WPAD     = 4
//    PROXYCONFIG_SYSTEM   = 5 (default)
pref("network.proxy.type", 0);

// Prevent bypasses/leakage

/// Always start proxy extensions (if installed) as soon as possible, instead of waiting for the first browser window to open
pref("extensions.webextensions.early_background_wakeup_on_request", true); // [HIDDEN - non-Android] [DEFAULT - Android]

/// Disable automatic failover from the proxy (if configured) to direct connections when certain system requests fail
// https://bugzilla.mozilla.org/show_bug.cgi?id=1720221
pref("network.proxy.failover_direct", false);

/// Disable file:///net
// https://bugzilla.mozilla.org/show_bug.cgi?id=1412081
// (This unfortunately breaks file upload on Android ATM)
pref("network.file.path_blacklist", "/net"); // [NO-ANDROID] [HIDDEN]

/// Disable GIO
// https://bugzilla.mozilla.org/1433507
pref("network.gio.supported-protocols", ""); // [HIDDEN]

/// Disable Uniform Naming Convention (UNC) file paths
// https://bugzilla.mozilla.org/1413868
pref("network.file.disable_unc_paths", true); // [HIDDEN]

/// Disable Wi-Fi Tickler
// Ex. disabled by the Proxy Bypass Protection build argument
// https://searchfox.org/firefox-main/source/netwerk/base/Tickler.h
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/base/Tickler.cpp#127
pref("network.tickle-wifi.enabled", false); // [DEFAULT - non-Android]

/// Prevent bypassing the proxy (if configured) for system connections that include the `bypassProxy` flag
// https://bugzilla.mozilla.org/show_bug.cgi?id=1732792
pref("network.proxy.allow_bypass", false);

/// Use the proxy (if configured) for remote DNS lookups
pref("network.proxy.socks_remote_dns", true);
pref("network.proxy.socks5_remote_dns", true); // [DEFAULT]

pref("browser.phoenix.status", "011");

/*** 012 WEBRTC ***/

/// Allow user to silence notifications when screen sharing
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2590
pref("privacy.webrtc.allowSilencingNotifications", true); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("privacy.webrtc.hideGlobalIndicator", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Always sandbox Media Transport
// https://searchfox.org/firefox-main/rev/82e2435f/security/sandbox/common/SandboxSettings.cpp#185
pref("media.peerconnection.mtransport_process", true); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Disable RTP Control Protocol (RTCP) reception
// https://wikipedia.org/wiki/RTP_Control_Protocol
// Used for quality monitoring and statistics
// https://searchfox.org/firefox-main/rev/874c5779/dom/media/webrtc/transportbridge/MediaPipeline.cpp#651
pref("media.webrtc.net.force_disable_rtcp_reception", true);

/// Enable global toggles for muting the camera/microphone
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2595
pref("privacy.webrtc.globalMuteToggles", true); // [HIDDEN - Android]

/// Enable mDNS Host Obfuscation to prevent leaking local IP addresses
// https://bugzilla.mozilla.org/show_bug.cgi?id=1588817
pref("media.peerconnection.ice.obfuscate_host_addresses", true); // [DEFAULT - non-Android]

/// Prevent WebRTC from bypassing the proxy (if configured)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1790270
pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);

/// Warn users when attempting to switch tabs in a window being shared over WebRTC
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2599
pref("privacy.webrtc.sharedTabWarning", true); // [HIDDEN - Android/Thunderbird]

pref("browser.phoenix.status", "012");

/*** 013 MEDIA ***/

/// Add DRM notes
pref("media.eme.enabled.0.NOTE", "DRM/EME is NOT supported or recommended.");
pref("media.eme.enabled.1.NOTE", "Enabling it WILL compromise your privacy/security.");
pref("media.eme.enabled.2.NOTE", "Proceed at your own caution.");

/// Block media autoplay by default
// https://support.mozilla.org/kb/block-autoplay
// `media.geckoview.autoplay.request.testing` is used when `media.geckoview.autoplay.request` is set to `true` (ex. on GeckoView/Fenix) - when `media.geckoview.autoplay.request` is false, `media.autoplay.default` appears to be used instead
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#12909
pref("media.autoplay.default", 5);
pref("media.geckoview.autoplay.request.testing", 2); // [DEFAULT: 0 - Follows the Autoplay site permission]

/// Configure the media autoplay blocking policy
// https://wiki.mozilla.org/Media/block-autoplay#What_strategy_does_Firefox_use_for_blocking_autoplay?
// Values are:
// 0 (Default): Sticky - Autoplay is blocked until the user interacts with a page, and is allowed indefinitely (until the user refreshes the page or navigates to a different page)
// 1: Transient - Autoplay is blocked until the user interacts with a page, BUT it is only allowed until a certain amount of time passes (controlled by `dom.user_activation.transient.timeout`)
// 2: Click-to-play - Autoplay is always blocked; media will only play on user interaction of the desired media
// 2 is ideal on paper (and we used to use that value, at least on Phoenix Extended), but it unfortunately causes breakage and prevents media from playing at all on certain websites - so I believe 1 is a nice balance/compromise
pref("media.autoplay.blocking_policy", 1);

/// Disable Encrypted Media Extensions (EME) (DRM)
// Garbage technology with privacy, security, and freedom concerns
// https://www.w3.org/TR/encrypted-media/
// https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next
// https://celenity.dev/posts/thoughts/drm/
// (For testing: https://bitmovin.com/demos/drm)
// NOTE: EME also requires Content Decryption Modules (CDMs) to function
// By default, when EME is enabled, Firefox automatically enables/installs Google Widevine on all platforms, in addition to Microsoft PlayReady on Windows
// Unlike Firefox, when EME is enabled, we don't automatically enable any CDMs (see prefs below) - instead, we allow the user to decide which CDM they prefer to use with EME, instead of making that choice for them - allowing the user to remain in control
// NOTE: The standard "media.eme.enabled" pref only disables PROPRIETARY CDMs - Firefox on Desktop also enables an additional CDM (Clear Key: https://www.w3.org/TR/encrypted-media-2/#clear-key), which is ALWAYS active, even when the EME pref is disabled... (For reference, Clear Key has previously had security vulnerabilities: https://www.mozilla.org/security/advisories/mfsa2016-77/ (Tor Browser disables Clear Key FWIW) - and while Clear Key is open source, it still implements basic content protection (such as preventing users from downloading videos... https://bugzilla.mozilla.org/show_bug.cgi?id=1136707#c18))
// BUT: To work around this, we leverage the `media.eme.require-app-approval` pref. This pref was originally intended for Android to block EME unless the user grants permission. However, when this pref is set on Desktop, since there's no way for users to grant permission to use EME like on Android, it ends up blocking EME entirely - INCLUDING Clear Key
// (For testing Clear Key: https://cpearce.github.io/mse-eme/ + https://reference.dashif.org/dash.js/latest/samples/drm/clearkey.html)
// So essentially:
// On Desktop: want to use EME, but ONLY with an open source CDM (Clear Key)? Set `media.eme.require-app-approval` to `false` and don't touch anything else. Otherwise, set `media.eme.enabled` to `true` AND `media.eme.require-app-approval` to `false`, and enable your preferred CDM(s) below
// On Android: want to use EME at all? Set `media.eme.enabled` to `true` (Do NOT touch `media.eme.require-app-approval`), and enable your preferred CDM below (Currently Android only supports Widevine)
pref("media.eme.enabled", false);
pref("media.eme.require-app-approval", true); // [DEFAULT - Android] https://bugzilla.mozilla.org/show_bug.cgi?id=1620102 https://searchfox.org/firefox-main/rev/82e2435f/dom/media/eme/MediaKeySystemAccessPermissionRequest.h#17

//// Disable the Google Widevine CDM by default (if EME is enabled)
/// https://developers.google.com/widevine/drm/overview
/// NOTE: Widevine on Desktop requires Gecko Media Plugins (GMP) - which we also disable by default, see below


/// Disable Gecko Media Plugins (GMP)
// This is currently only used for DRM and OpenH264 (both of which we disable)
// So this helps reduce attack surface (and unwanted network activity...)
// https://wiki.mozilla.org/GeckoMediaPlugins
// https://blog.pearce.org.nz/2019/06/firefoxs-gecko-media-plugin-eme.html
// NOTE: We previously set `media.gmp-provider.enabled` to `false`, but it turns out that pref is essentially useless... all it does is hide installed plug-ins from `about:addons` (and prevents manually triggered add-on updates from checking for GMP updates); it doesn't actually disable GMP or plug-ins installed by it, it doesn't prevent the installation or update of GMP plug-ins, etc...
// The `media.gmp-manager.updateEnabled` pref is a better fit, as it (combined with the `media.gmp-manager.allowLocalSources` pref) effectively block all GMP downloads/updates
// https://github.com/arkenfox/user.js/issues/709
pref("media.gmp-manager.updateEnabled", false); // [HIDDEN]


/// Disable GMP encoding
// GMP only makes sense for decoding/media *consumption*
pref("media.gmp.encoder.enabled", false); // [DEFAULT]

/// Disable GMP local sources
// When combined with `media.gmp-manager.updateEnabled`, this blocks all GMP downloads/updates
// When GMP is enabled (`media.gmp-manager.updateEnabled` set to `true`), this is still useful - as it ensures the GMP plug-ins that Firefox installs are always the latest versions available (instead of being outdated/potentially vulnerable), directly from Mozilla
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/modules/GMPInstallManager.sys.mjs#53
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/modules/GMPUtils.sys.mjs#180
pref("media.gmp-manager.allowLocalSources", false);

/// Disable GMP logging by default (to expose via the `about:config`)
pref("media.gmp.log.dump", false); // [HIDDEN] [DEFAULT]
pref("media.gmp.log.level", 70); // [HIDDEN] Limits logging to fatal only


/// Disable OpenH264 (in favor of hardware decoding)
// Mozilla has previously shipped outdated versions of OpenH264 - ex. 2.3.2, which was ~2 years out of date... https://github.com/cisco/openh264/releases/tag/v2.3.1
// The outdated version shipped by Mozilla was subject to a high severity CVE: https://www.cve.org/CVERecord?id=CVE-2025-27091
// https://bugzilla.mozilla.org/show_bug.cgi?id=CVE-2025-27091
// Downloads were also still distributed over standard, unencrypted HTTP for a very long time, but thankfully now do appear to be distributed over HTTPS, so at least there's that
// https://searchfox.org/firefox-main/source/toolkit/content/gmp-sources/openh264.json
pref("media.ffmpeg.allow-openh264", false); // [DEFAULT - Nightly]
pref("media.gmp-gmpopenh264.enabled", false);
pref("media.gmp-gmpopenh264.visible", false); // Don't display in UI/`about:addons`
pref("media.webrtc.hw.h264.enabled", true); // [DEFAULT - Android] Enables H264 hardware decoding https://bugzilla.mozilla.org/show_bug.cgi?id=1717679

/// Enable click to play UI for certain CSS skins by default [NO-ANDROID]
// https://github.com/black7375/Firefox-UI-Fix/blob/master/css/leptonContent.css#L223 [NO-ANDROID]
// https://github.com/black7375/Firefox-UI-Fix/wiki/Options#defaults-6 [NO-ANDROID]
pref("userContent.player.click_to_play", true); // [NO-ANDROID] [HIDDEN]

/// Enable the Data Decoder (RDD) process
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#data-decoder-rdd-process
// NOTE: Required for media playback on certain sites (ex. rumble.com, x.com) when isolated content processes
// are enabled on Android: https://bugzilla.mozilla.org/show_bug.cgi?id=1810736
// https://phabricator.services.mozilla.com/D260149
pref("media.rdd-applemedia.enabled", true); // [OSX-ONLY] [DEFAULT]
pref("media.rdd-ffmpeg.enabled", true); // [DEFAULT]
pref("media.rdd-ffvpx.enabled", true); // [DEFAULT - non-Android]
pref("media.rdd-opus.enabled", true); // [DEFAULT - non-Android]
pref("media.rdd-process.enabled", true); // [NO-ANDROID] [DEFAULT - non-Android] NOTE: This currently appears to cause memory safety issues on Android (detected via memory tagging), so for now this needs to remain disabled
pref("media.rdd-vorbis.enabled", true); // [DEFAULT - non-Android]
pref("media.rdd-vpx.enabled", true); // [DEFAULT - non-Android]
pref("media.rdd-wav.enabled", true); // [DEFAULT - non-Android]

/// Enable hardware/platform media decoding
// https://searchfox.org/firefox-main/source/dom/media/platforms/PDMFactory.cpp
// NOTE: Required for media playback on certain sites (ex. rumble.com, x.com) when isolated content processes
// are enabled on Android: https://bugzilla.mozilla.org/show_bug.cgi?id=1810736
// https://phabricator.services.mozilla.com/D260149
pref("media.ffvpx-hw.enabled", true); // [DEFAULT - Linux, Windows Nightly]
pref("media.gmp.decoder.preferred", false); // [DEFAULT]
pref("media.hardware-video-decoding.enabled", true); // [DEFAULT]

/// Enable hardware/platform media encoding
// https://searchfox.org/firefox-main/source/dom/media/platforms/PEMFactory.cpp
// NOTE: Required for media playback on certain sites (ex. rumble.com, x.com) when isolated content processes
// are enabled on Android: https://bugzilla.mozilla.org/show_bug.cgi?id=1810736
// https://phabricator.services.mozilla.com/D260149
pref("media.ffmpeg.encoder.enabled", true); // [DEFAULT - non-Android]
pref("media.gmp.encoder.preferred", false); // [DEFAULT]
pref("media.hardware-video-encoding.enabled", true); // [DEFAULT]
pref("media.use-remote-encoder.audio", true);
pref("media.use-remote-encoder.video", true);

/// Enable multi-threaded media decoding
// (Improves performance...)
pref("media.gmp.decoder.multithreaded", true);

/// Enable multi-threaded media encoding
// (Improves performance...)
pref("media.gmp.encoder.multithreaded", true);

/// If GMP is enabled (via `media.gmp-manager.updateEnabled`), ensure that installed plug-ins are visible/exposed in `about:addons`
pref("media.gmp-provider.enabled", true); // [DEFAULT - non-Thunderbird]


/// Use the more confined utility process for media decoding
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#data-decoder-rdd-process
// https://docs.google.com/document/d/1WDEY5fQetK_YE5oxGxXK9BzC1A8kJP3q6F1gAPc2UGE/edit
pref("media.allow-audio-non-utility", false); // [DEFAULT - non-iOS]
pref("media.utility-process.enabled", true); // [DEFAULT]

/// Validate signature when updating GMP (if enabled)
pref("media.gmp-manager.cert.checkAttributes", true); // [DEFAULT]
pref("media.gmp-manager.cert.requireBuiltIn", true); // [DEFAULT]
pref("media.gmp-manager.checkContentSignature", true); // [DEFAULT]

pref("browser.phoenix.status", "013");

/*** 014 ATTACK SURFACE REDUCTION ***/

/// Disable ASM.JS
// https://rh0dev.github.io/blog/2017/the-return-of-the-jit/
pref("javascript.options.asmjs", false); // [DEFAULT] https://bugzilla.mozilla.org/show_bug.cgi?id=2002635

/// Disable Graphite & SVG OpenType fonts
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+graphite
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg
pref("gfx.font_rendering.graphite.enabled", false);
pref("gfx.font_rendering.opentype_svg.enabled", false);

/// Disable JavaScript Just-in-time Compilation (JIT)
// https://microsoftedge.github.io/edgevr/posts/Super-Duper-Secure-Mode/
// https://firefox-source-docs.mozilla.org/js/index.html#javascript-jits
// https://codeberg.org/rusty-snake/firefox-config/src/commit/c8c157b28aad9a52d3bca63b3152b4d11fd62093/assets/user-overrides.js#L46
// https://codeberg.org/celenity/Phoenix/issues/93
// NOTE: Unfortunately, for WebAssembly (WASM) to function, either WASM-Baseline (javascript.options.wasm_baselinejit) OR WASM-Ion (javascript.options.wasm_optimizingjit) MUST be enabled. I've chosen to disable WASM-Ion here, as I think that's the safer bet, due to it having a larger attack surface than WASM-Baseline.
pref("javascript.options.baselinejit", false); // Baseline Compiler
pref("javascript.options.ion", false); // WarpMonkey
pref("javascript.options.jithints", false); // Eager baseline hints https://bugzilla.mozilla.org/show_bug.cgi?id=1831572
pref("javascript.options.main_process_disable_jit", true); // [DEFAULT - iOS] Disable all JITs for the (critical/especially sensitive) parent process https://searchfox.org/firefox-main/rev/1c6a8b56/xpcom/build/XPCOMInit.cpp#239 https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#parent-process
pref("javascript.options.native_regexp", false); // irregexp JIT, for regex evaluation https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/StaticPrefList.yaml#8741 https://searchfox.org/firefox-main/rev/dc1c78e9/js/xpconnect/src/XPCJSContext.cpp#901
pref("javascript.options.wasm_optimizingjit", false); // WASM-Ion (BaldrMonkey)

/// Disable JPEG-XL
// https://github.com/mozilla/standards-positions/pull/1064
pref("image.jxl.enabled", false); // [DEFAULT]

/// Disable MathML
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=mathml 
pref("mathml.disabled", true);

/// Disable shared memory allocation from the parent process to content processes
// https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/StaticPrefList.yaml#9130
// https://searchfox.org/firefox-main/rev/dc1c78e9/dom/ipc/ContentParent.cpp#2415
// (For reference, Firefox disables this alongside other JITs in Safe mode: https://searchfox.org/firefox-main/rev/dc1c78e9/js/xpconnect/src/XPCJSContext.cpp#904)
pref("javascript.options.self_hosted.use_shared_memory", false);

/// Disable SharedArrayBuffer using window.postMessage
// https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer
// https://developer.mozilla.org/docs/Web/API/Window/postMessage
// https://blog.mozilla.org/security/2018/01/03/mitigations-landing-new-class-timing-attack/
// https://github.com/tc39/ecma262/issues/1435
// By default, Firefox restricts the use of SharedArrayBuffer - this fully disables it.
pref("dom.postMessage.sharedArrayBuffer.bypassCOOP_COEP.insecure.enabled", false); // [DEFAULT]

/// Disable WebVR/WebXR
// https://developer.mozilla.org/docs/Web/API/WebXR_Device_API
pref("permissions.default.xr", 2); // [HIDDEN - Android/Thunderbird]

/// If JIT (Ion/WarpMonkey) is disabled, also disable it for extensions
// This is the default, but it's hidden - so setting it here lets us expose it...
// https://bugzilla.mozilla.org/show_bug.cgi?id=1599226
pref("javascript.options.jit_trustedprincipals", false); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "014");

/*** 015 PASSWORDS & AUTHENTICATION ***/

/// Allow filling passwords on all websites, even if they try to block it...
// https://bugzilla.mozilla.org/show_bug.cgi?id=956906
// https://blog.0xbadc0de.be/archives/124
pref("signon.storeWhenAutocompleteOff", true); // [DEFAULT]

/// Always display a `reveal password` button in `password` `<input>` types 
// https://developer.mozilla.org/docs/Web/HTML/Element/input/password
pref("layout.forms.reveal-password-button.enabled", true);

/// Crash on insecure password input [OSX-ONLY]
pref("intl.allow-insecure-text-input", false); // [OSX-ONLY] [DEFAULT - non-Firefox release/beta/Debug] https://searchfox.org/firefox-main/rev/93aad2a6615f670b1279c229dd37f7397236131a/modules/libpref/init/all.js#3454

/// Disable Autofill
pref("signon.autofillForms", false);
pref("signon.autofillForms.http", false); // [DEFAULT]

/// Disable Basic authentication over HTTP
// This makes it require secure HTTPS
// https://chromeenterprise.google/policies/#BasicAuthOverHttpEnabled
// https://bugzilla.mozilla.org/show_bug.cgi?id=1763671
pref("network.http.basic_http_auth.enabled", false);

/// Disable formless capture of log-in credentials
// This gets very complicated very fast, and there's very little documentation on this - but TL;DR:
// Firefox's built-in password manager has historically prompted users to save passwords by detecting standard <form> elements and waiting for specific events (ex. `onsubmit`)
// The problem is that not all websites use <form> elements for password fields, meaning Firefox can't always use this standard method.
// So, in order to detect these "formless" password entries (to ask users whether they want to save the password), Firefox uses a heuristic that temporarily monitors & stores user keystrokes...
// Note that with this disabled, Firefox will still show a password icon in the URL bar that allows you to store credentials, this only impacts the actual pop-up (for sites with these "formless" password entires)
// Unfortunately, it appears that Fenix doesn't support showing a password icon in the URL bar like Firefox on desktop does - so we're going to override this (`signon.formlessCapture.enabled`) for Android (but we'll still keep formless capture disabled in private browsing with `signon.privateBrowsingCapture.enabled`, and we still disable the password manager itself by default anyways...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1119035#c2
// https://bugzilla.mozilla.org/show_bug.cgi?id=1166947
// https://bugzilla.mozilla.org/show_bug.cgi?id=1119077#c1
pref("signon.formlessCapture.enabled", false); // [NO-ANDROID]
pref("signon.privateBrowsingCapture.enabled", false);

/// Disable Microsoft SSO
// https://www.microsoft.com/security/business/identity-access/microsoft-entra-single-sign-on
// https://support.mozilla.org/kb/windows-sso
pref("network.http.microsoft-entra-sso.container-enabled.0", false);
pref("network.http.microsoft-entra-sso.enabled", false); // [DEFAULT]
pref("network.http.windows-sso.container-enabled.0", false);
pref("network.http.windows-sso.enabled", false); // [DEFAULT]
pref("network.microsoft-sso-authority-list", ""); // DEFENSE IN DEPTH

/// Disable NTLM
// https://www.silverfort.com/blog/understanding-the-security-risks-of-ntlm/
// https://htmlpreview.github.io/?https://github.com/mdn/archived-content/blob/main/files/en-us/mozilla/integrated_authentication/raw.html
// https://mozilla.github.io/policy-templates/#authentication
pref("network.auth.force-generic-ntlm", false); // [DEFAULT]
pref("network.auth.force-generic-ntlm-v1", false); // [DEFAULT]
pref("network.automatic-ntlm-auth.allow-non-fqdn", false); // [DEFAULT]
pref("network.automatic-ntlm-auth.allow-proxies", false);
pref("network.automatic-ntlm-auth.trusted-uris", ""); // [DEFAULT]

/// Disable NTLM/SPNEGO SSO in Private Browsing
// https://htmlpreview.github.io/?https://github.com/mdn/archived-content/blob/main/files/en-us/mozilla/integrated_authentication/raw.html
// https://mozilla.github.io/policy-templates/#authentication
pref("network.auth.private-browsing-sso", false); // [DEFAULT] [DEFENSE IN DEPTH]

/// Disable Password Manager by default - Insecure & unencrypted
// You should instead use a proper solution (ex. Bitwarden)
// https://www.wired.com/2016/08/browser-password-manager-probably-isnt-enough/
// https://support.mozilla.org/kb/manage-your-logins-firefox-password-manager
// https://wiki.mozilla.org/Firefox/Features/Form_Autofill
pref("extensions.formautofill.addresses.enabled", false);
pref("extensions.formautofill.addresses.supported", "on"); // This feature is currently only exposed in certain regions by default. We set the browser's region to a dummy value ("XX"), so we need to skip that region check and ensure this is always available.
pref("extensions.formautofill.creditCards.enabled", false);
pref("extensions.formautofill.creditCards.supported", "on"); // [DEFAULT]

/// Disable password truncation
// https://www.ghacks.net/2020/05/18/firefox-77-wont-truncate-text-exceeding-max-length-to-address-password-pasting-issues/
pref("editor.truncate_user_pastes", false);

/// Disable SPNEGO
// https://www.ibm.com/think/x-force/critical-remote-code-execution-vulnerability-spnego-extended-negotiation-security-mechanism
// https://htmlpreview.github.io/?https://github.com/mdn/archived-content/blob/main/files/en-us/mozilla/integrated_authentication/raw.html
// https://people.redhat.com/mikeb/negotiate/
// https://mozilla.github.io/policy-templates/#authentication
pref("network.negotiate-auth.allow-non-fqdn", false); // [DEFAULT]
pref("network.negotiate-auth.allow-proxies", false);
pref("network.negotiate-auth.delegation-uris", ""); // [DEFAULT]
pref("network.negotiate-auth.trusted-uris", ""); // [DEFAULT] Modified by ex. RedHat/Fedora


/// Enable anti-spoof confirmation prompts
pref("network.auth.confirmAuth.enabled", true);

/// Enable strong password generation (if the Password Manager is enabled) by default
pref("signon.generation.enabled", true); // [DEFAULT]

/// If the PaymentRequest API is enabled, ensure we always require user interaction...
pref("dom.payments.request.user_interaction_required", true); // [DEFAULT]

/// Prevent cross-origin sub-resources from opening HTTP authentication dialogs to protect against phishing
// (Meaning dialogs for embedded items are only presented when originating from the same site)
// https://support.mozilla.org/questions/1245144
pref("network.auth.subresource-img-cross-origin-http-auth-allow", false); // [DEFAULT - non-Thunderbird]


pref("browser.phoenix.status", "015");

/*** 016 EXTENSIONS ***/

/// Allow enabling/disabling extensions per-container (if containers are enabled)
// This could allow for some extremely useful use-cases...
// Ex. With the Multi-Account Containers extension, you could use this to only allow certain extensions to access certain websites, regardless of the extension's permissions
pref("extensions.userContextIsolation.defaults.restricted", "[]"); // [HIDDEN] [DEFAULT]
pref("extensions.userContextIsolation.enabled", true); // [HIDDEN]

/// Allow certain trustworthy extensions to run on restricted/quarantined domains by default
pref("extensions.quarantineIgnoredByUser.{290ce447-2abb-4d96-8384-7256dd4a1c43}", true); // Runet Censorship Bypass
pref("extensions.quarantineIgnoredByUser.{446900e4-71c2-419f-a6a7-df9c091e268b}", true); // Bitwarden
pref("extensions.quarantineIgnoredByUser.{5d0d1f87-5991-42d3-98c3-54878ead1ed1}", true); // Censor Tracker
pref("extensions.quarantineIgnoredByUser.{6c00218c-707a-4977-84cf-36df1cef310f}", true); // Port Authority
pref("extensions.quarantineIgnoredByUser.{73a6fe31-595d-460b-a920-fcc0f8843232}", true); // NoScript
pref("extensions.quarantineIgnoredByUser.{b86e4813-687a-43e6-ab65-0bde4ab75758}", true); // LocalCDN
pref("extensions.quarantineIgnoredByUser.{d19a89b9-76c1-4a61-bcd4-49e8de916403}", true); // Mullvad
pref("extensions.quarantineIgnoredByUser.78272b6fa58f4a1abaac99321d503a20@proton.me", true); // Proton Pass
pref("extensions.quarantineIgnoredByUser.adguard-vpn@adguard.com", true); // AdGuard VPN
pref("extensions.quarantineIgnoredByUser.adguardadblocker@adguard.com", true); // AdGuard
pref("extensions.quarantineIgnoredByUser.crxviewer-firefox@robwu.nl", true); // Extension source viewer - important since we add AMO (`addons.mozilla.org`) to our restricted/quarantined domain list
pref("extensions.quarantineIgnoredByUser.foxyproxy@eric.h.jung", true); // FoxyProxy
pref("extensions.quarantineIgnoredByUser.foxyproxy-basic@eric.h.jung", true); // FoxyProxy Basic
pref("extensions.quarantineIgnoredByUser.idcac-pub@guus.ninja", true); // I still don't care about cookies
pref("extensions.quarantineIgnoredByUser.jid1-BoFifL9Vbdl2zQ@jetpack", true); // Decentraleyes
pref("extensions.quarantineIgnoredByUser.jid1-KtlZuoiikVfFew@jetpack", true); // GNU LibreJS
pref("extensions.quarantineIgnoredByUser.jid1-MnnxcxisBPnSXQ@jetpack", true); // Privacy Badger
pref("extensions.quarantineIgnoredByUser.jid1-MnnxcxisBPnSXQ-eff@jetpack", true); // Privacy Badger (from eff.org)
pref("extensions.quarantineIgnoredByUser.keepassxc-browser@keepassxc.org", true); // KeePassXC-Browser
pref("extensions.quarantineIgnoredByUser.skipredirect@sblask", true); // Skip Redirect
pref("extensions.quarantineIgnoredByUser.uBlock0@raymondhill.net", true); // uBlock Origin
pref("extensions.quarantineIgnoredByUser.uBOLiteRedux@raymondhill.net", true); // uBlock Origin Lite
pref("extensions.quarantineIgnoredByUser.vpn@proton.ch", true); // Proton VPN
pref("extensions.quarantineIgnoredByUser.@testpilot-containers", true); // Firefox Multi-Account Containers

/// Always allow installing "incompatible" add-ons
// Especially useful on Android & Thunderbird...
pref("extensions.strictCompatibility", false); // [DEFAULT - non-Thunderbird Release/Beta]

/// Always run extensions OOP (out of process...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1613141
// https://bugzilla.mozilla.org/show_bug.cgi?id=1880856
// https://groups.google.com/g/tb-planning/c/p4MUTMNYBVo
pref("extensions.webextensions.remote", true); // [DEFAULT]


/// Clear default list of sites allowed to install add-ons
pref("xpinstall.whitelist.add", "", locked); // [HIDDEN - non-Android] [DEFAULT - non-Android]


/// Disable add-on sideloading
// Only allows installing extensions from profile & application directories (Prevents extensions being installed from the system/via other software)
// https://archive.is/DYjAM
// https://support.mozilla.org/kb/deploying-firefox-with-extensions
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/AddonSettings.sys.mjs#125
pref("extensions.autoDisableScopes", 15); // [DEFAULT - non-Thunderbird] Defense in depth, ensures sideloaded extensions are always disabled by default... (Not locked for desktop because it can be useful in certain instances, ex. for those who use impermanence)
pref("extensions.enabledScopes", 5); // [HIDDEN]
pref("extensions.installDistroAddons", false); // [HIDDEN - non-Android] [DEFAULT - Android]
pref("extensions.sideloadScopes", 0); // [HIDDEN]
pref("extensions.startupScanScopes", 0); // [HIDDEN - Android] [DEFAULT - non-Thunderbird]

/// Disable the AMO Abuse Report API (`navigator.mozAddonManager.reportAbuse`)
// This depends on mozAddonManager anyways, which we disable below
// Users can still report add-ons from within Firefox using the standard form (`extensions.addonAbuseReport.url`), this just prevents using the API from the browser itself directly
// https://mozilla.github.io/addons-server/topics/api/abuse.html
pref("extensions.addonAbuseReport.url", "");

/// Disable arbitrary content script execution for extension (moz-extension) documents by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=2011234
// https://searchfox.org/firefox-main/rev/da6c7924/toolkit/components/extensions/WebExtensionPolicy.cpp#959
// https://searchfox.org/firefox-main/rev/da6c7924/toolkit/components/extensions/WebExtensionPolicy.cpp#999
pref("extensions.webextensions.allow_executeScript_in_moz_extension", false); // [DEFAULT - Nightly]

/// Disable installation of add-ons by default [DESKTOP]
// We also reset this per-session by setting it as a user pref in `phoenix-user-pref.cfg` [DESKTOP]
// Includes extensions and themes
// Does NOT apply to Android's `Recommended` extensions (collections) found at `Settings` -> `Advanced` -> `Extensions`
// This doesn't impact already installed add-ons and add-ons installed by policies
// Firefox (on Desktop) and Thunderbird will prompt to re-enable this when necessary
// Unfortunately Android doesn't have a prompt like this :( - so we won't disable this by default there - but we'll still set the pref to `true` to expose it via the `about:config` 
// We're also setting this as a user pref, which is quite nice from a security perspective - as it allows users to enable this functionality only when it's necessary...
// Ex: A user attempts to install an extension, sees the extra prompt/warning, and selects `Enable` (which temporarily sets this pref to `true`...). The user then proceeds to install the extension. On the next launch of Firefox/Thunderbird, this pref is reset back to `false`, meaning the ability to install extensions is fully disabled without them even thinking about it

/// Disable mozAddonManager
// mozAddonManager has various privacy (fingerprinting) and security (added attack surface) concerns.
// It also bypasses the permission prompt to install add-ons, and prevents add-ons (like uBlock Origin) from working on `addons.mozilla.org` (`addons.thunderbird.net` for Thunderbird).
// Note that disabling mozAddonManager unfortunately breaks installation of extensions from `addons.mozilla.org` on Android. It also typically breaks installation of extensions from `addons.thunderbird.net` on Thunderbird as well, but we have a clever work-around for Dove.
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
// https://github.com/thunderbird/addons-server/issues/332
pref("extensions.webapi.testing", false); // [DEFAULT] Disables mozAddonManager on Mozilla testing domains
pref("extensions.webapi.testing.http", false); // [DEFAULT] Disables mozAddonManager on Mozilla testing domains using insecure protocols

/// Enable Add-on Distribution Control (Install Origins)
// Prevents extensions being installed from websites that they don't specify in their manifest
// https://groups.google.com/g/firefox-dev/c/U7GpHE4R-ZY
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/XPIDatabase.sys.mjs#341
pref("extensions.install_origins.enabled", true);

/// Enable optional permission prompts
// https://bugzilla.mozilla.org/show_bug.cgi?id=1392176
pref("extensions.webextOptionalPermissionPrompts", true); // [DEFAULT]

/// Enable Mozilla's Extension Blocklist
pref("extensions.blocklist.enabled", true); // [DEFAULT]

/// Enable Manifest V3
// https://blog.mozilla.org/addons/2022/05/18/manifest-v3-in-firefox-recap-next-steps/
pref("extensions.manifestV3.enabled", true); // [DEFAULT]

/// Enable restricted/quarantined domains by default, and use our own list instead of Mozilla's
// Mozilla's list unfortunately hasn't been updated in ~2 years (FWIW: Our list includes all of their entries in addition to our own)
// We can use this to prevent less trustworthy add-ons from running on sensitive websites, while still allowing important/legitimate ones and content blockers (like uBlock Origin) to run on them
// Also useful, since we disable Mozilla's restrictions on certain domains that prevent ALL extensions from running on them (like AMO) - so we can add back some level of protection there
// Domains we add here can include downloads for add-ons/software, payment/banking, medical/health, password managers, sign-in pages, file storage, etc.
// Firefox on Desktop also shows a UI when the user is on a restricted domain, and to indicate which add-ons can't run
// https://support.mozilla.org/kb/quarantined-domains
// Mozilla's current list: https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/addons-manager-settings/changeset?_expected=0
pref("extensions.remoteSettings.disabled", true); // [HIDDEN] Used for downloading/updating Mozilla's list https://searchfox.org/firefox-main/source/toolkit/mozapps/extensions/docs/AMRemoteSettings-overview.rst
pref("extensions.quarantinedDomains.enabled", true); // [DEFAULT]
pref("extensions.quarantinedDomains.list", "autoatendimento.bb.com.br,ibpf.sicredi.com.br,ibpj.sicredi.com.br,internetbanking.caixa.gov.br,www.ib12.bradesco.com.br,www2.bancobrasil.com.br,10.0.0.1,192.168.1.1,192.168.50.1,1password.ca,1password.com,1password.eu,365online.com,account.amd.com,account.apple.com,account.asus.com,account.brave.com,account.collegeboard.org,account.live.com,account.microcenter.com,account.microsoft.com,account.nordpass.com,account.proton.me,account.sony.com,account.t-mobile.com,account-api.proton.me,accounts.1password.ca,accounts.1password.com,accounts.1password.eu,accounts.ent.1password.com,accounts.fedoraproject.org,accounts.firefox.com,accounts.google.com,accounts.nintendo.com,accounts.pixiv.net,accounts.scdn.co,accounts.snapchat.com,accounts.spotify.com,acs-home-prod-login-fde-hhd4d2h9drbfg7hy.a02.azurefd.net,addons.allizom.org,addons.mozilla.org,addons.thunderbird.net,admin.google.com,adyen.com,agrd.io,agreementexpress.net,alipay.com,alipayobjects.com,alipayplus.com,amazon.syf.com,amazonpay.in,amp.pandora.com,anz.com,anz.com.au,ap.www.namecheap.com,apay-us.amazon.com,api.pnc.com,api.stripe.com,api-auth.soundcloud.com,app.1password.ca,app.1password.com,app.1password.eu,app.advancedmd.com,app.dashlane.com,app.privacy.com,app.tuta.com,appleconnect.apple.com,appleid.apple.com,appleid.cdn-apple.com,applepay.cdn-apple.com,apply.commonapp.org,apps.apple.com,apps.microsoft.com,apps.obtainium.imranr.dev,api-dashboard.search.brave.com,apt.izzysoft.de,archive.mozilla.org,archlinux.org,argenta.be,artists.soundcloud.com,artists.spotify.com,asrock.com,asrockchina.com.cn,assets.loginwithamazon.com,att-yahoo.att.net,attestation.app,aur.archlinux.org,auth.adguard.io,auth.adguardaccount.com,auth.hulu.com,auth.meta.com,auth.max.com,auth.mozilla.auth0.com,auth.openai.com,auth.services.adobe.com,auth.sharefile.io,auth.synchronybank.com,auth.uber.com,auth.wikimedia.org,auth.zennioptical.com,b.stripecdn.com,bancogalicia.com.ar,bank99.at,bankaust.com.au,bankaustria.at,bankdirekt.at,bankeasy.com,bankofamerica.com,bankofireland.com,bankvic.com.au,belfius.be,belkart.by,belveb.by,bendigobank.com.au,binance.com,binance.us,bisq.network,bitpay.com,bitwarden.com,bkash.com,bnpparibasfortis.be,bobpony.com,braintree-api.com,braintreegateway.com,brave.com,brave-browser-apk-beta.s3.brave.com,brave-browser-apk-nightly.s3.brave.com,brave-browser-apk-release.s3.brave.com,build.opensuse.org,businessaccess.citibank.citigroup.com,businessonline-boi.com,cakepay.com,cakewallet.com,calendar.proton.me,calyxos.org,cardcomplete.com,cash.app,cbaccount.collegeboard.org,cbzsecure.com,cdn.akamai.steamstatic.com,cdn.mullvad.net,cdn.plaid.com,cdn.sso.mozilla.com,cdimage.debian.org,checkout.com,checkout.stripe.com,coinspot.com.au,commbank.com.au,console.accrescent.app,console.aws.amazon.com,console.cloud.google.com,consumer.intel.com,copr.fedorainfracloud.org,creditcall.com,crelan.be,cromite.org,dash.cloudflare.com,developer.apple.com,developer.nvidia.com,discord.gg,dist.torproject.org,dl.google.com,donate.torproject.org,download.cdn.mozilla.net,download.fedoraproject.org,download.gigabyte.com,download.lineageos.org,download.mozilla.org,download-installer.cdn.mozilla.net,download-installer-origin.cdn.mozilla.net,download-origin.cdn.mozilla.net,drive.google.com,drive.proton.me,dsadata.intel.com,easybanking.unifi-digitalbanking.com,easybankint.com,ebanking.easybank.at,eff.org,ente.io,epicmychart.nychhc.org,epicmychart.optum.com,etoro.com,f-droid.org,fdroid.ironfoxoss.org,fdroid.link,fedoraproject.org,flatex.at,flathub.org,flex.okta.com,franciscanmychart.org,franklincollege.okta.com,ftp.eu.mozilla.org,ftp.mozilla.org,ftp.prod.mozaws.net,ftp.prod.mozilla.org,ftp-ssl.mozilla.org,ftp-test.mozilla.org,galicia.ar,gateway.bank,gatewaybank.bank,gatewaybank.com.au,gatewayfirst.com,gds.google.com,geogroup.okta.com,george.sparkasse.at,george-business.sparkasse.at,gfgsa.com,google-admin.corp.google.com,grapheneos.org,greasyfork.org,guardarian.com,heartland.us,heartlandpaymentsystems.com,heartlandportico.com,hellobank.be,hendrick.okta.com,hpc.freedompay.com,hsbc.com,hsbc.com.au,icard.com,id.fedoraproject.org,id.sonyentertainmentnetwork.com,id.spectrum.net,identity.corp.google.com,identity.doordash.com,identity.eset.com,identity.gtm.eset.com,identity.kde.org,identity.lego.com,identity.walmart.com,idmsa.apple.com,idmsa.apple.com.cn,idmsac.apple.com,idp.ddp.akoya.com,idp.iam.mozilla.com,iforgot.apple.com,ing.com,ing.com.au,ingwb.com,iparitet.by,itsme-id.com,js.stripe.com,kairoscope.org,kbc.be,kdrp.okta.com,keytradebank.be,klarna.com,kraken.com,laptop-updates.brave.com,lastpass.com,lineageos.org,login.aa.com,login.advancedmd.com,login.amd.com,login.aol.com,login.corp.google.com,login.disney.com,login.eset.com,login.gov,login.kroger.com,login.live.com,login.mailbox.org,login.microsoftonline.com,login.nvgs.nvidia.com,login.okta.com,login.sparkasse.at,login.tailscale.com,login.wikimedia.org,login.yahoo.com,login.yahoo.net,login.xfinity.com,login-app.advancedmd.com,login-dev.advancedmd.com,login-no1a.www.tiktok.com,login3.id.hp.com,login4.fisglobal.com,lowes.syf.com,m.stripe.com,m.stripe.network,magic.falcon-2-eu.veriff.me,magic.veriff.me,mail.proton.me,mailbox.org,marmon.okta.com,matrix.to,mblogin.verizonwireless.com,mebank.com.au,merchant-ui-api.stripe.com,microg.org,mirrorbits.lineageos.org,linuxmint.com,login.pnc.com,molly.im,monero.com,mpay24.com,msauth.net,msauthimages.net,msdl.gravesoft.dev,msftauth.net,msftauthimages.net,msp.nordpass.com,mt-bank.net,mtb.com,mullvad.net,my.collegeboard.org,my.dish.com,my.disney.com,my.eir.ie,myaccount.google.com,myaccount.microsoft.com,myaccounts.wizards.com,mychart.albanymed.org,mychart.asante.org,mychart.atlantichealth.org,mychart.austinregionalclinic.com,mychart.azacp.com,mychart.bmc.org,mychart.carolinaeasthealth.com,mychart.ccf.org,mychart.centracare.com,mychart.childrenscolorado.org,mychart.clevelandclinic.org,mychart.crmcwy.org,mychart.duly.com,mychart.ecommunity.com,mychart.hopkinsmedicine.org,mychart.inova.org,mychart.kansashealthsystem.com,mychart.lovelace.com,mychart.mainehealth.org,mychart.med.utah.edu,mychart.metrohealth.net,mychart.multicare.org,mychart.mwhc.com,mychart.nghs.com,mychart.nortonhealthcare.org,mychart.ohiohealth.com,mychart.orlandohealth.com,mychart.premierhealthpartners.org,mychart.selfregional.org,mychart.sfdph.org,mychart.sih.net,mychart.stcharleshealthcare.org,mychart.texashealth.org,mychart.tmcaz.com,mychart.uchospitals.edu,mychart.uconn.edu,mychart.uihealthcare.org,mychart.uillinois.edu,mychart.upstate.edu,mychart.urmc.rochester.edu,mychartonline.umassmemorial.org,myhealthchart.com,mysignins.microsoft.com,mysinaichicago.org,mystate.com.au,nab.com.au,nmi.com,nordaccount.com,nordpass.com,nordstrom.okta.com,noscript.net,novantmychart.org,nrc.okta.com,oauth.xfinity.com,oidc.idp.clogin.att.com,ok1static.oktacdn.com,ok2static.oktacdn.com,ok7static.oktacdn.com,okta.jumbo.com,oldsecond.com,onedrive.com,onedrive.live.com,online.citi.com,open-banking.pnc.com,openuserjs.org,outlook.com,outlook.office365.com,ow2-cqm-01.advancedmd.com,panel.nordpass.com,paritetbank.by,pass.proton.me,passwordreset.microsoftonline.com,passwords.google,passwords.google.com,patientportal.advancedmd.com,pay.amazon.co.jp,pay.amazon.co.uk,pay.amazon.com,pay.amazon.de,pay.amazon.es,pay.amazon.eu,pay.amazon.fr,pay.amazon.it,pay.google.com,pay.viasat.com,paybox.com,paybox.com.co,payconiq.be,payeezystrg.z19.web.core.windows.net,payments.amazon.com,payments-amazon.com,payoneer.com,payscout.com,paysend.com,payu.com,paywire.com,play.google.com,plex.direct,portal.corp.google.com,poste.dz,pp-wfe-100.advancedmd.com,ppixiv.org,privacybadger.org,probo.ddp.akoya.com,prod.idp.collegeboard.org,productdelivery.mozilla-backup.org,production.plaid.com,profile.theguardian.com,proton.me,protonapps.com,psendbank.com,qdoba-prod.us.auth0.com,raiffeisen.at,rb.okta.com,register.gitlab.gnome.org,register.mailbox.org,registerdisney.go.com,release.calyxinstitute.org,releases.mozilla.org,renault-bank-direkt.de,renaultbank.es,renaultbank.fr,retoswap.com,revolut.com,rh.okta.com,rpmfusion.org,secure.chase.com,secure.informaction.com,secure.login.gov,secure.myvirtua.org,secure.pnc.com,secure.sndcdn.com,secure.soundcloud.com,secure.verizon.com,secure-api.pnc.com,secure-qa.pnc.com,securelogin.synchronybank.com,secureonline.pnc.com,secureonline.yourstatebank.com,send.vis.ee,signal.org,signin.att.com,signin.aws.amazon.com,signin.costco.com,signin.ebay.com,signin-static-js.att.com,signup.ebay.com,skydrive.com,smartpay.profitstars.com,sso.canvaslms.com,sso.fachschaften.org,sso.kroger.com,sso.mozilla.com,sso.redhat.com,start.1password.ca,start.1password.com,start.1password.eu,static.adguard.com,static.adtidy.org,stgeorge.com.au,store.epicgames.com,store.nintendo.com.hk,studio.youtube.com,tam.onecampus.com,tpeweb.paybox.com,tuta.com,u.bank,ubank.bank,ubank.com.au,ubuntu.com,unbelgin.com,unionpayintl.com,unzer.com,up.com.au,us.download.nvidia.com,usaepay.com,usbank.com,vault.bitwarden.com,vault.bitwarden.eu,venmo.com,verifone.com,viewmychart.com,vpn.proton.me,wallet.google,wallet.google.com,wallet.proton.me,wero-wallet.eu,westpac.co.nz,westpac.com.au,wiki.lineageos.org,wise.com,www.365online.com,www.chase.com,www.citi.com,www.citidirect.com,www.cromite.org,www.dashlane.com,www.debian.org,www.easybank.at,www.easybanking.net,www.eff.org,www.epicgames.com,www.firefox.com,www.franciscanmychart.org,www.gigabyte.com,www.icloud.com,www.icloud.com.cn,www.intel.com,www.lineageos.org,www.linuxmint.com,www.macquarie.com.au,www.mozilla.org,www.mychart.org,www.noscript.net,www.onlinebanking.pnc.com,www.paypal.com,www.paypalobjects.com,www.pnc.com,www.privacy.com,www.privatebank.citibank.com,www.sparkasse.at,www.synchrony.com,www.synchronymastercard.com,www.thunderbird.net,www.torproject.org,www.virustotal.com,www.wintrustbank.com,www.wintrustdigitalbanking.com,www.xmrbazaar.com,www.yourstatebank.com,xmrbazaar.com");
pref("extensions.quarantinedDomains.uiDisabled", false); // [HIDDEN] [DEFAULT] UI

/// Enable userScripts
// userScripts ran this way run in separate isolated sandboxes
// https://wiki.mozilla.org/WebExtensions/UserScripts
// https://bugzilla.mozilla.org/show_bug.cgi?id=1875475
pref("extensions.userScripts.mv3.enabled", true); // [DEFAULT]
pref("extensions.webextensions.userScripts.enabled", true); // [DEFAULT]

/// Ensure Firefox Multi-Account Containers can access all containers by default (if installed)
pref("extensions.userContextIsolation.@testpilot-container.restricted", "[]"); // [HIDDEN]

/// Ensure uBlock Origin can access all containers by default (if installed)
pref("extensions.userContextIsolation.uBlock0@raymondhill.net.restricted", "[]"); // [HIDDEN]

/// Ensure Web Compatibility interventions use the MV3 API instead of the older MV2 one
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/all.js#4118
pref("extensions.webcompat.useScriptingAPI", true); // [DEFAULT]

/// Harden CSP policy
// Compared to Firefox's default, this:
// Blocks scripts unless they're loaded from the same origin
// Blocks unsafe eval() - including WebAssembly (WASM)
// Upgrades network requests to HTTPS
// Etc...
pref("extensions.webextensions.base-content-security-policy", "script-src 'self' 'unsafe-inline'; upgrade-insecure-requests;"); // [NO-ANDROID] `unsafe-inline` is required for Web Compatibility interventions (`about:compat`)
pref("extensions.webextensions.base-content-security-policy.v3", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.base-content-security-policy.v3-with-localhost", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.default-content-security-policy", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.default-content-security-policy.v3", "script-src 'self'; upgrade-insecure-requests;"); // [DEFAULT]

/// Never allow installing extensions without first prompting the user
pref("extensions.postDownloadThirdPartyPrompt", false, locked); // [HIDDEN - Android/Thunderbird] https://github.com/arkenfox/user.js/issues/1090
pref("xpinstall.whitelist.directRequest", false); // [HIDDEN] For direct URL requests https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/XPIInstall.sys.mjs#4488
pref("xpinstall.whitelist.fileRequest", false); // [HIDDEN - non-Android] [DEFAULT - Android] For `file://` requests https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/XPIInstall.sys.mjs#4500
pref("xpinstall.whitelist.required", true, locked); // [DEFAULT] This is the `Warn you when websites try to install add-ons` setting at `about:preferences#privacy`

/// Only allow installation and updates of extensions using Firefox's built-in certificates by default
pref("extensions.install.requireBuiltInCerts", true); // [HIDDEN]
pref("extensions.update.requireBuiltInCerts", true); // [HIDDEN]


/// Prevent automatically granting MV3 extensions optional host permissions by default
// These permissions can still be enabled manually at `about:addons`, from the 'Permissions' tab at the extension's settings page
pref("extensions.originControls.grantByDefault", false);

/// Prevent certain undesired extensions from running on restricted/quarantined domains
// By default, Mozilla allows all add-ons they "recommend" to run on restricted/quarantined domains: https://support.mozilla.org/kb/add-on-badges#w_recommended-extensions
// This prevents some of those add-ons from running on our list of sensitive domains
pref("extensions.quarantineIgnoredByUser.{00000f2a-7cde-4f20-83ed-434fcb420d71}", false); // Imagus
pref("extensions.quarantineIgnoredByUser.{1018e4d6-728f-4b20-ad56-37578a4de76b}", false); // Flagfox
pref("extensions.quarantineIgnoredByUser.{154cddeb-4c8b-4627-a478-c7e5b427ffdf}", false); // PopUpOFF - Popup and overlay blocker
pref("extensions.quarantineIgnoredByUser.{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}", false); // Search by Image
pref("extensions.quarantineIgnoredByUser.{32af1358-428a-446d-873e-5f8eb5f2a72e}", false); // Download All Images
pref("extensions.quarantineIgnoredByUser.{3c078156-979c-498b-8990-85f7987dd929}", false); // Sidebery
pref("extensions.quarantineIgnoredByUser.{4a313247-8330-4a81-948e-b79936516f78}", false); // Image Search Options
pref("extensions.quarantineIgnoredByUser.{506e023c-7f2b-40a3-8066-bc5deb40aebe}", false); // Gesturefy
pref("extensions.quarantineIgnoredByUser.{52bda3fd-dc48-4b3d-a7b9-58af57879f1e}", false); // Stylebot
pref("extensions.quarantineIgnoredByUser.{531906d3-e22f-4a6c-a102-8057b88a1a63}", false); // SingleFile
pref("extensions.quarantineIgnoredByUser.{5384767E-00D9-40E9-B72F-9CC39D655D6F}", false); // EPUBReader
pref("extensions.quarantineIgnoredByUser.{54e2eb33-18eb-46ad-a4e4-1329c29f6e17}", false); // Block Site
pref("extensions.quarantineIgnoredByUser.{63d150c4-394c-4275-bc32-c464e76a891c}", false); // Audio Equalizer
pref("extensions.quarantineIgnoredByUser.{79b2e4de-8fb4-4ccc-b9f6-362ac2fb74b2}", false); // Measure-it
pref("extensions.quarantineIgnoredByUser.{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}", false); // Stylus
pref("extensions.quarantineIgnoredByUser.{7b1bf0b6-a1b9-42b0-b75d-252036438bdc}", false); // YouTube High Definition
pref("extensions.quarantineIgnoredByUser.{91aa5abe-9de4-4347-b7b5-322c38dd9271}", false); // Clippings
pref("extensions.quarantineIgnoredByUser.{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}", false); // User-Agent Switcher and Manager
pref("extensions.quarantineIgnoredByUser.{a9c2ad37-e940-4892-8dce-cd73c6cbbc0c}", false); // Feedbro
pref("extensions.quarantineIgnoredByUser.{b9acf540-acba-11e1-8ccb-001fd0e08bd4}", false); // Easy Youtube Video Downloader Express
pref("extensions.quarantineIgnoredByUser.{b9db16a4-6edc-47ec-a1f4-b86292ed211d}", false); // Video DownloadHelper
pref("extensions.quarantineIgnoredByUser.{c2c003ee-bd69-42a2-b0e9-6f34222cb046}", false); // Auto Tab Discard
pref("extensions.quarantineIgnoredByUser.{c5867acc-54c9-4074-9574-04d8818d53e8}", false); // Livemarks
pref("extensions.quarantineIgnoredByUser.{d07ccf11-c0cd-4938-a265-2a4d6ad01189}", false); // Web Archives
pref("extensions.quarantineIgnoredByUser.{d37dc5d0-431d-44e5-8c91-49419370caa1}", false); // FoxClocks
pref("extensions.quarantineIgnoredByUser.{DDC359D1-844A-42a7-9AA1-88A850A938A8}", false); // DownThemAll!
pref("extensions.quarantineIgnoredByUser.{de22fd49-c9ab-4359-b722-b3febdc3a0b0}", false); // Popup Blocker (strict)
pref("extensions.quarantineIgnoredByUser.{e839c3f9-298e-4cd0-99e0-464431cb7c34}", false); // Foxy Gestures
pref("extensions.quarantineIgnoredByUser.{e90f5de4-8510-4515-9f67-3b6654e1e8c2}", false); // Dictionary Anywhere
pref("extensions.quarantineIgnoredByUser.addon@darkreader.org", false); // Dark Reader
pref("extensions.quarantineIgnoredByUser.adb@mozilla.org", false, locked); // Firefox DevTools ADB Extension
pref("extensions.quarantineIgnoredByUser.ads@mozac.org", false, locked); // Mozilla Android Components - Ads Telemetry
pref("extensions.quarantineIgnoredByUser.ATBC@EasonWong", false); // Adaptive Tab Bar Color
pref("extensions.quarantineIgnoredByUser.cookies@mozac.org", false, locked); // Mozilla Android Components - Search Telemetry
pref("extensions.quarantineIgnoredByUser.copyplaintext@eros.man", false); // Copy PlainText
pref("extensions.quarantineIgnoredByUser.customscrollbars@computerwhiz", false); // Custom Scrollbars
pref("extensions.quarantineIgnoredByUser.dont-track-me-google@robwu.nl", false); // Don't track me Google
pref("extensions.quarantineIgnoredByUser.ddg@search.mozilla.org", false, locked); // DuckDuckGo - search engine
pref("extensions.quarantineIgnoredByUser.deArrow@ajay.app", false); // DeArrow
pref("extensions.quarantineIgnoredByUser.emoji@saveriomorelli.com", false); // Emoji
pref("extensions.quarantineIgnoredByUser.firefox@ghostery.com", false); // Ghostery
pref("extensions.quarantineIgnoredByUser.foxytab@eros.man", false); // Ghostery
pref("extensions.quarantineIgnoredByUser.jid0-dsq67mf5kjjhiiju2dfb6kk8dfw@jetpack", false); // FoxyTab
pref("extensions.quarantineIgnoredByUser.jid1-KdTtiCj6wxVAFA@jetpack", false); // Swift Selection Search
pref("extensions.quarantineIgnoredByUser.jid1-q4sG8pYhq8KGHs@jetpack", false); // AdBlocker for YouTube™
pref("extensions.quarantineIgnoredByUser.jid1-QoFqdK4qzUfGWQ@jetpack", false); // Dark Background and Light Text
pref("extensions.quarantineIgnoredByUser.juraj.masiar@gmail.com_ScrollAnywhere", false); // ScrollAnywhere
pref("extensions.quarantineIgnoredByUser.languagetool-webextension@languagetool.org", false); // LanguageTool
pref("extensions.quarantineIgnoredByUser.leechblockng@proginosko.com", false); // LeechBlock NG
pref("extensions.quarantineIgnoredByUser.linkgopher@oooninja.com", false); // Link Gopher
pref("extensions.quarantineIgnoredByUser.printedit-we@DW-dev", false); // Print Edit WE
pref("extensions.quarantineIgnoredByUser.s3download@statusbar", false); // Download Manager (S3)
pref("extensions.quarantineIgnoredByUser.simple-tab-groups@drive4ik", false); // Simple Tab Groups
pref("extensions.quarantineIgnoredByUser.snaplinks@snaplinks.mozdev.org", false); // Snap Links
pref("extensions.quarantineIgnoredByUser.soundfixer@unrelenting.technology", false); // SoundFixer
pref("extensions.quarantineIgnoredByUser.sponsorBlocker@ajay.app", false); // SponsorBlock
pref("extensions.quarantineIgnoredByUser.stefanvandamme@stefanvd.net", false); // Turn Off the Lights
pref("extensions.quarantineIgnoredByUser.tabby@whatsyouridea.com", false); // Tabby - Window and Tab Manager
pref("extensions.quarantineIgnoredByUser.tranquility@ushnisha.com", false); // Tranquility Reader
pref("extensions.quarantineIgnoredByUser.treestyletab@piro.sakura.ne.jp", false); // Tree Style Tabs
pref("extensions.quarantineIgnoredByUser.wikipedia@search.mozilla.org", false, locked); // Wikipedia (en) - search engine
pref("extensions.quarantineIgnoredByUser.worldwide@radio", false); // Worldwide Radio
pref("extensions.quarantineIgnoredByUser.zoompage-we@DW-dev", false); // Zoom Page WE

/// Prevent certain undesired websites from prompting to install add-ons by default
pref("xpinstall.blacklist.add.GNU", "gnuzilla.gnu.org"); // Mozzarella - Hosts very outdated versions of extensions...

/// Prevent extensions from opening pop-ups to remote websites
// https://bugzilla.mozilla.org/show_bug.cgi?id=1760608
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/extensions/ExtensionActions.sys.mjs#286
pref("extensions.manifestV2.actionsPopupURLRestricted", true); // [DEFAULT - Android]

/// Prevent extensions from opening pop-ups without user interaction
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/extensions/parent/ext-browserAction.js#1071
// https://searchfox.org/firefox-main/rev/82e2435f/mobile/shared/components/extensions/ext-browserAction.js#184
pref("extensions.openPopupWithoutUserGesture.enabled", false); // [DEFAULT - non-Nightly]

/// Prevent extensions from using the Gecko Profiler
// Includes certain Mozilla extensions by default
// https://firefox-source-docs.mozilla.org/tools/profiler/index.html
pref("extensions.geckoProfiler.acceptedExtensionIds", ""); // [HIDDEN - Android] [DEFAULT - Android]


/// Prevent unprivileged extensions from accessing experimental APIs by default
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/extensions/docs/basics.rst#142
pref("extensions.experiments.enabled", false); // [DEFAULT - non-Thunderbird]

/// Prevent hiding extensions [NO-ANDROID]
pref("devtools.aboutdebugging.showHiddenAddons", true, locked); // [NO-ANDROID]

/// Require resources loaded by MV2 extensions to be specified under web_accessible_resources in the extension's manifest
// (This is the default for MV3)
// https://developer.chrome.com/docs/extensions/reference/manifest/web-accessible-resources
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#6013
// https://searchfox.org/firefox-main/rev/82e2435f/caps/nsScriptSecurityManager.cpp#723
pref("extensions.content_web_accessible.enabled", true);

/// Require secure origins to install add-ons
pref("extensions.install.requireSecureOrigin", true); // [HIDDEN]

pref("browser.phoenix.status", "016");

/*** 017 AI ***/

/// Disable all AI functionality by default
pref("browser.ai.control.default", "blocked");
pref("browser.ai.control.linkPreviewKeyPoints", "blocked");
pref("browser.ai.control.pdfjsAltText", "blocked");
pref("browser.ai.control.sidebarChatbot", "blocked");
pref("browser.ai.control.smartTabGroups", "blocked");

/// Allow managing models from `about:addons`
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/ModelHubProvider.sys.mjs#18
pref("extensions.htmlaboutaddons.local_model_management", true); // [DEFAULT]


/// Disable the Firefox "AI" (Local machine learning) Runtime
// https://firefox-source-docs.mozilla.org/toolkit/components/ml/index.html
// Note that, even when this is enabled, we don't actually enable/install any AI models/functionality by default
pref("browser.ml.enable", false);


/// Disable AI/ML Autofill [NO-ANDROID]
// https://searchfox.org/firefox-esr140/source/toolkit/components/formautofill/MLAutofill.sys.mjs [NO-ANDROID]
pref("extensions.formautofill.ml.experiment.enabled", false); // [NO-ANDROID] [ESR]





/// Disable semantic history
// https://searchfox.org/firefox-main/source/toolkit/components/places/PlacesSemanticHistoryManager.sys.mjs
pref("places.semanticHistory.featureGate", false); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Nightly/Dev Firefox Desktop]


/// Disable the WebExtensions AI API
// https://firefox-source-docs.mozilla.org/toolkit/components/ml/extensions.html#webextensions-ai-api
pref("extensions.ml.enabled", false);





pref("browser.phoenix.status", "017");

/*** 018 GEOLOCATION ***/


/// Disable logging network geolocation requests by default
// This is already Firefox's default setting - but setting it here exposes it in the `about:config` since it's hidden
// https://searchfox.org/firefox-main/rev/82e2435f/dom/system/NetworkGeolocationProvider.sys.mjs#18
pref("geo.provider.network.logging.enabled", false); // [HIDDEN] [DEFAULT] 


/// Disable Mozilla's GeoIP/Region Service
// Prevents Firefox from monitoring the user's region/general location
// Note: Firefox will still use different regional search engines based on the browser/system locale (ex. tested with Wikipedia), but this prevents using geolocation
// https://firefox-source-docs.mozilla.org/toolkit/modules/toolkit_modules/Region.html
// https://searchfox.org/firefox-main/source/toolkit/modules/Region.sys.mjs
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16254
pref("browser.region.local-geocoding", false); // [HIDDEN] [DEFAULT]
pref("browser.region.network.scan", false); // [DEFAULT] [DEFENSE IN DEPTH] Disable Wi-Fi scanning for these requests
pref("browser.region.network.url", "");
pref("browser.region.update.enabled", false);
pref("browser.search.region", "XX"); // [HIDDEN]
pref("doh-rollout.home-region", "XX"); // [HIDDEN]

/// Do not force the use of the network geolocation provider by default
// When either of these preferences are set to `true`, Firefox will ALWAYS use the network geolocation provider (BeaconDB in our case), instead of OS geolocation providers
// We're just setting these here to expose via the `about:config`
// https://searchfox.org/firefox-main/rev/82e2435f/dom/geolocation/Geolocation.cpp#774
// https://searchfox.org/firefox-main/rev/82e2435f/dom/geolocation/Geolocation.cpp#778
pref("geo.provider.testing", false); // [HIDDEN] [DEFAULT]
pref("geo.provider.use_mls", false); // [HIDDEN] [DEFAULT]



/// Enable network request cache for the network geolocation provider by default
// This is already Firefox's default setting - but setting it here exposes it in the `about:config` since it's hidden
// https://searchfox.org/firefox-main/rev/82e2435f/dom/system/NetworkGeolocationProvider.sys.mjs#69
pref("geo.provider.network.debug.requestCache.enabled", true); // [HIDDEN] [DEFAULT]


/// Set BeaconDB as the default network geolocation provider
// Default is Google :/
// https://searchfox.org/firefox-main/rev/82e2435f/dom/system/NetworkGeolocationProvider.sys.mjs#341
pref("geo.provider.network.url", "https://api.beacondb.net/v1/geolocate");


pref("browser.phoenix.status", "018");

/*** 019 PDF.js ***/

/// Disable Automatic Alt Text by default
// This is generated by a local machine learning model
// Setting these ensures that the inference model is only downloaded if the user opts in (by enabling the toggle to "Create alt text automatically" from "Image alt text settings" when viewing a PDF)
// https://support.mozilla.org/kb/pdf-alt-text#w_add-alt-text-automatically
// https://hacks.mozilla.org/2024/05/experimenting-with-local-alt-text-generation-in-firefox-nightly/
pref("pdfjs.enableAltTextModelDownload", false);
pref("pdfjs.enableGuessAltText", false);

/// Disable automatic hyperlinks
// By default, PDF.js automatically creates hyperlinks for URLs - and clicking on or attempting to select a Hyperlink immediately navigates the user to the link, without warning or prior indication
// So this prevents that - but users can still easily select and navigate to links if desired
pref("pdfjs.enableAutoLinking", false);

/// Disable JavaScript
pref("pdfjs.enableScripting", false);

/// Disable XFA
// Not even a standard...
// https://learn.microsoft.com/deployedge/microsoft-edge-policies#viewxfapdfiniemodeallowedorigins
// https://insert-script.blogspot.com/2019/01/adobe-reader-pdf-callback-via-xslt.html
// https://www.sentinelone.com/blog/malicious-pdfs-revealing-techniques-behind-attacks/
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=xfa
// https://wikipedia.org/wiki/XFA
// https://deepwiki.com/mozilla/pdfjs-dist/6.2-advanced-configuration#security-considerations
pref("pdfjs.enableXfa", false);

/// Enable the ability to add signatures
pref("pdfjs.enableSignatureEditor", true);

/// Enable Alt Text creation
// This does NOT enable "Automatic Alt Text", we disable that separately above
// https://support.mozilla.org/kb/pdf-alt-text
pref("pdfjs.enableAltText", true);
pref("pdfjs.enableAltTextForEnglish", true);
pref("pdfjs.enableNewAltTextWhenAddingImage", true); // [DEFAULT] Enables the Alt Text Editor after adding an image
pref("pdfjs.enableUpdatedAddImage", true); // [DEFAULT]

/// Enable hardware acceleration by default
// This should help improve performance, which is especially notable for us since we disable JIT
pref("pdfjs.enableHWA", true);

/// Enable optimized partial rendering by default
// In my testing, this appears to make a *significant* performance improvement
// https://github.com/mozilla/pdf.js/blob/010e52e15db0cb534774cdf92e20c03bcd13d735/web/pdf_page_view.js#L93
pref("pdfjs.enableOptimizedPartialRendering", true);

/// Enforce using the internal font renderer
// This disable the CSS Font Loading API
// https://mozilla.github.io/pdf.js/api/draft/module-pdfjsLib.html
// https://developer.mozilla.org/docs/Web/API/CSS_Font_Loading_API
pref("pdfjs.disableFontFace", true);

/// Ensure users can select and interact with text
pref("pdfjs.textLayerMode", 1); // [DEFAULT]

/// Force PDFs to be downloaded/viewed locally, and prompt before opening the PDF Viewer
// So by default, if Firefox encounters a PDF file, it'll just automatically open it in most cases, and will load them from remote origins
// But thanks to the "Handlers" policy on Desktop (https://mozilla.github.io/policy-templates/#handlers), we force Firefox to prompt users before opening the file - and additionally, with the `browser.download.start_downloads_in_tmp_dir` & `browser.helperApps.deleteTempFileOnExit` prefs, when the users chooses to "Open" the PDF, it downloads the PDF to a temporary directory and loads it locally (from a `file://` URL), instead of from remote origins like the normal behavior
// This is also beneficial because it also allows users to effectively disable PDF.js (via the `browser.helperApps.showOpenOptionForPdfJS` pref), without being fingerprintable (like is the case with the standard `pdfjs.disabled` pref)
// The pref below are to further ensure we don't automatically open PDFs, and that we don't try to fetch anything remotely
// As a bonus, these likely also improve performance in many cases...
// https://deepwiki.com/mozilla/pdfjs-dist/6.2-advanced-configuration#network-options
// https://deepwiki.com/mozilla/pdfjs-dist/6.2-advanced-configuration#performance-optimization-configurations
// (For testing: https://emk.name/test/bug1790641.html)
pref("browser.download.open_pdf_attachments_inline", false); // [DEFAULT - non-Android] https://bugzilla.mozilla.org/show_bug.cgi?id=1772569
pref("pdfjs.disableRange", true);
pref("pdfjs.disableStream", true);

/// Never allow documents to prevent copying text
pref("pdfjs.enablePermissions", false); // [DEFAULT]

/// Open external links in new tabs/windows
// https://github.com/mozilla/pdf.js/blob/master/extensions/chromium/preferences_schema.json
pref("pdfjs.externalLinkTarget", 2);

/// Prevent attempting to load/convert unknown binary files
// https://developer.mozilla.org/docs/Web/HTTP/Guides/MIME_types#applicationoctet-stream
pref("pdfjs.handleOctetStream", false);

/// Show sidebar by default when viewing PDFs
pref("pdfjs.sidebarViewOnLoad", 2);

/// Update URL when changing pages [NO-ANDROID]
// ex. Typically, if I load "https://example.invalid/example.pdf", and navigate to Page 27, the URL stays the same as "https://example.invalid/example.pdf" [NO-ANDROID]
// When this is set to "true", if I loaded "https://example.invalid/example.pdf", and navigated to Page 27, the URL would instead update to "https://example.invalid/example.pdf#page=27" [NO-ANDROID]
// So this is an incredibly useful feature that allows easy bookmarking/sharing of PDFs, keeping track of what you've read, etc. [NO-ANDROID]
// (We also still nuke browsing history by default on exit) [NO-ANDROID]
// This currently doesn't seem to work properly on Android [NO-ANDROID]
pref("pdfjs.historyUpdateUrl", true); // [NO-ANDROID]

pref("browser.phoenix.status", "019");

/*** 020 SAFE BROWSING ***/

/// By default, when you report a Safe Browsing false positive, it sends the URL to both Mozilla and Google (NOT PROXIED), as well as your locale to Mozilla
// (ex. https://en-us.phish-error.mozilla.com/?url=example.org - which redirects directly to https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=example.org)
// We can improve privacy and speed by sending the domain *only* to Google & without sending your locale to anyone
// We could also potentially strip tpl=mozilla which tells Google the request is from Firefox - though it looks like there is a different page for Firefox users with a better privacy policy, so we will leave it for now
// Unclear whether 'MalwareMistake' is used, but we can set it anyways
pref("browser.safebrowsing.provider.google.reportMalwareMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google.reportPhishMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google4.reportMalwareMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google4.reportPhishMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google5.reportMalwareMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google5.reportPhishMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");

//// Similar behavior also appears to happen when you report a URL to Safe Browsing
pref("browser.safebrowsing.reportPhishURL", "https://safebrowsing.google.com/safebrowsing/report_phish/?tpl=mozilla&url=");

/// Disable the legacy (v2.2) Safe Browsing API
// https://code.google.com/archive/p/google-safe-browsing/wikis/Protocolv2Spec.wiki
// Has been nonfunctional since October 2018
// https://security.googleblog.com/2018/01/announcing-turndown-of-deprecated.html
// Let's make sure it's not used for defense in depth (and attack surface reduction...)
pref("browser.safebrowsing.provider.google.advisoryName", "Google Safe Browsing (Legacy)"); // Label it so it's clearly distinguishable if it is ever enabled for whatever reason...
pref("browser.safebrowsing.provider.google.lists", "disabled");
pref("browser.safebrowsing.provider.google.lists.default", "goog-badbinurl-shavar,goog-downloadwhite-digest256,goog-phish-shavar,googpub-phish-shavar,goog-malware-shavar,goog-unwanted-shavar"); // [HIDDEN] This pref does nothing, just makes it easier for users to re-enable this Safe Browsing provider if desired by copying and pasting the value of this pref as the value for `browser.safebrowsing.provider.google.lists`

/// Enable an additional plug-in blocklist from Mozilla
pref("urlclassifier.blockedTable", "moztest-block-simple,mozplugin-block-digest256"); // [DEFAULT - Nightly]

/// Enable the Potentially Harmful Application list (when Safe Browsing is enabled)
// This contains threats that are specific to Mobile/Android (of the `POTENTIALLY_HARMFUL_APPLICATION` type)
// Firefox on non-Android devices will just silently ignore/disregard this list
// https://bugzilla.mozilla.org/show_bug.cgi?id=1980046
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/nsUrlClassifierUtils.cpp#176
// https://developers.google.com/safe-browsing/reference/Local.Database
pref("urlclassifier.malwareTable", "goog-malware-proto,goog-unwanted-proto,moztest-harmful-simple,moztest-malware-simple,moztest-unwanted-simple,goog-harmful-proto");

/// Enable Safe Browsing by default
// This won't do anything if you don't have an API key from Google, though doesn't hurt...
// Harmless from a privacy perspective due to the below changes, also effective at preventing real-time malicious domains and downloads.
// We will of course **ALWAYS** give users the ability to disable.
// https://searchfox.org/firefox-main/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.blockedURIs.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.downloads.enabled", true); // [DEFAULT - non-Android]
pref("browser.safebrowsing.id", "navclient-auto-ffox"); // [DEFAULT - Official] Ensure we use Mozilla's ID
pref("browser.safebrowsing.malware.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.phishing.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.provider.google5.enabled", true); // [DEFAULT - Nightly]
pref("browser.safebrowsing.provider.mozilla.gethashURL", "https://shavar.services.mozilla.com/gethash?client=navclient-auto-ffox&appver=%MAJOR_VERSION%&pver=2.2"); // Ensure we always use Mozilla's official ID
pref("browser.safebrowsing.update.enabled", true); // [HIDDEN] [DEFAULT] Also covers Mozilla's tracking protection lists
pref("urlclassifier.downloadAllowTable", "goog-downloadwhite-proto"); // [DEFAULT - non-Android]
pref("urlclassifier.downloadBlockTable", "goog-badbinurl-proto"); // [DEFAULT - non-Android]
pref("urlclassifier.enabled_mode", 3); // [DEFAULT] Ensure we enable classification for ETP and Safe Browsing https://searchfox.org/firefox-main/rev/4dad4a9a/netwerk/base/nsNetUtil.cpp#3332 https://searchfox.org/firefox-main/rev/ac83682a/modules/libpref/init/StaticPrefList.yaml#18483
pref("urlclassifier.phishTable", "goog-phish-proto,moztest-phish-simple"); // [DEFAULT - Official] Ensure we're using Google's full/private phishing list https://bugzilla.mozilla.org/show_bug.cgi?id=1288840

/// Ensure users can override Safe Browsing warnings by default
pref("browser.safebrowsing.allowOverride", true); // [DEFAULT]

/// Prevent sending metadata of downloaded files to Safe Browsing providers
// NOTE: If this is enabled, we proxy this (via the `browser.safebrowsing.downloads.remote.url` pref)
// https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work#w_how-does-phishing-and-malware-protection-work-in-firefox
// https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/
pref("browser.safebrowsing.downloads.remote.enabled", false);

/// Prevent sharing data/telemetry with Safe Browsing providers
// https://searchfox.org/mozilla-central/source/netwerk/url-classifier/nsChannelClassifier.cpp#364
// https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/nsUrlClassifierDBService.cpp#1964
// https://bugzilla.mozilla.org/show_bug.cgi?id=1351147
// (Known providers taken from here: https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/nsUrlClassifierUtils.cpp#444)
pref("browser.safebrowsing.provider.google.dataSharing.enabled", false, locked); // [HIDDEN - non-Android] [DEFAULT]
pref("browser.safebrowsing.provider.google.dataSharingURL", "", locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.google4.dataSharing.enabled", false, locked); // [DEFAULT]
pref("browser.safebrowsing.provider.google4.dataSharingURL", "", locked);
pref("browser.safebrowsing.provider.google5.dataSharing.enabled", false, locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.google5.dataSharingURL", "", locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.mozilla.dataSharing.enabled", false, locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.mozilla.dataSharingURL", "", locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.test.dataSharing.enabled", false, locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.test.dataSharingURL", "", locked); // [HIDDEN] [DEFAULT]

/// Proxy Safe Browsing
// This sets up a new Safe Browsing "provider", using the servers we've set up for IronFox, hosted on our Cloudflare storage bucket (in EU jurisdiction)
pref("browser.safebrowsing.downloads.remote.url", "https://safebrowsing.ironfoxoss.org/safebrowsing/clientreport/download?key=%GOOGLE_SAFEBROWSING_API_KEY%");
pref("browser.safebrowsing.provider.google4.advisoryName", "Google Safe Browsing (Proxied by IronFox) - v4");
pref("browser.safebrowsing.provider.google4.gethashURL", "https://safebrowsing.ironfoxoss.org/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
pref("browser.safebrowsing.provider.google4.nextupdatetime", "1"); // [HIDDEN]
pref("browser.safebrowsing.provider.google4.updateURL", "https://safebrowsing.ironfoxoss.org/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
pref("browser.safebrowsing.provider.google5.advisoryName", "Google Safe Browsing (Proxied by IronFox) - v5");
pref("browser.safebrowsing.provider.google5.gethashURL", "https://safebrowsing.ironfoxoss.org/v5/hashes:search?key=%GOOGLE_SAFEBROWSING_API_KEY%");
pref("browser.safebrowsing.provider.google5.nextupdatetime", "1"); // [HIDDEN]
pref("browser.safebrowsing.provider.google5.updateURL", "https://safebrowsing.ironfoxoss.org/v5/hashLists:batchGet?key=%GOOGLE_SAFEBROWSING_API_KEY%");


/// Unbreak Google's download protection and legacy Safe Browsing provider (if enabled via the `browser.safebrowsing.provider.google.lists` pref)
//  Some (ex. LibreWolf) override these for no reason
pref("browser.safebrowsing.provider.google.gethashURL", "https://safebrowsing.google.com/safebrowsing/gethash?client=navclient-auto-ffox&appver=%MAJOR_VERSION%&pver=2.2"); // [DEFAULT]
pref("browser.safebrowsing.provider.google.updateURL", "https://safebrowsing.google.com/safebrowsing/downloads?client=navclient-auto-ffox&appver=%MAJOR_VERSION%&pver=2.2&key=%GOOGLE_SAFEBROWSING_API_KEY%"); // [DEFAULT]

/// Unclear whether these are actually used or not, but looks like Firefox has some kind of functionality to view a "report" from Safe Browsing about the safety, history, and general status of a site
// By default, it unnecessarily redirects from ex. https://safebrowsing.google.com/safebrowsing/diagnostic?site=example.org to https://transparencyreport.google.com/safe-browsing/search?url=example.org
// We can skip the redirect to improve performance
pref("browser.safebrowsing.provider.google.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");
pref("browser.safebrowsing.provider.google4.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");
pref("browser.safebrowsing.provider.google5.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");

pref("browser.phoenix.status", "020");

/*** 021 MISC. PRIVACY + SECURITY ***/

/// Disable Accessibility Services
// PRIVACY: Can be used to monitor users by design
// SECURITY: Can be easily abused by bad actors, Attack Surface Reduction
// "Firefox Accessibility Service is a technology built into Firefox that provides 3rd party applications running on the same device the ability to inspect, monitor, visualize, and alter web page content hosted within Firefox."
// We need to ensure we're still accomodating for impaired users, but I feel this is something that must be handled by the browser instead of external software
// https://web.archive.org/web/20240608190300/support.mozilla.org/en-US/kb/accessibility-services
// Values are -1 always on. 1 always off, 0 (default) is auto as some platform perform further checks.
// This pref is checked only once, and the browser needs a restart to pick up any changes.
pref("accessibility.force_disabled", 1);
pref("devtools.accessibility.enabled", false); // [NO-ANDROID] - Disables the Accessibility Inspector/context menu item by default - https://firefox-source-docs.mozilla.org/devtools-user/accessibility_inspector/

/// Disable automatic updates for OpenSearch engines
// PRIVACY: Unsolicited connections to search providers
// SECURITY: Could be abused to alter a user's search engine(s) without consent
// Doesn't appear to impact Mozilla's built-in search engines
// https://firefox-source-docs.mozilla.org/toolkit/search/Preferences.html#hidden
// https://developer.mozilla.org/docs/Web/XML/Guides/OpenSearch#supporting_automatic_updates_for_opensearch_plugins
pref("browser.search.update", false); // [DEFAULT - Android]

/// Disable Battery API (Navigator.getBattery)
// PRIVACY: Fingerprinting concerns, just plain creepy...
// SECURITY: Attack Surface Reduction
// NOTE: This only impacts chrome/certain privileged code; this is thankfully never exposed to websites
// I'm still not convinced that there's a legitimate use/need for this functionality though...
// https://developer.mozilla.org/docs/Web/API/Battery_Status_API
// https://developer.mozilla.org/docs/Web/API/Navigator/getBattery
// https://bugzilla.mozilla.org/show_bug.cgi?id=1313580
pref("dom.battery.enabled", false);

/// Disable Beacon API (Navigator.sendBeacon)
// PRIVACY: Used for analytics/tracking by design, see explanation below
// SECURITY: Attack Surface Reduction
// I was originally against disabling this, but after careful consideration, I've changed my position.
// The explicit, stated purpose/use case of this API is for analytics/tracking.
// Websites *can* obtain the data shared from this API through other means; though the other ways to obtain it are more disruptive and less reliable.
// Analytics/tracking is also evidently not a use case that we, as the user agent, should support or assist with.
// I don't see a justification for adding APIs/features to support this hostile behavior. We are the user agent and must act in the best interest of users...
// Also disabled by ex. Cromite: https://github.com/uazo/cromite/blob/master/docs/FEATURES.md https://github.com/uazo/cromite/issues/1454
// https://developer.mozilla.org/docs/Web/API/Beacon_API
// https://developer.mozilla.org/docs/Web/API/Navigator/sendBeacon
// https://udn.realityripple.com/docs/Web/API/Navigator/sendBeacon
// https://w3c.github.io/beacon/#privacy-and-security
// https://bugzilla.mozilla.org/show_bug.cgi?id=1454252
pref("beacon.enabled", false);

/// Disable Clipboard API
// PRIVACY: Fingerprinting concerns, prevents monitoring users' clipboards without their consent
// SECURITY: Prevents leaking sensitive information (ex. passwords), Attack Surface Reduction
// NOTE: This only impacts extensions; this is thankfully never exposed to websites
// I'm still not convinced extensions need or should have access to this data though (While there are currently other ways for extensions to access clipboard data, those are deprecated and will presumably not be around for much longer)
// https://developer.mozilla.org/docs/Web/API/Clipboard
pref("dom.events.testing.asyncClipboard", false, locked); // [DEFAULT]

/// Disable Content Analysis SDK
// PRIVACY: Used for monitoring users by design
// SECURITY: Can be easily abused by bad actors, Attack Surface Reduction
// DESKTOP: We also set "ContentAnalysis" in policies
// https://mozilla.github.io/policy-templates/#contentanalysis
// https://github.com/chromium/content_analysis_sdk
pref("browser.contentanalysis.default_result", 0, locked); // [DEFAULT]
pref("browser.contentanalysis.enabled", false, locked); // [DEFAULT]
pref("browser.contentanalysis.interception_point.clipboard.enabled", false, locked);
pref("browser.contentanalysis.interception_point.drag_and_drop.enabled", false, locked);
pref("browser.contentanalysis.interception_point.file_upload.enabled", false, locked);
pref("browser.contentanalysis.interception_point.print.enabled", false, locked);
pref("browser.contentanalysis.max_connections", 0, locked); // Sets maximum number of allowed connections to 0
pref("browser.contentanalysis.show_blocked_result", true, locked); // [DEFAULT] - Always notify users when Content Analysis blocks access to something...
pref("browser.contentanalysis.silent_notifications", false, locked); // [DEFAULT] If Content Analysis is enabled, ensure notifications aren't silenced so that users are fully aware

/// Disable Federated Credential Management (FedCM) API
// PRIVACY: Provides support for "identity federation services"/third party sign-in - which can be used for tracking by design
// SECURITY: Attack Surface Reduction
// https://developer.mozilla.org/docs/Web/API/FedCM_API
// https://w3c-fedid.github.io/FedCM/
pref("dom.security.credentialmanagement.identity.enabled", false); // [DEFAULT - non-Nightly]
pref("dom.security.credentialmanagement.identity.heavyweight.enabled", false); // [DEFAULT - non-Nightly]
pref("dom.security.credentialmanagement.identity.lightweight.enabled", false); // [DEFAULT]


/// Disable Native Messaging
// This functionality is used to allow browser extensions to communicate with external apps/programs
// Naturally, this raises various privacy and security concerns
// https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions/Native_messaging
// https://developer.chrome.com/docs/extensions/develop/concepts/native-messaging
// https://searchfox.org/firefox-main/rev/af0f713f/toolkit/components/extensions/NativeMessaging.sys.mjs#12
pref("webextensions.native-messaging.max-input-message-bytes", 0); // [HIDDEN] [DEFAULT: 1048576]
pref("webextensions.native-messaging.max-output-message-bytes", 0); // [HIDDEN] [DEFAULT: -1, but, to override: set to 2147483647]

/// Disable Reporting API
// PRIVACY: Fingerprinting concerns, used for analytics by design
// SECURITY: Attack Surface Reduction
// https://w3c.github.io/reporting/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1492036
pref("dom.reporting.crash.enabled", false); // [DEFAULT]
pref("dom.reporting.enabled", false); // [DEFAULT]
pref("dom.reporting.featurePolicy.enabled", false); // [DEFAULT]
pref("dom.reporting.header.enabled", false); // [DEFAULT]
pref("dom.reporting.testing.enabled", false); // [DEFAULT]


/// Disable Web Share API
// This API allows websites to share data directly to system applications...
// PRIVACY: Could result in leakage/unexpected behavior
// SECURITY: "The data passed to {{Navigator/share()}} might be used to exploit buffer overflow or other remote code execution vulnerabilities in the [=share target=] that receive shares. There is no general way to guard against this, but implementors will want to be aware that it is a possibility (particularly when sharing files).", Attack Surface Reduction
// https://developer.mozilla.org/docs/Web/API/Web_Share_API
pref("dom.webshare.enabled", false); // [DEFAULT - non-Android/non-Nightly Windows]
pref("dom.webshare.requireinteraction", true); // [DEFAULT] If enabled, ensure we always require interaction...

/// Disable WebGPU
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// https://gpuweb.github.io/gpuweb/#privacy-considerations
// https://gpuweb.github.io/gpuweb/#security-considerations
// https://browserleaks.com/webgpu
pref("dom.webgpu.enabled", false); // [DEFAULT - non-Windows/non-Silicon-OSX/non-Nightly]

/// Disable WebMIDI
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// See "Privacy Considerations" & "Security Considerations": https://webaudio.github.io/web-midi-api
// Toggling 'dom.webmidi.enabled' itself could be fingerprintable, but setting these instead just causes the permission to be automatically denied at a random interval
// https://searchfox.org/firefox-main/rev/82e2435f/dom/midi/MIDIPermissionRequest.cpp#120
// Test: https://permission.site/
pref("dom.sitepermsaddon-provider.enabled", false); // [DEFAULT - non-Android]
pref("dom.webmidi.gated", true); // [DEFAULT]
pref("permissions.default.midi", 2); // [HIDDEN]
pref("permissions.default.midi-sysex", 2); // [HIDDEN]

/// Disable the Windows UI Automation API
// Similar privacy and security concerns as with Accessibility Services (accessibility.force_disabled) above
// https://wikipedia.org/wiki/Microsoft_UI_Automation 
// https://searchfox.org/firefox-main/rev/87a1e2a5/modules/libpref/init/StaticPrefList.yaml#298
// 0: Never.
// 1: Always.
// 2: Enable unless incompatible accessibility clients are detected. (default)
pref("accessibility.uia.enable", 0); // [Windows]

/// Enable Local Network Access Restrictions
// https://wicg.github.io/local-network-access/
// https://searchfox.org/firefox-main/rev/7f33a0cc/netwerk/protocol/http/nsHttpTransaction.cpp#3735
// NOTE: `network.localhost.prompt.testing.allow` is used when `network.localhost.prompt.testing` is set to `true`, same applies for `network.localnetwork.prompt.testing.allow` and  `network.localnetwork.prompt.testing`
// when `network.localhost.prompt.testing`/`network.localnetwork.prompt.testing.allow` are set to false, the site permissions are followed like normal instead
pref("network.lna.allow_top_level_navigation", false); // Enforce LNA for top-level document navigation https://searchfox.org/firefox-main/rev/8e6b6cb1/modules/libpref/init/StaticPrefList.yaml#14619
pref("network.lna.benchmarking-is-local", true); // Enable LNA for IP addresses in the 192.18.X.X range https://searchfox.org/firefox-main/rev/28328852/modules/libpref/init/StaticPrefList.yaml#14678
pref("network.lna.block_trackers", true); // https://searchfox.org/firefox-main/rev/7f33a0cc/modules/libpref/init/StaticPrefList.yaml#14469
pref("network.lna.enabled", true); // [DEFAULT]
pref("network.lna.etp.enabled", false); // [DEFAULT] Enable LNA, regardless of ETP/ETP Strict https://searchfox.org/firefox-main/rev/7f33a0cc/browser/components/protections/ContentBlockingPrefs.sys.mjs#265
pref("network.lna.local-network-to-localhost.skip-checks", false); // Enforce LNA for requests from local network to your device https://searchfox.org/firefox-main/rev/8e6b6cb1/modules/libpref/init/StaticPrefList.yaml#14641
pref("network.lna.websocket.enabled", true); // Enforce LNA for WebSocket connections https://searchfox.org/firefox-main/rev/7f33a0cc/modules/libpref/init/StaticPrefList.yaml#14490
pref("permissions.default.local-network", 2); // [NO-ANDROID] Blocks websites from prompting to access the local network by default - 0: Always ask, 1: Allow, 2: Block
pref("permissions.default.localhost", 0); // [NO-ANDROID] [DEFAULT] Blocks websites from prompting to access apps and services (outside of the browser) on your device - 0: Always ask, 1: Allow, 2: Block

/// Enable Messaging Layer Security (MLS)
// PRIVACY: Ensures messages are only received by the intended recipient
// SECURITY: Protects the authenticity and integrity of messages
// Security layer for E2EE messaging
// https://wikipedia.org/wiki/Messaging_Layer_Security
// https://blog.mozilla.org/mozilla/messaging-layer-security-is-now-an-internet-standard/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1876002
pref("dom.origin-trials.mls.state", 1);

/// Prevent exposing XPCOM Components.interfaces to websites
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// (For reference, this is also set by ex. Tor Browser)
// https://bugzilla.mozilla.org/show_bug.cgi?id=429070
// https://devdoc.net/web/developer.mozilla.org/en-US/docs/Components.interfaces.html
pref("dom.use_components_shim", false); // [DEFAULT - Nightly]


pref("browser.phoenix.status", "021");

/*** 022 MISC. PRIVACY ***/

/// Block ports currently known to be abused by Android apps for tracking/fingerprinting
// Previously blocked by default on Android - and assuming they don't cause issues, I'd also like to keep these blocked for other platforms (for defense in depth and in case this method of tracking is also being used elsewhere...)
// https://localmess.github.io/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1970141
pref("network.security.ports.banned", "29009, 29010, 30102, 30103, 12387, 12388, 12580, 12581, 12582, 12583, 12584, 12585, 12586, 12587, 12588, 12589, 12590, 12591");

/// Disable CSP reporting
// Fingerprinting concerns, Used for analytics by design
// Also reduces unsolicited network activity and bandwidth consumption
// Glad we managed to convince Mozilla to add this :)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1964249
pref("security.csp.reporting.enabled", false);

/// Disable Hyperlink Auditing (Click Tracking)
// https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/
// https://searchfox.org/firefox-main/rev/82e2435f/docshell/base/nsPingListener.cpp#32
pref("browser.send_pings", false); // [DEFAULT]
pref("browser.send_pings.max_per_link", 1); // [DEFAULT] Ensure max number of pings are limited to 1 if Hyperlink Auditing is enabled
pref("browser.send_pings.require_same_host", true); // [DEFENSE IN DEPTH]

/// Disable Network Error Logging
// Fingerprinting concerns, Used for analytics by design
// https://developer.mozilla.org/docs/Web/HTTP/Network_Error_Logging
// https://w3c.github.io/network-error-logging/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1145235
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#13696
pref("network.http.network_error_logging.enabled", false); // [DEFAULT]

/// Disable online speech recognition
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/webspeech/recognition/OnlineSpeechRecognitionService.cpp#41
// https://searchfox.org/firefox-main/source/dom/media/webspeech/recognition/SpeechRecognition.cpp
pref("media.webspeech.service.endpoint", "data;"); // [HIDDEN]

/// Disable referers when leaving .onion domains
// NOTE: Please use TOR BROWSER for accessing .onion domains...
pref("network.http.referer.hideOnionSource", true); // [DEFAULT]

/// Disable storage access heuristics
// https://developer.mozilla.org/docs/Web/Privacy/State_Partitioning#storage_access_heuristics
pref("dom.storage_access.auto_grants", false); // Automatic storage access grants
pref("privacy.restrict3rdpartystorage.heuristic.navigation", false); // [DEFAULT - Android] 
pref("privacy.restrict3rdpartystorage.heuristic.opened_window_after_interaction", false);
pref("privacy.restrict3rdpartystorage.heuristic.recently_visited", false); // [DEFAULT - non-Android]
pref("privacy.restrict3rdpartystorage.heuristic.redirect", false); // [DEFAULT]
pref("privacy.restrict3rdpartystorage.heuristic.window_open", false); // [DEFAULT]
pref("privacy.restrict3rdpartystorage.heuristic.recently_visited_time", 0);

/// Disable TLS session identifiers
// Fingerprinting/tracking concerns
// Especially important for Android, where users likely leave the app open (and by extension: keep their browsing session active) for days at a time, much longer than on Desktop
// Even on Desktop, this can be used as a vector to detect whether Private Browsing is active: https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/44187
// For reference, this is also disabled by ex. Cromite
// https://arxiv.org/abs/1810.07304
pref("security.ssl.disable_session_identifiers", true);

/// Enable Containers
// https://support.mozilla.org/kb/how-use-firefox-containers
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/contextualidentity/ContextualIdentityService.sys.mjs#9
pref("privacy.userContext.enabled", true); // [HIDDEN - Android] [DEFAULT - Firefox Desktop Nightly]

/// Enable Cookie Banner Reduction
// https://support.mozilla.org/kb/cookie-banner-reduction
pref("cookiebanners.bannerClicking.enabled", true); // [DEFAULT]
pref("cookiebanners.cookieInjector.enabled", true); // [DEFAULT]
pref("cookiebanners.service.mode", 1);
pref("cookiebanners.service.mode.privateBrowsing", 1);
pref("cookiebanners.service.enableGlobalRules", true); // [DEFAULT]
pref("cookiebanners.service.enableGlobalRules.subFrames", true); // [DEFAULT]

/// Enable Cookies Having Independent Partitioned State (CHIPS)
// This allows websites to set cookies with a 'Partitioned' attribute, meaning they're limited in scope
// We still use ETP Strict for partioning anyways, so this could be useful as a defense in depth if a user decides to allow a specific domain (or domains) to access a third party cookie
// https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies
// https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#partitioned
// https://github.com/privacycg/CHIPS
pref("network.cookie.CHIPS.enabled", true); // [DEFAULT]
pref("network.cookie.chips.partitionLimitDryRun", false); // [DEFAULT]

/// Enable Do Not Track & Global Privacy Control
// Do Not Track is also covered by ETP Strict, pref to be removed soon...
pref("privacy.donottrackheader.enabled", true);
pref("privacy.globalprivacycontrol.enabled", true);
pref("privacy.globalprivacycontrol.functionality.enabled", true); // [DEFAULT - non-Thunderbird]
pref("privacy.globalprivacycontrol.pbmode.enabled", true); // [DEFAULT - non-Thunderbird]




/// Exclude third party trackers from storage access heuristics (if enabled)
// https://developer.mozilla.org/docs/Web/Privacy/State_Partitioning#storage_access_heuristics
pref("dom.storage_access.auto_grants.exclude_third_party_trackers", true); // [DEFAULT] Automatic storage access grants
pref("privacy.restrict3rdpartystorage.heuristic.exclude_third_party_trackers", true); // [DEFAULT]

/// Improve built-in query stripping to be on par with LibreWolf and Brave
// See Mozilla's defaults here: https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/query-stripping/changeset?_expected=0
// https://github.com/brave/brave-core/blob/9ce48443963b47716b73b643335aab67d9a6c664/components/query_filter/utils.cc#L26
pref("privacy.query_stripping.strip_list", "__hsfp __hssc __hstc __s _bhlid _branch_match_id _branch_referrer _gl _hsenc _kx _openstat at_recipient_id at_recipient_list bbeml bsft_clkid bsft_uid dclid et_rid fb_action_ids fb_comment_id fbclid gbraid gclid guce_referrer guce_referrer_sig hsCtaTracking igshid irclickid mc_eid mkt_tok ml_subscriber ml_subscriber_hash msclkid mtm_cid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id pk_cid rb_clickid s_cid sc_customer sc_eh sc_uid sms_click sms_source sms_uph srsltid ss_email_id syclid ttclid twclid unicorn_click_id vero_conv vero_id vgo_ee wbraid wickedid yclid ymclid ysclid");

//// Unbreak urldefense.com redirects
/// (ex. https://urldefense.com/v3/__https://www.portainer.io/hs/preferences-center/en/direct?data=W2nXS-N30h-M1W45lXqV2nFX8ZW3SzKNq3gnnN0W4cQh6C1Bnn1kW1VjfB24fr2-BW4mm3dy3T2wkqW2MWfBj49z9PPW4mqs512qWTfrW4px5K71Nn7N2W32DKbz1V7s-qW21bSln2KWpS4W1SdHmq2YwgS9W3P8RNt2r6W8pW49QSSt1_tcPsW3GSrf749CfyJW2PPdX33JPrgmW4hcHf84hm-NmW2FS2pd2sMKL-W2YGYkz43RS-9W4pjpV52t0rxlW3SB_f94psLW2W3_Sm6w2FGVTjW3K2-cG4fzZLWW2qDSdB3bzPyBW3j8X_q2PMxWzW36CtK22MvcXrW4hNdFB3DLWP3W3VMWNy3SYMyvW1Vs-MC43NZJNW4hLsTd2B1T2JW2sB9wk3DMh2mW2D0QS-2t04tYW43Cpv42Tz6SwW32rgcB3_SfvDW4mq1yB36nnnkW3BNLQw2YfSH9W49sKsP3z4zKPW3zd1YL1Zm6S3W4kmj3Z2sQ7WVW36xkSD2RSm5hW1Q0SqC30sK9ZW2-kSbQ2nH5KcW36fNc_2RjGNjW36pblN43qsbhW2CCNvJ3_SL29W1_sQHx4fqK9NW3Sy1cb4mpD3h0&utm_campaign=XNF&utm_source=hs_automation&utm_medium=email&utm_content=264158909&_hsenc=p2ANqtz--9JvIgI266aB1UVizENwYNYREZSotsXOhWcMNeKjZLJO9ZwmR9xlyfsQN2orbT25IymZ_vKUNTANMKQMVQBnzowi2339ExVoOKMJaHx0t2yn5esgg&_hsmi=264158909__;!!MlclJBHn!0eDf-zTf69h-IhFT9WDu2GIXAtCy6RENwguPVpTF1k2K-Nbnzy1NXix2Gj7azc8yDFyI2z3Tz4nTFuGe2hlLzsBl$)
/// https://github.com/brave/brave-browser/issues/41134
pref("privacy.query_stripping.allow_list", "urldefense.com");

/// Isolate permissions per container (if containers are enabled)
// https://support.mozilla.org/kb/how-use-firefox-containers
pref("permissions.isolateBy.userContext", true);

/// Isolate resources (ex. referrers and cookies) injected by extensions
// (ex. https://searchfox.org/mozilla-central/source/toolkit/components/extensions/test/xpcshell/test_ext_contentscript_antitracking.js)
pref("privacy.antitracking.isolateContentScriptResources", true); // [DEFAULT - Nightly]

/// Limit maximum cookie lifetime to 6 months/180 days (Like Brave)
// Firefox's default is currently 400 days (34560000)
// https://github.com/brave/brave-browser/issues/3443
// https://github.com/fmarier/brave-core/commit/4d222df50a8dfaaabb31e9f2c5070c4db5ba8fd5
// For testing: https://setcookie.net/
pref("network.cookie.maxageCap", 15552000);


/// Prevent sharing identifying information if a remote AutoConfig is being used
// https://searchfox.org/firefox-main/rev/82e2435f/extensions/pref/autoconfig/src/nsAutoConfig.cpp#213
pref("autoadmin.append_emailaddr", false, locked); // [HIDDEN] [DEFAULT]

/// Prevent third parties from setting cookies unless the third party already has cookies as a first party (Like Safari)
// https://webkit.org/tracking-prevention/#the-default-cookie-policy
// https://bugzilla.mozilla.org/show_bug.cgi?id=1587182
pref("privacy.dynamic_firstparty.limitForeign", true);

/// Restrict tracking referers
// 0=no-referrer, 1=same-origin, 2=strict-origin-when-cross-origin (default),
// 3=no-referrer-when-downgrade.
// Setting to 1 currently breaks various functionality https://codeberg.org/celenity/Phoenix/pulls/228#issuecomment-10051167
pref("network.http.referer.defaultPolicy.trackers", 2); // [DEFAULT]
pref("network.http.referer.defaultPolicy.trackers.pbmode", 2); // [DEFAULT]

/// Strip tracking parameters from URLs when shared by default
pref("privacy.query_stripping.strip_on_share.enabled", true); // [DEFAULT - non-Android/Thunderbird]

/// Trim cross-origin referers (Like Safari)
// https://wiki.mozilla.org/Security/Referrer
pref("network.http.referer.XOriginTrimmingPolicy", 2);

pref("browser.phoenix.status", "022");

/*** 023 MISC. SECURITY ***/

/// Always prompt users for a certificate when websites request one, rather than automatically selecting one...
// https://www.stigviewer.com/stig/mozilla_firefox/2023-06-05/finding/V-251547
pref("security.default_personal_cert", "Ask Every Time", locked); // [DEFAULT]

/// Apply CSP to internal browser.xhtml
pref("security.browser_xhtml_csp.enabled", true); // [DEFAULT]
pref("security.browser_xhtml_csp.report-only", false); // [NO-ANDROID] [ESR]

/// Block privileged `about:` pages from loading remote scripts
// https://searchfox.org/firefox-main/rev/82e2435f/dom/security/nsContentSecurityManager.cpp#1102
pref("security.disallow_privilegedabout_remote_script_loads", true);

/// Configure protocol handling
// This can get very confusing, very fast - so here's a basic explanation:
// If a protocol is "exposed", it can be opened/used by the browser in all contexts
// If a protocol is "external", it can not be opened/used by the browser directly, and the protocol will instead open in an external application
// If a protocol is "external" and set to "warn-external", the user will be warned/prompted before the protocol is opened in an external application
// By default, Firefox on Desktop "exposes" ALL protocols (network.protocol-handler.expose-all), and allows ALL protocols to be opened externally (network.protocol-handler.external-default) - though it does require prompting before all of them (network.protocol-handler.warn-external-default), except for `mailto:` (network.protocol-handler.external.mailto), and it does manually block several protocols from being opened externally
// Android is similar, except, in addition to `mailto`, it also disables prompting before opening `sms`, `tel`, and YouTube
// https://bugzilla.mozilla.org/show_bug.cgi?id=819554
// https://bugzilla.mozilla.org/show_bug.cgi?id=589403
// https://bugzilla.mozilla.org/show_bug.cgi?id=630364
// Instead of "exposing" all protocols, we can reduce attack surface by limiting them to only the ones we actually need/use/want
// We can also ensure that the user is always warned before opening a protocol externally, and we can block protocols ourselves if desired
pref("network.protocol-handler.expose.about", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.blob", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.chrome", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.data", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.file", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.http", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.https", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.javascript", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.moz-extension", true); // [DEFAULT - Thunderbird] [HIDDEN - non-Thunderbird]
pref("network.protocol-handler.expose.resource", true); // [HIDDEN]
pref("network.protocol-handler.expose-all", false); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.external.about", false); // [HIDDEN]
pref("network.protocol-handler.external.afp", false); // [DEFAULT]
pref("network.protocol-handler.external.bankid", true); // [HIDDEN] Ensure we do not try to handle BankID authentication internally...
pref("network.protocol-handler.external.blob", false); // [HIDDEN]
pref("network.protocol-handler.external.chrome", false); // [HIDDEN]
pref("network.protocol-handler.external.data", false); // [DEFAULT]
pref("network.protocol-handler.external.disk", false); // [DEFAULT]
pref("network.protocol-handler.external.disks", false); // [DEFAULT]
pref("network.protocol-handler.external.hcp", false); // [DEFAULT]
pref("network.protocol-handler.external.help", false); // [HIDDEN - non-macOS] [DEFAULT - macOS]
pref("network.protocol-handler.external.htp", false); // [DEFAULT]
pref("network.protocol-handler.external.htps", false); // [DEFAULT]
pref("network.protocol-handler.external.ie.http", false); // [DEFAULT]
pref("network.protocol-handler.external.iehistory", false); // [DEFAULT]
pref("network.protocol-handler.external.ierss", false); // [DEFAULT]
pref("network.protocol-handler.external.ile", false); // [DEFAULT]
pref("network.protocol-handler.external.javascript", false); // [DEFAULT]
pref("network.protocol-handler.external.le", false); // [DEFAULT]
pref("network.protocol-handler.external.mk", false); // [DEFAULT]
pref("network.protocol-handler.external.moz", false); // [HIDDEN]
pref("network.protocol-handler.external.moz-extension", false); // [HIDDEN]
pref("network.protocol-handler.external.moz-icon", false); // [DEFAULT]
pref("network.protocol-handler.external.moz-sbrs", false); // [HIDDEN]
pref("network.protocol-handler.external.ms-cxh", false); // [DEFAULT]
pref("network.protocol-handler.external.ms-cxh-full", false); // [DEFAULT]
pref("network.protocol-handler.external.ms-help", false); // [DEFAULT]
pref("network.protocol-handler.external.ms-msdt", false); // [DEFAULT]
pref("network.protocol-handler.external.obtainium", true); // [HIDDEN] Ensure we do not try to handle Obtainium app installation internally...
pref("network.protocol-handler.external.ps", false); // [DEFAULT]
pref("network.protocol-handler.external.res", false); // [DEFAULT]
pref("network.protocol-handler.external.resource", false); // [HIDDEN]
pref("network.protocol-handler.external.search", false); // [DEFAULT]
pref("network.protocol-handler.external.search-ms", false); // [DEFAULT]
pref("network.protocol-handler.external.shell", false, locked); // [DEFAULT] Never expose shell access https://www.stigviewer.com/stig/mozilla_firefox/2019-12-12/finding/V-15771
pref("network.protocol-handler.external.tel", true); // [HIDDEN] Ensure we do not try to handle tel (Phone) links internally...
pref("network.protocol-handler.external.tps", false); // [DEFAULT]
pref("network.protocol-handler.external.ttp", false); // [DEFAULT]
pref("network.protocol-handler.external.ttps", false); // [DEFAULT]
pref("network.protocol-handler.external.vbscript", false); // [DEFAULT]
pref("network.protocol-handler.external.view-source", false); // [HIDDEN]
pref("network.protocol-handler.external.vnd.ms.radio", false); // [DEFAULT]
pref("network.protocol-handler.warn-external.file", true); // [DEFAULT - non-Android]
pref("network.protocol-handler.warn-external.ftp", true); // [HIDDEN - non-Thunderbird] [DEFAULT - non-Thunderbird]
pref("network.protocol-handler.warn-external.mailto", true); // [HIDDEN - Thunderbird] [DEFAULT - non-Android/Firefox Desktop]
pref("network.protocol-handler.warn-external.shell", true, locked); // [HIDDEN] [DEFAULT]
pref("network.protocol-handler.warn-external.sms", true); // [HIDDEN - non-Android] [DEFAULT - non-Android]
pref("network.protocol-handler.warn-external.tel", true); // [HIDDEN - non-Android] [DEFAULT - non-Android]
pref("network.protocol-handler.warn-external.vnd.youtube", true); // [HIDDEN - non-Android] [DEFAULT - non-Android]
pref("network.protocol-handler.warn-external-default", true); // [DEFAULT]

/// Decrease the lifetime of extension processes
// https://bugzilla.mozilla.org/show_bug.cgi?id=1847608
pref("dom.ipc.keepProcessesAlive.extension", 0); // [HIDDEN - non-Android] [DEFAULT - non-Android]

/// Decrease the lifetime of privileged processes for `about:` pages
pref("dom.ipc.keepProcessesAlive.privilegedabout", 0);

/// Decrease the lifetime of web content processes
// https://bugzilla.mozilla.org/show_bug.cgi?id=1447393
pref("dom.ipc.keepProcessesAlive.web", 0); // [HIDDEN - non-Android] [DEFAULT - non-Android]


/// Disable Navigator Media Objects & getUserMedia Support in insecure contexts
// https://developer.mozilla.org/docs/Web/API/Navigator/mediaDevices
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#12475
pref("media.devices.insecure.enabled", false); // [DEFAULT]
pref("media.getusermedia.insecure.enabled", false); // [DEFAULT]


/// Do not allow additional ports by default
// This is just to expose the preference via the `about:config`
pref("network.security.ports.banned.override", ""); // [HIDDEN] [DEFAULT]



/// Enable content process sandboxing [NO-ANDROID]
// These are especially useful for ex. Thunderbird, which seems to disable sandboxing by default... [NO-ANDROID]
// Sandboxing is obviously critical from a security perspective as well, so doesn't hurt IMO to explicitly enable here [NO-ANDROID]
pref("security.sandbox.content.level", 3); // [OSX-ONLY] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#1567

/// Enable the Cross-Origin-Embedder Policy Header
// https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Cross-Origin-Embedder-Policy
pref("browser.tabs.remote.coep.credentialless", true); // [DEFAULT - non-Android stable] 'credentialless' 
pref("browser.tabs.remote.useCrossOriginEmbedderPolicy", true); // [DEFAULT]
pref("dom.origin-trials.coep-credentialless.state", 1); // 'credentialless' 

/// Enable the Cross-Origin-Opener Policy Header
// https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Cross-Origin-Opener-Policy
pref("browser.tabs.remote.useCrossOriginOpenerPolicy", true); // [DEFAULT]

/// Enable GPU Sandboxing
// https://www.ghacks.net/2023/01/17/firefox-110-will-launch-with-gpu-sandboxing-on-windows/
// https://searchfox.org/firefox-main/rev/82e2435f/security/sandbox/win/src/sandboxbroker/sandboxBroker.cpp#1293
// https://searchfox.org/firefox-main/rev/82e2435f/security/sandbox/chromium/sandbox/win/src/security_level.h#38
// For macOS, any level >= 1 enables the sandbox and setting a higher level has no effect. (default 1)
pref("security.sandbox.gpu.level", 2); // [1 = USER_RESTRICTED_NON_ADMIN (Default: Windows), 2 = USER_LIMITED (Stricter)]

/// Enable the Integrity-Policy header
// https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Integrity-Policy
pref("security.integrity_policy.enabled", true); // [DEFAULT]
pref("security.integrity_policy.stylesheet.enabled", true); // [DEFAULT]

/// Enable Opaque Response Blocking
// https://github.com/annevk/orb
pref("browser.opaqueResponseBlocking", true); // [DEFAULT - non-Android]
pref("browser.opaqueResponseBlocking.javascriptValidator", true); // [DEFAULT]

/// Enable Origin-keyed agent clustering by default (Like Chromium)
// https://chromeenterprise.google/policies/#OriginAgentClusterDefaultEnabled
// https://developer.chrome.com/blog/immutable-document-domain/
pref("dom.origin_agent_cluster.default", true);
pref("dom.origin_agent_cluster.enabled", true); // [DEFAULT]

/// Enforce Per-site Process Isolation + isolate all websites
// https://wiki.mozilla.org/Project_Fission
pref("browser.sessionstore.disable_platform_collection", false); // [DEFAULT - non-Thunderbird]
pref("fission.autostart", true); // [DEFAULT]
pref("fission.autostart.session", true); // [DEFAULT]
pref("fission.disableSessionHistoryInParent", false); // [DEFAULT] SHIP, required for Fission
pref("fission.highValue.login.monitor", true); // [DEFAULT - Android] Ensure that we are always marking log-in attempts as "high value", even if Fission is disabled - for if/when users decide to enable it later https://searchfox.org/firefox-main/rev/d88792ab/dom/ipc/LoginDetectionService.cpp#64
pref("fission.webContentIsolationStrategy", 1); // [DEFAULT] Isolate everything https://searchfox.org/firefox-main/rev/d88792ab/dom/ipc/ProcessIsolation.cpp#50
pref("gfx.webrender.all", true);

/// Enable the Sanitizer API
// https://github.com/WICG/sanitizer-api
pref("dom.security.sanitizer.enabled", true); // [DEFAULT]


/// Enable socket process sandboxing
// https://bugzilla.mozilla.org/show_bug.cgi?id=1608558
pref("security.sandbox.socket.process.level", 2); // [DEFAULT - Linux, non-Thunderbird]

/// Enable Spectre mitigations for isolated content
// Also enabled by ex. Tor Browser
pref("javascript.options.spectre.disable_for_isolated_content", false);

/// Enable Trusted Types
// https://developer.mozilla.org/docs/Web/API/Trusted_Types_API
pref("dom.security.trusted_types.enabled", true); // [DEFAULT]

/// Enable WebAssembly Memory Control
// https://github.com/WebAssembly/memory-control/blob/main/proposals/memory-control/Overview.md
pref("javascript.options.wasm_memory_control", true);

/// Enforce strict file:// Origin Policy
// https://stuffandnonsense.co.uk/blog/firefoxs_file_uri_origin_policy_and_web_fonts
// https://stackoverflow.com/questions/2856502/css-font-face-not-working-with-firefox-but-working-with-chrome-and-ie
pref("security.fileuri.strict_origin_policy", true); // [DEFAULT]

/// Enforce various important security-related prefs
pref("dom.block_external_protocol_in_iframes", true); // [DEFAULT]
pref("dom.block_external_protocol_navigation_from_sandbox", true); // [DEFAULT] [ESR]
pref("security.all_resource_uri_content_accessible", false); // [DEFAULT]
pref("security.allow_eval_in_parent_process", false); // [DEFAULT - non-Android/Thunderbird]
pref("security.allow_eval_with_system_principal", false); // [DEFAULT - non-Android]
pref("security.allow_parent_unrestricted_js_loads", false); // [DEFAULT - non-Android/Thunderbird]
pref("security.allow_unsafe_parent_loads", false); // [DEFAULT]
pref("security.data_uri.block_toplevel_data_uri_navigations", true); // [DEFAULT]

/// Ensure we block old/obsolete libavcodec libraries
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/platforms/ffmpeg/FFmpegLibWrapper.cpp#61
pref("media.libavcodec.allow-obsolete", false); // [DEFAULT]

/// If WebGL is enabled, force it to be loaded out of process
pref("webgl.out-of-process", true); // [DEFAULT]
pref("webgl.out-of-process.force", true);
pref("webgl.out-of-process.worker", true); // [DEFAULT]


/// Never skip the assertion that about:pages don't have content security policies (CSP)
// This is default on Standard Firefox releases, but not on ex. Thunderbird & other builds
pref("dom.security.skip_about_page_has_csp_assert", false); // [DEFAULT - non-Thunderbird]

/// Prefer to create new content processes, instead of re-using existing ones
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#2034
pref("browser.tabs.remote.subframesPreferUsed", false);

/// Prevent marking JIT code pages as both writable and executable, only one or the other...
// Might cause issues in certain specific set-ups
// https://bugzilla.mozilla.org/show_bug.cgi?id=1876632
pref("javascript.options.content_process_write_protect_code", true); // [DEFAULT - OpenBSD?]

/// Prevent AutoConfig files (if being used) from gaining privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/
// https://searchfox.org/firefox-main/rev/82e2435f/extensions/pref/autoconfig/src/nsReadConfig.cpp#148
pref("general.config.sandbox_enabled", true, locked); // [HIDDEN] [DEFAULT - Release/Beta]

/// Prevent remoteTypes from triggering process switches they shouldn't be able to...
// https://searchfox.org/firefox-main/rev/82e2435f/dom/ipc/ContentParent.cpp#5535
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/all.js#1917
pref("browser.tabs.remote.enforceRemoteTypeRestrictions", true); // [DEFAULT - Nightly Desktop]

/// Protect against CSRF Attacks (Like Chromium)
// https://groups.google.com/a/mozilla.org/g/dev-platform/c/6PZtLH7c6JQ
// https://hacks.mozilla.org/2020/08/changes-to-samesite-cookie-behavior/
// https://web.dev/articles/samesite-cookies-explained
// https://help.salesforce.com/s/articleView?id=000389944&type=1
// https://portswigger.net/web-security/csrf/bypassing-samesite-restrictions
// https://web.dev/articles/schemeful-samesite
pref("network.cookie.sameSite.laxByDefault", true);
pref("network.cookie.sameSite.noneRequiresSecure", true); // [DEFAULT]
pref("network.cookie.sameSite.schemeful", true); // [DEFAULT - Nightly]

/// Protect against MIME Exploits
// https://www.pcmag.com/encyclopedia/term/mime-exploit
pref("dom.workers.importScripts.enforceStrictMimeType", true); // [DEFAULT] [ESR]
pref("network.sniff.use_extension", true); // Sniff content types based on file extensions (Default only does this for `file://` URLs)
pref("security.block_fileuri_script_with_wrong_mime", true);
pref("security.block_Worker_with_wrong_mime", true); // [DEFAULT]

/// Sandbox AudioIPC (cubeb)
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#11215
pref("media.cubeb.sandbox", true); // [DEFAULT]

/// Use a separate content process for `file://` URLs
pref("browser.tabs.remote.separateFileUriProcess", true); // [DEFAULT - non-Android]


/// Yes, this is a real pref... 
// https://searchfox.org/firefox-main/rev/82e2435f/js/xpconnect/src/nsXPConnect.cpp#1167
pref("security.turn_off_all_security_so_that_viruses_can_take_over_this_computer", false, locked); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "023");

/*** 024 MISC. ***/

/// Block pop-ups by default
pref("dom.disable_open_during_load", true); // [DEFAULT - non-Thunderbird]


/// Disable Captive Portal Detection & Connectivity Checks
// Privacy & security concerns, and in general best handled by the OS.
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_network-detection
// https://www.eff.org/deeplinks/2017/08/how-captive-portals-interfere-wireless-security-and-privacy
pref("captivedetect.canonicalURL", "");
pref("network.captive-portal-service.enabled", false); // [DEFAULT - Android/Thunderbird]
pref("network.connectivity-service.DNSv4.domain", "");
pref("network.connectivity-service.DNSv6.domain", "");
pref("network.connectivity-service.enabled", false);
pref("network.connectivity-service.IPv4.url", "");
pref("network.connectivity-service.IPv6.url", "");
pref("network.trr.wait-for-portal", false); // [DEFAULT] Do not wait for captive portal to enable DoH https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#14839


/// Disable network connectivity status monitoring
// (Ex. used for automatically switching between offline & online mode)
// https://bugzilla.mozilla.org/show_bug.cgi?id=620472
pref("network.manage-offline-status", false);
pref("network.offline-mirrors-connectivity", false); // [DEFAULT]

/// Disable network requests to 0.0.0.0
// Appears to mitigate a (potentially severe?) privacy/security issue, but bug is confidential so I'm unable to find actual details...
// This is also being set by Tor Browser
// https://bugzilla.mozilla.org/show_bug.cgi?id=1889130
pref("network.socket.ip_addr_any.disabled", true); // [DEFAULT]

/// Disable WebVTT Testing Events
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/webvtt/HTMLTrackElement.cpp#530
pref("media.webvtt.testing.events", false); // [DEFAULT]

/// Enable Firefox's newer 'Felt privacy' design for Certificate Errors
pref("security.certerrors.felt-privacy-v1", true); // [HIDDEN - Android/Thunderbird]


/// Enable GREASE (Generate Random Extensions And Sustain Extensibility)
// This indirectly improves security for users, by ensuring that future TLS extensions/implementations are properly supported by websites
// For reference, this is enabled/always enforced by Chromium
// https://groups.google.com/a/chromium.org/g/security-dev/c/d_f6higCJzc
pref("security.tls.ech.disable_grease_on_fallback", false); // [DEFAULT]
pref("security.tls.ech.grease_http3", true); // [DEFAULT]
pref("security.tls.ech.grease_probability", 100); // [DEFAULT] Sets probability of using GREASE for ECH to 100%
pref("security.tls.grease_http3_enable", true);

/// Enable more detailed property error messages
pref("javascript.options.property_error_message_fix", true); // [DEFAULT]

/// Ensure that holding shift bypasses context menu events
// (When holding shift, this prevents websites from hijacking the right click/context menu)
// https://developer.mozilla.org/docs/Web/API/Element/contextmenu_event
pref("dom.event.contextmenu.shift_suppresses_event", true); // [DEFAULT]

/// Force pop-up windows to open in new tabs instead
pref("browser.link.open_newwindow", 3); // [DEFAULT]
pref("browser.link.open_newwindow.restriction", 0); // [DEFAULT - Android/Thunderbird]

/// Limit what events can cause pop-ups
pref("dom.popup_allowed_events", "click dblclick");



/// Prevent Safe Mode from automatically starting by default
// This causes ex. all extensions (such as uBlock Origin) to be disabled
// Users can still manually start Safe Mode from the command line if needed
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2142
pref("toolkit.startup.max_resumed_crashes", -1); // [HIDDEN - non-Firefox Desktop]

/// Prevent scripts from moving, resizing, and messing with windows
pref("dom.allow_scripts_to_close_windows", false); // [DEFAULT]
pref("dom.disable_window_flip", true); // [DEFAULT - non-Android]
pref("dom.disable_window_move_resize", true); // [DEFAULT - Android]

/// Prevent websites from automatically refreshing
pref("browser.meta_refresh_when_inactive.disabled", true); // [DEFAULT - Android]


/// Show an error page/details instead of a blank page for HTTP responses with certain error codes (ex. 4xx, 5xx, & Content-Length: 0)
// ex. https://ozuma.sakura.ne.jp/httpstatus/400
pref("browser.http.blank_page_with_error_response.enabled", false); // [DEFAULT - non-Android]


pref("browser.phoenix.status", "024");

/*** 025 DEBUGGING ***/

/// Allow inspecting the browser chrome by default
pref("devtools.chrome.enabled", true); // [DEFAULT - Thunderbird]

/// Allow inspecting the DOM by default [NO-ANDROID]
pref("devtools.dom.enabled", true); // [NO-ANDROID]

/// Allow inspecting/debugging local tabs from `about:debugging` by default [NO-ANDROID]
// Useful, especially for Thunderbird, as it gives us a URL bar... [NO-ANDROID]
// On Thunderbird, you can use it by navigating to `Tools` -> `Developer Tools` -> `Debug Add-ons` (`about:debugging`), and choosing `Inspect` next to any tab... [NO-ANDROID]
pref("devtools.aboutdebugging.local-tab-debugging", true); // [NO-ANDROID] [DEFAULT - non-MOZILLA_OFFICIAL builds]

/// Allow inspecting/debugging processes from `about:debugging` by default [NO-ANDROID]
pref("devtools.aboutdebugging.process-debugging", true); // [NO-ANDROID] [DEFAULT]

/// Always prompt before connecting to Remote Debugging...
pref("devtools.debugger.prompt-connection", true, locked); // [DEFAULT - non-Nightly]

/// "Beautify" HTML content upon copy to the clipboard by default [NO-ANDROID]
pref("devtools.markup.beautifyOnCopy", true); // [NO-ANDROID]

/// Disable annoying "A simpler highlighter can be enabled in the settings..." banner when using developer tools [NO-ANDROID]
pref("devtools.inspector.simple-highlighters.message-dismissed", true); // [NO-ANDROID] [HIDDEN]

/// Disable annoying "Firefox Profiler is now integrated into Developer Tools" banner when opening the performance panel [NO-ANDROID]
pref("devtools.performance.new-panel-onboarding", false); // [NO-ANDROID] [HIDDEN]

/// Disable automatic bracket/quote closing by default [NO-ANDROID]
pref("devtools.editor.autoclosebrackets", false); // [NO-ANDROID]

/// Disable editor onboarding [NO-ANDROID]
pref("devtools.webconsole.input.editorOnboarding", false); // [NO-ANDROID]

/// Disable JS dump()
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/all.js#602
pref("browser.dom.window.dump.enabled", false); // [DEFAULT - non-Android, desktop `MOZILLA_OFFICIAL` builds]

/// Disable network monitoring by default [NO-ANDROID]
pref("devtools.browserconsole.enableNetworkMonitoring", false); // [NO-ANDROID] [DEFAULT]

/// Disable pausing on debugger statements by default [NO-ANDROID]
pref("devtools.debugger.pause-on-debugger-statement", false); // [NO-ANDROID]

/// Disable the performance panel intro [NO-ANDROID]
pref("devtools.performance.popup.intro-displayed", true); // [NO-ANDROID]

/// Disable Remote Debugging by default
// We also reset this per-session by setting it as a user pref in `phoenix-user-pref.cfg`
// https://firefox-source-docs.mozilla.org/devtools/backend/protocol.html
pref("devtools.debugger.remote-enabled", false); // [DEFAULT - non-Thunderbird]

/// Disable the Remote Debugging Web Socket
pref("devtools.debugger.remote-websocket", false, locked); // [DEFAULT]



/// Display Web Console timestamps by default [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/webconsole/constants.js#81 [NO-ANDROID]
pref("devtools.webconsole.timestampMessages", true); // [NO-ANDROID]

/// Disable WebDriver BiDi experimental commands and events
// https://wiki.mozilla.org/WebDriver/RemoteProtocol/WebDriver_BiDi
// https://searchfox.org/firefox-main/rev/82e2435f/remote/doc/Prefs.md#25
pref("remote.experimental.enabled", false, locked); // [DEFAULT - non-Nightly]

/// Display responses in the "raw" format in the network monitor by default [NO-ANDROID]
pref("devtools.netmonitor.ui.default-raw-response", true); // [NO-ANDROID]

/// Enable the Anti tracking debug panel by default [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/644f0db1/devtools/client/definitions.js#485 [NO-ANDROID]
pref("devtools.anti-tracking.enabled", true); // [NO-ANDROID]

/// Enable DevTools buttons by default [NO-ANDROID]
pref("devtools.command-button-errorcount.enabled", true); // [NO-ANDROID] [DEFAULT] Error Count - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/framework/toolbox.js#2209
pref("devtools.command-button-frames.enabled", true); // [NO-ANDROID] [DEFAULT] Frame Target - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/framework/toolbox.js#2189
pref("devtools.command-button-measure.enabled", true); // [NO-ANDROID] Measure - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/themes/toolbox.css#541
pref("devtools.command-button-noautohide.enabled", true); // [NO-ANDROID] No Pop-up Autohide - https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/framework/components/ToolboxToolbar.js#118
pref("devtools.command-button-pick.enabled", true); // [NO-ANDROID] [DEFAULT] Element picker https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/framework/toolbox.js#2333
pref("devtools.command-button-responsive.enabled", true); // [NO-ANDROID] [DEFAULT] Responsive - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/definitions.js#557
pref("devtools.command-button-rulers.enabled", true); // [NO-ANDROID] Ruler - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/themes/toolbox.css#537
pref("devtools.command-button-screenshot.enabled", true); // [NO-ANDROID] Screenshot - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/definitions.js#588

/// Enable experimental DevTools preferences by default [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/definitions.js#550 [NO-ANDROID]
pref("devtools.command-button-experimental-prefs.enabled", true); // [NO-ANDROID] [HIDDEN - non-MOZILLA_OFFICIAL builds] [DEFAULT - non-MOZILLA_OFFICIAL builds]

/// Enable the Web Console sidebar toggle [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/webconsole/webconsole-ui.js#46 [NO-ANDROID]
pref("devtools.webconsole.sidebarToggle", true); // [NO-ANDROID] [DEFAULT - Nightly]

/// Enforce local debugging only
pref("devtools.debugger.force-local", true, locked); // [DEFAULT]
pref("devtools.inspector.remote", false, locked); // [NO-ANDROID] [DEFAULT]

/// Enforce system access checks for WebDriver
// https://searchfox.org/firefox-esr140/rev/ba1d416c/remote/marionette/driver.sys.mjs#65
// https://searchfox.org/firefox-main/rev/82e2435f/remote/doc/Prefs.md#61
// https://bugzilla.mozilla.org/show_bug.cgi?id=1955007
pref("remote.system-access-check.enabled", true, locked); // [NO-ANDROID] [HIDDEN] [DEFAULT] [ESR]

/// Highlight syntax when viewing the source of webpages (via `view-source:`)
pref("view_source.syntax_highlight", true); // [DEFAULT - non-Thunderbird]


/// Pretty print code when debugging by default [NO-ANDROID]
pref("devtools.debugger.auto-pretty-print", true); // [NO-ANDROID]

/// Prevent automatically clearing log messages after page reloads/navigation [NO-ANDROID]
pref("devtools.netmonitor.persistlog", true); // [NO-ANDROID]
pref("devtools.webconsole.persistlog", true); // [NO-ANDROID]

/// Prevent console API from writing to `stdout` when used by chrome content
pref("devtools.console.stdout.chrome", false); // [DEFAULT - non-Android, `MOZILLA_OFFICIAL` builds]

/// Prevent filter queries/searches and recent selections from persisting across restarts [NO-ANDROID]
// (For this to be effective, these pref must be set as "user" prefs) [NO-ANDROID]
pref("devtools.debugger.pending-selected-location", "{}"); // [NO-ANDROID] [DEFAULT]
pref("devtools.netmonitor.requestfilter", ""); // [NO-ANDROID] [DEFAULT]

/// Prevent logging URLs in Reader errors
pref("reader.errors.includeURLs", false); // [DEFAULT - Android/Thunderbird]

/// Prevent WebDriver from overriding preferences by default
// https://searchfox.org/firefox-main/rev/82e2435f/remote/doc/Prefs.md#41
pref("remote.prefs.recommended", false);

/// Significantly reduce input history [NO-ANDROID]
pref("devtools.webconsole.inputHistoryCount", 10); // [NO-ANDROID] [DEFEAULT: 300]

/// Set Browser/Error Console scope to "Multiprocess" instead of "Parent process only" by default [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/webconsole/webconsole-ui.js#47 [NO-ANDROID]
pref("devtools.browsertoolbox.scope", "everything"); // [NO-ANDROID] [DEFAULT - Thunderbird] 

// Show default/browser styles in the Inspector by default [NO-ANDROID]
pref("devtools.inspector.showUserAgentStyles", true); // [NO-ANDROID]

/// Unbreak debugging if `localhost` can't be looked up via DNS [NO-ANDROID]
// (Ex. for Tor Browser) [NO-ANDROID]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16523 [NO-ANDROID]
pref("devtools.debugger.chrome-debugging-host", "127.0.0.1"); // [NO-ANDROID]

/// Wrap lines when debugging by default [NO-ANDROID]
// https://discourse.mozilla.org/t/long-line-wrapping-in-developer-tools-css-editor-and-debugger-code-views/47058 [NO-ANDROID]
pref("devtools.debugger.ui.editor-wrapping", true); // [NO-ANDROID]

/// Wrap lines when viewing the source of webpages (via `view-source:`)
pref("view_source.wrap_long_lines", true); // [DEFAULT - Android]

pref("browser.phoenix.status", "025");

/*** 026 PERFORMANCE ***/

// Some of these are taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js

/// Compress cached JavaScript bytecode
// https://github.com/yokoffing/Betterfox/issues/247
// https://searchfox.org/firefox-main/rev/82e2435f/dom/script/ScriptCompression.cpp#99
// (Default = 0, which means it's off)
pref("browser.cache.jsbc_compression_level", 3);

/// Disable async stack tracing by default
// https://searchfox.org/firefox-main/rev/52e25e8b/modules/libpref/init/all.js#891
pref("javascript.options.asyncstack", false);
pref("javascript.options.asyncstack_capture_debuggee_only", true); // [DEFAULT] If async stack tracing (javascript.options.asyncstack) is enabled, only capture data when devtools are open

/// Disable certain UI animations by default // [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/widget/nsXPLookAndFeel.cpp#87 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/widget/LookAndFeel.h#48 [NO-ANDROID]
pref("ui.panelAnimations", 0); // [NO-ANDROID] [HIDDEN]
pref("ui.prefersReducedMotion", 1); // [NO-ANDROID] [HIDDEN] 
pref("ui.swipeAnimationEnabled", 0); // [NO-ANDROID] [HIDDEN]

/// Disable CSS error reporting by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=831123
pref("layout.css.report_errors", false); // [DEFAULT - Android]

/// Disable extra extension logging by default
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#29
pref("extensions.logging.enabled", false); // [DEFAULT]

/// Disable pacing requests
// https://codeberg.org/celenity/Phoenix/issues/84
pref("network.http.pacing.requests.enabled", false);


/// Enable Advanced Vector Extensions (AVX) [NO-ANDROID]
// https://wikipedia.org/wiki/Advanced_Vector_Extensions [NO-ANDROID]
// https://www.supportyourtech.com/articles/how-to-enable-avx-support-in-windows-11-a-step-by-step-guide/ [NO-ANDROID]
pref("javascript.options.wasm_simd_avx", true); // [DEFAULT] [NO-ANDROID]

/// Enable Branch Hinting
// https://github.com/WebAssembly/branch-hinting/blob/main/proposals/branch-hinting/Overview.md
pref("javascript.options.wasm_branch_hinting", true); // [DEFAULT]

/// Enable Canvas2D acceleration (if supported)
// `gfx.canvas.accelerated.force-enabled` can be used to forcefully enable this acceleration, regardless of platform support
pref("gfx.canvas.accelerated", true); // [DEFAULT]
pref("gfx.canvas.accelerated.cache-items", 32768); // [Default = 8192, Chromium = 4096]
pref("gfx.canvas.accelerated.cache-size", 4096); // Increase cache size (Default = 256, Chromium = 512)

/// Enable CSS Masonry Layout
// https://www.smashingmagazine.com/native-css-masonry-layout-css-grid/
// (For testing: https://codepen.io/rachelandrew/pen/wvWmZWB)
pref("layout.css.grid-template-masonry-value.enabled", true); // [DEFAULT - Nightly/Thunderbird] 

/// Enable the "fetchpriority" attribute
// https://web.dev/articles/fetch-priority
pref("network.fetchpriority.enabled", true); // [DEFAULT]

/// Enable hardware acceleration by default
pref("layers.acceleration.disabled", false); // [DEFAULT]

/// Enable JS GC Parallel Marking
pref("javascript.options.mem.gc_parallel_marking", true); // [DEFAULT - non-Android]

/// Enable SIMD
// https://stackoverflow.blog/2020/07/08/improving-performance-with-simd-intrinsics-in-three-use-cases/
pref("javascript.options.wasm_relaxed_simd", true); // [DEFAULT]

/// Enable the WebRender native compositor (if supported)
// `gfx.webrender.compositor.force-enabled` can be used to forcefully enable this acceleration, regardless of platform support
pref("gfx.webrender.compositor", true); // [DEFAULT - macOS/Windows]


/// Increase buffering for video playback
// This doesn't apply to videos delivered via Media Source Extensions
// https://www.cloudflare.com/learning/video/what-is-buffering/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1540573
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/ChannelMediaDecoder.cpp#467
pref("media.cache_readahead_limit", 600); // (Default = 60)
pref("media.cache_readahead_limit.cellular", 600); // (Default = 30)
pref("media.cache_resume_threshold", 300); // (Default = 30)
pref("media.cache_resume_threshold.cellular", 300); // (Default = 10)
pref("media.throttle-cellular-regardless-of-download-rate", false); // [HIDDEN - non-Android] [DEFAULT - non-Android]

/// Increase the chunk size for calls to image decoders
// (Default = 16384)
pref("image.mem.decode_bytes_at_a_time", 65536);

/// Increase DNS caching
pref("network.dnsCacheExpiration", 3600); // (Default = 60)
pref("network.dnsCacheEntries", 10000); // (Default = 1600)

/// Increase the file-backed media cache size for cellular connections
// (Default = 32768)
// This is set to match the value of "media.cache_size"
pref("media.cache_size.cellular", 512000);

/// Increase the image cache size
// (Default = 5242880 - non-Android, 1048576 - Android)
pref("image.cache.size", 10485760);

/// Increase the memory-backed media cache size
pref("media.memory_cache_max_size", 262144); // (Default = 8192)
pref("media.memory_caches_combined_limit_kb", 1048576); // (Default = 524288)

/// Increase memory cache
pref("browser.cache.memory.capacity", 131072); // (Default = -1)
pref("browser.cache.memory.max_entry_size", 20480); // (Default = 5120)

/// Increase the skia font cache size (Similar to Chromium)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1239151#c2
// (Default = 5, Chromium = 20)
pref("gfx.content.skia-font-cache-size", 32);

/// Increase the maximum number of HTTP connections
pref("network.http.max-connections", 1800); // (Default = 128 for Android, 900 elsewhere)
pref("network.http.max-persistent-connections-per-proxy", 48); // (Default = 20 for Android, 32 elsewhere)
pref("network.http.max-persistent-connections-per-server", 10); // (Default = 6)
pref("network.http.max-urgent-start-excessive-connections-per-host", 5); // (Default = 3)
pref("network.http.request.max-start-delay", 5); // (Default = 10)

/// Increase TLS token caching
// https://codeberg.org/celenity/Phoenix/issues/84
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/base/SSLTokensCache.cpp#491
// (Default = 2048)
pref("network.ssl_tokens_cache_capacity", 10240);

/// Use higher performance pinch-zoom
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#8039
pref("gfx.webrender.low-quality-pinch-zoom", true); // [DEFAULT - Android Nightly]

pref("browser.phoenix.status", "026");

/*** 027 Personal Touch 💜 ***/

/// Things that are nice to have™
// Not directly privacy & security related

/// Allow downloading and switching locales [NO-ANDROID]
pref("app.update.langpack.enabled", true); // [NO-ANDROID] [DEFAULT]
pref("intl.multilingual.downloadEnabled", true); // [NO-ANDROID] [DEFAULT - non-Developer/Nightly]
pref("intl.multilingual.enabled", true); // [NO-ANDROID] [DEFAULT - non-Developer/Nightly]

/// Allow Picture-in-Picture on all websites, even if they try to block it...
pref("media.videocontrols.picture-in-picture.respect-disablePictureInPicture", false);

/// Allow zoom by default...
pref("apz.allow_zooming", true); // [DEFAULT]

/// Allow zoom on all websites, even if the website tries to block it...
// (This is the `Zoom on all websites` UI setting for Android)
pref("browser.ui.zoom.force-user-scalable", true);

/// Allow zooming out beyond the initial scale of websites by default
// https://searchfox.org/firefox-main/rev/82e2435f/gfx/layers/apz/src/AsyncPanZoomController.cpp#155
pref("apz.allow_zooming_out", true);

/// Allow the use of custom CSS by default [NO-ANDROID]
pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // [NO-ANDROID]




/// Disable annoying Web Speech API error pop-ups, especially relevant on Linux [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/actors/SpeechDispatcherParent.sys.mjs#7 [NO-ANDROID]
pref("media.webspeech.synth.dont_notify_on_error", true); // [NO-ANDROID] [HIDDEN]


/// Disable fullscreen delay
pref("full-screen-api.transition-duration.enter", "0 0"); // [Default = 200 200]
pref("full-screen-api.transition-duration.leave", "0 0"); // [Default = 200 200]

/// Display "More settings" on print previews by default
// https://searchfox.org/firefox-main/rev/643d7328/modules/libpref/init/all.js#761
pref("print.more-settings.open", true);




/// Enable autoscrolling by default
pref("apz.autoscroll.enabled", true); // [DEFAULT]
pref("general.autoScroll", true); // [HIDDEN - Android] [DEFAULT - non-Android/Unix (excluding macOS, where it is on by default)]



/// Enable developer options for `about:profiling`
pref("devtools.performance.aboutprofiling.has-developer-options", true);

/// Enable display of in-process subframes at `about:processes` by default
pref("toolkit.aboutProcesses.showAllSubframes", true);


/// Enable display of thread information at `about:processes` by default
pref("toolkit.aboutProcesses.showThreads", true); // [DEFAULT - Nightly]


/// Enable IPv6
// Important, nice to have
pref("network.dns.disableIPv6", false); // [DEFAULT]

/// Enable overscrolling by default
// https://www.omgubuntu.co.uk/2024/09/mozilla-firefox-130-new-features
pref("apz.overscroll.enabled", true); // [DEFAULT]

/// Enable the "Page Setup.." menu by default (under `File` - ex. on the menu bar)
// https://searchfox.org/firefox-main/rev/643d7328/modules/libpref/init/all.js#729
// https://searchfox.org/firefox-main/rev/643d7328/toolkit/components/printing/content/printUtils.js#82
pref("print.show_page_setup_menu", true);

/// Enable smooth scrolling by default
// This currently appears to be overriden by `ui.prefersReducedMotion` on Desktop
pref("general.smoothScroll", true); // [DEFAULT]

/// Enable Spellcheck for both multi-line and single-line boxes [NO-ANDROID]
// [Default = 1, only checks multi-line boxes] [NO-ANDROID]
// https://codeberg.org/celenity/Phoenix/issues/33 [NO-ANDROID]
pref("layout.spellcheckDefault", 2); // [NO-ANDROID]






/// Ensure the escape key exits fullscreen by default... [OSX-ONLY]
pref("browser.fullscreen.exit_on_escape", true); // [OSX-ONLY] [DEFAULT]

/// Ensure users can always control Nimbus recipes
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#692
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#952
pref("nimbus.debug", true); // [HIDDEN - non-Firefox Desktop]
pref("nimbus.validation.enabled", false); // [HIDDEN - non-Firefox Desktop]


/// Expose hidden UI preferences at about:config [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/widget/nsXPLookAndFeel.cpp#87 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/widget/LookAndFeel.h#48 [NO-ANDROID]
pref("ui.hideCursorWhileTyping", 1); // [NO-ANDROID] [HIDDEN] [DEFAULT]
pref("ui.prefersReducedTransparency", 0); // [NO-ANDROID] [HIDDEN] [DEFAULT]
pref("ui.scrollToClick", 1); // [NO-ANDROID] [HIDDEN]
pref("ui.useAccessibilityTheme", 0); // [NO-ANDROID] [HIDDEN] [DEFAULT]


/// Hide the Title Bar by default
pref("browser.tabs.inTitlebar", 1);

/// Highlight all Findbar (Ctrl + F) results by default
pref("findbar.highlightAll", true);



/// Prevent including the space next to words when double-clicking/selecting text
// https://codeberg.org/celenity/Phoenix/issues/84#issuecomment-3097957
pref("layout.word_select.eat_space_to_next_word", false); // [DEFAULT - non-Windows]

/// Set the default log level for Background Tasks
// This is the default value - this just exposes the pref via the `about:config`
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/backgroundtasks/BackgroundTasksManager.sys.mjs#18
pref("toolkit.backgroundtasks.loglevel", "error"); // [HIDDEN] [DEFAULT]

/// Set the default log level for Remote Settings
// This is the default value - this just exposes the pref via the `about:config`
pref("services.settings.loglevel", "warn"); // [HIDDEN] [DEFAULT]

/// Set default URL to load when navigating to `moz://a`
// Default is https://www.mozilla.org/about/manifesto/
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/mozprotocol/MozProtocolHandler.sys.mjs#10
pref("toolkit.mozprotocol.url", "about:mozilla"); // [HIDDEN]

/// Toggle the menu bar with the alt key by default

pref("browser.phoenix.status", "027");

/*** 028 UPDATES ***/

// Ensure the browser's binary is always old enough to check for browser updates [NO-ANDROID]
pref("app.update.checkInstallTime.days", 0); // [NO-ANDROID]

/// Alert users of browser updates ASAP [NO-ANDROID]
pref("app.update.badgeWaitTime", 0); // [NO-ANDROID] Immediately show badge on hamburger menu when an update is available
pref("app.update.notifyDuringDownload", true); // [NO-ANDROID] Ensure that users are notified when an update is downloaded
pref("app.update.promptWaitTime", 0); // [NO-ANDROID] Immediately prompt users to update when an update is ready

/// Automatically update extensions by default
pref("extensions.systemAddon.update.enabled", true); // [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/AddonManager.sys.mjs#1317
pref("extensions.systemAddon.update.url", "https://aus5.mozilla.org/update/3/SystemAddons/%VERSION%/%BUILD_ID%/%BUILD_TARGET%/%LOCALE%/%CHANNEL%/%OS_VERSION%/%DISTRIBUTION%/%DISTRIBUTION_VERSION%/update.xml"); // [HIDDEN - Thunderbird] [DEFAULT - non-Thunderbird]
pref("extensions.update.autoUpdateDefault", true); // [HIDDEN - ANDROID] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/AddonManager.sys.mjs#4580
pref("extensions.update.enabled", true); // [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/AddonManager.sys.mjs#1348

/// Check for browser updates hourly [NO-ANDROID]
pref("app.update.background.interval", 3600); // [NO-ANDROID] (Default: 25200 (7 hours))
pref("app.update.interval", 3600); // [NO-ANDROID] (Default: 21600 (6 hours))

/// Check for extension/theme updates hourly
// Default is once every 24 hours
pref("extensions.update.interval", 3600);

/// Disable insecure extension updates
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/AddonUpdateChecker.sys.mjs#66
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/XPIDatabase.sys.mjs#2707
pref("extensions.checkUpdateSecurity", true); // [HIDDEN] [DEFAULT]

/// Sync with Remote Settings hourly, rather than the default of only once a day
// This is used for delivering lots of security-critical databases (Ex. CRLite/revocation checks, malicious add-on blocklists, etc...)
// So let's make sure our users are up to date as quick as possible
pref("services.settings.poll_interval", 3600);

pref("browser.phoenix.status", "028");

/*** 029 FIREFOX HOME ***/















































pref("browser.phoenix.status", "029");



























/*** 031 SYNC ***/ // [NO-ANDROID]

/// Disable Firefox Sync by default [NO-ANDROID]
// When signing in to Firefox Sync, this controls the items (checkboxes) that are set to sync (under `about:preferences#sync`). [NO-ANDROID]
// This allows the user to control and choose for themselves what they'd like to sync, rather than automatically syncing everything (like the default) [NO-ANDROID]
pref("services.sync.engine.addons", false); // [NO-ANDROID]
pref("services.sync.engine.addresses", false); // [NO-ANDROID] [DEFAULT]
pref("services.sync.engine.bookmarks", false); // [NO-ANDROID]
pref("services.sync.engine.creditcards", false); // [NO-ANDROID] [DEFAULT]
pref("services.sync.engine.history", false); // [NO-ANDROID]
pref("services.sync.engine.passwords", false); // [NO-ANDROID]
pref("services.sync.engine.prefs", false); // [NO-ANDROID]
pref("services.sync.engine.tabs", false); // [NO-ANDROID]


/// Disable sending the user agent with Firefox Sync requests [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/af0f713f/services/sync/modules/resource.sys.mjs#38 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/af0f713f/services/sync/modules/resource.sys.mjs#99 [NO-ANDROID]
pref("services.sync.sendVersionInfo", false); // [NO-ANDROID]


/// Disable telemetry [NO-ANDROID]
pref("identity.fxaccounts.account.telemetry.sanitized_uid", "", locked); // [NO-ANDROID]
pref("identity.fxaccounts.telemetry.clientAssociationPing.enabled", false, locked); // [NO-ANDROID]
pref("services.sync.log.logger.telemetry", "Fatal"); // [NO-ANDROID] [HIDDEN]
pref("services.sync.telemetry.maxEventsCount", 0, locked); // [NO-ANDROID] [HIDDEN] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("services.sync.telemetry.maxPayloadCount", 0, locked); // [NO-ANDROID] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("services.sync.telemetry.submissionInterval", 2147483647, locked); // [NO-ANDROID] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst

/// If Firefox sync is enabled, disable avatar fetching [NO-ANDROID]
// See "network.dns.localDomains" above, we need to block "profile.accounts.firefox.com" [NO-ANDROID]
// The pref below just prevents Firefox from complaining and generating log files/errors when that domain can't be reached (even though it's unnecessary for Sync to function AFAICT...) [NO-ANDROID]
pref("services.sync.log.appender.file.level", "Fatal"); // [NO-ANDROID]

/// Improve the reliability of extension storage sync [NO-ANDROID]
pref("services.sync.extension-storage.skipPercentageChance", 0); // [NO-ANDROID]



pref("browser.phoenix.status", "031"); // [NO-ANDROID]






/*** 033 SPECIALIZED/CUSTOM CONFIGS ***/ // [NO-ANDROID]

/// Configure remote AutoConfig files (if active) [NO-ANDROID]
pref("autoadmin.failover_to_cached", true); // [NO-ANDROID]
pref("autoadmin.offline_failover", true); // [NO-ANDROID]
pref("autoadmin.refresh_interval", 60); // [NO-ANDROID]


pref("browser.phoenix.status", "033"); // [NO-ANDROID]

pref("browser.phoenix.status", "successfully applied :D", locked);
pref("browser.phoenix.applied.cfg", true, locked);

//

//
// Copyright (C) 2024-2026 celenity
//
// This file is part of Phoenix.
//
// Phoenix is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
// Phoenix is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with Phoenix. If not, see https://www.gnu.org/licenses/.
//

// This file contains preferences shared across Phoenix 'Extended' configs.

/* INDEX 

001: FINGERPRINTING PROTECTION
002: WEBRTC
003: ATTACK SURFACE REDUCTION
004: MISC. PRIVACY + SECURITY (ANDROID ONLY)
005: MISC. PRIVACY

*/

/* KEY

Unspecified = This preference should be set EVERYWHERE

[OSX-ONLY] = This preference should ONLY be set for macOS
[SILICON-OSX-ONLY] = This preference should ONLY be set for macOS on Apple Silicon

[NO-ANDROID] = This preference should be set everywhere, EXCEPT for Android
[NO-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (Flatpak)
[NO-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux
[NO-NON-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (non-Flatpak)
[NO-INTEL-OSX] = This preference should be set everywhere, EXCEPT for macOS on Intel
[NO-WINDOWS] = This preference should be set everywhere, EXCEPT for Windows

*/

/// Add custom branding at `about:support`

/// Add custom branding under `Firefox Updates` at `about:preferences#general` [NO-ANDROID]
// This will unfortunately only display if the version of Firefox you're using is repackaged (ex. Flatpaks/Linux distros) [NO-ANDROID]

/*** 001 FINGERPRINTING PROTECTION ***/

/// Enable dynamic rounding of content dimensions [NO-ANDROID]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366 [NO-ANDROID]
pref("privacy.resistFingerprinting.letterboxing", true); // [NO-ANDROID]

/// Further harden FPP...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Extended#fingerprinting
// Compared to standard, this just removes '-JSDateTimeUTC' - meaning timezone is spoofed to UTC-0
pref("browser.phoenix.status.extended", "001");

/*** 002 WEBRTC ***/
// This will likely break WebRTC...

/// Always exclude local IP addresses, even in trusted scenarios
pref("media.peerconnection.ice.no_host", true);

/// Force a single candidate for ICE generation
pref("media.peerconnection.ice.default_address_only", true);

/// Only use TURN servers/relays
// No P2P
// https://gitlab.torproject.org/tpo/applications/mullvad-browser/-/issues/40#note_2884663
pref("media.peerconnection.ice.relay_only", true);

pref("browser.phoenix.status.extended", "002");

/*** 003 ATTACK SURFACE REDUCTION ***/

/// Disable WebAssembly (WASM)
// https://spectrum.ieee.org/more-worries-over-the-security-of-web-assembly
pref("javascript.options.wasm", false);

pref("browser.phoenix.status.extended", "003");

/*** 004 MISC. PRIVACY + SECURITY ***/


pref("browser.phoenix.status.extended", "004");

/*** 005 MISC. PRIVACY ***/

/// Only send cross-origin referers if hosts match
// https://wiki.mozilla.org/Security/Referrer
pref("network.http.referer.XOriginPolicy", 2);

pref("browser.phoenix.status.extended", "005");

pref("browser.phoenix.status.extended", "successfully applied :D", locked);
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

pref("mail.dove.version", "2026.02.24.1", locked);

/// Add custom branding at `about:support`
pref("app.support.vendor", "Dove: 2026.02.24.1 | Phoenix: 2026.02.23.1"); // [HIDDEN]

/// Add custom branding under `Thunderbird Updates` at `about:preferences#general`
pref("distribution.about", "Dove for Mozilla Thunderbird - 2026.02.24.1 💜", locked); // [HIDDEN]
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

[OSX-ONLY] = This preference should ONLY be set for macOS
[SILICON-OSX-ONLY] = This preference should ONLY be set for macOS on Apple Silicon

[NO-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (Flatpak)
[NO-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux
[NO-NON-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (non-Flatpak)
[NO-INTEL-OSX] = This preference should be set everywhere, EXCEPT for macOS on Intel
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

/// Freeze user agent to protect against fingerprinting
// As explained below, we can't use the standard RFP/FPP 'HttpUserAgent' & 'NavigatorUserAgent` targets, as Thunderbird lies and pretends to be Firefox, which ex. breaks the ATN (and it's unfortunately not currently possible to set granular overrides here: https://bugzilla.mozilla.org/show_bug.cgi?id=1968080)
// Until Thunderbird fixes this upstream, we'll spoof it ourselves
// This matches what Firefox's RFP/FPP targets use (only difference being we switch out Firefox for Thunderbird)
// We'll keep platform always spoofed to Windows - since we block JS by default, can be useful (and I can't see this causing weird issues like we see on Firefox...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1950775
pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:140.0) Gecko/20100101 Thunderbird/140.0"); // [HIDDEN]

/// Harden FPP
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Features#fingerprinting
// and here: https://codeberg.org/celenity/Phoenix/wiki/Extended.md#fingerprinting
// We're adding -HttpUserAgent & -NavigatorUserAgent (compared to standard Phoenix Extended) because they try to report that we're Firefox, which ex. breaks the ATN (and it's unfortunately not currently possible to set granular overrides here: https://bugzilla.mozilla.org/show_bug.cgi?id=1968080)
// We're removing -CanvasExtractionBeforeUserInputIsBlocked as Thunderbird simply doesn't support these permission prompts for canvas data extraction...
// (We're setting -EfficientCanvasRandomization for now to work-around an upstream bug that prevents randomization from applying everywhere as expected: https://bugzilla.mozilla.org/show_bug.cgi?id=2013976)
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme,-EfficientCanvasRandomization,-FrameRate,-HttpUserAgent,-NavigatorUserAgent");

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
pref("network.trr.resolvers", '[{"url":"https://dns.quad9.net/dns-query","name":"Quad9 🇨🇭"},{"url":"https://dns.adguard-dns.com/dns-query","name":"AdGuard 🇨🇾"},{"url":"https://unfiltered.adguard-dns.com/dns-query","name":"AdGuard (Unfiltered) 🇨🇾"},{"url":"https://mozilla.cloudflare-dns.com/dns-query","name":"Cloudflare 🇺🇸"},{"url":"https://security.cloudflare-dns.com/dns-query","name":"Cloudflare (Malware Protection) 🇺🇸"},{"url":"https://noads.joindns4.eu/dns-query","name":"DNS4EU (Ad Blocking) 🇨🇿"},{"url":"https://protective.joindns4.eu/dns-query","name":"DNS4EU (Protective) 🇨🇿"},{"url":"https://unfiltered.joindns4.eu/dns-query","name":"DNS4EU (Unfiltered) 🇨🇿"},{"url":"https://base.dns.mullvad.net/dns-query","name":"Mullvad (Base) 🇸🇪"},{"url":"https://dns.mullvad.net/dns-query","name":"Mullvad (Unfiltered) 🇸🇪"},{"url":"https://firefox.dns.nextdns.io/","name":"NextDNS 🇺🇸"},{"url":"https://wikimedia-dns.org/dns-query","name":"Wikimedia 🇺🇸"}]'); // [HIDDEN] [ESR] - Thunderbird now uses the same pref as Firefox (`doh-rollout.provider-list`), which is set by Phoenix

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
// We unfortunately still need this, since CRLite is currently broken on Thunderbird for users not using Firefox's Remote Settings instance (/ the `MOZ_REMOTE_SETTINGS_DEVTOOLS` environment variable)
// We need to find a way to set that variable for Thunderbird by default - and once we do (or, ideally, once Mozilla actually fixes CRLite for Thunderbird...), I'll remove this - but we'll keep for now due to that reason
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

/// Always allow installing "incompatible" add-ons
// REQUIRED FOR UBLOCK ORIGIN
pref("extensions.strictCompatibility", false, locked); //  [DEFAULT - Nightly]

/// Allow uBird (uBlock Origin builds for Thunderbird) to run on restricted/quarantined domains by default
pref("extensions.quarantineIgnoredByUser.uBird@celenity.dev", true);

/// Allow unprivileged extensions to use experimental APIs
// Required for ex. CardBook, also used by DKIM Verifier
// https://searchfox.org/mozilla-central/source/toolkit/components/extensions/docs/basics.rst#142
pref("extensions.experiments.enabled", true); // [DEFAULT]

/// Block Cardbook (if installed) and DKIM Verifier from accessing restricted/quarantined domains
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantineIgnoredByUser.cardbook@vigneau.philippe", false); // [DEFAULT]
pref("extensions.quarantineIgnoredByUser.dkim_verifier@pl", false); // [DEFAULT]

/// Disable compatibility overrides
// https://mozilla.github.io/addons-server/topics/api/v3_legacy/addons.html#compat-override
pref("extensions.getAddons.compatOverides.url", "");

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

/// Re-enable installation of add-ons by default
// Unfortunately, Thunderbird doesn't prompt to re-enable this when mozAddonManager is enabled
// (which we sadly need to enable to support installation of add-ons from `addons.thunderbird.net` for the time-being)
pref("xpinstall.enabled", true); // [HIDDEN] [DEFAULT]

/// Re-enable mozAddonManager
// mozAddonManager has various privacy (fingerprinting) and security (added attack surface) concerns.
// It also bypasses the permission prompt to install add-ons, and prevents add-ons (like uBlock Origin) from working on `addons.thunderbird.net`.
// But, unfortunately, due to the removal of InstallTrigger, this is the only way to install add-ons from `addons.thunderbird.net` ATM.
// I need to investigate finding another solution, but, for now, unfortunately: we'll re-enable this.
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
pref("extensions.webapi.enabled", true); // [DEFAULT]
pref("privacy.resistFingerprinting.block_mozAddonManager", false); // [DEFAULT]

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
pref("dom.event.clipboardevents.enabled", false);

/// Disable Geolocation
// https://browserleaks.com/geo
pref("geo.prompt.open_system_prefs", false); // Ensure users aren't prompted to open settings and enable Geolocation - https://searchfox.org/mozilla-central/rev/20fc11f1/modules/libpref/init/StaticPrefList.yaml#6406
pref("geo.provider.network.scan", false);
pref("geo.provider.network.url", "");
pref("geo.provider.use_corelocation", false); // [OSX-ONLY]
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


/// Do not try to submit unrecognized search/URL strings to the default search engine
pref("keyword.enabled", false);

/// Package Thunderbird's Autoconfiguration files locally
// By default, these are typically fetched remotely from here: https://autoconfig.thunderbird.net/v1.1/
// Using these locally improves privacy by avoiding the unwanted network activity/potential leakage, and improves performance/responsiveness
// https://wiki.mozilla.org/Thunderbird:Autoconfiguration
pref("mailnews.auto_config_url", "file:///opt/homebrew/opt/dove/assets/autoconfig/v1.1/"); // [SILICON-OSX-ONLY]

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
