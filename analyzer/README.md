# AWS Account Analzyer

There are 3 scripts here.  The first one gathers object metadata in json format from an account.  The second takes the raw output files and colates them into a single merged json object.  The third prints salient information in a nicely formatted way.

## scope.sh
Run this on an instance that has aws tools installed and has proper read credentails.  Everything is hard coded in the script.  Edit the script and change the path for the scratch directory and the regions.  Also edit the commands you want to iterate.

This script when run will spin through all the commands and generate output files for the account in json format which can be used by the other scripts to do an account analysis.

This script is purely read only on the account and by default writes its output files to /tmp/scope which gets nuked on every run.

Always run this script first to collect all the data.

## jsonmerge.rb

Usage:
```
./jsonmerge.rb us-east-1 /tmp/scope > /tmp/mergedfile.json
```
* region such as us-east-1 (shown)
* filepath such as /tmp/scope (the default for scope.sh)
* redirect the output to a file as shown.  This file will be the merge of all the json objects in /tmp/scope for the region specified.

**Notes:** It is possible to edit this script and have it output yaml instead of json.  Examples are shown at the end - simply change the last puts to
```
#Change
puts output_hash.to_json
#to
puts output_hash.to_yaml
```
## analyzer.rb

Usage:
```
./newanalyzer.rb /tmp/mergedfile.json
```
Gives a nicely formatted output of the /tmp/mergedfile.json generated with jsonmerge.rb.  This is relatively easy to edit and adjust as required for different outputs.
