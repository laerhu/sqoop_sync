# sqoop_sync

## Target

An automatic and simple data sync script maker module which helps to get rid of fussy and inflexible configuration of kettle steps.

## Usage

`sqoop_sync.sh tb1.conf 20211108063000`

argument #1 is a config file containing business parameters such as connection url, hive schema or table name formation.

argument #2 is a time value stands for when the job will be executed.

## Functions

- [x] business params in another config file.
- [ ] auto create table from source database schemas.
- [ ] multiple update method: overwrite and partition.
- [ ] batch tables in one job.
- [ ] multiple conccurency control method to choose: fifo or array-split.
