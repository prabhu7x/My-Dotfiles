

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



#### ignore everything
- /*
#### ignore file or folder
`path/to/file`
#### Exceptions
`!path/to/file`
### Include Specific Subfolder Without Including Everything Else
*we can't add subfolder directly, first we need to add it's parent folder and then add subfolder logically, which is explained below*

Here's how to include only Documents/learnings/ while ignoring everything else in Documents/:

#### Include Documents directory
` !Documents/ `
#### Ignore everything inside Documents
` Documents/* `     
#### Include only the learnings folder inside Documents
` !Documents/learnings/ `