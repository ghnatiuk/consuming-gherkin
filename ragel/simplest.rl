%%{
  machine m;
  main := alpha* @{ puts "Match" };
}%%

data = "abc".unpack("c*");

%%write data;
%%write init;
%%write exec;
