psql -U postgres -d solid_start -f /data/analysis/CreateCrimeScore.sql
psql -U postgres -d solid_start -f /data/analysis/CreateEarningsScore.sql
psql -U postgres -d solid_start -f /data/analysis/CreateFinalLocationTable.sql
psql -U postgres -d solid_start -f /data/analysis/CreateHomeValueScore.sql

psql -U postgres -d solid_start -f /data/analysis/CreateJobsScore.sql

psql -U postgres -d solid_start -f /data/analysis/CreateParkSocre.sql
psql -U postgres -d solid_start -f /data/analysis/Script.sql
