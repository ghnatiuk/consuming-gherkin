!SLIDE 
# BDD with Ragel

!SLIDE bullets incremental

* Get Ragel parsing _something_
* There are no rules (RSpec, then Cucumber)
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
# Tips and Tricks
.notes Remember regex == state machine, so inherently event driven

* Externalize proof of acceptance
* Parameterize the ctor with object that receives events
* (Dependency Injection)
* Test spy: SexpRecorder

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

!SLIDE small

    @@@ Ruby
    feature = <<FEATURE
    Feature: Autocuke
      Scenario: Motivation
        Given plain text is boring
        Then a GUI must be the answer
    FEATURE

    recorder = SexpRecorder.new
    Lexer.new(recorder).scan(feature)
    recorder.to_sexp

    # => [
    #      [:feature, "Feature", "Autocuke", 1],
    #      [:scenario, "Scenario", "Motivation", 2],
    #      [:step, "Given", "plain text is boring" 3],
    #      [:step, "Then", "a GUI must be the answer", 4]
    #    ]

!SLIDE
* utf8_pack
* 1.8/1.9 and UTF8

