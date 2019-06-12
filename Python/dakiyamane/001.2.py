#ユーザーから値を受けとる
def input_user():
	print('qで終了')
	user = input('> ')
	return part(user) 
#与えられたものを分解
def part(user):
	if user == 'q':
		exit()
	#xは1文字目、yは2文字目
	x = int(user[0])
	y = int(user[2])
	#user_intはxとyを受け取ったもの
	user_int = x, y

	#+の時
	if user[1] == '+':
		return plus(user_int)
	#-の時
	elif user[1] == '-':
		return minus(user_int)
	#*の時
	elif user[1] == '*':
		return times(user_int)
	#/の時
	elif user[1] == '/':
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


