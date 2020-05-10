## Andrew's Linux RICE (ALR)

This repository comprises of the dotfiles I use on Linux. 

Race-Inspired Cosmetic Enhancements (RICE) is a borrowed term from street racing.

This repository includes configuration files for:
  - vim (text editor)
  - zsh (shell)
  - i3wm/i3-gaps (window manager)
  - polybar (status bar)
  - ranger (file manager)
  - compton (X11 compositor)
  - neomutt (email client)
  - calcurse (terminal calendar utility)
  - newsboat (RSS feed)

It contains also various scripts which, among other things, pull the latest Vim and build from source with desired options, set the desktop background and refresh, and change the current Xresources theme.

Finally, it contains a fork of LukeSmith's st (Suckless terminal emulator) build.

### Current work
Writing scripts to better support switching monitor setups. Right now, there's no easy way to rotate a screen, and should I choose to close my laptop, the screen is still on and accessible. Polybar is missing useful information in some setups.

### Plans
- Create an interactive installation script to make it easier to turn a fresh install of Ubuntu into my current setup. 
- Write a document which contains notes on different pitfalls which are outside of these dotfiles. The HDMI audio hack on [this page](https://wiki.archlinux.org/index.php/PulseAudio/Examples#HDMI_output_configuration), correctly configuring /etc/mailcap for NeoMutt, and properly installing LaTeX come to mind.
- Transition to more Suckless software. i3 to dwm is a very large change, but one which I'd eventually like to try.
- Expand my use of rofi, and imitate Spotlight search on MacOS.

