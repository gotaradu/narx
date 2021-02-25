clear all;
close all;

load iddata-16.mat

u = id.u;
y = id.y;

uval  = val.u;
yval = val.y;

grad = 4;
na = 2;
nb = 2;
nk = 2;

%PREDICTIE
d = generatePolyPred(na,nb,nk,u,y) ;

%matrice de puteri ale regresorilor
P = mop(grad,na,nb);
a = zeros([0 0]);
PHI = zeros([0 0]);

% pt identificare
for k = 1:length(d)
    for i = 1:length(P)
        a(i) = 1;
        for j=2:na+nb+1
            a(i) =  a(i)*d(k,j) .^(P(i,j-1));                                                              %.*PHI(k,)^(uv(k,j)).*PHI(k,3).*PHI(k,4)
        end
        PHI(k,i) = a(i);
    end
end
theta = PHI \ y;
yhat_idPred = PHI*theta;

%pt validare
d_val = generatePolyPred(na,nb,nk,uval,yval);
a = zeros([0 0]);
PHI_val = zeros([0 0]);

for k = 1:length(d_val)
    for i = 1:length(P)
        a(i) = 1;
        for j=2:na+nb+1
            a(i) =  a(i)*d_val(k,j) .^(P(i,j-1));                                                              %.*PHI(k,)^(uv(k,j)).*PHI(k,3).*PHI(k,4)
        end
        PHI_val(k,i) = a(i);
    end
end

% Validare predictie
yhat_valPred = PHI_val * theta;

% SIMULARE
yhat_idSim = generatePolySim(na,nb,nk,u,theta,grad);
yhat_valSim = generatePolySim(na,nb,nk,uval,theta,grad);

% Calculare erori
errorIdPred(grad,na) = immse(y,yhat_idPred);
errorIdSim(grad,na) = immse(y,yhat_idSim);
errorValPred(grad,na) = immse(yval,yhat_valPred);
errorValSim(grad,na) = immse(yval,yhat_valSim);

% Creare obiecte iddata pentru compararea modelelor
data_idPred = iddata(yhat_idPred,u,id.Ts);
data_valPred = iddata(yhat_valPred,uval,id.Ts);
data_idSim = iddata(yhat_idSim,u,id.Ts);
data_valSim = iddata(yhat_valSim,uval,id.Ts);

% Graficele finale
figure;
compare(id,data_idPred);title(['Identificare vs Predictie grad = ',num2str(grad),', na = nb = ',num2str(na),', nk = ',num2str(nk)]);figure
compare(id,data_idSim);title(['Identificare vs Simulare grad = ',num2str(grad),', na = nb = ',num2str(na),', nk = ',num2str(nk)]);figure
compare(val,data_valPred);title(['Validare vs Predictie grad = ',num2str(grad),', na = nb = ',num2str(na),', nk = ',num2str(nk)]);figure
compare(val,data_valSim);title(['Validare vs Simulare grad = ',num2str(grad),', na = nb = ',num2str(na),', nk = ',num2str(nk)]);
