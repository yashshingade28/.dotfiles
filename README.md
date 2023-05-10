# .dotfiles

This repository contains my personal dotfiles for configuring Linux environments. These dotfiles are tailored to my personal preferences and workflows, but you are free to use them as a starting point for your own configuration.

## Prerequisites
To use these dotfiles, you must have the following software installed on your Linux system:
- Git
- [Nerd Fonts](https://www.nerdfonts.com/) (optional, but recommended)

## Installation
To install my dotfiles, follow these steps:
1) Clone this repository by entering the following command:
```bash
git clone --recursive https://github.com/yashshingade28/.dotfiles ~/.dotfiles
```
This will download the dotfiles repository into a new directory named .dotfiles in your home directory.

## Setup
Now that you have my dotfiles placed in the correct folder you can configure the various tools i use by following these commands.

<details>
  <summary>zsh</summary>
Run the following command to setup my zsh config.

```bash
bash ~/.dotfiles/setup.sh zsh
```
Note: To enable my zsh config you must first have zsh installed on your system. You can see how to install zsh on your system [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH).  
</details>

<details>
  <summary>kitty</summary>
Run the following command to setup my kitty config.

```bash
bash ~/.dotfiles/setup.sh kitty
```
</details>

<details>
  <summary>alacritty</summary>
Run the following command to setup my alacritty config.

```bash
bash ~/.dotfiles/setup.sh alacritty
```
</details>

<details>
  <summary>fonts</summary>
Run the following command to setup my fonts for the current user.

```bash
bash ~/.dotfiles/setup.sh fonts
```
Note: Please note that this command will load all the fonts present in the ~/.local/share/fonts directory for the current user, but it will not automatically set any font as the default. You will need to manually set your desired font in your system settings or in your application's font preferences.  
</details>

<details>
  <summary>tmux</summary>
Run the following command to setup my tmux config.

```bash
bash ~/.dotfiles/setup.sh tmux
```
Note: Thanks to [Grégory Pakosz](https://github.com/gpakosz) for his amazing [tmux configs](https://github.com/gpakosz/.tmux) from which i've borrowed most of my tmux configuration.
</details>

## Customization
Feel free to modify these dotfiles to suit your own preferences and workflows. Also let me know if i can improve any of my configs or any part of my workflow.
