# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/var/log/nginx", "/var"]

# Add project specific files
ADD default /etc/nginx/sites-enabled/default
ADD start_nginx.sh /etc/nginx/
WORKDIR /etc/nginx
RUN chmod u+x start_nginx.sh

# Define default command.
CMD ["./start_nginx.sh"]

# Expose ports.
EXPOSE 80
EXPOSE 443
