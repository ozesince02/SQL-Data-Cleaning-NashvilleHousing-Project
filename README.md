# SQL Data Cleaning Project

### Introduction

This SQL project focuses on data cleaning tasks performed on a dataset named "NashvilleHousing" within a database named "PortfolioProject." The goal is to standardize and improve the quality of the data for analysis and reporting purposes.

The project includes various SQL queries and operations to address data quality issues such as date formatting, missing property addresses, breaking down address fields, standardizing values, and removing duplicates.

### Learning Objectives

The key learning objectives of this project include:

1. SQL Syntax and Functions: Practicing and improving SQL skills by using various SQL functions and syntax to clean and manipulate data.

2. Data Cleaning Techniques: Understanding and applying data cleaning techniques such as date formatting, handling missing values, breaking down address fields, and standardizing data.

3.  Database Operations: Gaining hands-on experience with important database operations like altering tables, adding and dropping columns, and updating records.

4. Data Transformation: Learning how to transform data into a more structured and usable format for analysis.

5. Removing Duplicates: Exploring methods to identify and eliminate duplicate records from a dataset.

6.w Standardization: Standardizing data values to ensure consistency and ease of analysis.

### Project Tasks
1. Standardize Date Format

    A new column named "SaleDateConverted" is added to the "NashvilleHousing" table to store the standardized date format.
    The "SaleDate" column is converted to the appropriate date format and populated in the "SaleDateConverted" column.

2. Populate Missing Property Addresses

    Missing property addresses in the "PropertyAddress" column are identified and filled using data from other records with the same ParcelID.
    The ISNULL function is used to update the missing addresses.

3. Break Address into Individual Columns

    The "PropertyAddress" column is split into separate columns for "PropertyStreetAddress," "PropertyCity," and "PropertyState."
    This allows for more structured data when analyzing addresses.

4. Separate Owner Address Components

    The "OwnerAddress" column is split into separate columns for "OwnerStreetAddress," "OwnerCity," and "OwnerState."
    This separation improves the organization of owner address information.

5. Standardize "Sold as Vacant" Field

    Values in the "SoldAsVacant" column are standardized from 'Y' and 'N' to 'YES' and 'NO' respectively.

6. Remove Duplicate Records

    Duplicate records in the dataset are identified and removed based on specific criteria (ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference).
    The remaining unique records are retained in the "NashvilleHousing" table.

7. Delete Unused Columns

    Columns that are no longer needed in the dataset, such as "OwnerAddress," "TaxDistrict," "PropertyAddress," and "SaleDate," are dropped from the table.

### Conclusion

This project has provided valuable hands-on experience in SQL data cleaning, helping to reinforce SQL skills and deepen the understanding of data manipulation techniques. It serves as a practical example of using SQL to clean and prepare data for analysis, contributing to the overall growth and proficiency in SQL.

### Credits

This project was completed with the invaluable guidance and inspiration from the YouTube tutorial by Alex the Analyst. Alex's expertise in data analysis and SQL played a crucial role in the successful execution of this data cleaning project. I extend my gratitude to Alex for sharing educational content that empowers individuals in the field of data analysis.

Alex the Analyst's YouTube Channel: [Link](https://www.youtube.com/@AlexTheAnalyst)

### Additional Notes
The project includes commented-out code for importing data using OPENROWSET and BULK INSERT. These advanced techniques are provided for reference but require proper server configuration and data source access.

### Usage

The provided SQL queries can be executed in a SQL Server Management Studio or any other SQL database management tool. Ensure you have appropriate permissions to alter tables and execute queries on the database.

Make sure to back up your data before running any data-cleaning operations, especially when removing duplicates, as data loss is irreversible.

Please adapt and modify the SQL queries as needed for your specific dataset and requirements.

Project Owner: Pulkit Choudhary
Contact: khauffsaab@gmail.com

Last Updated: 10th September, 2023
