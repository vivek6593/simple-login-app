# Stage 1: Build Stage
FROM node:16 AS builder

# Set the working directory inside the builder container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json for installing dependencies
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application files
COPY . .

# Stage 2: Runtime Stage
FROM node:16-slim AS runtime

# Set the working directory inside the runtime container
WORKDIR /usr/src/app

# Copy only the necessary files from the builder stage
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/dist ./dist

# Expose the port that the app will run on
EXPOSE 4000

# Command to run the app
CMD ["node", "dist/app.js"]
