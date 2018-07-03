#!/bin/bash
set -ex
rm -rf ./_site/*
JEKYLL_ENV=production bundle exec jekyll build
cd _site
echo "ianchen.tw" > CNAME
rm -rf build.sh
git add .
git commit --amend --no-edit
git push origin master -f
cd ..
curl -X POST "https://api.cloudflare.com/client/v4/zones/${CF_ID}/purge_cache" \
     -H "X-Auth-Email: ${CF_EMAIL}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"purge_everything":true}'


