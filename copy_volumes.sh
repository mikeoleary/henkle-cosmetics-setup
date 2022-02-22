
#ALL RUN FROM NEW VM

export OLD_VM_IP='x.x.x.x'
export OLD_VM_USER='ubuntu'

#STOP THE CONTAINERS LOCALLY
docker-compose stop mysql
docker-compose stop wordpress

#STOP THE REMOTE CONTAINERS
ssh $OLD_VM_USER@$OLD_VM_IP 'cd ~/henkle-cosmetics && docker-compose stop mysql'
ssh $OLD_VM_USER@$OLD_VM_IP 'cd ~/henkle-cosmetics && docker-compose stop wordpress'

#make a temp dir
ssh $OLD_VM_USER@$OLD_VM_IP 'mkdir /tmp/mysql'
ssh $OLD_VM_USER@$OLD_VM_IP 'mkdir /tmp/wordpress'

#copy files from /var/lib to user's home dir on remote VM
ssh $OLD_VM_USER@$OLD_VM_IP 'sudo cp /var/lib/docker/volumes/henkle-cosmetics_mysql/ -r -p /tmp/mysql'
ssh $OLD_VM_USER@$OLD_VM_IP 'sudo cp /var/lib/docker/volumes/henkle-cosmetics_wordpress/ -r -p /tmp/wordpress'

#CHANGE OWNER of all the files on the remote VM because otherwise scp command won't work
ssh $OLD_VM_USER@$OLD_VM_IP "sudo chown -R $OLD_VM_USER:$OLD_VM_USER /tmp/mysql/*"
ssh $OLD_VM_USER@$OLD_VM_IP "sudo chown -R $OLD_VM_USER:$OLD_VM_USER /tmp/wordpress/*"

#copy files using SCP from old VM to new VM
scp -r $OLD_VM_USER@$OLD_VM_IP:/tmp/mysql /tmp
scp -r $OLD_VM_USER@$OLD_VM_IP:/tmp/wordpress /tmp

#EMPTY the existing volume and then copy all the copied files into it.
sudo rm -rf /var/lib/docker/volumes/henkle-cosmetics_mysql/
sudo cp -r /tmp/mysql/henkle-cosmetics_mysql /var/lib/docker/volumes/

sudo rm -rf /var/lib/docker/volumes/henkle-cosmetics_wordpress/
sudo cp -r /tmp/wordpress/henkle-cosmetics_wordpress /var/lib/docker/volumes/

#START THE CONTAINERS AGAIN
docker-compose start mysql
docker-compose start wordpress
