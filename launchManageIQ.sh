nohup /start_postgres.sh &
nohup /usr/bin/memcached -u root &
echo "waiting for the DB to start"
sleep 5
if [ -e /var/lib/pgsql/initialized ]
then
	echo "Reusing existing DB"
	cd /manageiq/vmdb
else
	echo "Init DB"
	sudo -u postgres sh /createDB.sh
	cd /manageiq/vmdb
	bin/rake db:migrate
	touch /var/lib/pgsql/initialized
fi
bin/rake evm:start
tail -f log/evm.log
