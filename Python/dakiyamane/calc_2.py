#ユーザーから値を受けとる
def input_user():
	print('qで終了')
	user = input('> ')
	return part(user) 
#与えられたものを分解
def part(user):
	if user == 'q':
		exit()
	#分解

	#+の時
	if '+' in user:
		user_p = user.split('+')
		user_int = [int(i) for i in user_p]	
		return plus(user_int)
	#-の時
	elif '-' in user:
		user_m = user.split('-')
		user_int = [int(i) for i in user_m]
		return minus(user_int)
	#*の時
	elif '*' in user:
		user_t = user.split('*')
		user_int = [int(i) for i in user_t]
		return times(user_int)
	#/の時
	elif '/' in user:
		user_d = user.split('/')
		user_int = [int(i) for i in user_d]
		return division(user_int)
	else:
		print('もう一度入力してください')
		return input_user()
#計算
#+
def plus(user_int):
	x = 0
	for i in user_int:
		x += i
	return x
#-
def minus(user_int):
	x = user_int[0]
#	print(x)
	for i in user_int:
		x += (-i)
	x = x + user_int[0]
	return x
#*
def times(user_int):
	x = 1
	for i in user_int:
		x *= i
	return x
#/
def division(user_int):
	x = user_int[0]
	for i in user_int:
		x /= i
	x = x * user_int[0]	
	return x

#全ての操作を'q'が与えらるまで繰り返す
while True:
	print(input_user())

