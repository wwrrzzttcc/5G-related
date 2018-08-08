%%%高斯消元法做的I,P方式编码阵%%%%

%%%%%This is a SIMPLE matlab for LDPC gauss encoding%%%%%%%%%%%%%%%%%%%%%
function  [outputHT, outputH, outputG]=LDPC_gauss_encode(inputx, inputy)
%%%%%HT will be the temp output for gauss inner value checking;%%%%%%%%%%%%%%%%%%%%
%%%%%H is the really output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%consider the gauss in aritcle so add the inputy for glay left I or right I%%%%%


%%%%%part-1 module the input and output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H = inputx;
flag =inputy;%%%flag1 means left I else the right I.
[m,n]=size(H);
%HT=H;

%%%%%PART-2 do the gauss itself to generate HT and H.
%%%%% no matter what flag, still need to generate H first.
%%%%%step0: added sum(H,2) to find all 0 column, if yes, change it with a real column%%%

%%%%%step1: check the 1 in h(i:i), if no, move the row with first 1 of collum i to this row%%%%%

%%%%%step2: use the h(i,i)==1 to add to i row's other 1's to make this row only (i,i)=1%%%%%

%%%%%step3: back to 1, if ==1, dont need to move other 1 row to replace, but step 2 directly%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%step4: use flag to move the (s,p)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if m>n;
     disp('m should smaller than n then V can calculte right C');
     outputHT=H;
     outputH = H;
     outputG =H;
else
for i=1:m;
          
   B = sum(H,2);
   if B(i)==0;
    j = find(B(i:m),1,'first') ;
    H([i,j+i+1],:)=H([j+i+1, i],:); %% move the all 0 column to lower
   end;
   
if H(i,i) == 0;
	j = find(H(i,:),1,'first');

    %HT1(:,[i,j])=H(:,[j,i]);
	H(:,[i,j])=H(:,[j,i]);

    %%becare dont add h(i,:) to itself
    if i>1;
        for l = 1:i-1;
            if H(l,i) == 1;
		    H(l,:) = mod((H(i,:)+H(l,:)),2); %%%ADD ADN THEN MODULE 2 TO GIVE ALL 0%%
		    end;
        end;
    end;
    if i<m;
    for k=i+1:m;
		if H(k,i) == 1;
		H(k,:) = mod((H(i,:)+H(k,:)),2); %%%ADD ADN THEN MODULE 2 TO GIVE ALL 0%%
		end;
    end;
    end;


else
    if i>1;
        for l = 1:i-1;
            if H(l,i) == 1;
		    H(l,:) = mod((H(i,:)+H(l,:)),2); %%%ADD ADN THEN MODULE 2 TO GIVE ALL 0%%
		    end;
        end;
    end;
    if i<m;
    for k=i+1:m;
		if H(k,i) == 1;
		H(k,:) = mod((H(i,:)+H(k,:)),2); %%%ADD ADN THEN MODULE 2 TO GIVE ALL 0%%
		end;
    end;
    end;

end;
end;
%%step4%%
%for i=m:-1:2;
%for k=i-1:-1:1;
%	if HT1(k,i) == 1; %%%dont need the judge?
%        HT1(k,:)= HT1(i,:)+HT1(k,:);
%		HT1(k,:)= mod(HT1(k,:),2);
%	end;
%end;
%end;

outputHT=H;%%%the HT part now back to normal H
outputH = H;


%%%%%%%%%%%%%%falg it can get G%%%%%%%%%%%%%%%%%%%%%%
	%%PP=HT1(:,m+1:n);

if flag ==1; %%left will be I so encode should be from last column
    %%PP=H(:,m+1:n);
	%%G = [PP;diag(ones(1,n-m))];
	outputG=H;
	%outputH=H;

else
  
        
    %G = [H(:,m+1:n); H(:,1:m)];
    %PP=H(:,m+1:n);
	%G = [diag(ones(1,n-m));PP];
	outputG=cat(2,H(:,m+1:n),H(:,1:m));
	%outputH=[H(:,m+1:n);H(:,1:m)];
    

    end;
end	;
end;
