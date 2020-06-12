# SQL Runner
SQL Runner is a tool to run sql scripts in .sql files using bash script. You can also pass the sql filename, log filename as parameters and as well parameters to each sql file.

*Command to invoke the Runner* is given below with two examples.
```
$ ./runSqlFile.sh db-config.properties sampleQuery-01.sql sampleQuery-01.log param-for-sql-file-01

$ ./runSqlFile.sh db-config.properties sampleQuery-02.sql sampleQuery-02.log param-for-sql-file-02
```
## Configurable
The SQL Runner loads the DB Configuration from a property file, making the tool flexible to run on any environment and the parameterised approach of passing SQL File(s) and parameter to SQL File(s) makes it much flexible to customization.

## Scheduling for Repeated Runs
We are using Crontab to configure the repeated run of each sql run as a job.
### How to configure Crontab


## Before using
  - Make sure you modify the db-config.properties as per your environment
  - Make sure you update the SQL Files with your queries and necessary changes for parameters

## Generating Artifacts Files from CSV
```
$ ./generateArtifacts.sh queries.csv
```
**Note**: In your case, the CSV Filename could be different