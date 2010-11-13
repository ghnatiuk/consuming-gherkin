!SLIDE bullets incremental 
# BDD (or TDD, or software development, or whatever) 
* with Ragel

!SLIDE bullets incremental
# The Steps to Take
* Get Ragel parsing something 
* Prove it

!SLIDE 
* 1st passing test example (spec side-by-side w/ ragel)

!SLIDE 
* changes (spec side-by-side w/ ragel)

!SLIDE
* coupla refactorings as we learned more

!SLIDE
* shared examples

!SLIDE
* pretty_formatter.feature

!SLIDE bullets incremental
# Testing
.notes SUT
.notes Driving out behavior
.notes Event based design of Gherkin came about out of need to easily test lexer
.notes Remember regex == state machine, so inherently event driven
.notes Acceptance: when Ragel finishes its work and the current state is not less than the final lexer state

* Externalize evidence of operation
* Test spy: SexpRecorder
* Parameterize the ctor with object that receives events
* (Dependency Injection)

!SLIDE small

    @@@ Ruby
    class Lexer
      %%{
        machine lexer;
        action do_action {
          # Send the appropriate messages to the listener
        }
        main := 'foo' $do_action;
      }%%

      def initialize(listener)
        @listener = listener
        %% write data;
      end

      def scan(text)
        data = text.unpack("c*")

        %% write init;
        %% write exec;
      end
    end

!SLIDE
.notes We know not really sexps but annoying pedants is more fun than being correct

    @@@ Ruby
    class SexpRecorder
      def initialize
        @sexps = []
      end

      def method_missing(event, *args)
        @sexps << [event] + args
      end

      def to_sexp
        @sexps
      end
    end

!SLIDE 

    Feature: Autocuke

      Scenario: Motivation
        Given plain text is boring
        Then a GUI must be the answer

!SLIDE small

    @@@ Ruby
    recorder = SexpRecorder.new
    Lexer.new(recorder).scan(feature)

    recorder.to_sexp.should == [
      [:feature,  "Feature",  "Autocuke",                 1],
      [:scenario, "Scenario", "Motivation",               2],
      [:step,     "Given",    "plain text is boring",     3],
      [:step,     "Then",     "a GUI must be the answer", 4]
    ]

!SLIDE
* utf8_pack
* 1.8/1.9 and UTF8
