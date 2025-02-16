# Start from Apline linux
FROM alpine:3.18

# Build args
ARG UID=5000
ARG GID=5000

# Add packages
RUN apk add --no-cache python3 python3-dev py3-pip # For octoprint
RUN apk add gcc musl-dev linux-headers python3-dev # For compiling plugins

# Create users
RUN addgroup -g $GID octoprint
RUN adduser -s /sbin/nologin -G octoprint -D -u $UID octoprint

# Install supervisor for controlling octocam (need just supervisorctl)
RUN apk add supervisor
RUN chown octoprint:octoprint /etc/supervisord.conf

# Install octoprint 
RUN pip install wheel 
RUN pip install OctoPrint

# Drop root
USER octoprint

# Create config files
RUN mkdir -p /home/octoprint/config /home/octoprint/plugins /home/octoprint/.local/lib/python3.11
RUN ln -s /home/octoprint/plugins /home/octoprint/.local/lib/python3.11/site-packages

# Run octoprint 
CMD ["octoprint", "serve", "--basedir=/home/octoprint/config/current"]
