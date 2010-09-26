%%{
  machine m;

  action increment_machine_match_count {
    @machine_matches += 1
  }

  action print_details {
    puts "Match! Current position: #{p}. Current char '#{data[p].chr}'. Machine match #{@machine_matches}" 
  }

  words = 'Words' @print_details @increment_machine_match_count;

  main := words*;

}%%

data = "WordsWordsWards".unpack("c*");

@machine_matches = 1

%%write data;
%%write init;
%%write exec;
