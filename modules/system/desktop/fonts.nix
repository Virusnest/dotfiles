{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    twemoji-color-font
    twitter-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    font-awesome
    dina-font
    proggyfonts
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.fontconfig = {
      enable = true;
      defaultFonts.emoji = [
          "Twitter Color Emoji"
      ];
  };


}