# Dove

**Dove is a suite of configurations & advanced modifications for Mozilla Thunderbird, designed to put the user first.**

It is not a simple user.js like you might expect - but it is not a fork either. It is installed on top of your standard Thunderbird installation.

**Dove strives to create the best email experience possible, and does so through significantly hardening user privacy & security, and protecting user freedom.** We also include various other QOL tweaks, performance enhancements, & nice-to-have features where possible.

Dove is built off of & heavily based on its sister project, [Phoenix](https://celenity.dev/phoenix), which you should also check out.

> [!NOTE]
> This project is hosted on both [Codeberg](https://codeberg.org/celenity/Dove) (which will be the primary & preferred place to contribute), & [GitHub](https://github.com/celenityy/Dove).

___

# 📖Glossary

**<details><summary>Click me</summary>**

- [Dove](#dove)
- [📖Glossary](#glossary)
- [🚀Install](#install)
	- [🐧GNU-Linux](#gnu-linux)
	- [🍎macOS](#macos)
	- [🪟Windows](#windows)
- [👋Uninstall](#uninstall)
	- [🐧GNU-Linux](#gnu-linux-1)
	- [🍎macOS](#macos-1)
- [📛Manual Mode *(Not recommended)*](#manual-mode-not-recommended)
- [💜Attribution](#attribution)

</details>

# 🚀Install

Dove offers easy to use install scripts for various platforms. All you have to do is have Thunderbird installed & ready, paste the command that corresponds to your platform of choice in your terminal, and you should be good to go. :)

## 🐧GNU-Linux

> [!IMPORTANT] 
> **⚠️ Thunderbird Flatpak & Snap packages are currently not supported.**

> [!NOTE]
> Dove only supports 39, 40 and 41 versions of Fedora.

```sh
sudo bash -c "$(curl -fsSL https://dove.celenity.dev/install.sh)"
```

</details>

___

## 🍎macOS

> [!IMPORTANT] 
> ⚠️ **You must have [Homebrew](https://brew.sh/) installed**

```sh
bash -c "$(curl -fsSL https://dove.celenity.dev/install.sh)"
```
___

## 🪟Windows

See upstream Codeberg issue [here](https://codeberg.org/celenity/Phoenix/issues/3) & GitHub issue [here](https://github.com/celenityy/Phoenix/issues/1)

**HELP WANTED!!**

___

# 👋Uninstall

If Dove isn't right for you - no worries! We also have easy to use uninstall scripts. Please be sure to [leave us feedback](https://dove.celenity.dev/issues) though so we can improve for the future!

## 🐧GNU-Linux

```sh
sudo bash -c "$(curl -fsSL https://dove.celenity.dev/uninstall.sh)"
```

</details>

___

## 🍎macOS

```sh
bash -c "$(curl -fsSL https://dove.celenity.dev/uninstall.sh)"
```

___

# 📛Manual Mode *(Not recommended)*

By default, Dove leverages Mozilla's [Centralized Management](https://support.mozilla.org/kb/customizing-firefox-using-autoconfig#w_centralized-management) feature to automatically update its configurations. This allows fast, easy updates & fixes as needed, regardless of your platform. Dove's Policies are updated separately, through the [AUR](https://aur.archlinux.org/packages/dove-policies) on Arch Linux, [COPR](https://copr.fedorainfracloud.org/coprs/dove/phoenix-policies/) on Fedora, the [MPR](https://mpr.makedeb.org/packages/dove-policies) on Debian/Ubuntu/Derivatives, & our [Homebrew](https://brew.sh/) [Tap](https://codeberg.org/celenity/tap) on macOS. 

> [!CAUTION] 
>**This is typically set-up & handled through our install scripts, and this is the set-up we would recommend most users stick to.**

However, if this is not desirable for you & your situation, you can manually install Dove with the following steps:

**1:** Download our `dove.cfg` file [here](https://dove.celenity.dev/manual/dove.cfg). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal: 

```sh
wget https://dove.celenity.dev/manual/dove.cfg
```

**2:** Download `dove.js` from [here](https://dove.celenity.dev/defaults/pref/dove.js). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal: 

```sh
wget https://dove.celenity.dev/defaults/pref/dove.js
```

**3:** Download `policies.json` from [here](https://dove.celenity.dev/policies/Policies/policies.json). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

```sh
wget https://dove.celenity.dev/policies/Policies/policies.json
```

**4:** Locate your Thunderbird installation directory. This will vary depending on your platform, you can generally find it by navigating to `Help` (Located on top bar) -> `Troubleshooting information` & checking the directory next to `Application Binary`. For example, on Fedora Linux, I see `/usr/lib64/thunderbird/thunderbird` next to `Application Binary`. This means our installation directory is `/usr/lib64/thunderbird`.

> [!CAUTION] 
>**Unless you're on Fedora Linux, your directory will probably be different, and you should replace this path on the following steps with your actual installation directory's path.**

**5:** Move `dove.cfg` to the **root** of your installation directory. You can either drag and drop it manually, or run the following command, assuming `/usr/lib64/thunderbird` is your installation directory:

```sh
sudo mv dove.cfg /usr/lib64/thunderbird/dove.cfg
```

**6:** **For macOS & Flatpak users**: If it does not already exist, in the **root** of your installation directory, create a folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. You can do this manually through your file explorer, or assuming `/usr/lib64/thunderbird` is your installation directory *(it won't be)*, you could run the following command:

```sh
sudo mkdir -p /usr/lib64/thunderbird/defaults/pref
```

**For Linux users:** If it does not already exist, you will want to create a folder named `thunderbird` located in your system's `etc` directory. Inside this `thunderbird` folder, create a new folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. This will work **regardless of your distribution** - even Snaps are supported. You can also just run the command below:

```sh
sudo mkdir -p /etc/thunderbird/defaults/pref
```

On macOS & Linux, you'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /usr/lib64/thunderbird/defaults/pref
```

**For all non-Flatpak Linux users:**
```sh
sudo chmod 655 /etc/thunderbird/defaults/pref
```

**7:** Move `dove.js` to the `pref` folder that you just created. Assuming your installation directory is `/usr/lib64/thunderbird`, you can run the following command:

```sh
sudo mv dove.js /usr/lib64/thunderbird/defaults/pref/dove.js
```

**For all non-Flatpak Linux users:**
```sh
sudo mv dove.js /etc/thunderbird/defaults/pref/dove.js
```

**8:** On macOS & Windows, in the **root** of your installation directory, create a folder named `distribution`. You can do this manually through your file explorer, or assuming `/usr/lib64/thunderbird` is your installation directory, you can run the following command:

```sh
sudo mkdir -p /usr/lib64/thunderbird/distribution
```

Linux users should **instead** create a `policies` folder inside of a `thunderbird` folder located in `/etc`. This will work **regardless** of your distribution, and even for Snaps.

```sh
sudo mkdir -p /etc/thunderbird/policies
```

On macOS & Linux, you'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /usr/lib64/thunderbird/distribution
```

**For all non-Flatpak Linux users:**
```sh
sudo chmod 655 /etc/thunderbird/policies
```

**9:** Finally, those on Windows & macOS should move `policies.json` to the `distribution` folder that you just created. Assuming your installation directory is `/usr/lib64/thunderbird`, you can run the following command:

```sh
sudo mv policies.json /usr/lib64/thunderbird/distribution/policies.json
```

Linux users should **instead** move `policies.json` to their `/etc/thunderbird/policies` folder they just created.

```sh
sudo mv policies.json /etc/thunderbird/policies/policies.json
```

Congratulations, you're done. Enjoy Dove, and be sure to keep up with updates!

___

# 💜Attribution

Huge thank you to the following projects & individuals for making Dove possible. Please show them support!

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
