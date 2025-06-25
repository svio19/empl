# Alternative approach using Node.js serve package
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies including serve globally
RUN npm ci && npm install -g serve

# Copy source code
COPY . .

# Build the app
RUN npm run build

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S reactuser -u 1001

# Change ownership of the app directory
RUN chown -R reactuser:nodejs /app

# Switch to non-root user
USER reactuser

# Expose port 3000
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000 || exit 1

# Start the application using serve
CMD ["serve", "-s", "build", "-l", "3000"]
