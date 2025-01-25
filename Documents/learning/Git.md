

- to ignore for git repo create a " .gitignore " and type item
- - eg: node_modules


# deploying vite project
- add **base** in vite.config.js
- - base: '/repo-name/'
- npm run build
- git add dist -f (forcefully adding dist to bypass gitignore)
- git commit -m 'msg'
- git subtree push --prefix dist origin gh-pages

# deploying react project
- install gh-pages 
- npm i gh-pages -D
- add **homepage** after version and in script section add **predeploy** : *npm run build* and **deploy** : *gh-pages -d build* in package.json
