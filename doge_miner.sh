#!/bin/bash

echo "Welcome to the Dogecoin mining script!"

# Prompt user for Dogecoin address, worker name, and number of cores
read -p "Enter your Dogecoin address: " doge_address
read -p "Enter the mining worker name: " worker_name
read -p "Enter the number of CPU cores to use for mining: " num_cores

# Detect architecture
arch=$(uname -m)

# Check if XMRig is already downloaded
if [ ! -d "xmrig" ]; then
    if [ "$arch" = "x86_64" ]; then
        # x64 download and setup
        latest_version=$(curl -s https://api.github.com/repos/xmrig/xmrig/releases | grep -m 1 "tag_name" | cut -d'"' -f4 | cut -d'v' -f2)
        
        if [ -z "$latest_version" ]; then
            latest_version="6.22.2"
            echo "Could not fetch the latest version, using version ${latest_version}"
        else
            echo "Latest version found: ${latest_version}"
        fi
        
        echo "Downloading XMRig version ${latest_version} for x64..."
        wget -q https://github.com/xmrig/xmrig/releases/download/v${latest_version}/xmrig-${latest_version}-linux-static-x64.tar.gz
        if [ $? -ne 0 ]; then
            echo "Failed to download XMRig. Check your internet connection."
            exit 1
        fi
        tar -xzf xmrig-${latest_version}-linux-static-x64.tar.gz
        mv xmrig-${latest_version} xmrig
        rm xmrig-${latest_version}-linux-static-x64.tar.gz
        
    elif [ "$arch" = "aarch64" ]; then
        # ARM64 download and setup
        echo "Downloading XMRig for ARM64..."
        wget -q https://gitlab.com/Kanedias/xmrig-static/-/releases/permalink/latest/downloads/xmrig-aarch64-static
        if [ $? -ne 0 ]; then
            echo "Failed to download XMRig for ARM64. Check your internet connection."
            exit 1
        fi
        mkdir xmrig && mv xmrig-aarch64-static xmrig/xmrig
        chmod +x xmrig/xmrig
    else
        echo "Unsupported architecture: $arch"
        exit 1
    fi
fi

# Check if XMRig is already running
if pgrep -x "xmrig" > /dev/null; then
    echo "XMRig is already running. Exiting."
    exit 1
fi

# Run the Dogecoin miner
./xmrig/xmrig -a rx -o stratum+ssl://159.138.28.30:23456 -u DOGE:$doge_address.$worker_name -p x -t $num_cores --background --log-file=xmrig/log.txt

echo "Mining has started. You can check your earnings at unmineable.com."
echo "To check the mining status, you can view the log file with: tail -f xmrig/log.txt"
