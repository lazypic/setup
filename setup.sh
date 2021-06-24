set -e

# Graphic Driver
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/460.84/NVIDIA-Linux-x86_64-460.84.run
dnf groupinstall "Development Tools"
dnf install libglvnd-devel elfutils-libelf-devel
grub2-editenv -set "$(grub2-editenv - list | grep kernelopts) nouveau.modeset=0"

# NAS
mkdir /mnt/drnss
echo "username=" >> /etc/.drnss_credentials
echo "password=" >> /etc/.drnss_credentials
echo "//nas.kzmdstu.com/drnss /mnt/drnss cifs defaults,uid=1000,gid=1000,credentials=/etc/.drnss_credential"

# Flathub for following Apps
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Firefox
flatpak install --noninteractive flathub org.mozilla.firefox
rm /usr/share/applications/firefox.desktop

# Blender
flatpak install --noninteractive flathub org.blender.Blender

# Gimp
flatpak install --noninteractive flathub org.gimp.GIMP

# Finally, install Gnome GUI Environ.
dnf groupinstall workstation
systemctl set-default graphical.target
systemctl isolate graphical
