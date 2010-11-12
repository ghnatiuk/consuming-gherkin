!SLIDE 
# Some Ragel

!SLIDE bullets
    @@@ Ruby
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
*  

!SLIDE bullets
    @@@ Ruby
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
* machine m;

!SLIDE bullets
    @@@ Ruby
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
* action print_me { puts data[p].chr; }

!SLIDE bullets
    @@@ Ruby
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
* Vowels = [aeiou] >print_me;

!SLIDE bullets
    @@@ Ruby
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
*  main := (Vowels | any)+;

!SLIDE bullets
    @@@ Ruby
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
* %%write data;

!SLIDE bullets
    @@@ Ruby
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
* data = str.unpack("c*");

!SLIDE bullets
    @@@ Ruby
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
* %%write init

!SLIDE bullets
    @@@ Ruby
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
* %%write exec

!SLIDE center
![parts_of_speech](parts_of_speech.png)

!SLIDE center
![steps](steps.png)

!SLIDE 
![gherkin](gherkin.png)

!SLIDE bullets incremental center
# Simple Machine Definitions

    @@@ Ruby
    'text'
    [tex]
    't'..'x'
    /text/
    any, white, lower, alnum, digit

!SLIDE bullets 
# Regular Language Operators

* Union
* Intersection
* Difference
* Concatenation
* Kleene star, etc... (*, +, ?, !)

!SLIDE bullets center
# Actions
    @@@ Ruby
    Vowels = [aeiou] >print_me;

!SLIDE bullets center
# Inline actions

    @@@ Ruby
    '\n'+ @{ puts "I have a newline" }

!SLIDE bullets
# Named actions
    @@@ Ruby
    action CountNewlines {
      @newlines += 1
    }

    EOL = '\n'+ @CountNewlines
.notes Why you probably want to do this.  
.notes so you can extract them easily to another machine, and have
.notes different language implementations
!SLIDE bullets

* Entry: < 
* All Transitions: $
* Finishing: @
* Leaving: %


!SLIDE bullets
# Guards and Nondeterminism

* finish-guarded
* :>>

!SLIDE center
    @@@ Ruby
    any* :>> 'STOP!'

!SLIDE bullets
* entry-guarded
* :>

!SLIDE center
    @@@ Ruby
    any* :> 'STOP!'

!SLIDE bullets
* left-guarded       <:
* longest-match      **
* named-priorities
