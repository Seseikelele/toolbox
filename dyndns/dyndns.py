#!/usr/bin/env python3
from dns.resolver import Resolver
import logging, requests, socket, sys, time

import secret

fmt = '%(asctime)s %(levelname)s: %(message)s'
datefmt = '%Y/%m/%d %H:%M:%S'
filename = 'dyndns.log'
level = logging.INFO
logging.basicConfig(format=fmt, datefmt=datefmt, filename=filename, level=level)

# TARGETS = [
# 	{
# 		'hostname': 'subdomain.domain.com',
# 		'id': 'dynhost_id',
# 		'pass': 'secret'
# 	},
# 	{
# 		'hostname': 'helloworld.example.com',
# 		'id': 'dynhost_id',
# 		'pass': 'secret'
# 	}
# ]

def get_public_ip():
	r = Resolver()
	r.nameservers = [socket.gethostbyname('resolver1.opendns.com')]
	return r.resolve('myip.opendns.com', 'A', search=True)[0].to_text()
	

def update_public_ips(ip):
	for target in secret.TARGETS:
		hostname = target['hostname']
		request = f'http://www.ovh.com/nic/update?system=dyndns&hostname={hostname}&myip={ip}'
		r = requests.get(request, auth=(target['id'], target['pass']))
		logging.info(f'{hostname} {r.text}')

def main():
	try:
		old_ip = '1.1.1.1'
		while True:
			try:
				curr_ip = get_public_ip()
				logging.debug('acquired IP: ' + curr_ip)
				if curr_ip != old_ip:
					logging.info('changing IP')
					update_public_ips(curr_ip)
					old_ip = curr_ip
				time.sleep(60)
			except Exception as e:
				logging.warning('error while getting public IP')
				time.sleep(300)
	except Exception as e:
		logging.error(e)

if __name__ == '__main__':
	main()