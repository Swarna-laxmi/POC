#!/bin/bash

set -euo pipefail  # Safe scripting: exit on error, undefined var, or pipe fail

# --- Default values ---
LOG_FILE="script.log"
NAME="User"

# --- Parse arguments ---
while [[ $# -gt 0 ]]; do
  case $1 in
    --name)
      NAME="$2"
      shift 2
      ;;
    *)
      echo "❌ Unknown option: $1"
      exit 1
      ;;
  esac
done

# --- Logging function ---
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# --- Start Script ---
log "🔁 Script started by $NAME"
log "📂 Current directory: $(pwd)"
log "📦 Disk usage:"
df -h | tee -a "$LOG_FILE"

# --- Check if 'logs/' folder exists ---
if [[ -d logs ]]; then
  log "📁 'logs/' directory found. Listing contents:"
  for file in logs/*; do
    log " - $file ($(du -h "$file" | cut -f1))"
  done
else
  log "⚠️  No 'logs/' directory found. Creating one..."
  mkdir logs
fi

# --- Environment info ---
log "👤 Running as: $(whoami)"
log "⏱️  System uptime: $(uptime -p)"

# --- Exit message ---
log "✅ Script completed successfully."
