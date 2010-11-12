class RagelTest
  %%{
    machine m;

    action print_me { puts data[p].chr; }

    Vowels = [aeiou] >print_me;

    main := (Vowels | any)+;
  }%%

  def initialize(str)
    %%write data;

    data = str.unpack("c*");

    %%write init;
    %%write exec;
  end
end

