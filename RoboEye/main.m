cam=videoinput('winvideo');
ser=serial('COM1','BaudRate',9600);
preview(cam);
color = lower(input('Please enter the first letter of the color you want me to track: [r,g,b,y,c,m] ', 's'));
while(1)
    f=getsnapshot(cam);
    f=ycbcr2rgb(f);
    a=f;
    %l=a(:,:,1);
    y=a;
    for m=1:120
        for n=1:160
            if color=='r'
                condi = a(m, n, 1)>=230;
            elseif color=='g'
                condi = a(m, n, 2)>=230;
            elseif color=='b'
                condi = a(m, n, 3)>=230;
            elseif color=='y'
                condi = a(m, n, 1)>=230 && a(m, n, 2)>=230;
            elseif color=='c'
                condi = a(m, n, 2)>=230 && a(m, n, 3)>=230;
            elseif color=='m'
                condi = a(m, n, 1)>=230 && a(m, n, 3)>=230;
            elseif color=='b'
                condi = a(m, n, 1)<=30 && a(m, n, 2)<=30 && a(m, n, 3)<=30;
            else
                condi = a(m, n, 1)>=230 && a(m, n, 2)>=230 && a(m, n, 3)>=230;
            end
            if(condi)
                y(m, n)=1;
            else
                y(m, n)=0;
            end
        end
    end
    w=0;
    s=0;
    c=0;
    for i=1:120
        for j=1:160
            if(y(i,j)==1)
                w=w+j;
                s=s+i;
                c=c+1;
            end
        end
    end
    w=w/c;
    s=s/c;
    if(w~=80 || s~=60)
        if(w<80)
            fopen(ser);
            fwrite(ser,'a','uchar');
            fclose(ser); 
        end
        if(w>80)
            fopen(ser);
            fwrite(ser,'d','uchar');
            fclose(ser); 
        end
        if(s<60)
            fopen(ser);
            fwrite(ser,'s','uchar');
            fclose(ser); 
        end
        if(s>60)
            fopen(ser);
            fwrite(ser,'w','uchar');
            fclose(ser); 
        end
    else
        fopen(ser);
        fwrite(ser,'x','uchar');
        fclose(ser); 
    end  
end
