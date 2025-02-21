#!/bin/bash

# Get script directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")
LOG_FILE="$SCRIPT_DIR/network_speed_log.csv"

# Check if jq and speedtest are installed
if ! command -v speedtest &> /dev/null || ! command -v jq &> /dev/null; then
    echo "Error: 'speedtest' and 'jq' are required but not installed." >&2
    exit 1
fi

# Create log file with headers if it does not exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Timestamp,Server Name,Server Location,ISP,Latency (ms),Jitter (ms),Download Speed (Mbps),Upload Speed (Mbps),Packet Loss (%),Result URL" > "$LOG_FILE"
fi

# Run speed test and capture output
RESULT=$(speedtest --format=json 2>/dev/null)

# Check if speedtest was successful
if [ -z "$RESULT" ] || [[ "$RESULT" == *"error"* ]]; then
    echo "Error: Speedtest failed. Check your internet connection." >&2
    exit 1
fi

# Extract values using jq
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
SERVER_NAME=$(echo "$RESULT" | jq -r '.server.name // "Unknown"')
SERVER_LOCATION=$(echo "$RESULT" | jq -r '.server.location // "Unknown"')
ISP=$(echo "$RESULT" | jq -r '.isp // "Unknown"')
LATENCY=$(echo "$RESULT" | jq -r '.ping.latency // "N/A"')
JITTER=$(echo "$RESULT" | jq -r '.ping.jitter // "N/A"')
DOWNLOAD=$(echo "$RESULT" | jq -r '.download.bandwidth // 0' | awk '{print $1 / 125000}')
UPLOAD=$(echo "$RESULT" | jq -r '.upload.bandwidth // 0' | awk '{print $1 / 125000}')
PACKET_LOSS=$(echo "$RESULT" | jq -r '.packetLoss // "N/A"')
RESULT_URL=$(echo "$RESULT" | jq -r '.result.url // "N/A"')

# Append results to log file
echo "\"$TIMESTAMP\",\"$SERVER_NAME\",\"$SERVER_LOCATION\",\"$ISP\",\"$LATENCY\",\"$JITTER\",\"$DOWNLOAD\",\"$UPLOAD\",\"$PACKET_LOSS\",\"$RESULT_URL\"" >> "$LOG_FILE"

# Output result to terminal in a clean format
echo "------------------------------------------"
echo "Speed Test Completed at: $TIMESTAMP"
echo "Server: $SERVER_NAME ($SERVER_LOCATION)"
echo "ISP: $ISP"
echo "Latency: $LATENCY ms | Jitter: $JITTER ms"
echo "Download Speed: $DOWNLOAD Mbps"
echo "Upload Speed: $UPLOAD Mbps"
echo "Packet Loss: $PACKET_LOSS %"
echo "Full Results: $RESULT_URL"
echo "------------------------------------------"

