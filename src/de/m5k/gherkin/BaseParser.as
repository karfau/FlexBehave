//### This file created by byacc 1.8 / ActionScript 3 extension 0.1)
//### ActionScript support added 16 April 2008, Gabriele Farina
//### Please send bug reports to gabriele@alittleb.it
//### private yysccsid = "@(#)yaccpar	1.8 (Berkeley +Cygnus.28) 01/20/91";



package de.m5k.gherkin
{



// #line 6 "gherkin.y"

// #line 11 "BaseParser.as"



/*
 * Encapsulates yacc() parser functionality in an ActionScript 3 class
 */
public class BaseParser
{
	private var yydebug: Boolean;	// debug output desired ?
	private var yynerrs: int;		// number of errors so far
	private var yyerrflag: int;		// was there an error ?
	private var yychar: int;		// the current working character


	public function debug( msg: String ): void
	{
		if( yydebug )
		{
			trace( msg );
		}
	}

	public function yyerror( msg: String ): void
	{
	    trace( "ERROR: " + msg );
	}

	private var statestk: Array;	// state stack
	private var stateptr: int;          
	private var stateptrmax: int; 		// highest index of stackptr
	private var statemax: int;			// state when highest index reached

	public function state_push( state: int ): void
	{
		statestk[ ++stateptr ] = state;

		if( stateptr > statemax )
		{
			statemax = state;
			stateptrmax = stateptr;
		}
	}

	public function state_pop(): int
	{
		if( stateptr < 0 )                 //underflowed?
		{
			return -1;
		}

		return statestk[ stateptr-- ];
	}

	public function state_drop( cnt: int ): void
	{
		var ptr: int = ( stateptr - cnt );

		if( ptr >= 0 )
		{
			stateptr = ptr;
		}
	}

	public function state_peek( relative: int ): int
	{
		var ptr: int = ( stateptr - relative );

		if( ptr < 0 )
		{
			return -1;
		}

		return statestk[ ptr ];
	}

	public function init_stacks(): Boolean
	{
		statestk = new Array();
		stateptr = -1;
		statemax = -1;
		stateptrmax = -1;
		val_init();

		return true;
	}

	public function yylex(): int
	{
		trace("cascjaskjhcajkshgcjkcs");
		return 0;
	}

	public function dump_stacks( count: int ): void
	{
		trace( "=index==state====value=     s:" + stateptr + "  v:" + get_valptr() );

		for( var i: int = 0; i < count; ++i )
		{
			trace( " " + i + "    " + statestk[ i ] + "      " + get_valstk()[ i ] );
		}

		trace( "======================" );
	}

//########## SEMANTIC VALUES ##########

private var yytext: String;		// user variable to return contextual strings
private var yyval: *;		// used to return semantic vals from action routines
private var yylval: *; 		// the 'lval' (result) got from method yylexlocal valstk;
private var valstk: Array;
private var valptr: int;

public function get_valptr(): int {
	return valptr;
}

public function get_valstk(): Array {
	return valstk;
}

public function set_yylval( val: * ): void {
	yylval = val;
}

public function set_yydebug( val: Boolean ): void {
	yydebug = val;
}

public function BaseParser() {
	yydebug     = false;        // debug
	yynerrs     = 0;			// number of errors so far
	yyerrflag   = 0;        // was there an error ?
	yychar      = -1;        // current working character
	statestk    = new Array();         // state stack
	stateptr    = -1;          // state stack pointer
	statemax    = -1;          // state when highest index is reached
	stateptrmax = -1;          // highest index of stackptr
	yytext      = null;        // user variable to return contextual strings
	yyval       = null;        // used to return semantic values from actions
	yylval      = null;        // the 'lval' result got from yylex
	valstk      = new Array();
	valptr      = -1;

	init_stacks();
}

public function val_init(): void {
	valstk = new Array();
	yyval  = null;
	yylval = null;
	valptr = -1;
}

public function val_push( val: * ): void {
	valstk[ ++valptr ] = val;
}

public function val_pop(): * {
	if( valptr < 0 )
	{
		return null; /* false ??? */
	}
	
	return valstk[ valptr-- ];
}

public function val_drop( cnt: int ): void {
	var ptr: int = ( valptr - cnt );
	
	if( ptr >= 0 )
	{
		valptr = ptr;
	}
}

public function val_peek( relative: int ): * {
	var ptr: int = ( valptr - relative ); 	
	if( ptr >= 0 )
	{
		return valstk[ ptr ];
	}
	
    return null; /* false ??? */
}

//#### end semantic value section ####
public static const YYERRCODE: int = 256;
public static var yylhs: Array = [                            -1,
    0,     0,     0,     0,     1,     1,     4,     4,     6,     7,
    7,     5,     8,     8,     9,     9,     9,     9,     9,     2,
    2,    10,    10,    10,    10,     3,     3,    11,    12,    12,
   13,    14,    14];
public static var yylen: Array = [                            2,
    1,    2,    2,    3,    1,    2,    1,    2,    1,    1,
    2,    2,    1,    2,    1,    1,    1,    1,    1,    1,
    2,    2,    3,    1,    2,    1,    2,    3,    1,    2,
    2,    1,    2,];
public static var yydefred: Array = [                          0,
    9,   26,    0,    0,    0,    0,    0,    0,    0,    0,
    0,   20,   24,   27,    0,    0,    6,   10,    0,   15,
   16,   17,   18,   19,    0,   13,    0,   21,    0,   25,
    0,    0,   11,   14,    0,    0,   29,    0,   32,    0,
   30,   33,];
public static var yydgoto: Array = [                          3,
    4,   10,   11,    6,   17,    7,   19,   25,   26,   12,
   13,   36,   37,   40,];
public static var yysindex: Array = [                      -248,
    0,    0,    0, -219, -247, -255, -259, -227, -227, -219,
 -216,    0,    0,    0, -219, -227,    0,    0, -251,    0,
    0,    0,    0,    0, -227,    0, -234,    0, -227,    0,
 -219, -227,    0,    0, -250, -246,    0, -227,    0, -244,
    0,    0,]
;
public static var yyrindex: Array = [                         0,
    0,    0,    0,   26,    0,   15,    5,    0,    0,   33,
    0,    0,    0,    0,   46,    0,    0,    0,   12,    0,
    0,    0,    0,    0,   18,    0,    0,    0,    0,    0,
   47,   21,    0,    0,    0,   24,    0,   27,    0,    1,
    0,    0,]
;
public static var yygindex: Array = [                         0,
   43,   34,   50,    0,    0,    0,    0,   -9,  -21,   -8,
   40,    0,   16,    0,];
public static var YYTABLESIZE: int = 288;
public static var yytable: Array = [                         27,
   31,   28,   16,   34,    7,   34,   32,   18,    1,    1,
   34,    8,    2,   14,    5,   33,   34,   22,   39,   38,
   12,   35,   28,   28,   42,    1,   23,   20,   21,   22,
   23,   24,    2,   35,   20,   21,   22,   23,   24,    8,
    9,    2,   29,    9,   14,    3,    4,   15,   31,    5,
   30,   41,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,   31,
   31,   31,    7,    7,    7,    7,    0,    0,   31,    8,
    8,    8,    8,    5,    5,    5,   22,   22,   22,   12,
   12,   12,   28,   28,   28,   23,   23,   23,];
public static var yycheck: Array = [                           9,
    0,   10,  258,   25,    0,   27,   16,  267,  257,  257,
   32,    0,  261,  261,    0,  267,   38,    0,  269,   29,
    0,  268,   31,    0,  269,    0,    0,  262,  263,  264,
  265,  266,    0,  268,  262,  263,  264,  265,  266,  259,
  260,  261,  259,  260,  261,    0,    0,    5,   15,    0,
   11,   36,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  259,
  260,  261,  258,  259,  260,  261,   -1,   -1,  268,  258,
  259,  260,  261,  259,  260,  261,  259,  260,  261,  259,
  260,  261,  259,  260,  261,  259,  260,  261,];
public static const YYFINAL: int = 3;
public static const YYMAXTOKEN: int = 269;
public static const yyname : Array = [,
"end-of-file",null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,,
null,null,null,"FEATURE","BACKGROUND","SCENARIO","SCENARIO_OUTLINE","TAG",,
"GIVEN","WHEN","THEN","AND","BUT","TEXT","EXAMPLES","TABLE_ROW",];
public static const yyrule: Array = [
"$accept : Root",
"Root : Feature",
"Root : Feature Scenarios",
"Root : Tags Feature",
"Root : Tags Feature Scenarios",
"Feature : FeatureHeader",
"Feature : FeatureHeader Background",
"FeatureHeader : FeatureName",
"FeatureHeader : FeatureName Description",
"FeatureName : FEATURE",
"Description : TEXT",
"Description : Description TEXT",
"Background : BACKGROUND Steps",
"Steps : Step",
"Steps : Steps Step",
"Step : GIVEN",
"Step : WHEN",
"Step : THEN",
"Step : AND",
"Step : BUT",
"Scenarios : Scenario",
"Scenarios : Scenarios Scenario",
"Scenario : SCENARIO Steps",
"Scenario : Tags SCENARIO Steps",
"Scenario : ScenarioOutline",
"Scenario : Tags ScenarioOutline",
"Tags : TAG",
"Tags : Tags TAG",
"ScenarioOutline : SCENARIO_OUTLINE Steps ExampleList",
"ExampleList : Examples",
"ExampleList : ExampleList Examples",
"Examples : EXAMPLES Table",
"Table : TABLE_ROW",
"Table : Table TABLE_ROW",
];

public function yylexdebug( state: int , ch: int): void
{
	var s: String;
	
	if( ch < 0 )
	{
		ch = 0;
	}
	
	if( ch <= YYMAXTOKEN ) //check index bounds
	{
		s = yyname[ ch ];		//now get it
	}
	
	if( s == null )
	{
		s = "illegal-symbol";
	}

	debug( "state " + state + ", reading " + ch + " (" + s + ")" );
}

private var yyn: int;		// next next thing to do
private var yym: int;
private var yystate: int;	// current parsing state from state table
private var yys: String;	// current token string

public function yyparse(): int
{
	var doaction: Boolean = false;
	
	init_stacks();
	
	yynerrs = 0;
	yyerrflag = 0;
	yychar = -1;	// impossible char forces a read
	yystate = 0;	// initial state
	
	state_push( yystate );	//save it
	
	while( true )	// until parsing is done, either correctly, or w/error
	{
		doaction = true;
		
		if( yydebug )
		{
			debug( "loop" );
		}
		
		//#### NEXT ACTION (from reduction table)
		yyn = yydefred[ yystate ];
		while( yyn == 0 )
		{
			if( yydebug )
			{
				debug( "yyn: " + yyn + "	state: " + yystate + "	yychar: " + yychar );
			}
			
			if( yychar < 0 )	//we want a char?
			{
				yychar = yylex();	//get next token
				if( yydebug )
				{
					debug( " next yychar: " + yychar );
				}
				
				// #### ERROR CHECK ####
				if( yychar < 0 )	//it it didn't work/error
				{
					yychar = 0;		//change it to default string (no -1!)
					
					if( yydebug )
					{
						yylexdebug( yystate, yychar );
					}
				}
			}
			
			yyn = yysindex[ yystate ];	//get amount to shift by (shift index)
			
			if( ( yyn != 0 ) && ( yyn += yychar ) >= 0 && yyn <= YYTABLESIZE && yycheck[ yyn ] == yychar )
			{
				if( yydebug )
				{
					debug( "state " + yystate + ", shifting to state " + yytable[ yyn ] );
				}
				
				//#### NEXT STATE ####
				yystate = yytable[ yyn ];	//we are in a new state
				state_push( yystate );		//save it
				val_push( yylval );			//push our lval as the input for next rule
				yychar = -1;				//since we have 'eaten' a token, say we need another
				
				if( yyerrflag > 0 )			//have we recovered an error?
				{
					--yyerrflag;			//give ourselves credit
				}
				
				doaction = false;			//but don't process yet
				break;
			}

			yyn = yyrindex[ yystate ];	//reduce
			if( ( yyn !=0 ) && ( yyn += yychar ) >= 0 && yyn <= YYTABLESIZE && yycheck[ yyn ] == yychar )
			{	 //we reduced!
				if( yydebug )
				{
					debug( "reduce" );
				}
				
				yyn = yytable[ yyn ];
				doaction = true; 		//get ready to execute
				break;					//drop down to actions
			}else //ERROR RECOVERY
			{
				if( yyerrflag == 0 )
				{
					yyerror( "syntax error" );
					yynerrs++;
				}
				
				if ( yyerrflag < 3 )	//low error count?
				{
					yyerrflag = 3;
					while( true )	 //do until break
					{
						if( stateptr < 0 )	 //check for under & overflow here
						{
							yyerror( "stack underflow. aborting..." );	//note lower case 's'
							return 1;
						}
						
						yyn = yysindex[ state_peek( 0 ) ];
						if ( ( yyn != 0 ) && ( yyn += YYERRCODE ) >= 0 && yyn <= YYTABLESIZE && yycheck[ yyn ] == YYERRCODE )
						{
							if( yydebug )
							{
								debug( "state " + state_peek( 0 ) + ", error recovery shifting to state " + yytable[ yyn ] + " " );
							}
							
							yystate = yytable[ yyn ];
							state_push( yystate );
							val_push( yylval );
							doaction = false;
							break;
						}else
						{
							if( yydebug )
							{
								debug( "error recovery discarding state " + state_peek( 0 ) + " " );
							}
								
							if( stateptr < 0 )	 //check for under & overflow here
							{
								yyerror( "Stack underflow. aborting..." );	//capital 'S'
								return 1;
							}
							
							state_pop();
							val_pop();
						}
					}
				}else						//discard this token
				{
					if( yychar == 0 )
					{
						return 1; //yyabort
					}
					
					if( yydebug )
					{
						yys = "illegal-symbol";
						
						if( yychar <= YYMAXTOKEN )
						{
							yys = yyname[ yychar ];
						}
						
						debug( "state " + yystate + ", error recovery discards token " + yychar + " (" + yys + ")" );
					}
					
					yychar = -1;	//read another
				}
			}
			
			yyn = yydefred[ yystate ];
		}
		
		if ( !doaction )	 		//any reason not to proceed?
		{
			continue;				//skip action
		}
		
		yym = yylen[ yyn ];			//get count of terminals on rhs
		
		if( yydebug )
		{
			debug( "state " + yystate + ", reducing " + yym + " by rule " + yyn + " (" + yyrule[ yyn ] + ")" );
		}
		
		if( yym > 0 )				//if count of rhs not 'nil'
		{
			yyval = val_peek( yym - 1 ); //get current semantic value
		}
		
		/* switch(yyn) */
		{
			//########## USER-SUPPLIED ACTIONS ##########
if( yyn == 1 ) // #line 21 "gherkin.y"
{ yyval =  val_peek( 0 ); }
if( yyn == 2 ) // #line 23 "gherkin.y"
{ yyval =  val_peek( 1 ); ASTFeature(yyval).scenarios = Vector.<ASTScenario>(val_peek( 0 )) }
if( yyn == 3 ) // #line 25 "gherkin.y"
{ yyval =  val_peek( 0 ); ASTFeature(yyval).tags = Vector.<String>(val_peek( 1 )) }
if( yyn == 4 ) // #line 27 "gherkin.y"
{ yyval =  val_peek( 1 ); ASTFeature(yyval).scenarios = Vector.<ASTScenario>(val_peek( 0 )); ASTFeature(yyval).tags = Vector.<String>(val_peek( 2 )) }
if( yyn == 5 ) // #line 32 "gherkin.y"
{ yyval =  val_peek( 0 ) }
if( yyn == 6 ) // #line 34 "gherkin.y"
{ yyval =  val_peek( 1 ); ASTFeature(yyval).background = ASTBackground(val_peek( 0 )) }
if( yyn == 7 ) // #line 38 "gherkin.y"
{ yyval =  val_peek( 0 ) }
if( yyn == 8 ) // #line 40 "gherkin.y"
{ yyval =  val_peek( 1 ); ASTFeature(yyval).description = String(val_peek( 0 )) }
if( yyn == 9 ) // #line 44 "gherkin.y"
{ yyval =  new ASTFeature(String(val_peek( 0 )));  }
if( yyn == 10 ) // #line 48 "gherkin.y"
{ yyval =  val_peek( 0 ) }
if( yyn == 11 ) // #line 49 "gherkin.y"
{ yyval =  val_peek( 1 ) + "\n" + val_peek( 0 ) }
if( yyn == 12 ) // #line 54 "gherkin.y"
{ yyval =  new ASTBackground(val_peek( 1 )); ASTBackground(yyval).steps = Vector.<ASTStep>(val_peek( 0 )); }
if( yyn == 13 ) // #line 59 "gherkin.y"
{ yyval = new <ASTStep>[val_peek( 0 )]; }
if( yyn == 14 ) // #line 60 "gherkin.y"
{ Vector.<ASTStep>(val_peek( 1 )).push(val_peek( 0 )); yyval = val_peek( 1 ) }
if( yyn == 15 ) // #line 64 "gherkin.y"
{ yyval =  new ASTStep("given", val_peek( 0 )); }
if( yyn == 16 ) // #line 65 "gherkin.y"
{ yyval =  new ASTStep("when", val_peek( 0 )); }
if( yyn == 17 ) // #line 66 "gherkin.y"
{ yyval =  new ASTStep("then", val_peek( 0 )); }
if( yyn == 18 ) // #line 67 "gherkin.y"
{ yyval =  new ASTStep("and", val_peek( 0 )); }
if( yyn == 19 ) // #line 68 "gherkin.y"
{ yyval =  new ASTStep("but", val_peek( 0 )); }
if( yyn == 20 ) // #line 73 "gherkin.y"
{ yyval =  new <ASTScenario>[ASTScenario(val_peek( 0 ))]; }
if( yyn == 21 ) // #line 74 "gherkin.y"
{ yyval = val_peek( 1 ); Vector.<ASTScenario>(val_peek( 1 )).push(ASTScenario(val_peek( 0 ))); }
if( yyn == 22 ) // #line 79 "gherkin.y"
{ yyval =  new ASTScenario(String(val_peek( 1 )), Vector.<ASTStep>(val_peek( 0 )));  }
if( yyn == 23 ) // #line 81 "gherkin.y"
{ yyval =  new ASTScenario(String(val_peek( 1 )), Vector.<ASTStep>(val_peek( 0 )), Vector.<String>(val_peek( 2 )) );  }
if( yyn == 24 ) // #line 83 "gherkin.y"
{ yyval = val_peek( 0 ); }
if( yyn == 25 ) // #line 85 "gherkin.y"
{ yyval = val_peek( 0 ); ASTScenarioOutline(yyval).tags = Vector.<String>(val_peek( 1 )); }
if( yyn == 26 ) // #line 89 "gherkin.y"
{ yyval = Vector.<String>[val_peek( 0 )]; }
if( yyn == 27 ) // #line 90 "gherkin.y"
{ yyval = val_peek( 1 ); val_peek( 1 ).push(val_peek( 0 )); }
if( yyn == 28 ) // #line 95 "gherkin.y"
{ yyval = new ASTScenarioOutline(String(val_peek( 2 )), Vector.<ASTStep>(val_peek( 1 )), Vector.<ASTExamples>(val_peek( 0 )) ); }
if( yyn == 29 ) // #line 99 "gherkin.y"
{ yyval = new <ASTExamples>[ASTExamples(val_peek( 0 ))]; }
if( yyn == 30 ) // #line 100 "gherkin.y"
{ yyval = val_peek( 1 ); Vector.<ASTExamples>(yyval).push(ASTExamples(val_peek( 0 ))); }
if( yyn == 31 ) // #line 103 "gherkin.y"
{ yyval = new ASTExamples(val_peek( 1 ), ASTTable(val_peek( 0 ))); }
if( yyn == 32 ) // #line 106 "gherkin.y"
{ yyval = new ASTTable(Vector.<String>(val_peek( 0 ))); }
if( yyn == 33 ) // #line 107 "gherkin.y"
{ yyval=val_peek( 1 ); ASTTable(yyval).addRow(Vector.<String>(val_peek( 0 ))); }
// #line 570 "BaseParser.as"
		//########## END OF USER-SUPPLIED ACTIONS ##########
		}
		
		//#### Now let's reduce... ####
		if( yydebug )
		{
			debug( "reduce" );
		}
		
		state_drop( yym );					//we just reduced yylen states
		yystate = state_peek( 0 );		 	//get new state
		val_drop( yym );				   	//corresponding value drop
		yym = yylhs[ yyn ];					//select next TERMINAL(on lhs)
		
		if( yystate == 0 && yym == 0 )		//done? 'rest' state and at first TERMINAL
		{
			debug( "After reduction, shifting from state 0 to state " + YYFINAL );
			
		  	yystate = YYFINAL;				//explicitly say we're done
		  	state_push( YYFINAL );			//and save it
			val_push( yyval );				//also save the semantic value of parsing
			
		  	if( yychar < 0 )				//we want another character?
			{
				yychar = yylex();			//get next character
				if( yychar < 0 )
				{
					yychar = 0;				//clean, if necessary
				}
				
				if( yydebug )
				{
					yylexdebug( yystate, yychar );
				}
			}
			
			if( yychar == 0 )				//Good exit (if lex returns 0 ;-)
			{
				break;				 		//quit the loop--all DONE
			}
		} else								//else not done yet
		{						 			//get next state and push, for next yydefred[]
			yyn = yygindex[ yym ];			//find out where to go
			if( ( yyn != 0 ) && ( yyn += yystate ) >= 0 && yyn <= YYTABLESIZE && yycheck[ yyn ] == yystate )
			{
				yystate = yytable[ yyn ];	//get new state
			}else
			{
				yystate = yydgoto[ yym ];	//else go to new defred
			}
			
			debug( "after reduction, shifting from state " + state_peek( 0 ) + " to state " + yystate );
		  	state_push( yystate );			//going again, so push state & val...
		  	val_push( yyval );				//for next action
		}
	}//main loop
	
	return 0;//yyaccept!!
}

}
}
