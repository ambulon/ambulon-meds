```python
cart state not loaded
cart event load
cart state loading
    cart state loaded data
        # cart event clear data           # get cart again
        # cart event update quantity
        cart event remove item          # get cart again
        
    cart state empty                    # add illustration
```
<br>

- [x] shimmer effect
- [x] popular searches
- [ ] cart module
- [ ] profile page

<br>

```python
splash():
    bool = check for JWT
	    if true:
            home()
        else:
            login()
        
login():
    id = await continue with google()
    saveJWT()

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
```