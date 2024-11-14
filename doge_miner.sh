#!/bin/bash

echo "Welcome to the Dogecoin mining script!"

# Prompt user for Dogecoin address, worker name, and number of cores
read -p "Enter your Dogecoin address: " doge_address
read -p "Enter the mining worker name: " worker_name
read -p "Enter the number of CPU cores to use for mining: " num_cores

# Check if XMRig is already downloaded
if [ ! -d "xmrig" ]; then
    # Get the latest version from GitHub API directly
    latest_version=$(curl -s https://api.github.com/repos/xmrig/xmrig/releases | grep -m 1 "tag_name" | cut -d'"' -f4 | cut -d'v' -f2)
    
    if [ -z "$latest_version" ]; then
        # If API fails, use the known stable version
        latest_version="6.22.2"
        echo "Could not fetch latest version, using version ${latest_version}"
    else
        echo "Latest version found: ${latest_version}"
    fi
    
    echo "Downloading XMRig version ${latest_version}..."
    
    # Download and extract the latest XMRig release
    wget https://github.com/xmrig/xmrig/releases/download/v${latest_version}/xmrig-${latest_version}-linux-static-x64.tar.gz
    tar -xzf xmrig-${latest_version}-linux-static-x64.tar.gz
    mv xmrig-${latest_version} xmrig
    rm xmrig-${latest_version}-linux-static-x64.tar.gz  # Clean up the tar file
fi

# Run the Dogecoin miner
./xmrig/xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u DOGE:$doge_address.$worker_name -p x -t $num_cores --background

echo "Mining has started. You can check your earnings at unmineable.com."
echo "To check the mining status, you can view the log file with: tail -f xmrig/log.txt"
