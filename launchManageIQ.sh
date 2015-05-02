nohup /start_postgres.sh &
echo "waiting for the DB to start"
sleep 5
echo "GO!"
sudo -u postgres sh /createDB.sh
cd /manageiq/vmdb
bin/rake db:migrate
bin/rake evm:start
tail -f log/evm.log
