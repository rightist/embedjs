DIR=`dirname $0`

# TODO actually the check should valllidate if this is a valid definition file
if [ -z "$1" ]; then
	echo "Please specify the kind of build you would like, choose from"
	# TODO the follwoing should actually ONLY be a list of the valid 
	find $DIR/../profiles -type f -name "*.definition" | xargs basename -a -s .definition
	echo 
	exit;
fi

PLATFORMS=`find $DIR/../profiles/platforms -type f -name "*.json"`
echo $PLATFORMS
for P in $PLATFORMS; do

	# The following has to be executed in "tools" directory, since getFiles.js relys on the path.
	FILES=$(java -jar $DIR/js.jar $DIR/getFiles.js "$DIR/../$P" $DIR/../src/dojo `cat $DIR/../profiles/$1.definition`)
	echo $FILES
	
	#PLATFORM_NAME=`basename "$P" .json`
	#if [ "${FILES:0:6}" = "ERROR:" ]; then
	#	echo $FILES
	#	exit;
	#fi
	#DEST_FILE=$DIR/../build/embed-$1-$PLATFORM_NAME.js
	#DEST_FILE_UNCOMPRESSED=$DIR/../build/embed-$1-$PLATFORM_NAME.uncompressed.js
	#cd $DIR/../src
	#java -jar $DIR/shrinksafe.jar $FILES > $DEST_FILE
	#echo "created `du -h $DEST_FILE`"
	## Create uncompressed files
	#cat $FILES > $DEST_FILE_UNCOMPRESSED
	#echo "created `du -h $DEST_FILE_UNCOMPRESSED`"
done

#echo
#echo "Creating files in src/tests"
#$DIR/createRunTests.sh