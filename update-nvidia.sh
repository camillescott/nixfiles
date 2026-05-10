NVIDIA_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)
echo New NVIDIA version: $NVIDIA_VERSION
echo Prefecting nix package...
nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/$NVIDIA_VERSION/NVIDIA-Linux-x86_64-$NVIDIA_VERSION.run
echo Update linux/default.nix with new version and hash
echo Run home-manager switch
echo Run provided non-nixos-gpu-setup command
