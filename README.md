# project_template

A skeleton template for analysis projects. To make full use of the reporting capabilities make sure Sphinx is installed locally. A workflow file and Buildcode have been added to publish a GitHub Pages website from the results of a project.

## Requirements

Jupyter-workbook and ghp-import

```{bash}
pip install pip install -U jupyter-book ghp-import
```


- Use this repo as a template  "Use this template" button. 
- Clone the project repo to your local computer.
- Run the analysis in the jupyter notebook in scripts.
- Make html report locally by running "jb build report/" in the root folder of the local project repo for quick updates and checks. 
- To activate the GitHub pages Sphinx static site, go to the Settings of the online project repo and activate GitHub pages from the Branch "gh-pages"
- To push to Github pages, run ghp-import -npf _build/html from in the report folder. This will push the html file to the gh-pages branch of yourn repo.

