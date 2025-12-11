
# home/programs/personaluse/spotify.nix
{ config, lib, pkgs, spicetify-nix, ... }:

let
  # 💡 ВОЗВРАЩАЕМСЯ К СИНТАКСИСУ LEGACYPACKAGES 
  # для гарантированного доступа к расширениям/темам
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.spicetify = {
    enable = true;

    # Используем spicePkgs
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      autoSkipVideo
      volumePercentage
    ];
    
    enabledSnippets = with spicePkgs.snippets; [ ];
    
    # 💥 ИСПРАВЛЕНИЕ: Используем spicePkgs.themes
    theme = spicePkgs.themes.comfy; 
    colorScheme = "Nord";
  };
}
