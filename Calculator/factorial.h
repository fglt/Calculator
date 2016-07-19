
#import <Foundation/Foundation.h>
#import<math.h>

double F(double t,double input)
{
    return pow(t,input)*pow(M_E,-t);
}
double simpson(double a,double b,double input)
{
    double c=(b+a)/2;
    return (F(a, input)+4*F(c, input)+F(b, input))*(b-a)/6;
}
double asr(double a,double b,double eps,double A,double input)
{
    double c=(b+a)/2;
    double L=simpson(a,c,input),R=simpson(c,b,input);
    if(fabs(L+R-A)<=15*eps) return L+R+(L+R-A)/15.0;
    return asr(a,c,eps,L,input)+asr(c,b,eps,R,input);
}
double asrl(double a,double b,double eps, double input)
{
    return asr(a,b,eps,simpson(a,b, input), input);
}


double factorial(double input){
    
    double result =1;
    
    while (input >1){
        result = result * input;
        input --;
    }
    if(input == 1)
        return result ;
    if(input < 1 && input >= 0.5 )
        return asrl(0,1e2,1e-10, input) * result;
    else {
        return result * asrl(0,1e2,1e-10, input+1)/(input+1); //修正小于0.5时的计算
    }
    
    return INFINITY;
}

// 0.5=<inpt<1时候的阶乘
double factor(double input)
{
    double result =1+sin(input*M_PI)/(1.4+25*input);
    
    result = result * pow(input, 0.55*input);
    return result;

}

double factorial2(double input){
    
    double result =1;
    
    if(input >170)
        return INFINITY;
    while (input >1){
        result = result * input;
        input --;
    }
    
    if(input == 1)
        return result ;
    if(input < 1 && input >= 0.5 ){
        return result * factor(input);
    }else
    {
        return result * (1-input)*input*M_PI/( factor(1-input)*sin(input*M_PI) );
    }
    
    return INFINITY;
}


