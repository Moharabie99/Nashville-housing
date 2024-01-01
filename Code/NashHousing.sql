-- Data cleaning for Nashcville housing report

-- Standrize date formate for SaleDate

ALTER TABLE nashhousing
ADD ChangedSaleDate Date;

UPDATE NashHousing
SET ChangedSaleDate = CONVERT(DATE, SaleDate)

--Populate PropertyAddress column

UPDATE one
SET PropertyAddress =  isnull (one.PropertyAddress,two.PropertyAddress)
FROM NashHousing one
INNER JOIN NashHousing two
	
	ON one.[UniqueID ] <> two.[UniqueID ]
	AND
	one.ParcelID = two.ParcelID
-- Spliting the PropertyAddress and OwnerAddress coulmns into (Street, City, State) columns

ALTER TABLE NashHousing
ADD PropertySplitAddress NVARCHAR(300);

UPDATE NashHousing
SET PropertySplitAddress = PARSENAME(REPLACE(PropertyAddress,',','.' ),2)

ALTER TABLE NashHousing
ADD PropertyCity NVARCHAR(300);

UPDATE NashHousing
SET PropertyCity = PARSENAME(REPLACE(PropertyAddress,',','.' ),1)

-- Spliting the OwnerAddress column to (Address, City, State) columns

ALTER TABLE NashHousing
ADD OwnnerSplitAddress NVARCHAR(300);

UPDATE NashHousing
SET OwnnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashHousing
ADD OwnnerCity NVARCHAR(300);

UPDATE NashHousing
SET OwnnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashHousing
ADD OwnnerState NVARCHAR(300);

UPDATE NashHousing
SET OwnnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

-- Changing the 'N' and 'Y' in the SoldAsVacant column to 'Yes' and 'No'

UPDATE NashHousing
SET SoldAsVacant = CASE 
	WHEN SoldAsVacant = 'y' THEN 'Yes'
	WHEN SoldAsVacant = 'n' THEN 'No'
	ELSE SoldAsVacant
END

SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant) n
FROM NashHousing
GROUP BY SoldAsVacant
ORDER BY n

-- Removing duplicate columns
WITH NumRowCTE AS (
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY ParcelID,
								PropertyAddress,
								Saleprice,
								SaleDate,
								LegalReference
								ORDER BY
								UniqueID) as row_num
FROM NashHousing
)

select *
FROM NumRowCTE
WHERE row_num > 1
ORDER BY PropertyAddress

-- Deleting unused columns

ALTER TABLE NashHousing
DROP COLUMN SaleDate, PropertyAddress, OwnerAddress

-- Rename some columns for more efficency

EXEC sp_RENAME 'NashHousing.ChangedSaleDate', 'SaleDate', 'COLUMN'
EXEC sp_RENAME 'NashHousing.PropertySplitAddress', 'PropertyAddress', 'COLUMN'
EXEC sp_RENAME 'NashHousing.OwnnerSplitAddress', 'OwnerAddress', 'COLUMN'

SELECT *
FROM NashHousing

