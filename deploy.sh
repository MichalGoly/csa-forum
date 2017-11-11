#!/bin/bash
echo "Deploying to Heroku..."

wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
export HEROKU_DEBUG=1
heroku plugins:install heroku-container-registry
heroku container:login
heroku container:push web --app mwg2forum
sleep 10
heroku run rake db:migrate --app mwg2forum
