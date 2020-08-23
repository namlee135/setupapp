#!/bin/bash

if ! which curl >> /dev/null; then
    echo "Error: curl not found"
    exit 1
fi

if ! which iproxy >> /dev/null; then
    echo "Error: iproxy not found"
    exit 1
fi

rm -rf ~/.ssh/known_hosts

cd "`dirname "$0"`"

idevicepair pair

iproxy 1025 44 2> /dev/null &

echo '#!/bin/bash' > respring.sh
echo 'mount -o rw,union,update /' >> respring.sh
echo 'rm -r /System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/RaptorActivation.pem' >> respring.sh
echo 'mv RaptorActivation.pem /System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/RaptorActivation.pem' >> respring.sh
echo 'chown 444 /System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/RaptorActivation.pem' >> respring.sh
echo 'snappy -f / -r `snappy -f / -l | sed -n 2p` -t orig-fs' >> respring.sh
echo 'mv lzma /usr/bin/' >> respring.sh
echo 'chmod +x /usr/bin/lzma' >> respring.sh
echo 'lzma -d -v boot.tar.lzma' >> respring.sh
echo 'tar -C / -xvf boot.tar && rm -r boot.tar' >> respring.sh
echo 'mv untethered.plist /Library/MobileSubstrate/DynamicLibraries/' >> respring.sh
echo 'mv untethered.dylib /Library/MobileSubstrate/DynamicLibraries/' >> respring.sh
echo 'chmod +x /Library/MobileSubstrate/DynamicLibraries/untethered.dylib' >> respring.sh
echo 'chmod 755 /usr/libexec/substrate && /usr/libexec/substrate' >> respring.sh
echo 'chmod 755 /usr/libexec/substrated && /usr/libexec/substrated' >> respring.sh
echo 'killall -9 backboardd' >> respring.sh
echo 'mv chflags /usr/bin' >> respring.sh
echo 'chmod +x /usr/bin/chflags' >> respring.sh
echo 'mv iuntethered.dylib /Library/MobileSubstrate/DynamicLibraries/iuntethered.dylib' >> respring.sh
echo 'mv iuntethered.plist /Library/MobileSubstrate/DynamicLibraries/iuntethered.plist' >> respring.sh
echo 'chmod +x /Library/MobileSubstrate/DynamicLibraries/iuntethered.dylib' >> respring.sh
echo 'killall -9 SpringBoard mobileactivationd' >> respring.sh
echo 'rm -r /Library/MobileSubstrate/DynamicLibraries/untethered.dylib' >> respring.sh
echo 'rm -r /Library/MobileSubstrate/DynamicLibraries/untethered.plist' >> respring.sh
echo 'chflags nouchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist' >> respring.sh
echo 'rm -r /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist' >> respring.sh
echo 'mv com.apple.commcenter.device_specific_nobackup.plist /var/wireless/Library/Preferences/' >> respring.sh
echo 'chflags uchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist' >> respring.sh
echo 'rm -r /var/mobile/Library/Logs/mobileactivationd' >> respring.sh
echo 'rm -rf /usr/libexec/substrate' >> respring.sh
echo 'rm -rf /usr/libexec/substrated' >> respring.sh
echo 'rm -rf /usr/bin/cycc' >> respring.sh
echo 'rm -rf /usr/bin/cynject' >> respring.sh
echo 'rm -rf /usr/include/substrate.h' >> respring.sh
echo 'rm -rf /usr/lib/cycript0.9' >> respring.sh
echo 'rm -rf /usr/lib/libsubstrate.dylib' >> respring.sh
echo 'rm -rf /usr/lib/substrate' >> respring.sh
echo 'rm -rf /Library/Frameworks/CydiaSubstrate.framework' >> respring.sh
echo 'rm -rf /Library/MobileSubstrate' >> respring.sh
echo 'uicache --all' >> respring.sh
echo 'killall -9 backboardd' >> respring.sh
echo 'rm /var/root/respring.sh' >> respring.sh

chmod +x sshpass

./sshpass -p alpine scp -rP 1025 -o StrictHostKeyChecking=no lzma boot.tar.lzma chflags RaptorActivation.pem untethered.dylib com.apple.commcenter.device_specific_nobackup.plist untethered.plist iuntethered.dylib iuntethered.plist respring.sh root@localhost:/var/root/

./sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 1025 "bash /var/root/respring.sh"
