CREATE OR REPLACE FUNCTION public.random_string(length integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
  chars text[] := '{1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,J,K,M,N,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,j,k,m,n,p,q,r,s,t,u,v,w,x,y,z,!,#,$,%,&,(,),*,+,-,/,:,;,<,=,>,?,@,[,\,],^,_}';
  result text := '';
  i integer := 0;
begin
  if length < 0 then
    raise exception 'Given length cannot be less than 0';
  end if;
  for i in 1..length loop
    result := result || chars[1+random()*(array_length(chars, 1)-1)];
  end loop;
  return result;
end;
$_$;

ALTER FUNCTION public.random_string(length integer) OWNER TO sdss;
