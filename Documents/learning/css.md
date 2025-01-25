# hover
### hovering elements issues and solutions
`element:hover { 
    transform: scale(1.02)
}`

- the above works fine until you add border 

`element:hover {
    transform: scale(1.02);
    border: Xpx type color;
    margin: -Xpx;
}`

- or add transparent border to actual element . this is best when using transition effect

- when you want to align child element based on parent's element when it's position is absolute then make sure it's parent position is relative

# eclipse or dots 

- properties for eclipse
- - height, width, overflow, line-height, text-overflow, white-space
- tips
- increase line-height and adjust height if text visible in the below.

# miskates

### box shadow 

- if box shadow not appearing even though with correct syntax
- try to give space like margin between those elements.

### centering element over other element
`
position: absolute;
left: 50%;
transform: translate(-50%, -50%);
`
