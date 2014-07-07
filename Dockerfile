# Set the base image to Ubuntu
FROM ubuntu

# Update the repository sources list
RUN apt-get update

#install packages
RUN apt-get -y install graphite-web graphite-carbon apache2 libapache2-mod-wsgi

#config graphite
RUN sed -i "s/#SECRET_KEY = .\+/SECRET_KEY='secretkey'/" /etc/graphite/local_settings.py
RUN sed -i "s/'USER':.\+/'USER': 'graphite',/" /etc/graphite/local_settings.py
RUN sed -i "s/'PASSWORD':.\+/'PASSWORD': 'password1',/" /etc/graphite/local_settings.py
RUN sed -i "s/'HOST':.\+/'HOST': '127.0.0.1',/" /etc/graphite/local_settings.py

RUN sed -i "s/CARBON_CACHE_ENABLED=false/CARBON_CACHE_ENABLED=true/" /etc/default/graphite-carbon 

#syncdb
RUN echo no|graphite-manage syncdb

#set conf in place
RUN ln -s /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-available/

#disable default vhost
RUN a2dissite 000-default

#enable our vhost
RUN a2ensite apache2-graphite

#apache reload
RUN service apache2 reload

##################### INSTALLATION END #####################

# Expose the default port

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]