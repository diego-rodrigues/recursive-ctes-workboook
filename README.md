# Recursive Common Table Expressions workbooks

This repository holds two workbooks that showcase how to use recursive CTEs to solve problems in SQL.

The code was developed and tested using a PostgreSQL server in a Docker container.

To create and start the PostgreSQL server, make sure to have Docker installed and run the following code:
```
docker-compose up
```

On your browser, head to [local server page](http://localhost:8888/browser/).

Log in using the default credentials (provided in the [docker-compose.yml](docker-compose.yml) file):
```
admin@admin.com 
admin
```

Register a new server:
- On the tab `General`, choose a name;
- On the tab `Connection`
    - set hostname to "db";
    - set username to "user-name" (provided in the docker compose file);
    - set password to "strong-password" (provided in the docker compose file).

Start a new SQL workbook!

