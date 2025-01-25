[nested map](#nested-mapping)

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