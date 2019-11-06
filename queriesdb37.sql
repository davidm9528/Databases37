--Nathan Donaghy 40226743
SELECT alt.LeaseID, alt.ApartmentNo, CONCAT(Building.BuildingNameorNum, ' ', Building.Street, ' ', Building.PostCode) AS 'Address',(alt.NumBedrooms-alt.NumTenants) AS 'Number of Free Bedrooms' 
FROM (SELECT Apartment.ApartmentNo,Apartment.NumBedrooms,Apartment.BuildingID,lt.LeaseID,lt.NumTenants 
FROM Apartment 
INNER JOIN (SELECT LeaseTenants.LeaseID,LeaseTenants.TenantID, Lease.ApartmentID, COUNT(*) AS 'NumTenants' 
FROM LeaseTenants 
INNER JOIN Lease ON LeaseTenants.LeaseID = Lease.LeaseID WHERE (SUBDATE(CURRENT_DATE, INTERVAL Lease.Duration MONTH) < Lease.StartDate) GROUP BY LeaseTenants.LeaseID)lt ON lt.ApartmentID = Apartment.ApartmentID)alt 
INNER JOIN Building ON alt.BuildingID = Building.BuildingID WHERE (alt.NumBedrooms - alt.NumTenants >0)

-- David Mackenzie 40238376
-- Find the num of Apartments in the Building with ensuites
SELECT Building.BuildingID AS "Building", Apartment.ApartmentNo AS "Apartment No", Apartment.NumBedrooms AS "Bedrooms", Apartment.NumBathrooms AS "Bathrooms"
FROM Building 
LEFT JOIN Apartment ON Apartment.BuildingID = Building.BuildingID 
WHERE Apartment.NumBedrooms = Apartment.NumBathrooms;
