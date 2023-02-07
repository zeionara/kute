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
