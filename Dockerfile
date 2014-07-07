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

#syncdb, we need a superuser, but to avoid writing an expect script to do that, interactive creation is skipped and the data
#is loaded manually after db creation from a json dump
RUN echo no|graphite-manage syncdb
RUN cat >initial.json <<"_EOF" \
[{"pk": 1, "model": "contenttypes.contenttype", "fields": {"model": "profile", "name": "profile", "app_label": "account"}}, {"pk": 2, "model": "contenttypes.contenttype", "fields": {"model": "variable", "name": "variable", "app_label": "account"}}, {"pk": 3, "model": "contenttypes.contenttype", "fields": {"model": "view", "name": "view", "app_label": "account"}}, {"pk": 4, "model": "contenttypes.contenttype", "fields": {"model": "window", "name": "window", "app_label": "account"}}, {"pk": 5, "model": "contenttypes.contenttype", "fields": {"model": "mygraph", "name": "my graph", "app_label": "account"}}, {"pk": 6, "model": "contenttypes.contenttype", "fields": {"model": "dashboard", "name": "dashboard", "app_label": "dashboard"}}, {"pk": 7, "model": "contenttypes.contenttype", "fields": {"model": "event", "name": "event", "app_label": "events"}}, {"pk": 8, "model": "contenttypes.contenttype", "fields": {"model": "permission", "name": "permission", "app_label": "auth"}}, {"pk": 9, "model": "contenttypes.contenttype", "fields": {"model": "group", "name": "group", "app_label": "auth"}}, {"pk": 10, "model": "contenttypes.contenttype", "fields": {"model": "user", "name": "user", "app_label": "auth"}}, {"pk": 11, "model": "contenttypes.contenttype", "fields": {"model": "session", "name": "session", "app_label": "sessions"}}, {"pk": 12, "model": "contenttypes.contenttype", "fields": {"model": "logentry", "name": "log entry", "app_label": "admin"}}, {"pk": 13, "model": "contenttypes.contenttype", "fields": {"model": "contenttype", "name": "content type", "app_label": "contenttypes"}}, {"pk": 14, "model": "contenttypes.contenttype", "fields": {"model": "tag", "name": "tag", "app_label": "tagging"}}, {"pk": 15, "model": "contenttypes.contenttype", "fields": {"model": "taggeditem", "name": "tagged item", "app_label": "tagging"}}, {"pk": 1, "model": "auth.permission", "fields": {"codename": "add_profile", "name": "Can add profile", "content_type": 1}}, {"pk": 2, "model": "auth.permission", "fields": {"codename": "change_profile", "name": "Can change profile", "content_type": 1}}, {"pk": 3, "model": "auth.permission", "fields": {"codename": "delete_profile", "name": "Can delete profile", "content_type": 1}}, {"pk": 4, "model": "auth.permission", "fields": {"codename": "add_variable", "name": "Can add variable", "content_type": 2}}, {"pk": 5, "model": "auth.permission", "fields": {"codename": "change_variable", "name": "Can change variable", "content_type": 2}}, {"pk": 6, "model": "auth.permission", "fields": {"codename": "delete_variable", "name": "Can delete variable", "content_type": 2}}, {"pk": 7, "model": "auth.permission", "fields": {"codename": "add_view", "name": "Can add view", "content_type": 3}}, {"pk": 8, "model": "auth.permission", "fields": {"codename": "change_view", "name": "Can change view", "content_type": 3}}, {"pk": 9, "model": "auth.permission", "fields": {"codename": "delete_view", "name": "Can delete view", "content_type": 3}}, {"pk": 10, "model": "auth.permission", "fields": {"codename": "add_window", "name": "Can add window", "content_type": 4}}, {"pk": 11, "model": "auth.permission", "fields": {"codename": "change_window", "name": "Can change window", "content_type": 4}}, {"pk": 12, "model": "auth.permission", "fields": {"codename": "delete_window", "name": "Can delete window", "content_type": 4}}, {"pk": 13, "model": "auth.permission", "fields": {"codename": "add_mygraph", "name": "Can add my graph", "content_type": 5}}, {"pk": 14, "model": "auth.permission", "fields": {"codename": "change_mygraph", "name": "Can change my graph", "content_type": 5}}, {"pk": 15, "model": "auth.permission", "fields": {"codename": "delete_mygraph", "name": "Can delete my graph", "content_type": 5}}, {"pk": 16, "model": "auth.permission", "fields": {"codename": "add_dashboard", "name": "Can add dashboard", "content_type": 6}}, {"pk": 17, "model": "auth.permission", "fields": {"codename": "change_dashboard", "name": "Can change dashboard", "content_type": 6}}, {"pk": 18, "model": "auth.permission", "fields": {"codename": "delete_dashboard", "name": "Can delete dashboard", "content_type": 6}}, {"pk": 19, "model": "auth.permission", "fields": {"codename": "add_event", "name": "Can add event", "content_type": 7}}, {"pk": 20, "model": "auth.permission", "fields": {"codename": "change_event", "name": "Can change event", "content_type": 7}}, {"pk": 21, "model": "auth.permission", "fields": {"codename": "delete_event", "name": "Can delete event", "content_type": 7}}, {"pk": 22, "model": "auth.permission", "fields": {"codename": "add_permission", "name": "Can add permission", "content_type": 8}}, {"pk": 23, "model": "auth.permission", "fields": {"codename": "change_permission", "name": "Can change permission", "content_type": 8}}, {"pk": 24, "model": "auth.permission", "fields": {"codename": "delete_permission", "name": "Can delete permission", "content_type": 8}}, {"pk": 25, "model": "auth.permission", "fields": {"codename": "add_group", "name": "Can add group", "content_type": 9}}, {"pk": 26, "model": "auth.permission", "fields": {"codename": "change_group", "name": "Can change group", "content_type": 9}}, {"pk": 27, "model": "auth.permission", "fields": {"codename": "delete_group", "name": "Can delete group", "content_type": 9}}, {"pk": 28, "model": "auth.permission", "fields": {"codename": "add_user", "name": "Can add user", "content_type": 10}}, {"pk": 29, "model": "auth.permission", "fields": {"codename": "change_user", "name": "Can change user", "content_type": 10}}, {"pk": 30, "model": "auth.permission", "fields": {"codename": "delete_user", "name": "Can delete user", "content_type": 10}}, {"pk": 31, "model": "auth.permission", "fields": {"codename": "add_session", "name": "Can add session", "content_type": 11}}, {"pk": 32, "model": "auth.permission", "fields": {"codename": "change_session", "name": "Can change session", "content_type": 11}}, {"pk": 33, "model": "auth.permission", "fields": {"codename": "delete_session", "name": "Can delete session", "content_type": 11}}, {"pk": 34, "model": "auth.permission", "fields": {"codename": "add_logentry", "name": "Can add log entry", "content_type": 12}}, {"pk": 35, "model": "auth.permission", "fields": {"codename": "change_logentry", "name": "Can change log entry", "content_type": 12}}, {"pk": 36, "model": "auth.permission", "fields": {"codename": "delete_logentry", "name": "Can delete log entry", "content_type": 12}}, {"pk": 37, "model": "auth.permission", "fields": {"codename": "add_contenttype", "name": "Can add content type", "content_type": 13}}, {"pk": 38, "model": "auth.permission", "fields": {"codename": "change_contenttype", "name": "Can change content type", "content_type": 13}}, {"pk": 39, "model": "auth.permission", "fields": {"codename": "delete_contenttype", "name": "Can delete content type", "content_type": 13}}, {"pk": 40, "model": "auth.permission", "fields": {"codename": "add_tag", "name": "Can add tag", "content_type": 14}}, {"pk": 41, "model": "auth.permission", "fields": {"codename": "change_tag", "name": "Can change tag", "content_type": 14}}, {"pk": 42, "model": "auth.permission", "fields": {"codename": "delete_tag", "name": "Can delete tag", "content_type": 14}}, {"pk": 43, "model": "auth.permission", "fields": {"codename": "add_taggeditem", "name": "Can add tagged item", "content_type": 15}}, {"pk": 44, "model": "auth.permission", "fields": {"codename": "change_taggeditem", "name": "Can change tagged item", "content_type": 15}}, {"pk": 45, "model": "auth.permission", "fields": {"codename": "delete_taggeditem", "name": "Can delete tagged item", "content_type": 15}}, {"pk": 1, "model": "auth.user", "fields": {"username": "root", "first_name": "", "last_name": "", "is_active": true, "is_superuser": true, "is_staff": true, "last_login": "2014-07-07T14:33:44.041", "groups": [], "user_permissions": [], "password": "pbkdf2_sha256$12000$PsI7ssBJV4dE$u0ozejWMPvLzjekwQHvWBV4jONtfjGyYOocOzC5fSDY=", "email": "", "date_joined": "2014-07-07T14:33:44.041"}}] \
 _EOF 
RUN graphite-manage loaddata inital.json
RUN rm initial.json
#set owner to graphite
RUN chown _graphite:_graphite /var/lib/graphite/graphite.db

#set conf in place
RUN ln -s /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-available/

#disable default vhost
RUN a2dissite 000-default

#enable our vhost
RUN a2ensite apache2-graphite

#apache reload
RUN service apache2 reload
RUN service carbon-cache start

##################### INSTALLATION END #####################

# load env vars for apache and expose the default port

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
