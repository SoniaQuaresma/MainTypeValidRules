# MainTypeValidRules
Statistical Main Type of Content Validation Rules expressed in SQL

The main type of statistical validation rules were identified and revised by Eurostat, the Task Force on Validation and the ESSnet ValiDat Integration.
These rules initially were meant only for macro data but in fact apply also to micro data.

Although Eurostat is covering the rules implementation using the Validation and Transformation Language VTL in the Portuguese NSI the language used for validation is SQL executed in Oracle databases.
Thus this repository covers the implementation of the afore mentioned rules in SQL.

D5_T6_2.pdf documents which rules were being covered - only to the content of a file and not to its format
D11_T14_2.pdf covers its first implementation by the Portuguese NSI in SQL

CreateTables.sql creates in your database all the tables required for the validation process and that are meant to store the rules, their specific paramaters for the current data being analysed and the validation logs

ProcedureValida.sql provides you the code for executing the validation rules in SQL assuming the tables refered in CreateTables.sql exist.
