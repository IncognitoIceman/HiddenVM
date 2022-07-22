|foo|

.. |foo| raw:: html

    <a href="#About"><img src="./misc/hiddenvm-logo-full.svg" width="100%" height="184pt"></a>
    <p align="center"><a href="#About"><img src="https://dummyimage.com/1x45/ffffff/ffffff.png" /></a> 
    <a href="#About"><img src="https://img.shields.io/github/v/release/incognitoiceman/HiddenVM.svg?color=%2344cc11ff&label=version" /></a>&nbsp; 
    <a href="#About"><img src="https://camo.githubusercontent.com/bf135a9cea09d0ea4bba410582c0e70ec8222736/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4c6963656e73652d47504c25323076332d626c75652e737667" /></a>&nbsp; 
    <a href="#About"><img src="https://img.shields.io/github/downloads/incognitoiceman/HiddenVM/total?color=%236b2981" /></a>&nbsp; 
    <a href="#About"><img src="https://img.shields.io/github/stars/incognitoiceman/HiddenVM.svg?label=github%20stars" /></a> 
    <a href="#About"><img src="https://dummyimage.com/1x45/ffffff/ffffff.png" /></a></p>

.. raw:: html

    <h2><a href="#About">HiddenVM</a></h2>

.. contents::

Warning
----------------------
This software is in the alpha stage of development. 

The work on this project is 90% complete as it is only missing a way to properly connect Whonix to the clearnet.

This software is specifically meant to run Whonix on Tails OS but it can run other operating systems. 

At this stage the hypervisor connects to the clearnet internet infrastructure (usermode networking) on Tails which connects to the internet without connecting to Tor which 
means any installed like Windows, Ubuntu and Mac will connect to the internet the same way you connect a VM to the internet from Ubuntu or Windows but the difference is the operating system is run as a persistent VM on Tails. I have even run Tails as a VM on the Tails host OS which successfully connected to the clearnet internet.

This project is specifically designed to run Whonix but can run other operating systems.

Our issue is that the capabilities of virt-manager become very limited when connected to clearnet usermode networking (qemu:///session). The Virtual Machines are perfectly able to connect to the internet using usermode networking but the Whonix gateway needs to connects to a NAT virtual bridge which is required to connect the VM to the internet. On the other hand qemu:///system which is run as root libvirtd (daemon) can create and connect to the NAT virtual bridge as it has root permissions but unfortunately the qemu:///system connection connects to the tor infrastructure and iptables blocks the connection.

What we are looking for is a way for the Whonix-Gateway to create and connect to clearnet using the NAT virtual bridge without any issues.

Once basic functionality has been successfully implemented we will look forward to other functionality.

Any help in the form of pull requests or issues to enable Whonix to connect to clearnet with a NAT virtual bridge from libvirt is greatly appreciated.

About
----------------------

**HiddenVM** is a futuristic tool powered by KVM designed to combine the powerful amnesic nature of Tails and the impenetrable design of Whonix with the unbreakable strength of Veracrypt.

This software has been forked from a project of the same name by the author aforensics `HiddenVM <https://github.com/aforensics/HiddenVM>`_.

Anyone is free to modify and re-use this software for non-commercial usage.

This version of HiddenVM is powered by KVM unlike the previous version which was powered by VirtualBox which is considered by many to be insecure. 

It is designed to be a one click free and open source Linux application that allows you to run Red Hat's open-source `Virtual Machine Manager <https://virt-manager.org>`_ 
on the `Tails operating system <https://tails.boum.org>`_. 

The libvirt daemon will connect to the clearnet infrastructure by default without modifying any setting of the Tor connection in Tails OS.

The persistent nature of HiddenVM allows you to save all your data inside a `hidden VeraCrypt volume <https://www.veracrypt.fr/en/Hidden%20Volume.html>`_ without losing any data.

The benefit of using a hidden Veracrypt volume is that any adversaries will be unable to tell if there is a hidden volume present because the data present on the drive would look like random data. Thus giving you the benefit of plausible deniability.

If set up correctly all an adversary can see is an empty Tails USB drive and a hard drive full of meaningless data.


Installation and usage
----------------------

**Before you install:**

* 
  Always have two Tails USB sticks, with one as a backup of the latest working Tails for your current HiddenVM.

* 
  Always upgrade Tails on your second stick, in case the new Tails doesn't work with your current HiddenVM.

*
  Always give us time to troubleshoot and fix our code to make it work with a new Tails version. Thank you for your patience.

*
  This will give you stability and prevent you from being locked out of your HiddenVM at any point due to a Tails upgrade.

**Install:**

* 
  Boot into `Tails <https://tails.boum.org>`_ on your computer and set an `admin password <https://tails.boum.org/doc/first_steps/startup_options/administration_password/index.en.html>`_ 
  for your session.

* 
  `Do NOT use <#why-shouldnt-i-use-tails-official-persistent-volume-feature>`_ Tails' `persistent volume feature <https://tails.boum.org/doc/first_steps/persistence/index.en.html>`_.

* 
  Create and mount a deniable, secure storage environment on internal or external media such as a `VeraCrypt <https://veracrypt.fr/en>`_ volume.

*
  `Download our latest release ZIP <https://github.com/IncognitoIceman/HiddenVM/releases>`_ and extract the archive.

*
  Run our AppImage file in the Files browser.

*
  Choose to store HiddenVM in your secure storage and it will download all binaries to launch Virtual Machine Manager. 
  

**Usage:**

* 
  After initially installing HiddenVM you can use it offline where each Virtual Machine Manager launch takes about 5 minutes.

How can I trust the HiddenVM AppImage file?
-------------------------------------------

**You don't have to. Inspect the code yourself it is open source:**


* 
  Open a Terminal and ``cd`` to the folder containing our AppImage.

*
  Extract the appimage using the commmand:  ``./AppImageName.AppImage --appimage-extract``.

*
  The AppImage will be extracted to a folder called ``squashfs-root``.
  
* 
  I recommend downloading the linux version of Visual Studio Code as a .deb file to view the entire source code. The debian package can be installed using the command ``sudo dpkg -i code*.deb``.  

FAQs / Warnings
---------------

What type of person might use HiddenVM?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the same way as Tor and Tails, **HiddenVM** (called **HVM** for short) is intended for a wide range of people facing different threats around the world. This software is specifically 
designed to be used by Privacy Activists, Whistleblowers and people living in countries controlled by an authoritarian government regardless anyone is free to use the software.


What is the motivation behind the development of this project?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
After the leaking of Top Secret and highly classified information by `Edward Snowden <https://en.wikipedia.org/wiki/Edward_Snowden>`_, I was struck by the extent of surveillance 
of foreign citizens by the US government including it's own. In the classified documents the US government used the 9/11 attacks as a pretext to spy on the whole world. There are 
countless Ed Snowdens in a lot of authoritarian countries. I am a strong advocate for freedom of speech and human rights.

To make sure were all in the same bus, I want to point out what happened to a Sheikh called `Nimr al-Nimr <https://en.wikipedia.org/wiki/Nimr_al-Nimr>`_ in Saudi Arabia who was executed for simply speaking out and calling for non-violent protests against the Saudi government and what happened to a journalist called `Jamal Khashoggi <https://en.wikipedia.org/wiki/Jamal_Khashoggi>`_ who was assasinated in Saudi Arabia on the orders of the crown prince `Mohammed bin Salman <https://en.wikipedia.org/wiki/Mohammed_bin_Salman>`_. Imagine if  `Ed Snowden <https://en.wikipedia.org/wiki/Edward_Snowden>`_ was beheaded in Times Square for exposing the spying activities of the US governement. These are some examples of the kind of danger that activists have to deal with living in authoritarian regimes.

The other compelling reason is that I saw that the original project was using VirtualBox which is highly insecure, the reasons for which are given in the next paragraph.

Why does this project use virt-manager over VirtualBox?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The Whonix developers themselves `have strongly advised <https://www.whonix.org/wiki/KVM#Why_Use_KVM_Over_VirtualBox.3F>`_ users not to use VirtualBox because lack of transparency 
and verifiability of the VirtualBox developer team mainly because of their decision to not go public on details of security bugs in their software , as well as discouraging full and public
disclosure by third parties. This kind of laziness is particularly alarming when it comes to patching critical security vulnerabilities in software used by vulnerable people case
in point a zero day vulnerability in their software reported privately to Oracle in October 2008. This security vulnerability remained unfixed for 4 years. This kind of indolent 
attitude has not been seen from any other company. 

People might think that this might be because of bad managment in the past but that isn't the case. On the VirtualBox bugtracker, ticket VirtualBox 5.2.18 is vulnerable to spectre/meltdown despite microcode being installed indicating non-responsiveness and non-progress by upstream. `Meltdown <https://en.wikipedia.org/wiki/Meltdown_(security_vulnerability)>`_ is a variant of `Spectre <https://en.wikipedia.org/wiki/Spectre_(security_vulnerability)>`_. Keep in mind that the spectre and meltdown vulnerabilities were reported way back in 2017 and are some of the most serious security vulnerabilities ever discovered. Other non-FOSS (Free and Open Source Software) and FOSS companies scrambled their developers to fix these vulnerabilities ASAP. Most of these companies released patches within a week. This kind of laziness from the VirtualBox team makes people question Oracle's motives on whether they might secretly be working with authoritarian governments to silence dissidents and political enemies. 

On the other hand libvirt developed by Red Hat and the QEMU team released patches to mitigate spectre in a short time frame. I want to stress the danger posed to the users of 
privacy software who are already at risk of torture and execution in totalitarian regimes. The usage of HiddenVM powered by VirtualBox would put them in an even greater risk. The best course of 
action for these vulnerable people would be to avoid using software like VirtualBox. The VirtualBox developers have an obligation either have to patch their software or discontinue their software rather than releasing software with unpatched and known security vulnerabilities. I am pretty sure that people who use this software will avoid the risk of capture and torture in authoritarian regimes as regular people do not need Tails or Whonix so safety and security must be put at a forefront, regardless anyone is welcome to use and contribute to this project.

What is the Virtual Machine software that this version of HiddenVM uses?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Compared to VirtualBox which is an independent software KVM has a lot of differences and depends on various software modules. The KVM version is made of four parts: 

1. `KVM <https://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine>`_ is a virtualization module integrated into the Linux Kernel that allows the kernel to function as a hypervisor.

2. `Libvirt <https://en.wikipedia.org/wiki/Libvirt>`_ which is an open source API and a management tool which runs as a `daemon (libvirtd) <https://en.wikipedia.org/wiki/Daemon_(computing)>`_ in memory. Libvirt is the application which manages the Virtual Machines.

3. `Virtual Machine Manager or virt-manager <https://en.wikipedia.org/wiki/Virtual_Machine_Manager>`_ is a desktop `hypervisor <https://en.wikipedia.org/wiki/Hypervisor>`_ which is developed by `Red Hat <https://en.wikipedia.org/wiki/Red_Hat>`_. This is the software you see loaded in the foreground once the HiddenVM installation process is complete.

4. `QEMU (Quick Emulator) <https://en.wikipedia.org/wiki/QEMU>`_ is a free and open source `emulator <https://en.wikipedia.org/wiki/Emulator>`_. It can interoperate with Kernel-based Virtual Machine (KVM) to run virtual machines at near-native speed. QEMU can also do emulation for user-level processes, allowing applications compiled for one architecture to run on another.

How does this version of HiddenVM connect to the internet?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The connection to the internet is enabled by connecting to the clearnet infrastructure on Tails. A virtual bridge connects the Whonix Gateway to the clearnet which is very different to the plug and play method used in VirtualBox. The way that VirtualBox connects to the internet is simple but can be insecure compared to libvirt which was built with security in mind. We had to perform some programming gymnastics to get the internet working as smoothly on Tails.


But isn't KVM's GUI more complicated to use than VirtualBox GUI?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Most of these complications can be minimized by having the installation process do most of the heavy lifting and configuration. This project is meant for marginalized communities whose rights have to be protected. I am sure they will be willing to learn even the hardest of ways to be safe. Like I said in my previous FAQ, 
it is better to completely avoid risky software than to use it because otherwise you would be putting yourself at unnecessary risk by using software like VirtualBox. It is also better to be safe than sorry. This project is not aimed towards average Joes.

What is the purpose of this project when projects like Qubes have been proven to be the most secure?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
It is true that Ed Snowden himself uses Qubes OS and a Whonix Gateway. The problem with Qubes is that it doesn't work with newer hardware and is very difficult to set up compared to HiddenVM which is a one click solution which runs on the most popular privacy operating system in the world. You can argue that a comnputer running Qubes is the most secure system which is something that can be debated. Qubes uses LUKS (Linux Unified Key Setup) for its encryption purposes which is safe enough but it doesn't have the Hidden volume feature of veracrypt with which users can claim "plausible deniability" on whether a hidden volume exists which can be a bonus. Also Qubes also uses Whonix as a base for security. Either way the data is still fully encrypted with both Veracrypt and LUKS. This project can serve as an alternative to Qubes for less teach savvy people.

Do you know the original author of HiddenVM?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
No I have no affiliations with aforensics and have never been in contact with them. One of my colleagues introduced me to this project which impressed me a lot but I decided to fork this project because I saw that the original project was using VirtualBox as a hypervisor which is insecure. 

What guest OSes work with HiddenVM?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We have so far successfully tested Windows 10, macOS Mojave, Linux Mint, Ubuntu, Xubuntu, Fedora, and Whonix. Anything that works in Virtual Machine Manager should be compatible.


How much RAM do I need?
^^^^^^^^^^^^^^^^^^^^^^^

Using VMs in Tails uses a lot of RAM because Tails already runs entirely in RAM. We recommended at least 16 GB in your machine but your mileage may vary.


Why is HiddenVM taking more than the usual 4 minutes to launch?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The first time you run HiddenVM, the install can take anywhere from several minutes to more than half an hour because it needs to download all the necessary software that it uses. After 

that it caches everything offline for a much quicker 2-minute launch time.

Every 7 days, if you're connected to the Internet HiddenVM will do an ``apt-get`` update to check repositories like virt-manager and will download new updates if available. Sometimes you 

can get connected to a very slow Tor circuit in Tails. Close off HiddenVM's Terminal window and restart Tails to hopefully be connected to a faster circuit.

Every time you do a Tails and HiddenVM upgrade, the first time after this will almost always need to install new package versions, thus taking around 5 minutes or longer. Then it returns to 
the usual 2 minutes.


Known limitations:
^^^^^^^^^^^^^^^^^^


* Currently, during HiddenVM's launch process doing certain tasks in Tails can crash your live session. It's not a serious limitation e.g. using Tails' Tor Browser does not cause the crash. 

The issue is caused by our complicated process of installing Virtual Machine Manager in Tails which temporarily upgrades and then restores the original versions of dependencies used by certain GNOME apps. 

When HiddenVM finishes its launch you can resume all activity in Tails again. We hope we can remove this limitation in a future HiddenVM redesign.

'Extras' and 'Dotfiles' feature
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

HiddenVM allows you to fully automate the customization of your Tails environment at every launch by performing system settings modifications or loading additional software including persistent config files for such software.

Go to 'extras' folder in your HiddenVM and rename ``extras-example.sh`` to ``extras.sh``. Any lines you add will be performed as bash script code at the end of each subsequent HiddenVM launch, right after it opens Virtual Machine Manager.

Some examples:

.. code-block::

   sudo apt-get install autokey-gtk -y #Install a popular Linux universal hotkeys tool

.. code-block::

   nohup autokey & #Launch the Linux universal hotkeys tool that Extras just installed

.. code-block::

   gsettings set org.gnome.desktop.interface enable-animations false #Turn off GNOME animations

Eventually we will have a Wiki page with many Extras examples. Please contribute ideas. The installation and launching of a pre-Virtuaal Machine Manager VPN could be possible.

Warning: Make sure your commands work or it can cause HiddenVM to produce errors or not fully exit its Terminal.

**Dotfiles:** Inside 'extras' is the 'dotfiles' folder. Place any files or folder structures in there and HiddenVM will recursively symlink them into your Tails session's Home folder at ``/home/amnesia``. 

This is a very powerful feature. By putting a *.config* folder structure in there you can have all your additional software settings pre-loaded before they're installed via Extras.

Why shouldn't I use Tails' official persistent volume feature?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Tails' `Additional Software <https://tails.boum.org/doc/first_steps/additional_software/index.en.html#index1h2>`_ feature disturbs HiddenVM's complicated ``apt-get update`` wizardry that achieves our Virtual Machine Manager-installing breakthrough.

More importantly, our intention is for HVM's virtual machines to be truly 'hidden', i.e. forensically undetectable. This is the first time you can emulate VeraCrypt's Windows 

`Hidden OS <https://www.veracrypt.fr/en/VeraCrypt%20Hidden%20Operating%20System.html>`_ feature, but this time the plausible deniability hasn't been 
`broken by security researchers <https://www.researchgate.net/publication/318155607_Defeating_Plausible_Deniability_of_VeraCrypt_Hidden_Operating_Systems>`_ and it's for any OS you want.

Due to using LUKS encryption, Tails' persistent volume feature currently offers no anti-forensics for the data in that area of your Tails stick, and is therefore not airport border inspection proof. 
If that ever changes, we would prefer to integrate HiddenVM more elegantly into Tails' existing infrastructure, and we appreciate the wonderful work the Tails devs do.

Is HiddenVM a slap in the face to the whole idea of Tails?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

No, HiddenVM is just an innovative and unexpected use of Tails that people didn't think was possible.

Our project actually pays a high compliment to Tails. We're promoting Tails as an entire platform and ecosystem for aforensic computing, which expands the vision of its benefits for the world. We trust and humbly rely on Tails, Tor, Debian and 
Linux as upstream projects and we feel an extreme sense of responsibility with what we're doing.

We take user privacy, security, and anonymity very seriously and will implement updates to improve the default safety for HiddenVM users over time. For now, we invite you to inspect our code and offer suggestions and contributions that 
improve security without removing functionality or features.

Furthermore, HiddenVM could attract new users to the Tails user base, which would increase its anonymity set, which is beneficial for the Tails community.

Although we don't use Tails' Tor for our main Tor computing and we prefer HVM Whonix instead, we are still promoting and making use of Tails' Tor as a fundamental part of downloading and setting up HiddenVM. Due to Tails being amnesic and connecting 
to the Tor network by default, it's an incredibly safe environment to set up a computer using HiddenVM, and we are promoting this. 

As such, we are normal Tails users and advocates ourselves.

But doesn't Whonix inside Tails mean Tor-over-Tor?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Due to HiddenVM's design, fortunately no. Because it connects to pre-Tor 'clearnet' Internet by default, Whonix-Gateway will connect independently of Tails' own Tor process, making both able to co-exist in the one environment.


Disclaimer
----------

Despite our grand words earlier in this README, any software project claiming increased security, privacy or anonymity can never provide a guarantee for such things, and we are no different here.

As our license states, we are not liable to you for any damages as a result of using our software. Similarly, any claims by our project or its representatives are personal opinions and do not constitute 

legal advice or digital security advice.

The HiddenVM project provides no guarantee of any security, privacy or anonymity as a result of you using our software. You use our software at your own risk, and if or how you use it is your own discretion.
