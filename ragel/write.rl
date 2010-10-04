/*
 * For experimenting with write commands.
 */

%%{
  machine writing;
  main := 'abcd';
}%%

data = "abcd".unpack("c*")

# Writing data
%% write data;

# Writing init
%% write init;

# Writing exec
%% write exec;
