# syntax=docker.io/docker/dockerfile:1

FROM node:22-alpine AS base

FROM base AS builder

WORKDIR /app

# Install dependencies first (for caching)
COPY package.json package-lock.json* ./
# Ommit --production flag for Typescript devDependencies
RUN npm ci

COPY src ./src
COPY public ./public
COPY next.config.ts .
COPY tsconfig.json .
COPY postcss.config.mjs .

RUN npm run build

# Note: It is not necessary to add an intermediate step that does a full copy of `node_modules` here

FROM base AS runner

WORKDIR /app

# Don't run production as root
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
USER nextjs

# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=builder --chown=nextjs:nodejs /app/public ./public

EXPOSE 3000

CMD ["node", "server.js"]