#!/usr/bin/env bash

xsl="vendor/ant2dot.xsl"
out="vendor/build.dot"
xalan="vendor/xalan.jar"
javaClass="org.apache.xalan.xslt.Process"

currentUser=$(whoami)
homeDirectory=(echo {HOME})

result="build.png"

buildXmlFilepath=$1
outputDirectory=$2

if [ ${#outputDirectory} -gt 0 ]
then
	outputDirectory="$outputDirectory/$result"
else
	outputDirectory=$result
fi

if [ ${#buildXmlFilepath} -gt 0 ]
then
	if [ -f $outputDirectory ]; then
		echo "File with this name already exists. Please remove first the old"
		exit
	else
		java -cp $xalan $javaClass -IN $1 -XSL $xsl -OUT $out
		dot -Tpng $out -o $outputDirectory
		rm -f $out
	fi
fi
