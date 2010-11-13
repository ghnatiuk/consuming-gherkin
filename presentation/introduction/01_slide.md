!SLIDE 
# Consuming Gherkin
## One Byte at a Time

!SLIDE
# Who We Are
## Greg Hnatiuk & Mike Sassak

!SLIDE bullets incremental
# A Bit about Gherkin
* Language
* Parser

!SLIDE
# Call to arms

### "We need a faster parser. I'm currently looking at Ragel - a super fast state machine compiler. It's used by Mongrel, Thin, RedCloth and Hpricot to name a few, so it has a good track record in the Ruby community... Previous experience with Ragel is not a must, but definitely a plus."
## Aslak Hellesøy 

!SLIDE smaller
# Step
    I18N_Step = ("Given " | "When " | "Then ") \ 
      >start_keyword %end_keyword;

    Step = space* I18N_Step %begin_content ^EOL+ \ 
      %store_step_content :> EOL+;

!SLIDE center bullets incremental
# Ragel
* A tool for building parsers...
* ...by specifying state machines...
* ...with regular expressions.

!SLIDE bullets incremental
# Some people, when confronted with a problem, think "I know, I'll use regular expressions." 

!SLIDE center
# "Now they have two problems."
![atreyu](atreyu.png)
