#!/bin/bash
mount -o rw,union,update /
rm -r /System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/RaptorActivation.pem
mv RaptorActivation.pem /System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/RaptorActivation.pem
chown 444 /System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/RaptorActivation.pem
mkdir /Library/MobileSubstrate/DynamicLibraries/
mv untethered.plist /Library/MobileSubstrate/DynamicLibraries/
mv untethered.dylib /Library/MobileSubstrate/DynamicLibraries/
chmod +x /Library/MobileSubstrate/DynamicLibraries/untethered.dylib
snappy -f / -r `snappy -f / -l | sed -n 2p` -t orig-fs
lzma -d -v boot.tar.lzma
tar -C / -xvf boot.tar && rm -r boot.tar
chmod 755 /usr/libexec/substrate && /usr/libexec/substrate
chmod 755 /usr/libexec/substrated && /usr/libexec/substrated
killall -9 backboardd
mv chflags /usr/bin
chmod +x /usr/bin/chflags
mv iuntethered.dylib /Library/MobileSubstrate/DynamicLibraries/iuntethered.dylib
mv iuntethered.plist /Library/MobileSubstrate/DynamicLibraries/iuntethered.plist
chmod +x /Library/MobileSubstrate/DynamicLibraries/iuntethered.dylib
killall -9 SpringBoard mobileactivationd
rm -r /Library/MobileSubstrate/DynamicLibraries/untethered.dylib
rm -r /Library/MobileSubstrate/DynamicLibraries/untethered.plist
chflags nouchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist
rm -r /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist
mv com.apple.commcenter.device_specific_nobackup.plist /var/wireless/Library/Preferences/
chflags uchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist
rm -r /var/mobile/Library/Logs/mobileactivationd
rm /var/root/reboots.sh
