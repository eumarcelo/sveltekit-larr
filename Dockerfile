# FROM node:19.7-alpine AS sk-build
# WORKDIR /usr/src/app

# COPY . /usr/src/app
# RUN npm install
# RUN npm run build

# FROM node:19.7-alpine
# WORKDIR /usr/src/app

# COPY --from=sk-build /usr/src/app/package.json /usr/src/app/package.json
# COPY --from=sk-build /usr/src/app/package-lock.json /usr/src/app/package-lock.json
# RUN npm i --only=production

# COPY --from=sk-build /usr/src/app/build /usr/src/app/build

# EXPOSE 3000
# CMD [ "npm", "run", "start:node" ]

#Dockerfile

# Use this image as the platform to build the app
FROM node:20-alpine AS sveltekit-larr

# A small line inside the image to show who made it
LABEL Developer="Marcelo Lima"

# The WORKDIR instruction sets the working directory for everything that will happen next
WORKDIR /app

# Copy all local files into the image
COPY . .

# Clean install all node modules
RUN npm ci

# Build SvelteKit app
RUN npm run build

# Delete source code files that were used to build the app that are no longer needed
RUN rm -rf src/ static/

# This is the command that will be run inside the image when you tell Docker to start the container
EXPOSE 3000
CMD ["node","build/index.js"]