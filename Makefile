
cron:
	(crontab -l 2>/dev/null; echo "* * * * * sleep 23; cd $(CURDIR) && ./antivirus-cron.sh $(CURDIR)/dir $(CURDIR)/malicious_dir $(CURDIR)/directory-info.last $(CURDIR)/whitelist >> $(CURDIR)/antivirus.log 2>&1") | crontab -

uncron:
	crontab -r

setup:
	chmod +x antivirus-cron.sh antivirus.sh restore.sh
	mkdir -p dir malicious_dir whitelist

run: setup
	./antivirus-cron.sh dir malicious_dir directory-info.last whitelist

restore:
	./restore.sh dir malicious_dir whitelist

clean:
	rm -f directory-info.new antivirus.log
