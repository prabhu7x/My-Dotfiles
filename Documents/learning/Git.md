

## BASICS
- to create new branch and switch
- - new version
`git switch -c branch-name`
- - older version
`git checkout -b branch-name`
- `git branch branch-name` => just create branch not switch

- to switch branch 
`git checkout branch-name`
- merge branch
`git merge branch-name` (this will merge with current branch. do same with other branch)

- merge branches in cleaner way with **rebase**
`git rebase branch-name`

- detach : checkout commit instead of branch
`git checkout commit-name`
- to detach one step up
- `git HEAD^` (move one step from current branch)
- `git HEAD~n` (move up n number from current branch)

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