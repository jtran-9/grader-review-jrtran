# set -e
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

testFile=`find -name ListExamples.java`

# checks if file exists
# if not, terminates bash script
if [[ -e $testFile ]] && [[ -f $testFile ]]
then 
  cp -r $testFile TestListExamples.java lib grading-area
  cd grading-area
  javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
else
  echo "File not found: ListExamples.java"
  exit 1
fi
OUTPUT=`java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples`

error=$?
if [[ $error -ne 0 ]]
then
  echo "Error Code:" $error
  echo "Error found when running tests. Please double check your code in ListExamples.java. More information is in the output.txt file."
fi

echo "$OUTPUT" > output.txt
numTests=`grep "Tests" output.txt`
totalTest=-1
numFails=0
for i in $numTests
do
  if [[ ${i:0:1} =~ ^[0-9]+$ ]]
  then
    if [[ $totalTest == -1 ]]
    then
      totalTest=${i:0:1}
    else
      numFails=${i:0:1}
    fi
  fi
done

if [[ $totalTest == -1 ]] && [[ $numFails == 0 ]]
then
  echo "Grade: 100%"
else
  echo "Grade:" `expr $totalTest - $numFails` / $totalTest
fi
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
