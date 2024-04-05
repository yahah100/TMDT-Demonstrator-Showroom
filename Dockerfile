FROM node:16-alpine as builder
ENV NODE_ENV production
# Add a work directory
WORKDIR /app
# Cache and Install dependencies
COPY package.json .
COPY package*.json ./
RUN npm ci
# Copy app files
COPY . .
# Build the app
RUN npm run build
FROM devforth/spa-to-http:latest
COPY --from=builder /app/build .