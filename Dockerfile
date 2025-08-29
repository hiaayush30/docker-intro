FROM node:22

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy app source
COPY index.js ./

# Run app
ENTRYPOINT ["node", "index.js"]


# or (Every RUN in Docker runs in its own shell and doesn’t persist environment variables.)

# FROM ubuntu:22.04

# Install dependencies
# RUN apt update && apt install curl bash build-essential -y

# Install nvm + Node in one step
# RUN bash -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
#     . ~/.nvm/nvm.sh && \
#     nvm install 22 && 
#     nvm alias default 22"

# ENV NODE_VERSION=22
# ENV NVM_DIR=/root/.nvm
# ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# WORKDIR /app

# COPY package.json package-lock.json ./
# RUN npm install

# COPY index.js ./

# ENTRYPOINT ["node", "index.js"]
