FROM node:20.10.0-slim AS build

WORKDIR /usr/src/app

# Installing typescript for transpiling
RUN npm install -g typescript@5.5.4

# Copying package and package lock
COPY package*.json ./

# Installing dependencies
RUN npm ci

# Copying rest of the code
COPY . .

# Generating migrations (SQL)
RUN npm run db:generate

# Building the project
RUN npm run build

# Copying migration files to dist folder
RUN cp -r ./db/migrations ./dist/db/migrations

# Actual Image
FROM node:20.10.0-slim

WORKDIR /usr/src/app

USER node

# Setting enviornment variable
ENV NODE_ENV=production

# Copying dist folder from build stage
COPY --from=build usr/src/app/dist ./dist
COPY --from=build usr/src/app/node_modules ./node_modules

# Setting working directory to dist folder, to execute migration.js file when running the container in swarm
WORKDIR /usr/src/app/dist







