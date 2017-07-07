# Archivesspace Report Script  

This script runs through variety of data linked accession objects in archivesspace.  It does this using SQL and Ruby to format the item into excel spreadsheets.  This script was written for a yearly use and getting items out that were needed for Libraries reporting.

## Dependencies  
- Archivesspace >= 2.0.1 
- Ruby >= 2.3.3  

## GEMS  
- Mysql2 
- RubyXL 

## How to Use
 - First download or clone this repository
 - Make sure you have permissons or a user setup on your archivesspace mysql database.  
 - Change your database connections either in the main.rb file  (see database section)
 - Make sure you have permission to run execute the main.rb file 
 - Make sure your in apace_report (this directory if you renamed it) directory 
 - then run `ruby ./main.rb` in a command line or terminal 

## All Archivesspace Data Export 
  - To get all export data make sure that all the tables for your version of archivesspace are in the csv file seperated by commas.  Then run `ruby ./all_data_excel.rb` in the command line or terminal. **THIS WILL TAKE 10-12 HOURS** 

### DB Connection 
  ```ruby 
      # create a db connection and query some results 
      db = DBConnect.new()
      db.db_host  = "127.0.0.1" # your ip here
      db.db_user  = "root" # your user here 
      db.db_pass  = "password" # your password here
      db.db_name = "archivesspace" # this should be the same 
      db.db_port = "3306" # port number of your mysql db 
  ```

## Contributing 
This can be done in the form of documentation, code, or submitting bugs.  

If you notice a way to improve this code, or want contribute your work back to the repository.  You may do so by forking the repository and putting in a pull-request with changes you have made.   

## Open Source 
This is open source, you can copy, read, modify, fork, etc without telling the West Virginia University Library.  The various gems, programming languages, and other depdendencies may have other liscensing.  