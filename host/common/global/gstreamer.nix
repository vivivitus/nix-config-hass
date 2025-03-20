{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.gst_all_1; [
    gstreamer
    gst-plugins-bad
    gst-plugins-ugly
    gst-plugins-base
    gst-plugins-good
  ];
}