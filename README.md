# Network Speed Test Logger

This project provides a script to log network speed test results to a CSV file. The script uses `speedtest` and `jq` to perform the speed test and parse the results, respectively.

## Prerequisites

- `speedtest` (by Ookla)
- `jq`

## Installation

1. Install `speedtest`:
    ```sh
    sudo apt-get install speedtest-cli
    ```

2. Install `jq`:
    ```sh
    sudo apt-get install jq
    ```

## Usage

1. Clone the repository:
    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2. Make the script executable:
    ```sh
    chmod +x network_speed_test.sh
    ```

3. Run the script:
    ```sh
    ./network_speed_test.sh
    ```

## Output

The script logs the network speed test results to [network_speed_log.csv](http://_vscodecontentref_/0) with the following columns:
- Timestamp
- Server Name
- Server Location
- ISP
- Latency (ms)
- Jitter (ms)
- Download Speed (Mbps)
- Upload Speed (Mbps)
- Packet Loss (%)
- Result URL

## Example

Example of a log entry in [network_speed_log.csv](http://_vscodecontentref_/1):
```csv
"2025-02-21 17:10:03","YTL Broadband","Kuala Lumpur","TM Net","8.61","0.369","97.2481","49.6006","0","https://www.speedtest.net/result/c/d73e915d-8c02-46ae-9cfa-0d03b3f5899a"


