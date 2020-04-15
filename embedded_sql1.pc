/* This is a sample dynamic Embedded SQL program. In order to run it,
   You need to do the following. 
1. proc dsqlm1.pc
2. cc -c dsqlm1.c -I/usr/include/oracle/11.2/client64	
3. cc -o dsqlm1 dsqlm1.o -L/usr/lib/oracle/11.2/client64/lib -lclntsh
4. ./dsqlm1

cc -o dsqlm12 dsqlm12.o -L/usr/lib/oracle/11.2/client64/lib -lclntsh
*/

#include <stdio.h>
exec sql include sqlca;
exec sql begin declare section;
  char sqlstmt[3][1024] = {
    "create table Supplier (s# varchar(15) NOT NULL primary key, sname varchar(15), status integer, city varchar(15))",
    "create table Part (p# varchar(15) NOT NULL primary key, pname varchar(15), pcolor varchar(15), weight FLOAT(126), city varchar(15))",
    "create table SP (s# varchar(15), p# varchar(15), qty integer, primary key (s#, p#))"
  };
  char *MYID= "fedora/oracle";
exec sql end declare section;

int main(){
  exec sql connect :MYID;
  if (sqlca.sqlcode == 0)
      printf("Connected to ORACLE\n");
  else
      printf("Connection Failed\n");

/*  create table account using dynamic methid 1 	*/

  // strcpy(sqlstmt, "create table account (acc# int primary key,name varchar2(10),balance real default 0, check (balance >= 0))");

  exec sql set transaction read write;
  exec sql execute immediate :sqlstmt[0];
  if (sqlca.sqlcode == 0)
      printf("Table Supplier created \n");    
  else
      printf("Table Supplier not created\n");
     
/*  drop table account using dynamic SQL method 1	*/
    
  exec sql execute immediate "drop table Supplier";
  if (sqlca.sqlcode == 0)
      printf("Table Supplier dropped \n");    
  else
      printf("Table Supplier not dropped \n");

  exec sql execute immediate :sqlstmt[1];
  if (sqlca.sqlcode == 0)
      printf("Table Part created \n");    
  else
      printf("Table Supplier not created\n");
     
/*  drop table account using dynamic SQL method 1	*/
    
  exec sql execute immediate "drop table Part";
  if (sqlca.sqlcode == 0)
      printf("Table Part dropped \n");    
  else
      printf("Table Part not dropped \n");


  exec sql execute immediate :sqlstmt[2];
  if (sqlca.sqlcode == 0)
      printf("Table SP created \n");    
  else
      printf("Table SP not created\n");
     
/*  drop table account using dynamic SQL method 1	*/
    
  exec sql execute immediate "drop table SP";
  if (sqlca.sqlcode == 0)
      printf("Table SP dropped \n");    
  else
      printf("Table SP dropped \n");   

  exec sql commit release;
  exit(0);
}

