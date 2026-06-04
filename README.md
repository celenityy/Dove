# Dove
<p align="center">
    <img src="assets/dove.png"
        alt="Dove"
        height="200">
</p>

**Dove is a suite of configurations & advanced modifications for Mozilla Thunderbird, designed to put the user first - with a focus on privacy, security, freedom, functionality, & usability.**

> [!NOTE]
> While Dove's home is [Codeberg](https://codeberg.org/celenity/Dove), this repo is also mirrored to both [GitLab](https://gitlab.com/celenityy/Dove) & [GitHub](https://github.com/celenityy/Dove).

> [!NOTE]
> **Firefox users should consider taking a look at [Phoenix](https://phoenix.celenity.dev) - Dove's sister project.**

### Want to join the Dove Community?

We'd love to see you over on [Matrix](https://matrix.to/#/#celenity:unredacted.org) *(Recommended)* and [Discord](https://discord.gg/TsADPVDerv)!

___

Dove works by leveraging Thunderbird's [AutoConfig](https://enterprise.thunderbird.net/deploy/mcd-thunderbird-autoconfig) & [Enterprise Policies](https://github.com/thunderbird/policy-templates/tree/master/templates/central) functionality, and is installed on top of your standard, official Thunderbird installation. **This allows us to go above and beyond what a simple `user.js` file can offer, without the security risks of using a fork**. For example, forks often fall behind on Thunderbird updates, **which can leave users open to severe, detrimental vulnerabilities.** Dove's approach allows users to continue receiving immediate updates, directly from Mozilla.

Dove's approach also provides users with a seamless experience that is accessible and easy to use. Gone are the days of creating `override` files, manually keeping track of updates, & resetting old preferences. **Not only is Dove the most effective & comprehensive approach to configuring Thunderbird, it is also the most accessible & easiest to use.**

Dove's settings & changes to Thunderbird are carefully considered based on extensive research & studying of Thunderbird's inner workings. **For an incomplete, non-exhaustive list of Dove's features & enhancements, see [here](https://dove.celenity.dev/features).**

**Dove is designed to maintain compatibility with email providers and to avoid breakage as much as possible, while still substantially improving privacy & security compared to vanilla Thunderbird & most other email clients.**

**You should also see [here](https://dove.celenity.dev/compare) for a comparison between Dove, standard Thunderbird, thunderbird-user.js, & other projects of similar nature.**

**Dove also disables various anti-features & strives to put the user back in control of their email experience.** Additionally, Dove includes quality of life enhancements, performance improvements, and other 'goodies' where possible and where it doesn't compromise user privacy or security.

At the end of the day, above all else:

**Dove is designed from the ground up to always put the user first.**

> [!IMPORTANT]
>**⚠️ All users MUST read the Wiki [here](https://dove.celenity.dev/wiki) before proceeding. The [Important](https://codeberg.org/celenity/Dove/wiki/Important.md) pages is of extra importance!!**

___

# 📖Glossary

**<details><summary>Click me</summary>**

- [Dove](#dove)
		- [Want to join the Dove Community?](#want-to-join-the-dove-community)
- [📖Glossary](#glossary)
- [🚀Install](#install)
- [👋Uninstall](#uninstall)
- [📛Manual Installation](#manual-installation)
- [⚖️Licensing](#licensing)
- [🏛️Notices](#notices)
- [💜Attribution](#attribution)

</details>

# 🚀Install

Dove currently provides official support for:

* **Arch Linux**
* **Debian (& derivatives...)**
* **Fedora Linux**
* **NixOS**
* **Flatpak** *(System)*
* **macOS**
* **Ubuntu (& derivatives...)**

> [!IMPORTANT]
> ⚠️ **Flatpak *(User)* & Snap packages of Thunderbird are currently not supported.**

Other platforms have unfortunately proven difficult to support, though progress **is** being made. Contributions are always welcome and appreciated.

**<details><summary>Arch</summary>**

> [!NOTE]
> You can use **`paru`** instead of **`yay`** with the same options.

Thunderbird *(Pacman)*:

```sh
yay -S dove
```

Thunderbird *(System Flatpak)*:

```sh
yay -S dove-flatpak
```

</details>

**<details><summary>Debian/Ubuntu & derivatives</summary>**

 Before installing Dove, you'll first need to add [celenity's OBS repo](https://build.opensuse.org/project/show/home:celenity):

> [!NOTE]
> You may see a warning, such as the following, when updating your `apt` cache.
>
> ```sh
> Warning: https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/InRelease: Policy will reject signature within a year, see --audit for details
> ```
>
> This is because `apt` will not support V3 GPG keys after `2026-02-01`, and currently the OBS uses a V3 GPG key. For now, there shouldn't be any issues.

 ```sh
 echo 'deb https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/ /' | sudo tee /etc/apt/sources.list.d/home:celenity.list
 wget -O- https://download.opensuse.org/repositories/home:celenity/Debian_Unstable/Release.key 2>/dev/null | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null
 sudo apt update
 ```

Thunderbird *(DEB)*:

```sh
sudo apt install dove
```

Thunderbird *(System Flatpak)*:

```sh
sudo apt install dove-flatpak
```

</details>

**<details><summary>Fedora</summary>**

 Before installing Dove, you'll first need to add [celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr/):

 ```sh
 sudo dnf copr enable celenity/copr
 sudo dnf makecache
 ```

Thunderbird *(RPM)*:

```sh
sudo dnf install dove
```

Thunderbird *(System Flatpak)*:

```sh
sudo dnf install dove-flatpak
```

</details>

**<details><summary>macOS</summary>**

> [!IMPORTANT]
> ⚠️ **Before proceeding, you must have [Homebrew](https://brew.sh/) installed.**

Run the following installation script in your terminal of choice:

```sh
/bin/zsh -c "$(curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose --location https://gitlab.com/celenityy/Dove/-/raw/pages/osx/scripts/osx_install.sh)"
```

</details>

**<details><summary>NixOS</summary>**

NixOS is supported for [flake-based configurations](https://wiki.nixos.org/wiki/Flakes#Using_nix_flakes_with_NixOS):
1. Add Dove and Phoenix repositories to your flake inputs (Dove is based on Phoenix configs).
2. Add `dove` as one of the arguments to your output function.
3. Add the Dove NixOS Module to your configuration.
```nix
{
  inputs = {
    # Note that this assumes you have a flake-input called nixpkgs,
    # which is often the case. If you've named it something else,
    # you'll need to change the `nixpkgs` below.
    dove = {
      url = "git+https://gitlab.com/celenityy/Dove.git?ref=pages";
      inputs.nixpkgs.follows = "nixpkgs";
	  inputs.phoenix.follows = "phoenix";
    };
	phoenix = {
      url = "git+https://gitlab.com/celenityy/Phoenix.git?ref=pages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  # Add the `dove` argument to your output function, as below:
  outputs = {nixpkgs, dove, ...}: {
	# The configuration here is an example; it will look slightly different
	# based on your machine name and architecture.
    nixosConfigurations.your-box = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # This is the important part -- add this line to your module list!
        dove.nixosModules.default
      ];
	};
  };
}
```

</details>

## **If you would like to use Dove on an unsupported platform, see [📛Manual Installation](#manual-installation).**

___

# 👋Uninstall

**<details><summary>Arch</summary>**

> [!NOTE]
> You can use **`paru`** instead of **`yay`** with the same options.

Thunderbird *(Pacman)*:

```sh
yay -Rcns dove-arch
```

Thunderbird *(System Flatpak)*:

```sh
yay -Rcns dove-flatpak
```

</details>

**<details><summary>Debian/Ubuntu & derivatives</summary>**

Thunderbird *(DEB)*:

```sh
sudo apt remove dove
```

Thunderbird *(System Flatpak)*:

```sh
sudo apt remove dove-flatpak
```

You can also remove [celenity's OBS repo](https://build.opensuse.org/project/show/home:celenity) if desired:

```sh
sudo rm /etc/apt/sources.list.d/home:celenity.list
sudo rm /etc/apt/trusted.gpg.d/home_celenity.gpg
sudo apt update
```

</details>

**<details><summary>Fedora</summary>**

Thunderbird *(RPM)*:

```sh
sudo dnf remove dove
```

Thunderbird *(System Flatpak)*:

```sh
sudo dnf remove dove-flatpak
```

You can also remove [celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr/) if desired:

```sh
sudo dnf copr remove celenity/copr
sudo dnf makecache
```

</details>

**<details><summary>macOS</summary>**

Run the following uninstall script in your terminal of choice:

```sh
/bin/zsh -c "$(curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose --location https://gitlab.com/celenityy/Dove/-/raw/pages/osx/scripts/osx_uninstall.sh)"
```

</details>

**<details><summary>NixOS</summary>**

**?**

</details>

Please [leave us feedback](https://dove.celenity.dev/issues) on the way out, so we can improve for the future!

___

# 📛Manual Installation

> [!CAUTION]
>**This is NOT recommended for most users.**

By default, Dove is installed & updated via your operating system's package manager. This allows for fast, easy updates & fixes as needed, right with the rest of your system!

However, if this is not desirable for you & your situation, or you would simply like to use Dove on an unsupported operating system, you can manually install Dove with the following steps:

**1:** Download the archive for your desired Dove release:

This can be found at the link below *(replacing `{DOVE_VERSION}` with the version of Dove you'd like to download)*. For reference, the latest version of Dove can always be found at the top of [the `Releases` page](https://codeberg.org/celenity/Dove/releases).

- Linux: `https://releases.celenity.dev/dove/releases/{DOVE_VERSION}/linux/dove-{DOVE_VERSION}-linux.tar.xz`
- macOS: `https://releases.celenity.dev/dove/releases/{DOVE_VERSION}/osx/dove-{DOVE_VERSION}-osx.tar.xz`
- Windows: `https://releases.celenity.dev/dove/releases/{DOVE_VERSION}/windows/dove-{DOVE_VERSION}-windows.zip`

You can navigate to the link above and download the archive
directly from your web browser, or you can run the following
command in your terminal:

**Linux**:

```sh
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose --remote-name --location https://releases.celenity.dev/dove/releases/{DOVE_VERSION}/linux/dove-{DOVE_VERSION}-linux.tar.xz
```

**macOS**:

```sh
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose --remote-name --location https://releases.celenity.dev/dove/releases/{DOVE_VERSION}/osx/dove-{DOVE_VERSION}-osx.tar.xz
```

**Windows**:

```sh
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose --remote-name --location https://releases.celenity.dev/dove/releases/{DOVE_VERSION}/windows/dove-{DOVE_VERSION}-windows.zip
```

**2:** Extract your downloaded archive:

First, create the directory where you'd like to extract Dove:

```sh
mkdir -p dove
```

Now, extract the downloaded archive:

*(Replacing `{DOVE_VERSION}` with the version of Dove you'd like to download, and `/path/to` with the path to your downloaded archive)*

**Linux**:

```sh
tar xJf /path/to/dove-{DOVE_VERSION}-linux.tar.xz -C dove
```

**macOS**:

```sh
tar xJf /path/to/dove-{DOVE_VERSION}-osx.tar.xz -C dove
```

**Windows**:

```sh
unzip -q /path/to/dove-{DOVE_VERSION}-windows.zip -d dove
```

**3:** Locate your Thunderbird installation directory. This will vary depending on your platform, you can generally find it by navigating to `Help` (Located on top bar) -> `Troubleshooting information` & checking the directory next to `Application Binary`. For example: If I see `/Users/${USER}/Applications/Thunderbird.app/Contents/MacOS/thunderbird` listed next to `Application Binary`,
my installation directory would be: **`/Users/${USER}/Applications/Thunderbird.app`**.

> [!CAUTION]
>**Your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**4:**

**Linux**:

If it does not already exist, you will want to
create a folder named `thunderbird` located in your system's `etc` directory. 
This will work **regardless of your distribution** - even Snaps are supported.
You can also just run the command below:

```sh
sudo mkdir -p /etc/thunderbird
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/thunderbird
```

Now, copy `dove.cfg` to the `/etc/thunderbird` directory you just created. You can either drag and drop it manually, or run the following command:

**NOTE**: If you have previously installed `dove.cfg` to a different location *(such as Thunderbird's installation directory)*, **please REMOVE it** to ensure any conflicts are avoided.

```sh
sudo cp dove/dove.cfg /etc/thunderbird/dove.cfg
```

**macOS**:

Copy `dove.cfg` to the **`Resources`** folder within your installation directory.
You can either drag and drop it manually, or run the following command:
*assuming `/Users/${USER}/Applications/Thunderbird.app` is your installation directory*

```sh
sudo cp dove/dove.cfg /Users/${USER}/Applications/Thunderbird.app/Resources/dove.cfg
```

**Windows**:

Copy `dove.cfg` to the **root** of your installation directory. You
can either drag and drop it manually, or run the following command:

```sh
cp dove\dove.cfg C:\'Program Files'\'Mozilla Thunderbird'\dove.cfg
```

**5:** If it does not already exist, inside the `/etc/thunderbird` directory, create a new folder named `defaults`,
and inside this new `defaults` folder, create another folder titled `pref`. This will work
**regardless of your distribution** - even Snaps are supported. You can also
just run the command below:

```sh
sudo mkdir -p /etc/thunderbird/defaults/pref
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/thunderbird/defaults/pref
```

**macOS**:

If it does not already exist, inside the `Resources` directory, create a new folder named `defaults`,
and inside this new `defaults` folder, create another folder titled `pref`.
You can do this manually through your file explorer, or you can run the following command:
*assuming `/Users/${USER}/Applications/Thunderbird.app` is your installation directory*

```sh
sudo mkdir -p /Users/${USER}/Applications/Thunderbird.app/Resources/defaults/pref
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 744 /Users/${USER}/Applications/Thunderbird.app/Resources/defaults/pref
```

**Windows**:

If it does not already exist, in the **root** of your installation directory, create a folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. You can do this manually through your file explorer, or you can run the following command for your platform:

```sh
mkdir -vp C:\'Program Files'\'Mozilla Thunderbird'\defaults\pref
```

**6:** Copy `defaults/pref/dove.js` to the `pref` folder that you just created. You can run the following command for your platform below:

**Linux**:

```sh
sudo cp dove/defaults/pref/dove.js /etc/thunderbird/defaults/pref/dove.js
```

**macOS**:

*assuming `/Users/${USER}/Applications/Thunderbird.app` is your installation directory*

```sh
sudo cp dove/defaults/pref/dove.js /Users/${USER}/Applications/Thunderbird.app/Resources/defaults/pref/dove.js
```

**Windows**:

```sh
cp dove\defaults\pref\dove.js C:\'Program Files'\'Mozilla Thunderbird'\defaults\pref\dove.js
```

**7:**

On Windows, in the **root** of your installation directory, create a folder named `distribution`. You can do this manually through your file explorer, or you can run the following command:

```sh
mkdir -vp C:\'Program Files'\'Mozilla Thunderbird'\distribution
```

non-Flatpak GNU/Linux users should **instead** create a `policies` folder inside of the `thunderbird` folder located in `/etc`. This will work **regardless** of your distribution, and even for Snaps.

```sh
sudo mkdir -vp /etc/thunderbird/policies
```

For non-Flatpak GNU/Linux users, you'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/thunderbird/policies
```

**9:** Now, those on Windows should copy `distribution/policies.json` to the `distribution` folder that you just created. You can run the following command:

```sh
cp dove\distribution\policies.json C:\'Program Files'\'Mozilla Thunderbird'\distribution\policies.json
```

macOS users should **instead** copy `macos/org.mozilla.thunderbird.plist` to `/Library/Preferences`, and **reboot** their device once finished:

```sh
sudo cp dove/macos/org.mozilla.thunderbird.plist /Library/Preferences/org.mozilla.thunderbird.plist`
```

GNU/Linux users should **instead** copy `policies/policies.json` to their `/etc/thunderbird/policies` folder they just created.

```sh
sudo cp dove/policies/policies.json /etc/thunderbird/policies/policies.json
```

**10**: Within your Dove directory, create a directory titled `assets`, and copy `assets/autoconfig` into this new `assets` directory.

**Linux** *(Non-Flatpak)*:

```sh
mkdir -vp /etc/thunderbird/dove/assets
cp -vrf dove/assets/autoconfig /etc/thunderbird/dove/assets/
```

**Linux** *(Flatpak)*:

```sh
mkdir -vp /var/lib/flatpak/app/org.mozilla.Thunderbird/current/active/files/etc/thunderbird/dove/assets
cp -vrf dove/assets/autoconfig /var/lib/flatpak/app/org.mozilla.Thunderbird/current/active/files/etc/thunderbird/dove/assets/
```

**macOS** *(Apple Silicon)*:

```sh
mkdir -vp /opt/homebrew/opt/dove/assets
cp -vrf dove/assets/autoconfig /opt/homebrew/opt/dove/assets/
```

**macOS** *(Intel)*:

```sh
mkdir -vp /usr/local/opt/dove-intel/assets
cp -vrf dove/assets/autoconfig /usr/local/opt/dove-intel/assets/
```

**Windows**:

```sh
mkdir -vp C:\dove\assets
cp -vrf dove\assets\autoconfig C:\dove\assets\
```

**Alternatively**: At the cost of privacy and security, after installing Dove, you can set the value of `mailnews.auto_config_url` to `https://autoconfig.thunderbird.net/v1.1/` from [`about:config`](about:config) *(Accessible by navigating to `Settings` -> `General` -> Scroll to the bottom -> `Config Editor...`)*. This is **NOT** recommended, as it will share your email provider with Mozilla, and is slower/less responsive.

Congratulations, you're done. Enjoy Dove, and be sure to keep up with updates!

___

# ⚖️Licensing

Dove is licensed under the [GNU General Public License v3.0 or later](https://spdx.org/licenses/GPL-3.0-or-later.html) *(`GPL-3.0-or-later`)* where applicable.

Phoenix is licensed under the [GNU General Public License v3.0 or later](https://spdx.org/licenses/GPL-3.0-or-later.html) *(`GPL-3.0-or-later`)* where applicable.

Dove's [archives](https://gitlab.com/celenityy/Dove/-/tree/pages/archives) include:

- `assets/autoconfig/` - From [Thunderbird's `ISPDB`](https://github.com/thunderbird/autoconfig), available under the [Mozilla Public License 2.0](https://spdx.org/licenses/MPL-2.0.html).

# 🏛️Notices

Mozilla Thunderbird is a trademark of the Mozilla Foundation.

This is not an officially supported Mozilla product. Dove is in no way affiliated with Mozilla.

Dove is not sponsored or endorsed by Mozilla.

Thunderbird source code is available at [https://hg-edge.mozilla.org](https://hg-edge.mozilla.org/).

# 💜Attribution

Huge thank you to the following projects & individuals for making Dove possible. Please show them support!

**Also see Phoenix's Attribution page [here](https://phoenix.celenity.dev#attribution)**.

- **[Seyed Mohamad Amin Modaresi](https://codeberg.org/gnu1)**
	- Suggested Dove's icon, created the install & uninstall scripts, helped with maintenance/packaging, assisted with README formatting, provided general advice & support, and responsible for various other significant contributions to the project.

- **[Kora](https://github.com/bikass/kora)**
	- 🪪 [bikass](https://github.com/bikass)
	- ⚖️ [GPL-3.0-only](https://github.com/bikass/kora/blob/9cdedbcd55114eae05440573606c5783aff4be26/LICENSE)
    - 💸 [Donate](https://ko-fi.com/tarmakofi)
	- Designed Dove's icon

- **[thunderbird-user.js](https://github.com/HorlogeSkynet/thunderbird-user.js)**
    - 🪪 [Samuel FORESTIER](https://github.com/HorlogeSkynet) + [Daniel Nathan Gray](https://github.com/dngray)
    - ⚖️ [MIT](https://raw.githubusercontent.com/HorlogeSkynet/thunderbird-user.js/master/LICENSE)
    - Discovered various prefs & learned from their very nice documentation

- **[Arkenfox](https://github.com/arkenfox/user.js)**
	- 🪪 [Thorin-Oakenpants](https://github.com/thorin-oakenpants) + [earthlng](https://github.com/earthlng) + [claustromaniac](https://github.com/claustromaniac)
	- ⚖️ [MIT](https://github.com/arkenfox/user.js/blob/master/LICENSE.txt)

- **[Betterfox](https://github.com/yokoffing/Betterfox)**
	- 🪪 [yokoffing](https://github.com/yokoffing)
	- ⚖️ [MIT](https://github.com/yokoffing/Betterfox/blob/main/LICENSE)
    - 💸 [Donate](https://github.com/sponsors/yokoffing)
    - Various performance-related prefs

- **[Narsil's mozilla.cfg](https://codeberg.org/Narsil/mozilla.cfg)**
	- 🪪 [Narsil](https://codeberg.org/Narsil)
	- ⚖️ [GPL-3.0-or-later](https://codeberg.org/Narsil/mozilla.cfg/src/branch/master/LICENSE.txt)
	- Certain preferences + inspiration

- **[Brace](https://codeberg.org/divested/brace)**
	- 🪪 [Divested Computing Group](https://divested.dev/)
	- ⚖️ [AGPL-3.0-or-later](https://codeberg.org/divested/brace/src/branch/master/LICENSE)
	- 💸 [Donate](https://divested.dev/pages/donate)
	- Certain preferences + inspiration

- **[LibreWolf](https://librewolf.net/)**
	- 🪪 [bgstack15](https://codeberg.org/bgstack15) + [fxbrit](https://codeberg.org/fxbrit) + [Malte Jürgens](https://codeberg.org/maltejur) + [ohfp](https://codeberg.org/ohfp) + [James McClain](https://codeberg.org/TheGreatMcPain) + [threadpanic](https://codeberg.org/threadpanic) + [Guillaume](https://codeberg.org/ltguillaume)
	- ⚖️ [MPL-2.0](https://codeberg.org/librewolf/settings/src/branch/master/LICENSE.txt)
	- Inspiration + certain preferences & policies

- **[firefox-config](https://codeberg.org/rusty-snake/firefox-config)**
	- 🪪 [rusty-snake](https://codeberg.org/rusty-snake)
	- ⚖️ [CC0-1.0](https://codeberg.org/rusty-snake/firefox-config#license-cc0)
	- Inspiration + certain preferences

- **[uBlock Origin](https://github.com/gorhill/uBlock)**
	- 🪪 [Raymond Hill](https://github.com/gorhill) + [ItsProfesssional](https://github.com/ItsProfessional) + [MasterKia](https://github.com/MasterKia) + [peace2000](https://github.com/peace2000) + [Peter Lowe](https://pgl.yoyo.org/) + [PiQuark6046](https://github.com/piquark6046) + [stephenhawk8054](https://github.com/stephenhawk8054)
	- ⚖️ [GPL-3.0-or-later](https://github.com/gorhill/uBlock/blob/master/LICENSE.txt)
	- Pre-installed extension - provides content blocking

- **[Mullvad DNS](https://mullvad.net/help/dns-over-https-and-dns-over-tls)**
	- 🪪 [Mullvad VPN AB](https://mullvad.net/about)
	- Default DNS Over HTTPS Resolver

And of course...

- **[Thunderbird](https://www.thunderbird.net/)**
	- 🪪 [Mozilla](https://www.mozilla.org/)
	- ⚖️ [MPL-2.0](https://www.mozilla.org/foundation/licensing/)
	- 💸 [Donate](https://www.thunderbird.net/?form=support)
