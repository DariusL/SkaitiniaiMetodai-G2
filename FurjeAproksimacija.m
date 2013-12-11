function FurjeAproksimacija
    clc,close all,clear all
    fnk = @(T, t)((1-sign(sin(2.*pi.*t./T))).*cos(2.*pi.*2.*t./T)+0.25.*sin(2.*t.*70./T));
    n=1000; 
    n=round(n/2)*2+1;
    m = 200;
    T=4;
    dazniu_slenkstis=m;
    ampl_slenkstis=0;
    dt=T/n;
    N=1000;
    dttt=T/N;

    t=[0:dt:T-dt];
    ttt=[-T:dttt:2*T];

    % disp('kontrole:'),disp(sum(fC(3,T,t).*fC(0,T,t)))

    fff=fnk(T,t); % apskaiciuojame ir pavaizduojame duota tasku seka 
    figure(1),hold on,grid on,plot(t,fff,'b.-','MarkerSize',8);
    legend(sprintf('Vienas funkcijos periodas n=%d tasku',n))
    title('Duotoji funkcija')

    ac0=dot(fff,fC(0,T,t))/n;
    for i=1:m-1
        ac(i)=dot(fff,fC(i,T,t))*2/n;
        as(i)=dot(fff,fS(i,T,t))*2/n;
    end
    ac,as

    figure(2),hold on
    bar(0:m-1,[ac0,sqrt(ac.^2+as.^2)],0.01)
    xx=axis; 
    plot(xx(1:2),ampl_slenkstis*[1 1],'m--','LineWidth',3);
    plot(dazniu_slenkstis*[1 1],xx(3:4),'g--','LineWidth',3);
    title('Furje amplitudziu spektras pagal kompleksinio skaiciaus moduli ')
    legend({'amplitudziu spektras';'amplitudes slenkstis';'dazniu slenkstis'})


    fffz=ac0*fC(0,T,ttt)
    frequencies=[1:m-1];
    frequencies=frequencies(find(frequencies < dazniu_slenkstis))
    for i=frequencies
        if sqrt(ac(i)^2+as(i)^2) > ampl_slenkstis
            fffz=fffz+ac(i)*fC(i,T,ttt)+as(i)*fS(i,T,ttt);    
        end
    end

    figure(3),hold on,grid on, plot(ttt,fffz,'r');plot(t,fff,'b-','LineWidth',2);
    legend(sprintf('n=%d tasku, m=%d harmoniku, a-slenkstis=%g  d-slenkstis=%g',n,m,ampl_slenkstis,dazniu_slenkstis))
    title(sprintf('Pagal Furje spektra atkurta funkcija'))

end

function c=fC(i,T,t)
    if i==0
        c=1*cos(0*t);
    else
        c=cos(2*pi*i/T*t);
    end
end

function s=fS(i,T,t)
    s=sin(2*pi*i/T*t);
end