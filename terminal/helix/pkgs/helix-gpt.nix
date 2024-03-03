{pkgs, fetchurl, ...}:
# with import <nixpkgs> {};
# todo: make this pure (we have to fkn use the --impure flag bcz im too fkn retarded to fix this shit fuck me)
# github: https://github.com/leona/helix-gpt
pkgs.stdenv.mkDerivation rec {
  pname = "helix-gpt";
  version = "0.28";
  
  src = fetchurl {
    url = "https://github.com/leona/helix-gpt/releases/download/0.28/helix-gpt-${version}.js";
    sha256 = "sha256-8Uuzvg8XqYy96ITGr7W4riLjLj7uW6DrffuZO5Bctb4";
  };

  buildInputs = [
    pkgs.bun
  ];
  
  phases = ["installPhase" "patchPhase"];

  # source: https://github.com/NixOS/nixpkgs/issues/255890
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp $src $out/bin/helix-gpt
    
    chmod +x $out/bin/helix-gpt
    
    runHook postInstall
  '';
}

