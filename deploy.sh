#/bin/bash
set -e

echo "- Building site"
cd source
bundle install
bundle exec jekyll build --destination ../generated_site
cd ..

echo " - Cloning Brakeman repo"
rm -rf brakeman_site
git clone --single-branch --branch gh-pages git@github.com:presidentbeef/brakeman.git brakeman_site
cd brakeman_site
git pull
cd ..

echo " - Cleaning repo"
set +e
find ./brakeman_site/ -not -path '*/\.*' -delete
cp -rf generated_site/* brakeman_site/
rm -rf generated_site

echo "- Pushing new changes"
set -e
cd ./brakeman_site
git add .
git commit -m "Site updated at $(date)"
git push origin gh-pages
