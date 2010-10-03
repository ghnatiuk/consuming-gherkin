%%{
  machine actions;

  action entering {
    puts '>entering'
  }

  action finishing {
    puts '@finishing'
  }

  action all {
    puts '$all'
  }

  action leaving {
    puts '%leaving'
  }

  main := 'abcd' @finishing >entering %leaving $all;
}%%

data = "abcd".unpack("c*")
eof = data.length

%% write data;
%% write init;
%% write exec;
