# ---- Build Stage ----

# syntax=docker.io/docker/dockerfile:1
FROM node:22-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci --only=production

COPY . .

# ---- Runtime Stage ----
FROM node:22-alpine AS runner

WORKDIR /app
COPY --from=builder /app ./

EXPOSE 4000

CMD ["npm", "start"]
