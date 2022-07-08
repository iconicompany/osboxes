# https://www.linuxcapable.com/how-to-install-chromium-browser-on-ubuntu-22-04-lts/
sudo add-apt-repository ppa:savoury1/chromium -y
#breaks opencv-dev, to remove issue command sudo ppa-purge ppa:savoury1/ffmpeg4^
#sudo add-apt-repository ppa:savoury1/ffmpeg4 -y
sudo apt-get update
sudo apt install chromium-browser -y
