{ pkgs, ... }:
# let
#   get-a-gal = pkgs.stdenv.mkDerivation {
#     name = "get-a-gal";
#     version = "1.0";

#     # Spécifiez le chemin vers la source
#     src = builtins.fetchGit {
#       url = "ssh://git@github.com/Arut0ria/get-a-gal.git";
#       ref = "master";
#       rev = "a14ec59c964409a03ae9ac1a9f2c851ea99f9b04";
#       allRefs = true;
#     };

#     installPhase = ''
#       mkdir -p $out/bin
#       cp src/main.py $out/bin/main.py

#       # Install images into the package
#       cp -r images $out/images
#     '';

#     buildInputs = with pkgs; [
#       python3
#     ];

#     # Meta-informations
#     meta = with pkgs.lib; {
#       description = "Get a Gal - Simple image getter";
#       maintainers = [ "Arut0ria" ];
#     };
#   };
# in
# {
#   environment.systemPackages = with pkgs; [
#     get-a-gal
#   ];
# }

pkgs.stdenv.mkDerivation {
  name = "get-a-gal";
  version = "1.0";

  # Spécifiez le chemin vers la source
  src = builtins.fetchGit {
    url = "ssh://git@github.com/Arut0ria/get-a-gal.git";
    ref = "master";
    rev = "a14ec59c964409a03ae9ac1a9f2c851ea99f9b04";
    allRefs = true;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp src/main.py $out/bin/main.py
    chmod +x $out/bin/main.py

    # Install images into the package
    cp -r images $out/images
  '';

  buildInputs = with pkgs; [
    python3
  ];

  # Meta-informations
  meta = with pkgs.lib; {
    description = "Get a Gal - Simple image getter";
    maintainers = [ "Arut0ria" ];
  };
}
