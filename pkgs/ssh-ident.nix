with import <nixpkgs> {};

stdenv.mkDerivation {

	pname = "ssh-ident";
	version = "66a0010";
	
	src = fetchFromGitHub {
		owner = "ccontavalli";
		repo = "ssh-ident";
		rev = "66a00104057411d85592411455261284d08bb065";
		sha256 = "sha256-ThUEhwfw4B5BBEYU8UJspgMKgN8kgFVGHD43AO1el5g=";
	};

	buildInputs = [ python3 ];

	installPhase = ''
		mkdir -p $out/bin
		cp ssh-ident $out/bin/
		chmod +x $out/bin/ssh-ident
		ln -s $out/bin/ssh-ident $out/bin/ssh
		ln -s $out/bin/ssh-ident $out/bin/sftp
	'';

}
