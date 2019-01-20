from utils import is_prime


def seudofibo(max):
    result = []
    prev, curr, modifier, count = 0, 1, 1, 1

    while count < max:
        print(curr)
        result.append(curr)
        curr, prev = prev * modifier + curr , curr
        modifier *= -1
        count += 1

    return result


f = seudofibo(100)
if 233 in f:
    print('encontrado!')
else:
    print('no encontrado :(')
