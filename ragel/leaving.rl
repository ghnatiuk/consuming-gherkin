%%{
  machine m;

  action do_something {
  }

  main := 'Pony' %do_something;

}%%

%%write data;
data = "Pony".unpack("c*");
eof = data.length
%%write init;
%%write exec;

