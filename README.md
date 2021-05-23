```python
cart state not loaded
cart event load from prefs
cart state loading
    cart state loaded data
        cart event clear data           # clear SP and yield state init
        cart event edit list
            cart state init with list
        
    cart state init
        cart event load network data    # save to SP
        cart state loaded data          # above
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