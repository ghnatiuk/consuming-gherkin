!SLIDE 
# Consuming Gherkin
## One Byte at a Time

!SLIDE center bullets incremental
# Ragel
* A tool for building parsers...
* ...by specifying state machines...
* ...with regular expressions.

!SLIDE bullets incremental
# Some people, when confronted with a problem, think "I know, I'll use regular expressions." 

!SLIDE 
# "Now they have two problems"
.notes Artax dying

!SLIDE smallest

    I18N_Feature = (("Feature") ':') >start_keyword %end_keyword; 
    I18N_Background = (("Background") ':') >start_keyword %end_keyword;
    I18N_ScenarioOutline = (("Scenario Outline") ':') >start_keyword %end_keyword;
    I18N_Scenario = (("Scenario") ':') >start_keyword %end_keyword;
    I18N_Step = ("* " | "Given " | "When " | "Then " | "And " | "But ") >start_keyword %end_keyword;
    I18N_Examples = (("Examples" | "Scenarios") ':') >start_keyword %end_keyword;
    EOF = '%_FEATURE_END_%'; # Explicit EOF added before scanning begins 
    EOL = ('\n' | '\r\n') @inc_line_number @last_newline;
    BOM = 0xEF 0xBB 0xBF; # http://en.wikipedia.org/wiki/Byte_order_mark
    PIPE = '|';
    ESCAPED_PIPE = '\\|';
    FeatureHeadingEnd = EOL+ space* (I18N_Feature | I18N_Background | I18N_Scenario | I18N_ScenarioOutline | I18N_Examples | '@' | '#' | EOF) >next_keyword_start;
    ScenarioHeadingEnd = EOL+ space* ( I18N_Feature | I18N_Background | I18N_Scenario | I18N_ScenarioOutline | I18N_Step | '@' | '#' | EOF ) >next_keyword_start;
    BackgroundHeadingEnd = EOL+ space* ( I18N_Feature | I18N_Scenario | I18N_ScenarioOutline | I18N_Step | '@' | '#'| EOF ) >next_keyword_start;
    ScenarioOutlineHeadingEnd = EOL+ space* ( I18N_Feature | I18N_Scenario | I18N_Step | '@' | '#' | EOF ) >next_keyword_start;
    ExamplesHeadingEnd = EOL+ space* ( I18N_Feature | '|' | '#') >next_keyword_start;
    FeatureHeading = space* I18N_Feature %begin_content any* :>> FeatureHeadingEnd @store_feature_content;
    BackgroundHeading = space* I18N_Background %begin_content any* :>> BackgroundHeadingEnd @store_background_content;
    ScenarioHeading = space* I18N_Scenario %begin_content any* :>> ScenarioHeadingEnd @store_scenario_content;
    ScenarioOutlineHeading = space* I18N_ScenarioOutline %begin_content any* :>> ScenarioOutlineHeadingEnd @store_scenario_outline_content;
    ExamplesHeading = space* I18N_Examples %begin_content any* :>> ExamplesHeadingEnd @store_examples_content;
    Step = space* I18N_Step %begin_content ^EOL+ %store_step_content :> EOL+;
    Comment = space* '#' >begin_content ^EOL* %store_comment_content :> EOL+;
    Tag = ( ('@' [^@\r\n\t ]+) >begin_content ) %store_tag_content;
    Tags = space* (Tag space*)+ EOL+;
    StartRow = space* PIPE >start_row;
    EndRow = EOL space* ^PIPE >next_keyword_start;    
    Cell = PIPE (ESCAPED_PIPE | (any - (PIPE|EOL))+ )* >begin_cell_content %store_cell_content;
    RowBody = space* Cell** PIPE :>> (space* EOL+ space*) %store_row;
    Row = StartRow :>> RowBody <: EndRow?;
    StartPyString = '"""' >start_pystring space* :>> EOL; 
    EndPyString = (space* '"""') >next_keyword_start; 
    PyString = space* StartPyString %begin_pystring_content (^EOL | EOL)* :>> EndPyString %store_pystring_content space* EOL+;
    Tokens = BOM? (space | EOL)* (Tags | Comment | FeatureHeading | BackgroundHeading | ScenarioHeading | ScenarioOutlineHeading | ExamplesHeading | Step | Row | PyString)* (space | EOL)* EOF;
    main := Tokens %end_feature @!end_feature;

!SLIDE bullets incremental
# What Uses Ragel

* Mongrel/Thin/Unicorn/Command Tower
* JSON gem
* Redcloth
* Hpricot
* Erbal
* Gherkin (oh yeah...)

!SLIDE bullets
# Why you are here

* Why are you here?

!SLIDE
# Parses _regular languages_ (not CFGs)
