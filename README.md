# Nashville Housing Data Cleaning

## Overview

This project involves cleaning and standardizing the Nashville housing dataset. The dataset contains information about property sales, including dates, addresses, and sale prices. The goal is to prepare the data for further analysis by resolving inconsistencies and improving data integrity.

## Data Cleaning Steps

1. **Standardize SaleDate:**
   - Added `ChangedSaleDate` column to store standardized date format.
   - Updated the `ChangedSaleDate` column with the standardized date format.

2. **Populate PropertyAddress:**
   - Populated missing `PropertyAddress` values by matching records with the same `ParcelID` but different `UniqueID`.

3. **Split Address Columns:**
   - Separated `PropertyAddress` into `PropertySplitAddress` (Street) and `PropertyCity`.
   - Split `OwnerAddress` into `OwnerSplitAddress` (Street), `OwnerCity`, and `OwnerState`.

4. **SoldAsVacant Correction:**
   - Corrected values in the `SoldAsVacant` column by replacing 'Y' with 'Yes' and 'N' with 'No'.

5. **Remove Duplicates:**
   - Identified and removed duplicate records based on specific columns to ensure data consistency.

6. **Delete Unused Columns:**
   - Removed unnecessary columns like `SaleDate`, `PropertyAddress`, and `OwnerAddress`.

7. **Column Renaming:**
   - Renamed columns for better clarity and efficiency.
