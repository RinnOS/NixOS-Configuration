#
# Compositor
#

{ pkgs, ... }:

{
    services.picom = {
        enable = true;
        activeOpacity = "1";
        inactiveOpacity = "1";
        backend = "glx";
        fade = true;
        fadeDelta = 5;
        opacityRule = [
            "95:class_i ?= 'pcmanfm'"
            "95:class_i ?= 'rofi'"
            "80:class_i *= 'discord'"
            "80:class_i *= 'emacs'"
            "80:class_i *= 'Alacritty'"
        ];
        shadow = true;
        shadowOpacity = "0.75";
        menuOpacity = "0.95";
#       blur = true;
#       blurExclude = [
#        "class_i *= 'polybar'"
#       ];
        vSync = true;
    };
}