#!/bin/bash

# Print environment variables to a file
echo "Setting up environment variables..."
env >> /etc/environment

# Make sure the cron service has the right permissions
echo "Setting permissions..."
chmod 0644 /etc/cron.d/hello-cron
crontab /etc/cron.d/hello-cron

# Start the cron service in the foreground
echo "Starting cron..."
cron -f -L 15
