```markdown
# Dogecoin CPU Miner Script

Automated script for CPU mining Dogecoin using XMRig through unMineable pool. This script automatically downloads the latest version of XMRig and configures it for Dogecoin mining.

## Features

- Automatic download and setup of latest XMRig release
- Interactive configuration with user prompts  
- Custom worker name support
- Adjustable CPU core usage
- Background mining process

## Requirements

- Linux-based operating system
- Internet connection  
- Dogecoin wallet address

## Quick Start

1. Download the script:
```bash
wget [https://raw.githubusercontent.com/yourusername/dogecoin-cpu-miner/main/doge_miner.sh](https://raw.githubusercontent.com/Swooned5197/dogecoin-cpu-miner/refs/heads/main/doge_miner.sh)
```

2. Make it executable:
```bash
chmod +x doge_miner.sh
```

3. Run the script:
```bash
./doge_miner.sh  
```

## Usage

The script will prompt you for:
1. Your Dogecoin wallet address
2. Worker name (for identification on unMineable)  
3. Number of CPU cores to use

## Script Content
```bash
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
```

## Monitoring

Check mining status:
```bash
tail -f xmrig/log.txt
```

Monitor your earnings at [unMineable.com](https://unmineable.com)

## Warning

- Mining cryptocurrency is resource-intensive
- May increase electricity consumption
- Please mine responsibly
- Monitor your hardware temperature

## License

MIT License

Copyright (c) 2024 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Disclaimer

This script is provided as-is without warranty. Use at your own risk. Please ensure cryptocurrency mining is legal in your jurisdiction.
```
