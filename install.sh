#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
NC='\033[0m'
SCRIPTPATH=`dirname $(realpath $0)`
INSTALLDIR="/opt"

if [[ $EUID -ne 0 ]]; then
  echo -e "${RED}Please run as root"${NC} 2>&1
  exit 1
fi

cd $INSTALLDIR

echo -e "${GREEN}Installing nodejs${NC}"
apt-get install -y apt-transport-https curl
curl -o /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n
chmod +x /usr/local/bin/n
n lts

echo -e "${GREEN}Installing other dependencies${NC}"
apt-get install -y build-essential redis-server libpng-dev git python-minimal nfs-common

echo -e "${GREEN}Installing yarn${NC}"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get -y install yarn

echo -e "${GREEN}Cloning xo repositories${NC}"
git config --global url."https://".insteadOf git://
git clone -b stable http://github.com/vatesfr/xo-server
git clone -b stable http://github.com/vatesfr/xo-web

echo -e "${GREEN}Copying configuration${NC}"
cd xo-server
cp ${SCRIPTPATH}/config/.xo-server.yaml .xo-server.yaml

echo -e "${GREEN}Building xo-server${NC}"
yarn

echo -e "${GREEN}Building xo-web${NC}"
cd ../xo-web/
yarn

echo -e "${GREEN}Enable xo-server on startup${NC}"
cp ${SCRIPTPATH}/config/xo-server.service /etc/systemd/system/xo-server.service
chmod +x /etc/systemd/system/xo-server.service
systemctl enable xo-server.service

echo -e "${GREEN}Starting xo-server${NC}"
systemctl start xo-server.service
systemctl status xo-server.service
