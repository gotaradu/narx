function g = generatePolySim(na,nb,nk,u,theta,grad)

p = mop(grad,na,nb);
ysim = zeros(length(u),1);
phi(1,1) = 1;
dsim(1,1) = 1;
for k = 2:length(u)
    for i = 1:na
        if k - i < 1
            dsim(k,i) = 0;
        else
            dsim(k,i) = ysim(k-i);
        end
    end
    
    for j = nb+1:(na+nb)
        if k-j+nb-nk < 1
            dsim(k,j) = 0;
        else
            dsim(k,j) = u(k-j+nb-nk);
        end
    end
    dsim(k,1:na+nb+1) = [1 dsim(k,1:na+nb)];
    for i = 1:length(p)
        b(k,i) = 1;
        for j=2:na+nb+1
            b(k,i) =  b(k,i)*dsim(k,j) .^(p(i,j-1));
        end
        phi(k,i) = b(k,i);
    end
    
    ysim(k) = phi(k,:)*theta;
end
g = ysim;
end