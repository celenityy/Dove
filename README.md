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

We'd love to see you over on [Matrix](https://matrix.to/#/#dove:unredacted.org) *(Recommended)* and [Discord](https://discord.gg/GartyGah9m)!

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
- [💜Attribution](#attribution)

</details>

# 🚀Install

Dove currently provides official support for:

* **Arch Linux**
* **Debian (& derivatives...)**
* **Fedora Linux** *(39-41)*
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
> Warning: https://download.opensuse.org/repositories/home:/celenity/Debian_12/InRelease: Policy will reject signature within a year, see --audit for details
> ```
>
> This is because `apt` will not support V3 GPG keys after `2026-02-01`, and currently the OBS uses a V3 GPG key. For now, there shouldn't be any issues.

 ```sh
 echo 'deb https://download.opensuse.org/repositories/home:/celenity/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:celenity.list
 wget -O- https://download.opensuse.org/repositories/home:celenity/Debian_12/Release.key 2>/dev/null | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null
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

 Before installing Phoenix, you'll first need to add [celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr/):

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
/bin/zsh -c "$(curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/installer_scripts/macos_install.sh)"
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
      url = "git+https://gitlab.com/celenityy/Dove";
      inputs.nixpkgs.follows = "nixpkgs";
	  inputs.phoenix.follows = "phoenix";
    };
	phoenix = {
      url = "git+https://gitlab.com/celenityy/Phoenix";
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
/bin/zsh -c "$(curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/uninstaller_scripts/macos_uninstall.sh)"
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

**1:** Download `dove.cfg` file from [here](https://gitlab.com/celenityy/Dove/-/raw/pages/dove.cfg). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal: 

```sh
wget https://gitlab.com/celenityy/Dove/-/raw/pages/dove.cfg
```

**2:** Download `dove.js` from [here](https://gitlab.com/celenityy/Dove/-/raw/pages/prefs/dove.js). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

```sh
wget https://gitlab.com/celenityy/Dove/-/raw/pages/prefs/dove.js
```

**3:** Download `policies.json` from [here](https://gitlab.com/celenityy/Dove/-/raw/pages/policies.json). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

```sh
wget https://gitlab.com/celenityy/Dove/-/raw/pages/policies.json
```

**4:** Locate your Thunderbird installation directory. This will vary depending on your platform, you can generally find it by navigating to `Help` (Located on top bar) -> `Troubleshooting information` & checking the directory next to `Application Binary`. For example, on Fedora Linux, I see `/usr/lib64/thunderbird/thunderbird` next to `Application Binary`. This means our installation directory is `/usr/lib64/thunderbird`.

> [!CAUTION]
>**Unless you're on Fedora Linux, your directory will probably be different, and you should replace this path on the following steps with your actual installation directory's path.**

**5:** Move `dove.cfg` to the **root** of your installation directory. You can either drag and drop it manually, or run the following command, assuming `/usr/lib64/thunderbird` is your installation directory:

```sh
sudo cp dove.cfg /usr/lib64/thunderbird/dove.cfg
```

**6:** **For macOS & Flatpak users**: If it does not already exist, in the **root** of your installation directory, create a folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. You can do this manually through your file explorer, or assuming `/usr/lib64/thunderbird` is your installation directory *(it won't be)*, you could run the following command:

```sh
sudo mkdir -p /usr/lib64/thunderbird/defaults/pref
```

**For GNU/Linux users:** If it does not already exist, you will want to create a folder named `thunderbird` located in your system's `etc` directory. Inside this `thunderbird` folder, create a new folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. This will work **regardless of your distribution** - even Snaps are supported. You can also just run the command below:

```sh
sudo mkdir -p /etc/thunderbird/defaults/pref
```

On macOS & GNU/Linux, you'll also want to ensure that the folder you created has proper permissions:

**For macOS users:** - assuming `/usr/lib64/thunderbird` is your installation directory *(it won't be)*

```sh
sudo chmod 744 /usr/lib64/thunderbird/defaults/pref
```

**For all non-Flatpak GNU/Linux users:**

```sh
sudo chmod 655 /etc/thunderbird/defaults/pref
```

**7:** Move `dove.js` to the `pref` folder that you just created. Assuming your installation directory is `/usr/lib64/thunderbird`, you can run the following command:

```sh
sudo cp dove.js /usr/lib64/thunderbird/defaults/pref/dove.js
```

**For all non-Flatpak GNU/Linux users:**

```sh
sudo cp dove.js /etc/thunderbird/defaults/pref/dove.js
```

**8:** On macOS & Windows, in the **root** of your installation directory, create a folder named `distribution`. You can do this manually through your file explorer, or assuming `/usr/lib64/thunderbird` is your installation directory, you can run the following command:

```sh
sudo mkdir -p /usr/lib64/thunderbird/distribution
```

GNU/Linux users should **instead** create a `policies` folder inside of a `thunderbird` folder located in `/etc`. This will work **regardless** of your distribution, and even for Snaps.

```sh
sudo mkdir -p /etc/thunderbird/policies
```

On macOS & GNU/Linux, you'll also want to ensure that the folder you created has proper permissions:

**For macOS users:** - assuming `/usr/lib64/thunderbird` is your installation directory *(it won't be)*

```sh
sudo chmod 744 /usr/lib64/thunderbird/distribution
```

**For all non-Flatpak GNU/Linux users:**

```sh
sudo chmod 655 /etc/thunderbird/policies
```

**9:** Finally, those on Windows & macOS should move `policies.json` to the `distribution` folder that you just created. Assuming your installation directory is `/usr/lib64/thunderbird`, you can run the following command:

```sh
sudo cp policies.json /usr/lib64/thunderbird/distribution/policies.json
```

GNU/Linux users should **instead** move `policies.json` to their `/etc/thunderbird/policies` folder they just created.

```sh
sudo cp policies.json /etc/thunderbird/policies/policies.json
```

Congratulations, you're done. Enjoy Dove, and be sure to keep up with updates!

___

# 💜Attribution

Huge thank you to the following projects & individuals for making Dove possible. Please show them support!

**Also see Phoenix's Attribution page [here](https://phoenix.celenity.dev#attribution)**.

- **[Seyed Mohamad Amin Modaresi](https://codeberg.org/gnu1)**
	- Suggested Dove's icon, created the install & uninstall scripts, helped with maintenance/packaging, assisted with README formatting, provided general advice & support, and responsible for various other significant contributions to the project.

- **[Kore](https://github.com/bikass/kora)**
	- 🪪 [bikass](https://github.com/bikass)
	- ⚖️ [GPL-3.0](https://github.com/bikass/kora/blob/9cdedbcd55114eae05440573606c5783aff4be26/LICENSE)
    - 💸 [Donate](https://ko-fi.com/tarmakofi)
	- Designed Dove's icon

- **[thunderbird-user.js](https://github.com/HorlogeSkynet/thunderbird-user.js)**
    - 🪪 [Samuel FORESTIER](https://github.com/HorlogeSkynet) + [Daniel Nathan Gray](https://github.com/dngray)
    - ⚖️ [MIT](https://raw.githubusercontent.com/HorlogeSkynet/thunderbird-user.js/master/LICENSE)
    - Discovered various prefs & learned from their very nice documentation

- **[Arkenfox](https://github.com/arkenfox/user.js)**
	- 🪪 [Thorin-Oakenpants](https://github.com/thorin-oakenpants) + [earthlng](https://github.com/earthlng) + [claustromaniac](https://github.com/claustromaniac)
	- ⚖️ [MIT](https://github.com/arkenfox/user.js/blob/master/LICENSE.txt)
	- Discovered various prefs - Also learned lots from their excellent research & documentation

- **[Betterfox](https://github.com/yokoffing/Betterfox)**
	- 🪪 [yokoffing](https://github.com/yokoffing)
	- ⚖️ [MIT](https://github.com/yokoffing/Betterfox/blob/main/LICENSE)
    - 💸 [Donate](https://github.com/sponsors/yokoffing)
    - Various performance-related prefs

- **[Narsil's mozilla.cfg](https://codeberg.org/Narsil/mozilla.cfg)**
	- 🪪 [Narsil](https://codeberg.org/Narsil)
	- ⚖️ [GPLv3](https://codeberg.org/Narsil/mozilla.cfg/src/branch/master/LICENSE.txt)
	- Certain prefs & some inspiration

- **[Brace](https://codeberg.org/divested/brace)**
	- 🪪 [Divested Computing Group](https://divested.dev/)
	- ⚖️ [GPLv3](https://codeberg.org/divested/brace/src/branch/master/LICENSE)
	- 💸 [Donate](https://divested.dev/pages/donate)
	- Where I first learned of the idea to leverage policies & package them... + inspiration

- **[LibreWolf](https://librewolf.net/)**
	- 🪪 [bgstack15](https://codeberg.org/bgstack15) + [fxbrit](https://codeberg.org/fxbrit) + [Malte Jürgens](https://codeberg.org/maltejur) + [ohfp](https://codeberg.org/ohfp) + [James McClain](https://codeberg.org/TheGreatMcPain) + [threadpanic](https://codeberg.org/threadpanic) + [Guillaume](https://codeberg.org/ltguillaume)
	- ⚖️ [MPL-2.0](https://codeberg.org/librewolf/settings/src/branch/master/LICENSE.txt)
	- Inspiration + certain preferences & policies

- **[firefox-config](https://codeberg.org/rusty-snake/firefox-config)**
	- 🪪 [rusty-snake](https://codeberg.org/rusty-snake)
	- ⚖️ [CC0](https://codeberg.org/rusty-snake/firefox-config#license-cc0)
	- Inspiration + certain preferences

- **[mobile-config-firefox](https://gitlab.com/postmarketOS/mobile-config-firefox)**
	- 🪪 [postmarketOS](https://postmarketos.org/)
	- ⚖️ [MPL-2.0](https://gitlab.com/postmarketOS/mobile-config-firefox/-/blob/master/LICENSE)
	- 💸 [Donate](https://opencollective.com/postmarketOS)
	- Inspiration

- **[uBlock Origin](https://github.com/gorhill/uBlock)**
	- 🪪 [Raymond Hill](https://github.com/gorhill) + [ItsProfesssional](https://github.com/ItsProfessional) + [MasterKia](https://github.com/MasterKia) + [peace2000](https://github.com/peace2000) + [Peter Lowe](https://pgl.yoyo.org/) + [PiQuark6046](https://github.com/piquark6046) + [stephenhawk8054](https://github.com/stephenhawk8054)
	- ⚖️ [GPLv3](https://github.com/gorhill/uBlock/blob/master/LICENSE.txt)
	- Pre-installed extension - provides content blocking

- **[Quad9](https://quad9.net/)**
	- 🪪 [Quad9 Team](https://quad9.net/about/team/)
	- 💸 [Donate](https://www.quad9.net/donate/)
	- Default DNS Over HTTPS Resolver

And of course...

- **[Firefox](https://mozilla.org/firefox)**
	- 🪪 [Mozilla](https://www.mozilla.org/)
	- ⚖️ [MPL-2.0](https://www.mozilla.org/foundation/licensing/)
	- 💸 [Donate](https://foundation.mozilla.org/donate/)
