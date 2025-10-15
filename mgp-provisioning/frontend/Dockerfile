FROM node:22-alpine

WORKDIR /app

# Install dependencies first (for caching)
COPY package.json package-lock.json* ./
RUN npm install

# Copy app source
COPY . .

# Expose Next.js dev port
EXPOSE 3000

# Run Next.js in dev mode
CMD ["npm", "run", "dev"]