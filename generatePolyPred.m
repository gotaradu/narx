function g = generatePolyPred(na,nb,nk,u,y)

gy = zeros([1 na]) ;
PHIy = zeros([length(u) na]);
PHIu = zeros([length(u) nb]);


for k=1:length(u)
    
    if(k>na)
        gy = [ flip([y((k-na):(k-1)) ])'  zeros([1 na-k+1])]';
         
    else
        gy = [ flip([y(1:(k-1)) ])' zeros([1 na-k+1])];
       
    end
       
    if (k>nb)
        gu = [ flip([u((k-nb):(k-1)) ])' zeros([1 nb-k+1])]';
    else
        gu = [ flip([u(1:(k-1)) ])' zeros([1 nb-k+1])];
    end
    
    
    PHIu(k+nk-1,1:nb) = [gu];
    PHIy(k ,1:na) = [gy];
    
end
PHIu(end-nk+2:end,:)=[];
g = [ ones([k,1]) PHIy PHIu ];

end