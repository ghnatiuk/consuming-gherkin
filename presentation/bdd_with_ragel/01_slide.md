!SLIDE bullets incremental 
# BDD (or TDD, or software development, or whatever) 
* with Ragel

!SLIDE bullets incremental
# Externalize Evidence of Operation
* Make assertions on the collected evidence

!SLIDE small
# git show c8f94a3
    commit c8f94a39e88d1203acb807ee0ba39a729152b87f
    Author: Aslak Hellesøy <aslak.hellesoy@gmail.com>
    Date:   Tue Sep 1 04:47:51 2009 +0200

        Some basics up and running. 
        Still no idea what I'm doing with Ragel

!SLIDE small
    @@@ Ruby
    class Table
      %%{
        machine table;
        
        EOL = '\r'? '\n';
        BAR = '|';
        
        cell = alpha @ { puts data[p, fpc].pack("c*") };
        table_row = space* BAR (cell BAR)+ space* EOL;
        table = table_row+;
        
        main := table @ { puts "TABLE DONE" } ;
      }%%

      def initialize
        %% write data;
      end

      def parse(data)
        data = data.unpack("c*") if data.is_a?(String)
        %% write init;
        %% write exec;
      end
    end

!SLIDE
    @@@ Ruby
    describe Table do
      tables = {
        "|a|b|\n"        => [%w{a b}],
        "|c|d|\n|e|f|\n" => [%w{c d}, %w{e f}]
      }
                            
      tables.each do |text, expected|
        it "should parse #{text}" do
          Table.new.parse(text)
        end
      end
    end

!SLIDE
    @@@ Ruby
    describe Table do
      tables = {
        "|a|b|\n"        => [%w{a b}],
        "|a|b|c|\n"      => [%w{a b c}],
        "|c|d|\n|e|f|\n" => [%w{c d}, %w{e f}]
      }
      
      tables.each do |text, expected|
        it "should parse #{text}" do
          Table.new.parse(text).
                    should == expected
        end
      end
    end

!SLIDE
# Verily Behold The Proper Use of a Mock Object

!SLIDE small
    @@@ Ruby
    describe Table do
      def scan(text, expected)
        listener = mock('listener')
        listener.should_receive(:table).with(expected)
        Table.new.scan(text, listener)
      end

      it "should parse a 1x2 table with newline" do
        scan(" | 1 | 2 | \n", [%w{1 2}])
      end
    end

!SLIDE bullets incremental
# What the Tests Told Us
.notes Event based design of Gherkin came about out of need to easily test lexer
.notes Remember regex == state machine, so inherently event driven
.notes Acceptance: when Ragel finishes its work and the current state is not less than the final lexer state

* Parameterize the Lexer's ctor with a listener
* (Dependency Injection)
* Compose listeners for flexibility and additional layers of responsibility
* Test using a Test Spy listener: SexpRecorder

!SLIDE
# Parameterize the Constructor

    @@@ Ruby
    class Lexer

      # Ragel machine definitions here

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

!SLIDE small
## Named Actions Send Messages to the Listener

    Tag = ('@' [^@\r\n\t ]+) %store_tag_content;

    action store_tag_content {
      @listener.tag(data[start...p], @current_line)
    }

!SLIDE smaller
# Compose Listeners
    @@@ Ruby
    builder   = Cucumber::GherkinBuilder.new
    filter    = Gherkin::FilterFormatter.new(builder)
    tag_count = Gherkin::TagCountFormatter.new(filter)
    parser    = Gherkin::Parser.new(tag_count)

    parser.parse(source)

!SLIDE
# Test Spy Listener
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
