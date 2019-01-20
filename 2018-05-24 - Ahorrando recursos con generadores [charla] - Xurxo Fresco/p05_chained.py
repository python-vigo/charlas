from utils import print_and_return


def readfiles(filenames):
    for f in filenames:
        print ('opening {f}')
        for line in open(f):
            print ('return line')
            yield line


def grep(pattern, lines):
    # return (line for line in lines if pattern in line)
    for line in lines:
        if pattern in line:
            yield line


def printlines(lines):
    for line in lines:
        print(line, )


def main(pattern, filenames):
    lines = readfiles(filenames)
    lines = grep(pattern, lines)
    printlines(lines)


if __name__ == "__main__":
    main("python", ["o:\\outros\\pyvigo\\access.log"])
