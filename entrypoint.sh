#!/bin/bash
# Print environment variables to a file
env >> /etc/environment

# Ensure permissions for cron directory
chmod 0644 /etc/cron.d/hello-cron

# Apply cron job
crontab /etc/cron.d/hello-cron

# Start the cron service in the foreground
echo "Starting cron..."
cron -f -L 15
