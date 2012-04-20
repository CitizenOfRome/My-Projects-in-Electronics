cam=videoinput('winvideo');
preview(cam);
closepreview();
f=getsnapshot(cam);
f=ycbcr2rgb(f);
a=f;
imshow(a);
l=a(:,:,1);
y=l;
for m=1:120
	for n=1:160
		if(l(m,n)>=41 && l(m,n)<=255)
			y(m,n)=1;
		else
			y(m,n)=0;
		end
	end
end
imshow(y);
imtool(a);
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
w=round(w);
s=round(s);
p=y;
p(w,s)=0;
imtool(p);
