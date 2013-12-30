input=""
expected_output="Philippines"
echo input : $input
echo expected output : $expected_output
actual_output=$(echo $input | perl example.pl)
echo actual output : $actual_output
if [ "$expected_output" = "$actual_output" ]
then
	echo ok
	exit 0
else
	echo not ok
	exit 1
fi