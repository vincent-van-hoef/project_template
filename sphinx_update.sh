#!/bin/bash

echo "" >> docs/conf.py
echo "master_doc = 'index'" >> docs/conf.py
echo "numfig = True" >> docs/conf.py

sed -i 's/alabaster/sphinx_rtd_theme/g' docs/conf.py

mkdir docs/content

cp docs/templates/acknowledgements.rst docs/content/acknowledgements.rst
cp docs/templates/closing.rst docs/content/closing.rst
cp docs/templates/data_responsibility.rst docs/content/data_responsibility.rst
cp docs/templates/material_methods.rst docs/content/material_methods.rst
cp docs/templates/project_description.rst docs/content/project_description.rst
cp docs/templates/results.rst docs/content/results.rst
cp docs/templates/index.rst docs/index.rst

cp docs/templates/NBIS-logo.png docs/_static/NBIS-logo.png
cp docs/templates/scilife_logo.jpg docs/_static/scilife_logo.jpg

git add .