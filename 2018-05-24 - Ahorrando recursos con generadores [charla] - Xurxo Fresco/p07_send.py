
def grep(pattern):
    print ("Looking for %s" % pattern)
    line= yield False
    while True:
        line = yield pattern in line

g = grep("python")
g.send(None)
print (g.send("I'm the operator with my pocket generator"))
print (g.send("A series of tubes"))
print (g.send("python generators rock!"))