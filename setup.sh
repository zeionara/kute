quit () {
    echo $1
    exit 1
}

# 1. Install kvm

sudo apt -y install bridge-utils cpu-checker libvirt-clients libvirt-daemon qemu qemu-kvm

# 2. Download minikube installation script

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 || quit 'Cannot download minikube installation script'
chmod +x minikube

# 3. Install minikube

sudo mkdir /usr/local/bin || quit 'Cannot create directory for installing minikube'
sudo install minikube /usr/local/bin || quit 'Cannot install minikube'

rm minikube || quit 'Cannot delete minikube executable'

install_swift () {
    archive_path=${0:-/tmp/swift.tar.gz}

    wget https://download.swift.org/swift-5.7.3-release/ubuntu2204/swift-5.7.3-RELEASE/swift-5.7.3-RELEASE-ubuntu22.04.tar.gz -O $archive_path || quit 'Cannot download swift'
    tar -xzvf $archive_path || quit 'Cannot unpack swift installation'
    rm $archive_path || quit 'Cannot remove downloaded archive'

    swift_root=/usr/local/swift-5.7.3
    sudo mv swift-5.7.3-RELEASE-ubuntu22.04 $swift_root || quit 'Cannot move unpacked folder'
    echo -e "\nexport PATH=\$PATH:$swift_root/usr/bin" >> ~/.bashrc || quit 'Cannot update bashrc'

    # if doesn't work, try installing version for ubuntu 18.04 instead of 22.04
}

# 4. Install swift

swift -v || install_swift || quit 'Cannot install swift'
