# Clone repository and compile Radeon-TOP
cd ${DATA_DIR}
git clone https://github.com/clbr/radeontop
cd ${DATA_DIR}/radeontop
git checkout v$LAT_V
make -j${CPU_COUNT}

# Create directories and copy files to destination
mkdir -p ${DATA_DIR}/radeontop-$LAT_V/usr/bin ${DATA_DIR}/radeontop-$LAT_V/usr/share/libdrm ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/usr ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/lib ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/images
cp ${DATA_DIR}/radeontop/radeontop ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/usr/
cp /usr/lib/x86_64-linux-gnu/libdrm.so.2 /usr/lib/x86_64-linux-gnu/libdrm.so.2.4.0 ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/lib
cp /usr/lib/x86_64-linux-gnu/libdrm_amdgpu.so.1 /usr/lib/x86_64-linux-gnu/libdrm_amdgpu.so.1.0.0 ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/lib
cp /lib/x86_64-linux-gnu/libncursesw.so.6 /lib/x86_64-linux-gnu/libncursesw.so.6.2 ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/lib
cp /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.6.2 ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/lib
cp /usr/share/libdrm/amdgpu.ids ${DATA_DIR}/radeontop-$LAT_V/usr/share/libdrm/
# Create wrapper script and move it to destination
echo '#!/bin/bash
# Wrapper script for 'radeontop' by ich777 for Unraid
LD_LIBRARY_PATH=/usr/local/emhttp/plugins/radeontop/lib /usr/local/emhttp/plugins/radeontop/bin/radeontop "$@"' > ${DATA_DIR}/radeontop-$LAT_V/usr/bin/radeontop
wget -q -O ${DATA_DIR}/radeontop-$LAT_V/usr/local/emhttp/plugins/radeontop/images/radeontop.png https://raw.githubusercontent.com/ich777/docker-templates/master/ich777/images/radeontop.png
mkdir -p ${DATA_DIR}/v$LAT_V
cd ${DATA_DIR}/radeontop-$LAT_V/
chmod -R 755 ${DATA_DIR}/radeontop-$LAT_V/

# Create Slackware package
makepkg -l y -c y ${DATA_DIR}/v$LAT_V/$APP_NAME-"$(date +'%Y.%m.%d')".tgz
cd ${DATA_DIR}/v$LAT_V
md5sum $APP_NAME-"$(date +'%Y.%m.%d')".tgz > $APP_NAME-"$(date +'%Y.%m.%d')".tgz.md5