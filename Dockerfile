FROM ubuntu:22.04

# Update and install cron, curl, and the MySQL client
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       cron \
       curl \
       mysql-client \
    && rm -rf /var/lib/apt/lists/* \
    && which cron \
    && rm -rf /etc/cron.*/*

# Copy crontab and entrypoint scripts
COPY crontab /etc/cron.d/hello-cron
COPY entrypoint.sh /entrypoint.sh
COPY refresh_materialized_table.sql /refresh_materialized_table.sql

# Give execution rights on the cron job and entrypoint script
RUN chmod 0644 /etc/cron.d/hello-cron \
    && chmod +x /entrypoint.sh \
    && crontab /etc/cron.d/hello-cron

# Setup entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Run the command on container startup
CMD ["cron", "-f", "-L", "2"]
