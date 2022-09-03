from datetime import datetime
import json
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.types import *
from itertools import groupby
import sys

class SparkProcessException(Exception):
    """User customized spark session class"""

#reading command line argument
param_conf = sys.argv[1]
job_name = sys.argv[2]

spark = SparkSession.builder \
    .appName(job_name) \
    .config("spark.debug.maxToStringFields","10000") \
    .getOrCreate()  

appId = spark.sparkContext.applicationId

buitlin_print = print
def timestamp_print(*args, **kwargs):
    logTime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    printheader = logTime+" "+job_name+" "+" SPARK - "
    buitlin_print(printheader, *args, **kwargs)
print = timestamp_print

print('INFO - Spark job started')
print(f'INFO - Spark application id for the job : {appId}')

# try:
#     with open(param_conf, 'r') as attr_conf:
#         attr_all = json.load(attr_conf)
#     print('INFO - conf file read status : Successful !')
#     attr_global = [x for x in attr_all if str(x[])]

read_file_path = '../Data/'
file_name = 'Primary_Person_use.csv'

try:
    persons_df = spark.read.csv(f'{read_file_path}{file_name}', header=True)
    print("INFO - Reading source file status : Successful !")
except Exception as e:
    print(f'ERROR - Spark read failed with error : {e}')
    raise SparkProcessException('Spark process failed.') from e

#business logic
non_male = persons_df.filter(persons_df.PRSN_GNDR_ID.isin(["FEMALE","UNKNOWN","NA"])) \
    .groupby("CRASH_ID").count() \
    .select("CRASH_ID")

male_killed = persons_df.filter((persons_df.PRSN_GNDR_ID == "MALE") & (persons_df.DEATH_CNT == 1)) \
    .groupBy("CRASH_ID").count() \
    .select("CRASH_ID").subtract(non_male) \
    .selectExpr("count(CRASH_ID) as crash_count") \
    .withColumn("description", F.lit("Crashes [male killed]")) \
    .select("description","crash_count")

write_file_path = '../output/'
try:
    male_killed.write.save('{}analysis_1/'.format(write_file_path),\
        format='csv', sep = '|', mode='overwrite', header = True, escape='', quote='')
except Exception as e:
    print(f'ERROR - Spark write into hdfs failed with error : {e}')
    raise SparkProcessException('Spark write into hdfs failed.') from e