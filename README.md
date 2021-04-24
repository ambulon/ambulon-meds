```python

splash():
    bool = check for JWT
	    if true:
            home()
        else:
            login()
        
login():
    id = await continue with google()
    bool = checkUserExistinNode?(id)
    if true:
        save JWT
        home()
    else:
        JWT = createinNode(id)
        save JWT
        registerinNode({age, location...})
        home()

home()
    getdetails()
```
<br>

```python
home -> SR1
    event startNode [str]
SR1 -> SR2
    event addNode eventList.add(str)
SR1 <- SR2
    if(len(list) == 0)  pop context
    event removeNode eventList.pop()

