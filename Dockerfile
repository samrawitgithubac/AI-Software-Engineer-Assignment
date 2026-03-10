# Use Node.js LTS as base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json first for better caching
COPY package.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Run tests by default
CMD ["npm", "test"]
