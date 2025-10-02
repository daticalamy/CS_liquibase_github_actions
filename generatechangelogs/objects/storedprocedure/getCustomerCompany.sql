CREATE PROCEDURE dbo.getCustomerCompany
(
    
    @LastName nvarchar(50) = NULL,
    @FirstName nvarchar(50) = NULL
)
AS

BEGIN
    
    
    SET NOCOUNT ON

    
    SELECT FirstName, LastName, CompanyName
       FROM SalesLT.Customer
       WHERE FirstName = @FirstName AND LastName = @LastName;
END;