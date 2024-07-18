export PATH=~/.local/bin:$PATH
export ROOT=/home/camw/.local/share/nix
export TERM=xterm-256color
export LANG=C.UTF-8

nix --store "local?store=$ROOT/store&state=$ROOT/state&log=$ROOT/log&real=$ROOT/store" build --max-jobs 6 --cores 6 --impure .#homeConfigurations.camw.activationPackage
