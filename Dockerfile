# Use the official Nginx image as the base image
FROM nginx

# Install Certbot
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx && \
    rm -rf /var/lib/apt/lists/*

# Expose port 80 and port 443
EXPOSE 80
EXPOSE 443

# Copy custom Nginx configuration (if needed)
COPY nginx.conf /etc/nginx/nginx.conf

# Copy custom website content (if needed)
COPY src /usr/share/nginx/html

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

