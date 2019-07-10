
def x():
    a = input('> ')
    if '+' in a:
        y = a.split('+')
        return int(y[0]) + int(y[1])
    elif '-' in a:
        y = a.split('-')
        return int(y[0]) - int(y[1])
    elif '*' in a:
        y = a.split('*')
        return int(y[0]) * int(y[1])
    elif '/' in a:
        y = a.split('/')
        return int(y[0]) / int(y[1])
while True:
    print(x())

