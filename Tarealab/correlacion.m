function [C,m]=correlacion(x1,x2,M)
    m=(-M:M); C=zeros(1,2*M+1); 
    N=length(x1);  
    
    for i= 1:length(m)
        n= m(i);
        if(n<0)
            k=1:N-abs(n);
            C(i)=sum(x1(k).*x2(k+abs(n)));
         
        else
            k=n+1:N;
            C(i)=sum(x1(k).*x2(k-n));

        end
    end
end
