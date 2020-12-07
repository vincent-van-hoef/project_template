#!/bin/bash

echo "" >> docs/conf.py
echo "master_doc = 'index'" >> docs/conf.py
echo "numfig = True" >> docs/conf.py

sed -i '' 's/alabaster/sphinx_rtd_theme/g' docs/conf.py

git add .
git commit -m "First Commit"
git push