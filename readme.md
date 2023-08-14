# Outlookadblock

Outlookadblock is a simple patch to the Windows hosts file, that causes the Outlook desktop client to stop displaying those annoying ads in your inbox. There will still be an empty space, but no more ads that you accidentially click on.

This simpyl works by not allowing your PC to access the website `outlookads.live.com`, which outlook uses to fetch the ads it displays:

###### Note: I am also working on removing that blank space, but could take some time.

## Contents

1. [Installation](#installation)
2. [Before and after](#before-and-after)

## Installation

There are two ways:

1. [The script method](#script-method)
2. [The manual method](#manual-method)

## Script method

To make it simpler, I threw together a quick windows batch script that does all the work for you!

### 1. Downloading

Download the `block.bat` file to your PC.

### 2. Executing

Execute the `block.bat` file. There will be an UAC prompt asking for admin rights (these are needed to edit the hosts file).

## Usage

After executing, you will see this screen. From there you can select if you want to add or remove the line of text to your hosts file. Type in `1` and press enter to add it to your hosts file or press `2` and enter to remove it.

![using](https://i.ibb.co/V2Pspn6/1.png)

When selecting number `1` for example, the line gets added and outlook will no longer display ads:

![1](https://i.ibb.co/0QmKP5k/2.png)

## Manual method

Don't trust my script or having problems? This is how you can DIY.

## Before and after

Test

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Disclaimer
This repository is for research purposes only, the use of this code is your responsibility.

I take NO responsibility and/or liability for how you choose to use any of the source code available here. By using any of the files available in this repository, you understand that you are AGREEING TO USE AT YOUR OWN RISK. Once again, ALL files available here are for EDUCATION and/or RESEARCH purposes ONLY.
