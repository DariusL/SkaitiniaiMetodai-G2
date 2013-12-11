function Niutonas
    clc,clear all
    close all

    xmin= 3;
    xmax= 6;
    n=7; 

    k=0:n-1;
    fnk = @(x)(log(x)./(sin(3.*x)+1.5));
    
    X=(xmax+xmin)/2+(xmax-xmin)/2*cos((2*k+1)*pi/(2*n)); %Ciobysevo abscises
    fprintf(1, '\nCiobysovo abscises: \n');
    fprintf(1, ' %g ', X);
    Y=fnk(X);                                           %Ciobysevo ordinates
    fprintf(1, '\nCiobysovo ordinates: \n');
    fprintf(1, ' %g ', Y);

    x=min(X):(max(X)-min(X))/1000:max(X); %x asies reiksmes brezimui
    figure(1), hold on, grid on, axis equal
    plot(x,fnk(x), 'b-', 'LineWidth', 3) %Pradine funkcija

    n=length(X);
    fprintf('\n');
    fprintf('Interpoliavimo mazgai:\n')
    fprintf('\nX= ')
    for i=1:n
        fprintf('\t%4.2f',X(i))
    end
    fprintf('\nY= ')
    for i=1:n
        fprintf('\t%4.2f',Y(i))
    end
    fprintf('\n')
    xx=zeros(n,n);
    xx(:,1)=1;
    for j=2:n
        for i=j:n
            san=1;
            for k=1:j-1
                san=san*(X(i)-X(k));
                xx(i,j)=san;
            end
        end
    end
    fprintf('\nBaziniø funkcijø reikðmës interpoliavimo mazguose:\n\n')
    for i=1:n
        for j=1:n
            fprintf('\t%9.4f',xx(i,j));
        end
        fprintf('\n')
    end
    A=xx\Y';
    fprintf('\nNiutono interpoliacinës iðraiðkos koeficientai:\n\n');
    for i=1:n
        fprintf('\t%9.4f',A(i))
    end
    fprintf('\n')

    x=min(X):(max(X)-min(X))/1000:max(X);

    f=A(1);
    for i=2:n
        sand=1;
        for k=1:i-1
            sand=sand.*(x-X(k));
        end
        f=f+A(i).*sand;
    end

    plot(X,Y,'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',10);
    hold on;
    grid on; 
    plot(x, f, 'g-', 'LineWidth', 3)
    legend({'duota funkcija','Ciobysevo abcises','Interpoliacine funkcija'})
end