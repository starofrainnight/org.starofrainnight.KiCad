#!/bin/bash

apt update
# Install add-apt-repository
apt install -y software-properties-common python3-software-properties
add-apt-repository -y ppa:alexlarsson/flatpak
apt update
apt install -y flatpak flatpak-builder
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.gnome.Platform/x86_64/3.26
flatpak install -y flathub org.gnome.Platform.Locale/x86_64/3.26
flatpak install -y flathub org.gnome.Sdk/x86_64/3.26
flatpak install -y flathub org.gnome.Sdk.Locale/x86_64/3.26

echo "Building kicad ..."

flatpak-builder --repo=repo ./build org.sorn.KiCad.yml

echo "Building flatpak bundle ..."

flatpak build-bundle repo kicad.flatpak org.sorn.KiCad
