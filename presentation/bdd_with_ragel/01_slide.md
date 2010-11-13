!SLIDE bullets incremental 
# BDD (or TDD, or software development, or whatever) 
* with Ragel

!SLIDE bullets incremental
# Externalize Evidence of Operation
* Make assertions on the collected evidence

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
.notes Event based design of Gherkin came about out of need to easily test lexer
.notes Remember regex == state machine, so inherently event driven
.notes Acceptance: when Ragel finishes its work and the current state is not less than the final lexer state

* Parameterize the Lexer's ctor with a listener
* (Dependency Injection)
* Test Spy: SexpRecorder

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

!SLIDE smaller
# A Real Test

    @@@ Ruby
    it "should parse steps with inline py_string" do
      scan("Given I have a string\n\"\"\"\nhello\nworld\n\"\"\"")
      @listener.to_sexp.should == [
        [:step, "Given ", "I have a string", 1],
        [:py_string, "hello\nworld", 2],
        [:eof]
      ]
    end

!SLIDE smallest
# Cucumber
    @@@ Cucumber
    Given a Gherkin parser
    When the following text is parsed:
      """
      Feature: Advanced Lulzfinding Mechanism
        Scenario: Monty Python
          Given the following excerpt:
            \"\"\"
            WOMAN:  Who are the Britons?
            ARTHUR:  Well, we all are. we're all Britons and I am your king.
            WOMAN:  I didn't know we had a king.  I thought we were an autonomous
                collective.
            DENNIS:  You're fooling yourself.  We're living in a dictatorship.
                A self-perpetuating autocracy in which the working classes--
            WOMAN:  Oh there you go, bringing class into it again.
            DENNIS:  That's what it's all about if only people would--
            ARTHUR:  Please, please good people.  I am in haste.  Who lives
                in that castle?  
            \"\"\"
          When I read it
          Then I should be amused
      """
    Then there should be no parse errors

!SLIDE small

    @@@ Ruby
    Given /^a Gherkin parser$/ do 
      @parser = Gherkin::Parser.new(@listener)
    end

    Given "the following text is parsed:" do |text|
      @parser.parse(text)
    end

    Then "there should be no parse errors" do
      @listener.errors.should == []
    end

!SLIDE
* utf8_pack
* 1.8/1.9 and UTF8
