function str = exchangelistorder(strlist)
strmedian = strlist(1);
strlist(1) = strlist(5);
strlist(5) = strmedian;

strmedian = strlist(2);
strlist(2) = strlist(4);
strlist(4) = strmedian;

strmedian = strlist(3);
strlist(3) = strlist(6);
strlist(6) = strmedian;

str = strlist;
