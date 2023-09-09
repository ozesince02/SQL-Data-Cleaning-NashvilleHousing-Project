/*
Data Cleaning in SQL Queries
*/


Select *
From PortfolioProject.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

Select SaleDateConverted, CONVERT(Date,SaleDate)
From PortfolioProject.dbo.NashvilleHousing


--Update NashvilleHousing
--SET SaleDate = CONVERT(Date,SaleDate)


ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From PortfolioProject.dbo.NashvilleHousing
--Where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
Join PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is NULL


Update a
SET PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
Join PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is NULL

--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From PortfolioProject.dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID


Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as Address
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertyStreetAddress nvarchar(255);

Update NashvilleHousing
SET PropertyStreetAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)


ALTER TABLE NashvilleHousing
Add PropertyCity nvarchar(255);

Update NashvilleHousing
SET PropertyCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))


--Alter Table NashvilleHousing
--DROP Column Address,City

Select *
From PortfolioProject.dbo.NashvilleHousing
where OwnerAddress is not null



Select OwnerAddress
From PortfolioProject.dbo.NashvilleHousing


Select
PARSENAME(REPLACE(OwnerAddress, ',','.'),3),
PARSENAME(REPLACE(OwnerAddress, ',','.'),2),
PARSENAME(REPLACE(OwnerAddress, ',','.'),1)
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerStreetAddress nvarchar(255);

Update NashvilleHousing
SET OwnerStreetAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'),3)


ALTER TABLE NashvilleHousing
Add OwnerCity nvarchar(255);

Update NashvilleHousing
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',','.'),2)


ALTER TABLE NashvilleHousing
Add OwnerState nvarchar(255);

Update NashvilleHousing
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',','.'),1)


--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant


Select SoldAsVacant,
	CASE WHEN SoldAsVacant='Y' THEN 'YES'
		 WHEN SoldAsVacant='N' THEN 'NO'
		 ELSE SoldAsVacant END
From NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant=CASE WHEN SoldAsVacant='Y' THEN 'YES'
		 WHEN SoldAsVacant='N' THEN 'NO'
		 ELSE SoldAsVacant END




-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

--Select *
--FROM
--(
--Select *,
--	ROW_NUMBER() OVER(
--	PARTITION BY ParcelID,PropertyAddress,SalePrice,SaleDate,LegalReference ORDER BY UniqueID) row_num
--From PortfolioProject.dbo.NashvilleHousing
--) as A
--Where row_num>1


WITH ROWNUMCTE AS
(
Select *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,PropertyAddress,SalePrice,SaleDate,LegalReference ORDER BY UniqueID) row_num
From PortfolioProject.dbo.NashvilleHousing
--Order By ParcelID
)
SELECT *
--DELETE
FROM ROWNUMCTE
Where row_num>1
--order by PropertyAddress

---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns


Alter table NashvilleHousing
Drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

Select *
From NashvilleHousing

















-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--- Importing Data using OPENROWSET and BULK INSERT	

--  More advanced and looks cooler, but have to configure server appropriately to do correctly
--  Wanted to provide this in case you wanted to try it


--sp_configure 'show advanced options', 1;
--RECONFIGURE;
--GO
--sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;
--GO


--USE PortfolioProject 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 

--GO 


---- Using BULK INSERT

--USE PortfolioProject;
--GO
--BULK INSERT nashvilleHousing FROM 'C:\Temp\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv'
--   WITH (
--      FIELDTERMINATOR = ',',
--      ROWTERMINATOR = '\n'
--);
--GO


---- Using OPENROWSET
--USE PortfolioProject;
--GO
--SELECT * INTO nashvilleHousing
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
--    'Excel 12.0; Database=C:\Users\alexf\OneDrive\Documents\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv', [Sheet1$]);
--GO

















