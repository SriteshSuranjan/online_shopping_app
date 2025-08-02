# # Stage 1 - Development
# FROM node:18 AS builder
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .

# # Stage 2 - Production
# FROM node:18-alpine
# WORKDIR /app
# COPY --from=builder /app .
# EXPOSE 5173
# CMD ["npm", "run", "dev"]


# Stage 1 - Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2 - Production
FROM node:18-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=builder /app/dist ./dist
EXPOSE 5173
CMD ["serve", "-s", "dist", "-l", "5173"]
