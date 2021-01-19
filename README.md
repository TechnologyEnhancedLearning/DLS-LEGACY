# Installs

- [Visual Studio Professional 2019](https://visualstudio.microsoft.com/downloads/)
- SQL Server 2019
- [SQL Server Management Studio 18](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
- [Git](https://git-scm.com/)
- [DevExpress] (https://www.devexpress.com/ClientCenter/DownloadManager/)

# Getting the code

Checkout the `DLS-LEGACY` repository from [GitHub](https://github.com/TechnologyEnhancedLearning/DLS-LEGACY):

```bash
git checkout https://github.com/TechnologyEnhancedLearning/DLS-LEGACY.git
```

You should now be able to open the solution in Visual Studio 2019 by finding and double-clicking the `ITSP-TrackingSystemRefactor.sln` file.

# Setting up the database

Get a database backup `.bak` file from the current system.

## Restore the database from the backup

- Open SQL Server Management Studio and connect to your `localhost` instance
- Right-click *Databases* → *Restore Database…*
- On the *General* tab, select *Device* under source and click the *…* button to the right
- In the backup media window, click *Add* and navigate to and select the `.bak` file
- Click *OK* on the various windows until the restore starts to run
- Alternatively, run the create database `DLS-LEGACY\database\CreateDatabaseMbdbx101.sql` - a populate data script may be added in future

You should now see the `mbdbx101` database in your *Databases* folder on the `localhost` server.

### Inspecting the database

It can be useful to have a look at what's in the database, to test out and plan SQL queries. The easiest way to do this is:

1. Open SQL Server Management Studio
2. Connect to `localhost`
3. Expand databases -> `mbdbx101` in the menu on the left.
4. Expand tables. You can now see all the tables in the database.
5. Right click a table and click "Select top 1000 rows". This should open an editor with an SQL query to get the first 1000 rows in the DB. You should also be able to see the result of running that query below. You can change this SQL query to anything you like and click the "execute" button to run it and update the results.

## Making changes to the database
If you just want to make temporary changes to the database for testing (e.g. adding in some specific data to a table to test something) then you can do that in SQL Management Studio with the SQL scripts as described in the previous section. However if you want to make a permanent change to the database, for example to add a new table, then you need to use a migration and this should be added to the `digitallearningsolutions` repository at [GitHub](https://github.com/TechnologyEnhancedLearning/DLSV2).

That repository uses [fluent migrator](https://fluentmigrator.github.io/articles/intro.html) for migrations. Migrations live in DigitalLearningSolutions.Data.Migrations. The migrations are applied by the RegisterMigrationRunner method in MigrationHelperMethods.cs. They should get applied when you run the app and when you run the data unit tests.