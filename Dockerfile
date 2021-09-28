#FROM node:14-slim
FROM node:14-buster

# set our node environment, either development or production
# defaults to production, compose overrides this to development on build and run
ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

# default to port 3000 for node, and 9229 and 9230 (tests) for debug
ARG PORT=9080
ENV PORT $PORT
EXPOSE $PORT 9229 9230

RUN apt-get update -y && \
    apt-get install -y \
        libnss3 \
        libgtk-3-0 \
        libx11-xcb1 \
        libxss1 \
        libasound2 \
        && rm -rf /var/lib/apt/lists/*

# make directory as root and change permissions
RUN mkdir /opt/app && chown node:node /opt/app

# you'll likely want the latest npm, regardless of node version, for speed and fixes
# but pin this version for the best stability
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH /home/node/.npm-global/bin:$PATH
USER node
RUN npm i --loglevel=error --global npm@latest expo-cli@latest vue-native-cli@latest electron@latest

# install dependencies first, in a different location for easier app bind mounting for local development
# https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#non-root-user
WORKDIR /opt/app
ENV PATH /opt/app/.bin:$PATH
#COPY --chown=node:node package.json package-lock.json* ./
#RUN npm install --no-optional && npm cache clean --force

## check every 30s to ensure this service returns HTTP 200
#HEALTHCHECK --interval=30s CMD node healthcheck.js

# copy in our source code last, as it changes the most
# copy in as node user, so permissions match what we need
RUN mkdir /opt/app/node_modules && chown node:node /opt/app/node_modules
WORKDIR /opt/app
#COPY --chown=node:node . .

#COPY docker-entrypoint.sh /usr/local/bin/
#ENTRYPOINT ["docker-entrypoint.sh"]

# if you want to use npm start instead, then use `docker run --init in production`
# so that signals are passed properly. Note the code in index.js is needed to catch Docker signals
# using node here is still more graceful stopping then npm with --init afaik
# I still can't come up with a good production way to run with npm and graceful shutdown
#CMD [ "node", "./bin/www" ]

#ENTRYPOINT ["npm", "run"]
#CMD ["web"]

CMD ["npm", "run", "web"]
