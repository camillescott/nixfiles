# nixfiles

Configuration for using the Nix home-manager utility to manage user programs and configuration
files.

Assuming Nix is installed, add necessary channels and install `home-manager`. We also add the
`nixGL` channel here, which allows for properly functioning openGL applications when the graphical
session is not being managed by nix (see the relevant
[issue](https://github.com/nix-community/home-manager/issues/2251)).

    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl
    nix-channel --update
    nix-shell '<home-manager>' -A install

Remove the default configuration:

    rm -r ~/.config/nixpkgs

Clone this repo:

    git clone git@github.com:camillescott/nixfiles.git

Link it into the expected location:

    cd ~/.config
    ln -s ~/nixfiles nixpkgs

Link the appropriate entrypoint file (`home-linux.nix` or `home-darwin.nix`):

    cd ~/nixfiles
    ln -s home-linux.nix home.nix

Activate using:

    home-manager switch

## Useful References

I've been putting this together by learning from a variety of sources. There are a few tutorials:

1. https://ghedam.at/24353/tutorial-getting-started-with-home-manager-for-nix
2. https://alexpearce.me/2021/07/managing-dotfiles-with-nix/

As well as the home-manager and Nix documentation and GitHub issues:

* Manual: https://nix-community.github.io/home-manager/
* Configuration options: https://nix-community.github.io/home-manager/options.html
* Getting expected hash values for `fetchFromGitHub` pkgs: https://github.com/NixOS/nix/issues/1880
* The home-manager zsh module source: https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix#L222
