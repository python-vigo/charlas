class fibo(object):
    def __init__(self, max=None):
        self.max = max
        self.prev = 0
        self.curr,  self.count , self.modifier =1, 1,1

    def __iter__(self):
        return self

    def __next__(self):
        fib = self.curr
        if self.count > self.max:
            raise StopIteration
        self.curr, self.prev = self.prev * self.modifier+ self.curr , self.curr
        print(fib)
        self.count +=1
        self.modifier *= -1
        return fib

if 233 in fibo(100000):
    print('encontrado!')
else:
    print('no encontrado :(')
