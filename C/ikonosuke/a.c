#include <stdio.h>
main()
{
    double  a, b, ans;
    char    op;

    printf( "加減乗除(+,-,*,/)ができます。指定例:2+5、終了時はq\n" );
    while( 1 ) {
        printf( "ready : " );
        if( scanf( "%lf %c %lf", &a, &op, &b ) != 3 ) break;
        switch( op ) {
        case '+': ans = a + b; break;
        case '-': ans = a - b; break;
        case '*': ans = a * b; break;
        case '/': if( b == 0.0 ) {
                     printf( "Error!(ゼロでの割算はできません)\n" );
                     continue;
                  }
                  ans = a / b; break;
        default:  printf( "Error!(演算記号の指定が誤りです)\n" );
                  continue;
        }
        printf( "--> %g\n", ans );
    }
    printf( ".... Power OFF\n" );
}
