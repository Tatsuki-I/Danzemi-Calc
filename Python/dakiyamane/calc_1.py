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
		user_int = int(user_p[0]), int(user_p[1])	
		return plus(user_int)
	#-の時
	elif '-' in user:
		user_m = user.split('-')
		user_int = int(user_m[0]), int(user_m[1])
		return minus(user_int)
	#*の時
	elif '*' in user:
		user_t = user.split('*')
		user_int = int(user_t[0]), int(user_t[1])
		return times(user_int)
	#/の時
	elif '/' in user:
		user_d = user.split('/')
		user_int = int(user_d[0]), int(user_d[1])
		return division(user_int)
	else:
		print('もう一度入力してください')
		return input_user()
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


