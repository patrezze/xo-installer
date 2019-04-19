#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
NC='\033[0m'
SCRIPTPATH=$(dirname "$(realpath "$0")")
INSTALLDIR="/opt"

if [[ $EUID -ne 0 ]]; then
  echo -e "${RED}Please run as root${NC}" 2>&1
  exit 1
fi

cd ${INSTALLDIR} || exit

echo -e "${GREEN}Installing nodejs${NC}"
apt-get install -y apt-transport-https curl
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs

echo -e "${GREEN}Installing yarn${NC}"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get -y install yarn

echo -e "${GREEN}Installing other dependencies${NC}"
apt-get install -y build-essential redis-server libpng-dev git python-minimal libvhdi-utils lvm2 cifs-utils

echo -e "${GREEN}Cloning xen-orchestra repository${NC}"
git clone -b master http://github.com/vatesfr/xen-orchestra

echo -e "${GREEN}Building xen-orchestra${NC}"
cd xen-orchestra || exit
yarn
yarn build

echo -e "${GREEN}Copying configuration${NC}"
cd packages/xo-server || exit
cp "${SCRIPTPATH}"/config/.xo-server.toml .xo-server.toml
cp "${SCRIPTPATH}"/config/xo-server.service /etc/systemd/system/xo-server.service

echo -e "${GREEN}Linking modules${NC}"
mkdir -p /usr/local/lib/node_modules 
ln -sv /opt/xen-orchestra/packages/xo-server-auth-ldap /usr/local/lib/node_modules/
ln -sv /opt/xen-orchestra/packages/xo-server-backup-reports /usr/local/lib/node_modules/
ln -sv /opt/xen-orchestra/packages/xo-server-load-balancer /usr/local/lib/node_modules/
ln -sv /opt/xen-orchestra/packages/xo-server-perf-alert /usr/local/lib/node_modules/
ln -sv /opt/xen-orchestra/packages/xo-server-transport-email /usr/local/lib/node_modules/
ln -sv /opt/xen-orchestra/packages/xo-server-transport-nagios /usr/local/lib/node_modules/
ln -sv /opt/xen-orchestra/packages/xo-server-transport-slack /usr/local/lib/node_modules/
ln -sv /opt/xen-orchestra/packages/xo-server-transport-xmpp /usr/local/lib/node_modules/

echo -e "${GREEN}Enable xen-orchestra on startup${NC}"
chmod +x /etc/systemd/system/xo-server.service
systemctl enable xo-server.service

echo -e "${GREEN}Starting xen-orchestra${NC}"
systemctl start xo-server.service
systemctl status xo-server.service

echo ""
echo -e "${GREEN}Xen Orchestra installed${NC}"
echo -e "Default user: \"admin@admin.net\" with password \"admin\""
echo ""
