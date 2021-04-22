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
