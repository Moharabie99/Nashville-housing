-- Corrected spelling
ALTER TABLE NashHousing
ADD OwnerCity NVARCHAR(300);

UPDATE NashHousing
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashHousing
ADD OwnerState NVARCHAR(300);

UPDATE NashHousing
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
-- Corrected update for OwnerState
UPDATE NashHousing
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
-- Include PropertyAddress in the DROP COLUMN statement
ALTER TABLE NashHousing
DROP COLUMN SaleDate, PropertyAddress, OwnerAddress
-- Example of renaming column
EXEC sp_RENAME 'NashHousing.ChangedSaleDate', 'SaleDate', 'COLUMN'
-- Consider using ALTER TABLE...RENAME COLUMN
ALTER TABLE NashHousing
RENAME COLUMN ChangedSaleDate TO SaleDate;
-- Trim spaces in SoldAsVacant
UPDATE NashHousing
SET SoldAsVacant = TRIM(SoldAsVacant)
