#include <stdio.h>
main()
{
	double  su1, su2, ans;
	char    op;

	printf("�d����N�������܂����B\n\n");
	while (1) 
	{
		printf("�a(+)��(-)��(*)��(/)���ł��܂��B\n�I�������͕����̒P����͂ł��B\n");
		printf("������͂��Ă�������");



		if (scanf("%lf %c %lf", &su1, &op, &su2) != 3)
		{
			break;
		}
			
		switch (op) 
		{
		case '+': 
			ans = su1 + su2; 
			break;
		case '-':
			ans = su1 - su2; 
			break;
		case '*':
			ans = su1 * su2; 
			break;
		case '/': 
			if (su2 == 0.0)
			{
				printf("�O�Ŋ���؂�Ȃ��悤�ɐݒ肵�Ă��܂��B\n\n");
				continue;
			}
			ans = su1 / su2; 
			break;
		default:  
			printf("�\�����ʋL�����͂���܂����B\n");
			printf("������x���͂��Ă��������B\n\n");
			continue;
		}
		
		printf("%g\n\n", ans);
	}
	printf("�d����I�����܂��B\n");
}