# Use the official Node.js image as a base
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock to install dependencies
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Expose the port that your MedusaJS server runs on
EXPOSE 9000

# Start the MedusaJS server
CMD ["yarn", "start"]

