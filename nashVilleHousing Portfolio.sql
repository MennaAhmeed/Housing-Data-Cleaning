select * 
from portfolioproject..NashvilleHousing
---------------------------------------------------------------------------------

--STANDRIZE DATA FORMAT

select SaleDateConverted,CONVERT(Date,saleDate)
from portfolioproject..NashvilleHousing

update NashvilleHousing
set SaleDate=CONVERT(date,SaleDate)

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

 UPDATE NashvilleHousing
   set SaleDateConverted = CONVERT(date,saleDate)
   ----------------------------------------------------------------------------------

   -- populaty property address data

   select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress
   from portfolioproject..NashvilleHousing  a
   join portfolioproject..NashvilleHousing  b
   on a.ParcelID=b.ParcelID
   and a.[UniqueID ]<>b.[UniqueID ]
   where a.PropertyAddress is null


   update a
   set PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
   from portfolioproject..NashvilleHousing  a
   join portfolioproject..NashvilleHousing  b
   on a.ParcelID=b.ParcelID
   and a.[UniqueID ]<>b.[UniqueID ]
   where a.PropertyAddress is null

     select *
   from portfolioproject..NashvilleHousing
   where PropertyAddress is null
   -----------------------------------------------------------------------

   --breaking out address into individual columns (address,city,state)

   select 
   SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1),
   SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1 ,LEN(propertyAddress))

      from portfolioproject..NashvilleHousing
	  -----------------------
	  ALTER TABLE NashvilleHousing
      ADD PropertySplitAddress nvarChar(255);

      UPDATE NashvilleHousing
      set PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1)
	  -----------------
      ALTER TABLE NashvilleHousing
      ADD PropertySplitCity nvarchar(255);

      UPDATE NashvilleHousing
      set PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1 ,LEN(propertyAddress))


	  select *
	  from portfolioproject..NashvilleHousing
	  -------------------------------------------------------------------------------------
	  
	  -- split owner address
	  select OwnerAddress
	  from portfolioproject..NashvilleHousing

	   --select 
	   --SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1),
	   --SUBSTRING(OwnerAddress,CHARINDEX(',',OwnerAddress)-1,LEN(OwnerAddress)),

	   --from portfolioproject..NashvilleHousing

	   select 
	   PARSENAME(REPLACE(OwnerAddress,',','.'),3) as Address,
	   PARSENAME(REPLACE(OwnerAddress,',','.'),2) as City,
	   PARSENAME(REPLACE(OwnerAddress,',','.'),1) as State

	   from portfolioproject..NashvilleHousing

	    ALTER TABLE NashvilleHousing
      ADD OwnerSplitAddress nvarchar(255);

      UPDATE NashvilleHousing
      set OwnerSplitAddress =PARSENAME(REPLACE(OwnerAddress,',','.'),3)
	  ----
	   ALTER TABLE NashvilleHousing
      ADD OwnerSplitCity nvarchar(255);

      UPDATE NashvilleHousing
      set OwnerSplitCity =PARSENAME(REPLACE(OwnerAddress,',','.'),3)
	  -----

	   ALTER TABLE NashvilleHousing
      ADD OwnerSplitState nvarchar(255);

      UPDATE NashvilleHousing
      set OwnerSplitState =PARSENAME(REPLACE(OwnerAddress,',','.'),3)

	  select * from portfolioproject..NashvilleHousing
	  ------------------------------------------------------------------------

	  -- change Y and N to Yes and No in "Sold as Vacant"

	  	 select SoldAsVacant,
		 case when SoldAsVacant ='Y' then 'Yes'
		      when SoldAsVacant='N' then 'No' 
			  Else SoldAsVacant
			  END
		 from portfolioproject..NashvilleHousing

		 update NashvilleHousing
		 set SoldAsVacant=
		 case when SoldAsVacant ='Y' then 'Yes'
		      when SoldAsVacant='N' then 'No' 
			  Else SoldAsVacant
			  END


		 select distinct(SoldAsVacant),COUNT(SoldAsVacant)
		 from portfolioproject..NashvilleHousing
		 group by SoldAsVacant
         -----------------------------------------------------
		 -- REMOVE UNUSED COLUMNS

		 select * from portfolioproject..NashvilleHousing

		 alter table portfolioproject..NashvilleHousing
		 drop column propertyaddress,owneraddress,taxdistrict,saleDate

     	 select * from portfolioproject..NashvilleHousing


		 -------------------------------------------------
	