self: super: {
    nix = super.nix.overrideAttrs (old: { 
        doCheck = false; 
        doInstallCheck = false; 
    });
}
