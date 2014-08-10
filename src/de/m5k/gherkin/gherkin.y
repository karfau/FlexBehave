// Compile with: racc gherkin.y -o parser.rb

//class GherkinRuby::Parser
// ../../../../AsYacc/AsYacc -Hclass=GherkinParser -Hpackage=de.m5k.parser gherkin.y
%{

%}

// Declare tokens produced by the lexer
%token FEATURE BACKGROUND SCENARIO SCENARIO_OUTLINE
%token TAG
%token GIVEN WHEN THEN AND BUT
%token TEXT
%token EXAMPLES
%token TABLE_ROW

%%

  Root:
    Feature
        { $$ =  $1; }
  | Feature Scenarios
        { $$ =  $1; ASTFeature($$).scenarios = Vector.<ASTScenario>($2) }
  | Tags Feature
        { $$ =  $2; ASTFeature($$).tags = Vector.<String>($1) }
  | Tags Feature Scenarios
        { $$ =  $2; ASTFeature($$).scenarios = Vector.<ASTScenario>($3); ASTFeature($$).tags = Vector.<String>($1) }
   ;


  Feature:
    FeatureHeader { $$ =  $1 }
  | FeatureHeader
      Background  { $$ =  $1; ASTFeature($$).background = ASTBackground($2) }
  ;

  FeatureHeader:
    FeatureName           { $$ =  $1 }
  | FeatureName
      Description         { $$ =  $1; ASTFeature($$).description = String($2) }
  ;

  FeatureName:
    FEATURE       { $$ =  new ASTFeature(String($1));  }
  ;

  Description:
    TEXT              { $$ =  $1 }
  | Description TEXT  { $$ =  $1 + "\n" + $2 }
  ;

  Background:
    BACKGROUND Steps
        { $$ =  new ASTBackground($1); ASTBackground($$).steps = Vector.<ASTStep>($2); }
  ;


  Steps:
    Step                  { $$ = new <ASTStep>[$1]; }
  | Steps Step             { Vector.<ASTStep>($1).push($2); $$ = $1 }
  ;

  Step:
    GIVEN               { $$ =  new ASTStep("given", $1); }
    | WHEN              { $$ =  new ASTStep("when", $1); }
    | THEN              { $$ =  new ASTStep("then", $1); }
    | AND               { $$ =  new ASTStep("and", $1); }
    | BUT               { $$ =  new ASTStep("but", $1); }
  ;


  Scenarios:
    Scenario              { $$ =  new <ASTScenario>[ASTScenario($1)]; }
  | Scenarios Scenario    { $$ = $1; Vector.<ASTScenario>($1).push(ASTScenario($2)); }
  ;

  Scenario:
    SCENARIO Steps
        { $$ =  new ASTScenario(String($1), Vector.<ASTStep>($2));  }
  | Tags SCENARIO Steps
        { $$ =  new ASTScenario(String($2), Vector.<ASTStep>($3), Vector.<String>($1) );  }
  | ScenarioOutline
       { $$ = $1; }
  | Tags ScenarioOutline
       { $$ = $2; ASTScenarioOutline($$).tags = Vector.<String>($1); }
  ;

  Tags:
    TAG         { $$ = Vector.<String>[$1]; }
  | Tags TAG    { $$ = $1; $1.push($2); }
  ;

  ScenarioOutline:
    SCENARIO_OUTLINE Steps ExampleList
      { $$ = new ASTScenarioOutline(String($1), Vector.<ASTStep>($2), Vector.<ASTExamples>($3) ); }
  ;

  ExampleList:
    Examples               { $$ = new <ASTExamples>[ASTExamples($1)]; }
  |  ExampleList Examples   { $$ = $1; Vector.<ASTExamples>($$).push(ASTExamples($2)); }
  ;

  Examples: EXAMPLES Table { $$ = new ASTExamples($1, ASTTable($2)); };

  Table:
    TABLE_ROW { $$ = new ASTTable(Vector.<String>($1)); }
  | Table TABLE_ROW { $$=$1; ASTTable($$).addRow(Vector.<String>($2)); }
  ;


%%
