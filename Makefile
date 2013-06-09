
schema:
	rm -f ./db/test.db
	sqlite3 ./db/test.db < ./db/schema.sql
	rm -f ./db/test.db

newdb:
	rm -f ./db/odesk.db
	sqlite3 ./db/odesk.db < ./db/schema.sql
	sqlite3 ./db/odesk.db < ./db/data.sql

tests:
	make newdb
	dzil build

.PHONY: newdb schema tests
