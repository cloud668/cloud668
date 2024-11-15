
```markdown
# Dogecoin Mining Script

Welcome to the **Dogecoin Mining Script**! This script sets up and runs the [XMRig](https://xmrig.com/) miner to mine Dogecoin via the [unMineable](https://unmineable.com/) pool. It supports both x64 and ARM64 architectures, making it versatile for different devices.

## Features
- Automatically detects system architecture (x64 or ARM64) and downloads the appropriate XMRig binary.
- Configures mining parameters such as Dogecoin wallet address, worker name, and CPU core usage.
- Runs XMRig in the background with a log file for monitoring.

## Requirements
- **Operating System**: Linux (x64 or ARM64)
- **Dependencies**:
  - `wget`
  - `curl`
  - Bash shell

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Swooned5197/dogecoin-cpu-miner.git
   cd dogecoin-cpu-miner
   ```

2. **Run the Script**:
   ```bash
   bash dogecoin_miner.sh
   ```

3. **Follow the Prompts**:
   - Enter your Dogecoin wallet address.
   - Choose a worker name to identify your miner.
   - Specify the number of CPU cores to use for mining.

4. **Monitor Mining Logs**:
   Check mining logs with:
   ```bash
   tail -f xmrig/log.txt
   ```

## How It Works
1. **Architecture Detection**:
   - Detects whether your system is x64 or ARM64.
   - Downloads the appropriate version of XMRig.

2. **Mining Configuration**:
   - Connects to the unMineable pool using your provided Dogecoin wallet address and worker name.
   - Optimizes CPU usage based on the number of cores specified.

3. **Background Mining**:
   - Runs XMRig in the background for uninterrupted mining.
   - Logs mining activity to a file.

## Example
```bash
bash dogecoin_miner.sh
```
- Input: `DQdja...zkg (Dogecoin Address)`
- Input: `worker01 (Worker Name)`
- Input: `4 (Number of CPU Cores)`

## Notes
- Ensure your system has a stable internet connection during setup and mining.
- You can check your mining progress on [unMineable](https://unmineable.com/) by entering your Dogecoin wallet address.

## Contributions
Contributions are welcome! Feel free to submit issues, suggest features, or create pull requests.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---

### Disclaimer
This script is provided for educational purposes. Mining cryptocurrency may have associated costs (e.g., electricity). Ensure you comply with local laws and regulations.

```

