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
		x, y = int(user_p[0]), int(user_p[1])
		user_int = x, y
		return plus(user_int)
	#-の時
	elif '-' in user:
		user_m = user.split('-')
		x, y = int(user_m[0]), int(user_m[1])
		user_int = x, y
		return minus(user_int)
	#*の時
	elif '*' in user:
		user_t = user.split('*')
		x, y = int(user_t[0]), int(user_t[1])
		user_int = x, y
		return times(user_int)
	#/の時
	elif '/' in user:
		user_d = user.split('/')
		x, y = int(user_d[0]), int(user_d[1])
		user_int = x, y
		return division(user_int)
	
#計算
#+
def plus(user_int):
	result = user_int[0] + user_int[1]
	return result
#-
def minus(user_int):
	result = user_int[0] - user_int[1]
	return result
#*
def times(user_int):
	result = user_int[0] * user_int[1]
	return result
#/
def division(user_int):
	result = user_int[0] / user_int[1]
	return result

#全ての操作を'q'が与えらるまで繰り返す
while True:
	print(input_user())


