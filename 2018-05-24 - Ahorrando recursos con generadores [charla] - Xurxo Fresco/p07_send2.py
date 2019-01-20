import time


def follow(thefile, target):
    thefile.seek(0, 2)  # Go to the end of the file
    target.send(None)
    while True:
        line = thefile.readline()
        if not line:
            time.sleep(0.1)  # Sleep briefly
            continue
        target.send(line)


def printer():
    while True:
        line = (yield)
        print(line, )


f = open("access.log")
follow(f, printer())
