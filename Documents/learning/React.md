- [useContext](#usecontext)
- [Lazy Loading](#lazyloading)
- [React Router](#react-router)

# useContext

1.  create Context
    - const contextName = React.createContext()
2.  create Provider and pass values to it (export it)

> `function ProviderName({childred}){
   return(<contextName.Provider value={data_to_be_passed}>
    {children}
    </contextName.Provider>
    )
    }`

3.  import above Context to index.js and wrap entire app into already _imported_ **ProviderName**

        `<Providername>
        <App.js>
        <Providername>
        `

4.  using those data or state in other compoents

- import useContext and contextName from path
- const varName = useContext(imported_contextName)
- now varName can be used in that component

# LazyLoading

- instead of importing component directly. import it into `React.Lazy`
- `const varName = React.Lazy(() => import('path/to/dir'))`
- `<Route React.Suspense fallback='str/component'> <varName/> </Route>`

# passing args to event handler function

- create new function in onEvent
- example : onClick={(e)=>handler(e,arg1,arg2)}

# AND gate for multiple conditions

- to check all values true
-     [value1, value2, value3].every(Boolean)
- for false
-     [!value1, value2, value3].every(Boolean)

# React Router

- to get rid of history when navigating
  > use {replace: true}  
  > eg: navigate('some_pah',{replace: true})

### Nested Routes in the same page
`import { Outlet,Link } from "react-router-dom";

const Layout = ()=> {
    return (
      <>
        <button>
          <Link to="/">Home</Link> 
        </button>
        <button>
          <Link to="job">Job</Link>
        </button>
        <button>
          <Link to="career">career</Link>
        </button>
        <main>
        <Outlet />
        </main>
      </>
    );`
}

export default Layout;

- in App.jsx <Route path="/" element={Layout} />

# add class name to clicked item in map function and using useState

- `const [activeIndex, setActiveIndex] = useState(null)`
- `const handleClick = (item_index)=>{
    setActiveIndex(item_index)
  }`
- `array.map.(item,index)=>(<div\>
    <button onClick={()=>handleClick(index)}
className={activeIndex === index ? 'active' : null}>click me</button> <\div>)`