#!/bin/bash
#
# Run tests on an assignment question.  We run the tests and capture
# their standard output (plus any error stream messages) to an output
# file.  A question test passes if the difference of the output matches
# a reference/correct example output file.  No differences means the
# question test passes, but differences indicate problems and the test
# fails.

# parse command line args
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--use-color)
            USE_COLOR=YES
            shift # past argument
            ;;
        -*|--*)
            echo "Usage run-system-tests [-c|--use-color]"
            exit 1
            ;;
    esac
done

# list of system test simulations to run
tests="
q01 01
q01 02
q01 03
"

# directories for input and output files
indir="tests"
outdir="output"

# constants for colored terminal output (https://misc.flogisoft.com/bash/tip_colors_and_formatting)
if [ -z "$USE_COLOR" ];
then
    GREEN=""
    RED=""
    NORMAL=""
else
    GREEN="\e[1m\e[92m" # this is actually bold light green
    RED="\e[1m\e[91m"   # bold light red
    NORMAL="\e[0m"
fi

# create temporary directory for output, remove any old output first
rm -rf ${outdir}
mkdir -p ${outdir}

# run all of the system tests
declare -i passed=0
declare -i numtests=0
IFS=$'\n'
for testdata in $tests
do
    # parse out the simulation inputs and name
    question_num=`echo ${testdata} | cut -d ' ' -f 1`
    test_num=`echo ${testdata} | cut -d ' ' -f 2`
    question_script="${question_num}.py"
    
    # set up input and output file names to use
    infile=${indir}/${question_num}-${test_num}-input.dat
    expectfile=${indir}/${question_num}-${test_num}-expected.out
    outfile=${outdir}/${question_num}-${test_num}-actual.out

    # run the simulation
    #python3 ${question_script} > ${outfile} 2>&1
    expect -f tests/test-expect q01.py ${infile} > ${outfile}

    # diff returns 0 if files are identical, which means system test passed
    diff --report-identical-files --brief --ignore-all-space --ignore-blank-lines --ignore-tab-expansion --ignore-case ${outfile} ${expectfile} > /dev/null

    if [ $? -eq 0 ]
    then
      echo -e "Question ${question_num} test ${test_num}: ${GREEN}PASSED${NORMAL}"
      passed=$(( passed + 1 ))
    else
      echo -e "Question ${question_num} test ${test_num}: ${RED}FAILED${NORMAL}"
      diff --ignore-all-space --ignore-blank-lines --ignore-tab-expansion --ignore-case ${outfile} ${expectfile}
      echo ""
    fi
    numtests=$(( numtests + 1 ))
done

# display final result of tests, give explicit non-zero exit code on failure so workflow detects
# failed tests
if [ ${passed} -eq ${numtests} ]
then
    echo -e "${GREEN}===============================================================================${NORMAL}"
    echo -e "${GREEN}All ${question_num} tests passed    ${NORMAL} (${passed} tests passed of ${numtests} tests)"
    exit 0
else
    echo -e "${RED}===============================================================================${NORMAL}"
    echo -e "${RED}Question ${question_num} failures detected${NORMAL} (${passed} tests passed of ${numtests} tests)"
    exit 1
fi
