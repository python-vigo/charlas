def fibo(maxi=None):
    prev, curr, count, modifier= 0, 1,1,1
    while not maxi or count < maxi:
        print('generado numero {}'.format(curr))
        yield curr
        curr, prev = prev * modifier + curr , curr
        modifier = modifier*-1
        count+=1
    return

if __name__ == '__main__':
    f = fibo(3)
    print(next(f))
    print(next(f))
    if 233 in fibo(100000):
        print('encontrado!')
    else:
        print('no encontrado :(')
