#!/bin/bash
#
# Script is to be executed in this directory!
# - Probably you have to compile AsYacc for your architecture
# - cd to <WORKSPACE>/AsYacc 
# - gcc *.c -o AsYacc 

cmd=$(which AsYacc)

if [ -z "$cmd" ]; then
	cat <<EOF

*** Kann AsYacc nicht finden. ***

Massnahmen: Falls notwendig, AsYacc kompilieren

  cd <WORKSPACE_ROOT>/bm_mathcore/AsYacc
  gcc -o AsYacc[.exe] *.c 
  
Dann AsYacc[.exe] in ein Verzeichnis im PATH kopieren. 

EOF
exit 1
fi

$cmd -Hclass=EplParser -Hextends=BaseEplParser -Hpackage=com.bettermarks.mathcore.edl.parser epl.y && mv EplParser.as EplParser_tmp.as && cat EplParser_tmp.as | sed -e's/yyname \: Array = \[/yyname \: Array = \[null/' > EplParser.as && rm EplParser_tmp.as

echo "Token.as in eclipse neu laden!"
echo "Ggf. EplLexer.as anpassen!"
