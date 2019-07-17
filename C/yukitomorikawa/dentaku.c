#include <stdio.h>
main()
{
	double  su1, su2, ans;
	char    op;

	printf("電卓を起動させました。\n\n");
	while (1) 
	{
		printf("和(+)差(-)積(*)商(/)ができます。\n終了条件は文字の単一入力です。\n");
		printf("式を入力してください");



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
				printf("０で割り切れないように設定しています。\n\n");
				continue;
			}
			ans = su1 / su2; 
			break;
		default:  
			printf("予期せぬ記号がはいりました。\n");
			printf("もう一度入力してください。\n\n");
			continue;
		}
		
		printf("%g\n\n", ans);
	}
	printf("電卓を終了します。\n");
}