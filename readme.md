# Outlook desktop ad blocker

This is a simple patch to the Windows hosts file, that causes the Outlook desktop client to stop displaying those *annoying* ads in your inbox. There will still be an empty space, but no more ads that you accidentially click on.

This simply works disallowing your PC to access the website `outlookads.live.com`, which outlook uses to fetch the ads it displays:

## Contents

1. [Installation](#installation)
2. [Before and after](#before-and-after)
3. [Other OS support](#other-os-support)

## Installation

There are three ways:

1. [The easy method](#easy-method)
2. [The script method](#script-method)
3. [The manual method](#manual-method)

## Easy method

The simplest option there is. A single PowerShell command that downloads the adblocker script executes it and removes everything after it's done.

### 1. Opening

Open a new PowerShell prompt. If you don't know how, take a quick look here: [9 ways to open PowerShell in Windows](https://www.digitalcitizen.life/ways-launch-powershell-windows-admin/)

### 2. Executing

Simply copy and paste this command into your PowerShell prompt and hit enter:

```
irm https://raw.githubusercontent.com/Pyenb/Outlook-desktop-ad-blocker/main/tools/oneline.ps1 | iex
```

For further usage, see [usage](#usage).

![irm](https://i.ibb.co/M128T65/1.png)

## Script method

To make it simpler, I threw together a quick windows batch script that does all the work for you!

### 1. Downloading

Download the [block.bat](https://github.com/Pyenb/Outlook-desktop-ad-blocker/blob/main/block.bat) file to your PC.

### 2. Executing

Execute the `block.bat` file. There will be an UAC prompt asking for admin rights (these are needed to edit the hosts file).

### Usage

After executing, you will see this screen. From there you can select if you want to add or remove the line of text to your hosts file. Type in `1` and press enter to add it to your hosts file or press `2` and enter to remove it.

![using](https://i.ibb.co/2MmzD4V/2.png)

When selecting number `1` for example, the line gets added and outlook will no longer display ads (after restarting the program):

![1](https://i.ibb.co/0QmKP5k/2.png)

If the line is already present, the script will tell you that:

![present](https://i.ibb.co/ZmWxprh/3.png)

## Manual method

Don't trust my script or having problems? This is how you can DIY.

### 1. The right tool for the job

Open any text editor of your choice as administrator

### 2. Opening

Open the `hosts` file, located at `C:\Windows\System32\drivers\etc\hosts`.

### 3. Editing

Add the text

```127.0.0.1 outlookads.live.com```

as a new line inside the `hosts` file.

### 4. Profit

Restart Outlook desktop and enjoy your ad free experience.

## Before and after

**Before:**

![Before](https://i.ibb.co/1nDYYXx/4.png)

**After:**

![After](https://i.ibb.co/dG89q6Y/5.png)

## Other OS support

While having only tested it on the newest Windows 11 build, this should also work for any other OS. Just search on how to edit your hosts file and make the same edits as in [the manual method](#manual-method) (just change the file path).

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Disclaimer
This repository is for research purposes only, the use of this code is your responsibility.

I take NO responsibility and/or liability for how you choose to use any of the source code available here. By using any of the files available in this repository, you understand that you are AGREEING TO USE AT YOUR OWN RISK. Once again, ALL files available here are for EDUCATION and/or RESEARCH purposes ONLY.
