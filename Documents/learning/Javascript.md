[nested map](#nested-mapping)
[usage of curly braces in body block of => function](#arrow-functions-in-javascript--implicit-vs-explicit-return)

# nested mapping
- `array.map(item => <div> 
    item.name
    {
        item.nested_object(another_item => <div>
        another_item 
        </div>)
    }
</div>)`

- remember to start map with main array arg when nesting map 
- in this **item** array for nested map


## Arrow Functions in JavaScript – Implicit vs Explicit Return
🔹 Implicit Return (No {} used)

    Use when the function returns a single expression.

    Cleaner and more readable for short logic (like in map, filter, find, etc).

const filtered = data.filter(item => item.active);

    No need to write return when omitting {}.

    Preferred for concise, one-liner logic.

🔹 Explicit Return (With {} and return)

    Use when the function contains multiple lines or extra logic.

    Must use return to return a value explicitly.

const filtered = data.filter(item => {
  console.log(item.name);
  return item.active;
});

    Better for debugging, clarity, and complex logic.

🔸 Common Mistake

Using {} without a return leads to undefined being returned:

// ❌ This returns undefined
data.filter(item => { item.active }) 

✅ Fix it with:

// ✅ Add return
data.filter(item => { return item.active });

🧠 Best Practice

    Use implicit return for short, clean logic.
    Use explicit return when things get more complex or for debugging.

