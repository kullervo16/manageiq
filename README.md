#ManageIQ Docker file

This Dockerfile builds ManageIQ into a centos PostgreSQL image. 

Be prepared for a rather large build

##Running
The first time you run the container, you should give it a name. This first run will initialize the database. Following runs should reference the volumes to pick up the changes you made.

  docker run --name=manageiq -d -P  kullervo16/manageiq

Once completely initialized, you can access it (this may take some time). When  running later, use this command :

  docker run --rm --volumes-from=manageiq -P kullervo16/manageiq

The interface is exposed at port *3000*. The login is *admin* with pwd *smartvm*. You can change this or course.

Have fun with it...
