-- Creating Bank Database 
   CREATE DATABASE BANK;
   
-- Use Bank database
   USE BANK;
  
-- Creating tables for Bank Database

--  1.  Departments Table
     CREATE TABLE Departments(
	-- Unique identifier for Departments table
	   Department_ID INT PRIMARY KEY AUTO_INCREMENT,
	-- Name of the Departments
       Department_Name VARCHAR(50) NOT NULL UNIQUE,
	-- Department Contact number
       Department_phone_number VARCHAR(15) NOT NULL,
	-- Branch Id 
       Branch_ID VARCHAR(10) NOT NULL UNIQUE,
	-- Manager Id 
       Manager_ID VARCHAR (10) NOT NULL
     );
     
     INSERT INTO Departments (Department_Name, Department_phone_number, Branch_ID, Manager_ID)
     VALUES
     ('Customer Service', '1234567890', 'BR001', 'MGR001'),
     ('Loans', '9876543210', 'BR002', 'MGR002'),
     ('Savings Accounts', '1122334455', 'BR003', 'MGR003'),
     ('Checking Accounts', '5566778899', 'BR004', 'MGR004'),
     ('IT Support', '6677889900', 'BR005', 'MGR005'),
     ('HR', '1230984567', 'BR006', 'MGR006'),
     ('Marketing', '2345678901', 'BR007', 'MGR007'),
     ('Compliance', '3456789012', 'BR008', 'MGR008'),
     ('Wealth Management', '4567890123', 'BR009', 'MGR009'),
     ('Audit', '5678901234', 'BR010', 'MGR010');
     
   SELECT * FROM Departments;

-- Using count functions to check how many departments are their with their name.
   SELECT Department_Name , COUNT(*) AS Department_Count
   FROM Departments
   GROUP BY Department_Name;                      -- Group By Clause

-- 2. Employees Table
    CREATE TABLE Employees(
	-- Unique identifier for the employee
       Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    -- Name of the employee
       Employee_Name VARCHAR(50) NOT NULL,
    -- Department of the employee
	   Department_ID INT NOT NULL,
    -- Contact number of the employee
       Contact_Number VARCHAR(20) NOT NULL UNIQUE,
    -- Email address of the employee
       Email VARCHAR(50) NOT NULL UNIQUE,
	-- Adding a foreign key for Department_ID
       FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID)
);

     INSERT INTO Employees (Employee_Name, Department_ID, Contact_Number, Email)
     VALUES
     ('Rahul Kapoor', 1, '9988776655', 'rahul.kapoor@gmail.com'),
     ('Simran Kaur', 2, '8877665544', 'simran.kaur@gmail.com'),
     ('Aarav Sharma', 3, '7766554433', 'aarav.sharma@gmail.com'),
     ('Priya Joshi', 4, '6655443322', 'priya.joshi@gmail.com'),
     ('Kabir Khan', 5, '5544332211', 'kabir.khan@gmail.com'),
	 ('Ananya Verma', 6, '4433221100', 'ananya.verma@gmail.com'),
     ('Vikram Gupta', 7, '3322110099', 'vikram.gupta@gmail.com'),
     ('Sneha Das', 8, '2211009988', 'sneha.das@gmail.com'),
     ('Rohan Malhotra', 9, '1100998877', 'rohan.malhotra@gmail.com'),
     ('Tara Iyer', 10, '0099887766', 'tara.iyer@gmail.com');
   
   SELECT * FROM Employees;
   
-- Getting employees details along with their Departments.

    SELECT E.Employee_Name, E.Contact_Number, E.Email, D.Department_Name   -- Alias
    FROM Employees E
    JOIN Departments D ON E.Department_ID = D.Department_ID          -- Using Joins
	WHERE D.Department_Name = 'Marketing';                          -- Where Clause
    
   -- 3. Employee Salary table
      CREATE TABLE Employee_Salary (
      Salary_ID INT PRIMARY KEY AUTO_INCREMENT,     
      Employee_ID INT NOT NULL,                     
      Base_Salary DECIMAL(15, 2) NOT NULL,          
      Bonus DECIMAL(15, 2) DEFAULT 0.00,            
      Deductions DECIMAL(15, 2) DEFAULT 0.00,       
      Total_Salary DECIMAL(15, 2) NOT NULL,         
      Payment_Date DATE NOT NULL,                   
      FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID) 
);
   
   INSERT INTO Employee_Salary (Employee_ID, Base_Salary, Bonus, Deductions, Total_Salary, Payment_Date)
   VALUES
   (1, 50000.00, 5000.00, 2000.00, 53000.00, '2024-12-18'),
   (2, 45000.00, 4000.00, 1500.00, 47500.00, '2024-12-18'),
   (3, 55000.00, 6000.00, 2500.00, 58500.00, '2024-12-18'),
   (4, 47000.00, 4500.00, 1800.00, 49700.00, '2024-12-18'),
   (5, 52000.00, 5000.00, 2200.00, 54800.00, '2024-12-18'),
   (6, 48000.00, 4000.00, 1700.00, 49700.00, '2024-12-18'),
   (7, 53000.00, 5500.00, 2000.00, 56500.00, '2024-12-18'),
   (8, 50000.00, 5000.00, 3000.00, 52000.00, '2024-12-31'),
   (9, 60000.00, 7000.00, 4000.00, 63000.00, '2024-12-31'),
   (10, 55000.00, 6000.00, 3500.00, 58000.00, '2024-12-31');
   
   SELECT * FROM Employee_Salary;
   
-- Using joins and where clause to find employees with salary ,more than 50000.
  
  SELECT 
    E.Employee_ID, 
    E.Employee_Name, 
    ES.Total_Salary, 
    E.Department_ID
    
   FROM Employees AS E                      -- E as Alias for employees table
   JOIN Employee_Salary AS ES              -- Using joins
   ON E.Employee_ID = ES.Employee_ID 
   WHERE ES.Total_Salary > 50000;         -- where clause
   
   
-- Find employees with a total salary below 55000
   SELECT 
    Employee_ID, 
    Base_Salary, 
    Bonus, 
    Deductions, 
    Total_Salary
    FROM Employee_Salary
    WHERE Total_Salary < 55000;
    
--  Use sum to calculate base salary bounus and dedeuction. 
   SELECT 
    Employee_ID,
    SUM(Base_Salary) AS Total_Base_Salary,               -- Aggregated Function Sum
    SUM(Bonus) AS Total_Bonus,
    SUM(Deductions) AS Total_Deductions,
	SUM(Base_Salary) + SUM(Bonus) - SUM(Deductions) AS Final_Salary
    
    FROM Employee_Salary
    GROUP BY Employee_ID;         -- Group By Clause
    
-- 4. Customers Table
	   CREATE TABLE Customers (
	-- Unique identifier for each customer
       Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
	-- Name of the customer
       Customer_Name VARCHAR(50) NOT NULL,
	-- Email address of the customer
       email VARCHAR(100) NOT NULL UNIQUE,
    -- phone number of the customer
       phone VARCHAR(20) NOT NULL UNIQUE,
    -- Account Number of the customer
       Account_no VARCHAR(50) NOT NULL UNIQUE,
    -- Account_type of the customer
       Account_type VARCHAR(50) NOT NULL,
    -- Status of the customer
       Account_Status VARCHAR(10) NOT NULL CHECK ( Account_Status IN ('Active', 'Inactive', 'Closed')) DEFAULT 'Active'
);

   INSERT INTO Customers (Customer_Name, email, phone, Account_no, Account_type, Account_Status)
   VALUES 
    ('Alia Gupta', 'aliagupta@gmail.com', '1234567890', 'ACC123456789', 'Savings', 'Active'),
    ('Abhisekh Juyal', 'abhijuyal@gmail.com', '9876543210', 'ACC987654321', 'Checking', 'Active'),
    ('Bella Singh', 'bellasingh@gmail.com', '1122334455', 'ACC112233445', 'Savings', 'Inactive'),
    ('Kunal Mehta', 'KunalMehta@gmail.com', '5566778899', 'ACC556677889', 'Checking', 'Closed'),
    ('Dev Verma', 'devverma@gmail.com', '6677889900', 'ACC667788990', 'Savings', 'Active'),
    ('Ishan Patel', 'Ishanpatel@gmail.com', '1230984567', 'ACC123098456', 'Checking', 'Inactive'),
    ('Meera Sharma', 'meerasharma@gmail.com', '2345678901', 'ACC234567890', 'Savings', 'Active'),
    ('Aditi Roy', 'aditiroy@gmail.com', '3456789012', 'ACC345678901', 'Checking', 'Closed'),
    ('Heena Desai', 'heenadesai@gmail.com', '4567890123', 'ACC456789012', 'Savings', 'Active'),
    ('Siddharth Mehta', 'siddharthmehta@gmail.com', '5678901234', 'ACC567890123', 'Checking', 'Inactive');
    
   DESCRIBE Customers;
   SELECT * FROM Customers;
   
-- Using REGEXP to validate the general format of email addresses
   SELECT Customer_Name, email
   FROM Customers
   WHERE (email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$');           -- Regular expresssions
   
-- 5. Accounts Table 
     CREATE TABLE Accounts (
    -- Unique identifier for the account
       Account_ID INT PRIMARY KEY AUTO_INCREMENT,
    -- Type of the account (e.g., Savings, Checking, Loan)
       Account_Type VARCHAR(20) NOT NULL,
    -- Unique identifier of the customer owning the account
      Customer_ID INT NOT NULL,
    -- Balance in the account
       Balance DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    -- Branch where the account is maintained
       Branch_ID VARCHAR(10) NOT NULL,   
    -- Status of the account (e.g., Active, Closed)
       Status VARCHAR(20) NOT NULL DEFAULT 'Active',
	-- Adding a foreign key for Customer_ID
       FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)  ON DELETE CASCADE ON UPDATE CASCADE,
    -- Adding a foreign key for Branch_ID
       FOREIGN KEY (Branch_ID) REFERENCES Departments(Branch_ID)
);
 
	INSERT INTO Accounts (Account_Type, Customer_ID, Balance, Branch_ID, Status)
    VALUES
    ('Savings', 1, 10000.50, 'BR001', 'Active'),
    ('Checking', 2, 5000.00, 'BR002', 'Active'),
    ('Loan', 3, -200000.00, 'BR003', 'Active'),
    ('Savings', 4, 7500.75, 'BR001', 'Closed'),
    ('Checking', 5, 3000.20, 'BR002', 'Active'),
    ('Savings', 6, 25000.00, 'BR003', 'Inactive'),
    ('Loan', 7, -50000.00, 'BR004', 'Active'),
    ('Savings', 8, 12000.00, 'BR001', 'Active'),
    ('Checking', 9, 6000.00, 'BR002', 'Closed'),
    ('Savings', 10, 0.00, 'BR003', 'Active');

  SELECT * FROM Accounts;
  Describe Accounts;
  
  -- To check if any customers account is closed.
     SELECT 
     c.Customer_ID,               -- c. customer here 'c' is alias of Customer table
     c.Customer_Name, 
     a.Account_ID,                -- a.Account here 'a' is alias for Accounts table
     a.Status
     FROM customers AS c
     JOIN accounts AS a               -- Using Joins
     ON c.Customer_ID = a.Customer_ID
     WHERE a.Status = 'Closed';           -- And where clause
  
-- To Find customers with balance greater than 5000 .
   
     SELECT c.Customer_Name, a.Account_Type, a.Balance
     FROM Customers AS c
     JOIN Accounts AS a ON c.Customer_ID = a.Customer_ID
     WHERE a.Balance > 5000;
     
-- To update the account status to 'Inactive' after 3 years.

  ALTER TABLE Accounts 
  ADD COLUMN last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
  
  -- Triggers
  
  DELIMITER //

   CREATE TRIGGER CloseInactiveAccounts
   AFTER UPDATE ON Accounts
   FOR EACH ROW
    BEGIN
    IF NEW.Status = 'Inactive' AND TIMESTAMPDIFF(YEAR, NEW.last_updated, NOW()) > 3 THEN
	UPDATE Accounts
	SET Status = 'Closed'
	  WHERE Account_ID = NEW.Account_ID;
      END IF;
    END ;

// DELIMITER ;

-- Checking trigger
    UPDATE Accounts           -- DML (Update) Commands
    SET Status = 'Inactive'
    WHERE Account_ID = 5;

-- Alter table to add account_number in accounts table
    ALTER TABLE Accounts
    ADD account_no VARCHAR(12) NOT NULL UNIQUE COMMENT 'Bank account number (6-12 digits)';
 
-- Regular Expressions
 -- To ensure an accounts number is following a specific patterns. 
   
   SELECT CASE 
         WHEN account_no REGEXP '^[0-9]{6,12}$' THEN 'Valid' 
         ELSE 'Invalid' 
       END AS validation_result
      FROM Accounts;

     SELECT * FROM Accounts;


 -- 6. Transactions Table
    CREATE TABLE Transactions (
    -- Unique identifier for the transaction
       Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
	-- Customer Id from customer table
        Customer_ID INT ,
    -- Account involved in the transaction
       Account_ID INT NOT NULL,
    -- Type of the transaction (e.g., Deposit, Withdrawal, Transfer)
       Transaction_Type VARCHAR(20) NOT NULL,
    -- Date and time of the transaction
	   Transaction_Date DATETIME,
    -- Amount involved in the transaction
       Amount DECIMAL(15, 2) NOT NULL,
    -- Description of the transaction
       Description VARCHAR(255),
    -- Status of the transaction (e.g., Successful, Pending, Failed)
       Status VARCHAR(20) NOT NULL DEFAULT 'Successful',
	-- Adding a foreign key for Customer_ID
       FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Adding a foreign key for Account_ID
       FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

   INSERT INTO Transactions (Account_ID, Transaction_Type, Transaction_Date, Amount, Description, Status, Customer_ID)
   VALUES
    (1, 'Deposit', '2024-12-18', 5000.00, 'Deposit into savings account', 'Successful', 1),
    (2, 'Withdrawal', '2024-12-18', 2000.00, 'Withdrawal from checking account', 'Successful', 2),
    (3, 'Transfer', '2024-12-18', 15000.00, 'Transfer from loan account to savings', 'Pending', 3),
    (4, 'Deposit', '2024-12-17', 1000.00, 'Deposit into savings account', 'Successful', 4),
    (5, 'Withdrawal', '2024-12-16', 1200.50, 'Withdrawal from checking account', 'Failed', 5),
    (6, 'Transfer', '2024-12-15', 5000.00, 'Transfer from savings to checking', 'Successful', 6),
    (7, 'Deposit', '2024-12-14', 3000.00, 'Deposit into savings account', 'Successful', 7),
    (8, 'Withdrawal', '2024-12-13', 100.00, 'ATM withdrawal from savings account', 'Successful', 8),
    (9, 'Transfer', '2024-12-12', 2000.00, 'Transfer to loan account', 'Successful', 9),
    (10, 'Deposit', '2024-12-11', 500.00, 'Deposit into checking account', 'Pending', 10);
   
   SELECT * FROM Transactions;
   
-- Find customers whose transactions are failed or pending to check the problems.
    SELECT t.Customer_ID, t.status
    FROM Transactions AS t                   -- using alias and where clause
    WHERE t.status IN ('Failed', 'Pending');
    
-- Using Stored procedure a new transaction record into the Transactions table. 
   DELIMITER //

   CREATE PROCEDURE InsertTransaction(
    IN p_Account_ID INT,
    IN p_Transaction_Type VARCHAR(20),
    IN p_Transaction_Date DATETIME,
    IN p_Amount DECIMAL(15, 2),
    IN p_Description VARCHAR(255),
    IN p_Status VARCHAR(20),
    IN p_Customer_ID INT
)
     BEGIN
       INSERT INTO Transactions (Account_ID, Transaction_Type, Transaction_Date, Amount, Description, Status, Customer_ID)
       VALUES (p_Account_ID, p_Transaction_Type, p_Transaction_Date, p_Amount, p_Description, p_Status, p_Customer_ID);
    END ;

// DELIMITER ;

-- To call the procedure:
   CALL InsertTransaction(1, 'Deposit', '2024-12-23', 2000.00, 'Deposit into savings account', 'Successful', 1);

   
-- 7. Branch Table
   CREATE TABLE Branches (
    -- Unique identifier for each branch
    Branch_ID VARCHAR(10) PRIMARY KEY,
    -- Name of the branch
    Branch_Name VARCHAR(50) NOT NULL UNIQUE,
    -- Address of the branch
    Branch_Address VARCHAR(255) NOT NULL,
    -- Contact number of the branch
    Branch_Phone_Number VARCHAR(15) NOT NULL UNIQUE,
    -- Manager of the branch
    Manager_ID INT NOT NULL,
    -- Status of the branch 
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',
    -- Foreign key to link Manager_ID to the Employees table
    FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID)
);

   INSERT INTO Branches (Branch_ID, Branch_Name, Branch_Address, Branch_Phone_Number, Manager_ID, Status)
   VALUES
    ('BR001', 'Downtown Branch', '123 Main St, Cityville', '555-1234567', 1, 'Active'),
    ('BR002', 'Uptown Branch', '456 High St, Townsville', '555-2345678', 2, 'Active'),
    ('BR003', 'Eastside Branch', '789 East Ave, Citytown', '555-3456789', 3, 'Inactive'),
    ('BR004', 'Westside Branch', '101 West Rd, Metropolis', '555-4567890', 4, 'Active'),
    ('BR005', 'Central Branch', '202 Central Blvd, Bigcity', '555-5678901', 5, 'Closed'),
    ('BR006', 'Southside Branch', '303 South Rd, Newtown', '555-6789012', 6, 'Active'),
    ('BR007', 'Northside Branch', '404 North Ave, Smalltown', '555-7890123', 7, 'Active'),
    ('BR008', 'Coastal Branch', '505 Coastal St, Oceanview', '555-8901234', 8, 'Inactive'),
    ('BR009', 'Mountain Branch', '606 Mountain Rd, Hilltop', '555-9012345', 9, 'Active'),
    ('BR010', 'City Centre Branch', '707 City Blvd, Downtown', '555-0123456', 10, 'Closed');
   
   SELECT * FROM Branches;
   
-- 8. Branch transactions Table
      CREATE TABLE Branch_Transactions (
      Branch_Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,   
      Branch_ID VARCHAR(10) NOT NULL,                           
      Transaction_ID INT NOT NULL,                              
      Transaction_Date DATETIME,                                
      Amount DECIMAL(15, 2) NOT NULL,                           
      FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID),   
      FOREIGN KEY (Transaction_ID) REFERENCES Transactions(Transaction_ID) 
);

     INSERT INTO Branch_Transactions (Branch_ID, Transaction_ID, Transaction_Date, Amount)
     VALUES
    ('BR001', 11, '2024-12-18 10:30:00', 5000.00),
    ('BR002', 12, '2024-12-18 11:00:00', 2000.00),
    ('BR003', 13, '2024-12-18 12:00:00', 15000.00),
    ('BR001', 14, '2024-12-17 09:45:00', 1000.00),
    ('BR002', 15, '2024-12-16 14:20:00', 1200.50),
    ('BR003', 16, '2024-12-15 16:30:00', 5000.00),
    ('BR004', 17, '2024-12-14 11:10:00', 3000.00),
    ('BR005', 18, '2024-12-13 13:00:00', 100.00),
    ('BR006', 19, '2024-12-12 15:15:00', 2000.00),
    ('BR007', 20, '2024-12-11 17:25:00', 500.00);
    
    SELECT  * FROM Branch_Transactions;
    SELECT Transaction_ID, Account_ID, Customer_ID
    FROM Transactions;
    
    
-- Using CTE to retrieve the total amount of transactions for each branch
   WITH BranchTransactionTotals AS (
    SELECT
        Branch_ID,
        SUM(Amount) AS Total_Amount
     FROM Branch_Transactions
     GROUP BY Branch_ID
 )
 
SELECT * FROM BranchTransactionTotals;



-- 9. Payments Table for the mode of transactions customer used (credit card, debit card or net banking).
      CREATE TABLE Payments_mode(
   -- Unique identifier for each payment method
      Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
   -- CustomerId from Customer table
	  Customer_ID INT NOT NULL,
   -- Payment Mode
	  Mode VARCHAR(50) NOT NULL,
   -- For credit card and debit card
      CardNumber VARCHAR(16),
   -- Bank Name 
	  BankName VARCHAR(50) NOT NULL,   
   -- Card expiry date
      Expiry_Date DATE,
   -- TransactionId from Transaction Table
      Transaction_ID INT NOT NULL,
   -- Taking Foreign key from Customer Table
      FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID), 
   -- Taking Foreign Key From Transaction Table
      FOREIGN KEY (Transaction_ID) REFERENCES Transactions(Transaction_ID) 
  );
   
   INSERT INTO Payments_mode (Customer_ID, Mode, CardNumber, BankName, Expiry_Date, Transaction_ID)
   VALUES
   (1, 'Credit Card', '1234567812345678', 'Bank A', '2025-12-31', 1),  
   (2, 'Debit Card', '8765432187654321', 'Bank B', '2026-11-30', 2),  
   (3, 'Net Banking', NULL, 'Bank C', NULL, 3),  
   (4, 'Credit Card', '2345678923456789', 'Bank D', '2027-10-15', 4), 
   (5, 'Debit Card', '9876543298765432', 'Bank E', '2026-09-20', 5),  
   (6, 'Net Banking', NULL, 'Bank F', NULL, 6),  
   (7, 'Credit Card', '3456789034567890', 'Bank G', '2028-01-01', 7),  
   (8, 'Debit Card', '7654321076543210', 'Bank H', '2026-06-25', 8),  
   (9, 'Net Banking', NULL, 'Bank I', NULL, 9),  
   (10, 'Credit Card', '4567890145678901', 'Bank J', '2025-05-18', 10); 
     
     SELECT * FROM Payments_mode;
     
-- Making a group of customer according to mode of payments

   SELECT Mode,  COUNT(Customer_ID) AS Number_of_Customers 
   FROM Payments_mode
   WHERE Mode IN ('Credit Card', 'Debit Card', 'Net Banking')
   GROUP BY Mode;
     
-- 10. Card Transactions Table

    CREATE TABLE Card_Transactions (
      Card_Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
      Customer_ID INT NOT NULL,
      CardNumber VARCHAR(16) NOT NULL,
      Transaction_Date DATETIME,
      Amount DECIMAL(15, 2) NOT NULL,
      Transaction_Type VARCHAR(20) NOT NULL, -- e.g., 'Purchase', 'Refund'
      Merchant_Name VARCHAR(100) NOT NULL,
      Status VARCHAR(20) NOT NULL DEFAULT 'Successful',
      FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

     INSERT INTO Card_Transactions (Customer_ID, CardNumber, Transaction_Date, Amount, Transaction_Type, Merchant_Name, Status)
     VALUES
    (1, '1234567812345678', '2024-12-10 15:30:00', 150.00, 'Purchase', 'Amazon', 'Successful'),
    (2, '8765432187654321', '2024-12-11 12:00:00', 200.00, 'Purchase', 'Walmart', 'Successful'),
    (3, '2345678923456789', '2024-12-12 10:45:00', 1000.00, 'Refund', 'Best Buy', 'Pending'),
    (4, '9876543298765432', '2024-12-13 14:20:00', 250.50, 'Purchase', 'Target', 'Successful'),
    (5, '3456789034567890', '2024-12-14 09:00:00', 500.00, 'Purchase', 'Starbucks', 'Failed'),
    (6, '7654321076543210', '2024-12-15 11:30:00', 120.00, 'Purchase', 'Ebay', 'Successful'),
    (7, '1234567812345678', '2024-12-16 16:00:00', 75.50, 'Purchase', 'Nike', 'Successful'),
    (8, '8765432187654321', '2024-12-17 13:45:00', 300.00, 'Refund', 'H&M', 'Successful'),
    (9, '2345678923456789', '2024-12-18 10:00:00', 450.00, 'Purchase', 'Ikea', 'Successful'),
    (10, '9876543298765432', '2024-12-19 17:30:00', 90.00, 'Purchase', 'Sephora', 'Pending');

    SELECT * FROM Card_Transactions;

-- 11. Loans Table
    
    CREATE TABLE Loans (
    Loan_ID INT PRIMARY KEY AUTO_INCREMENT,         
    Customer_ID INT NOT NULL,                       
    Loan_Amount DECIMAL(15, 2) NOT NULL,            
    Interest_Rate DECIMAL(5, 2) NOT NULL,           
    Loan_Term INT NOT NULL,                         
    Loan_Start_Date DATE NOT NULL,                  
    Loan_End_Date DATE NOT NULL,                    
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',   
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) 
);

   INSERT INTO Loans (Customer_ID, Loan_Amount, Interest_Rate, Loan_Term, Loan_Start_Date, Loan_End_Date, Status)
   VALUES
   (1, 50000.00, 7.5, 36, '2024-01-15', '2027-01-15', 'Active'),
   (2, 100000.00, 6.0, 48, '2024-03-20', '2028-03-20', 'Active'),
   (3, 25000.00, 8.0, 24, '2023-06-10', '2025-06-10', 'Closed'),
   (4, 75000.00, 7.0, 60, '2024-05-25', '2029-05-25', 'Active'),
   (5, 120000.00, 6.5, 72, '2024-02-05', '2030-02-05', 'Active'),
   (6, 30000.00, 9.0, 36, '2023-11-30', '2026-11-30', 'Inactive'),
   (7, 80000.00, 7.0, 48, '2024-07-01', '2028-07-01', 'Active'),
   (8, 150000.00, 5.5, 60, '2023-04-15', '2028-04-15', 'Closed'),
   (9, 50000.00, 6.8, 36, '2024-08-10', '2027-08-10', 'Active'),
   (10, 60000.00, 7.2, 48, '2024-09-25', '2028-09-25', 'Active');
   
   SELECT * FROM Loans;
   
-- Createing View to know customer details and loan informations.
  
  CREATE VIEW Active_Loans_View AS     -- View
   SELECT 
    L.Loan_ID,
    C.Customer_ID,
    C.Customer_Name AS Customer_Name, 
    L.Loan_Amount,
    L.Interest_Rate,
    L.Loan_Term,
    L.Loan_Start_Date,
    L.Loan_End_Date,
    L.Status
    FROM Loans L
    JOIN Customers C ON L.Customer_ID = C.Customer_ID
    WHERE L.Status = 'Active';
    
    SELECT * FROM Active_Loans_View ;
   
-- 12. Loans Repayments Table
   -- Creating Loan Repayments Table
      CREATE TABLE Loan_Repayments (
      Repayment_ID INT PRIMARY KEY AUTO_INCREMENT,
      Loan_ID INT NOT NULL,
      Repayment_Date DATE NOT NULL,
      Amount DECIMAL(15, 2) NOT NULL,
      Remaining_Balance DECIMAL(15, 2) NOT NULL,
      FOREIGN KEY (Loan_ID) REFERENCES Loans(Loan_ID)
);

-- Inserting Records
      INSERT INTO Loan_Repayments (Loan_ID, Repayment_Date, Amount, Remaining_Balance)
      VALUES
     (1, '2024-12-18', 1000.00, 49000.00),
     (2, '2024-12-18', 1500.00, 98500.00),
     (3, '2024-12-17', 800.00, 24200.00),
     (4, '2024-12-16', 1200.00, 73800.00),
     (5, '2024-12-15', 2000.00, 118000.00),
     (6, '2024-12-14', 500.00, 29500.00),
     (7, '2024-12-13', 1500.00, 78500.00),
     (8, '2024-12-12', 1000.00, 149000.00),
     (9, '2024-12-11', 800.00, 49200.00),
     (10, '2024-12-10', 1500.00, 58500.00);
     
     SELECT * FROM Loan_Repayments;
     
-- A view to track loan repayment progress with the remaining balance:

   CREATE VIEW Loan_Repayment_Progress AS
   SELECT 
    LR.Repayment_ID,
    LR.Loan_ID,
    L.Customer_ID,
    C.Customer_Name AS Customer_Name,
    LR.Repayment_Date,
    LR.Amount AS Paid_Amount,
    LR.Remaining_Balance
    FROM Loan_Repayments LR
    JOIN Loans L ON LR.Loan_ID = L.Loan_ID
    JOIN Customers C ON L.Customer_ID = C.Customer_ID;

-- Query the view
   SELECT * FROM Loan_Repayment_Progress;
     
   
-- 13. ATM Transactions Table

  -- Creating ATM Transactions Table 
    CREATE TABLE ATM_Transactions (
    ATM_Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    ATM_Location VARCHAR(100) NOT NULL,
    Transaction_Date DATETIME,
    Amount DECIMAL(15, 2) NOT NULL,
    Transaction_Type VARCHAR(20) NOT NULL, -- Deposit or Withdrawal
    Status VARCHAR(20) NOT NULL DEFAULT 'Successful',
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Inserting Records
    INSERT INTO ATM_Transactions (Customer_ID, ATM_Location, Transaction_Date, Amount, Transaction_Type, Status)
    VALUES
    (1, 'Main Street ATM', '2024-12-18 14:00:00', 1000.00, 'Deposit', 'Successful'),
    (2, 'Downtown ATM', '2024-12-18 14:30:00', 500.00, 'Withdrawal', 'Successful'),
    (3, 'Uptown ATM', '2024-12-17 10:45:00', 2000.00, 'Withdrawal', 'Failed'),
    (4, 'South Side ATM', '2024-12-16 13:20:00', 1500.00, 'Deposit', 'Successful'),
    (5, 'West End ATM', '2024-12-15 16:00:00', 2500.00, 'Withdrawal', 'Successful'),
    (6, 'East Side ATM', '2024-12-14 11:10:00', 300.00, 'Withdrawal', 'Failed'),
    (7, 'Central ATM', '2024-12-13 09:50:00', 1200.00, 'Deposit', 'Successful'),
    (8, 'City Square ATM', '2024-12-12 17:30:00', 500.00, 'Withdrawal', 'Successful'),
    (9, 'Main Branch ATM', '2024-12-11 14:10:00', 1800.00, 'Deposit', 'Successful'),
    (10, 'Park Road ATM', '2024-12-10 16:40:00', 2200.00, 'Withdrawal', 'Successful');
   
   SELECT * FROM ATM_Transactions;
   
   
-- 14. Insurance Policies Table

      CREATE TABLE Insurance_Policies (
       Policy_ID INT PRIMARY KEY AUTO_INCREMENT,
       Customer_ID INT NOT NULL,
       Policy_Type VARCHAR(50) NOT NULL,  -- e.g., Health, Life, Property
       Premium DECIMAL(15, 2) NOT NULL,
       Coverage_Amount DECIMAL(15, 2) NOT NULL,
       Policy_Start_Date DATE NOT NULL,
       Policy_End_Date DATE NOT NULL,
       FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Inserting Records
    INSERT INTO Insurance_Policies (Customer_ID, Policy_Type, Premium, Coverage_Amount, Policy_Start_Date, Policy_End_Date)
    VALUES
   (1, 'Life', 2000.00, 100000.00, '2024-01-01', '2027-01-01'),
   (2, 'Health', 1500.00, 50000.00, '2024-02-15', '2025-02-15'),
   (3, 'Health', 1800.00, 60000.00, '2023-08-01', '2024-08-01'),
   (4, 'Life', 2200.00, 150000.00, '2024-03-10', '2027-03-10'),
   (5, 'Property', 3000.00, 200000.00, '2024-04-20', '2027-04-20'),
   (6, 'Life', 2500.00, 120000.00, '2024-05-25', '2027-05-25'),
   (7, 'Health', 1400.00, 55000.00, '2024-06-10', '2025-06-10'),
   (8, 'Life', 2300.00, 170000.00, '2024-07-01', '2027-07-01'),
   (9, 'Property', 2700.00, 250000.00, '2024-08-05', '2027-08-05'),
   (10, 'Health', 1600.00, 70000.00, '2024-09-10', '2025-09-10');
   
   SELECT * FROM Insurance_Policies;
   
   
   -- 15. Creating Table Fixed Deposits
   
   CREATE TABLE FixedDeposits (
    -- Unique identifier for each fixed deposit
    Deposit_ID VARCHAR(10) PRIMARY KEY,
    -- Customer ID to link the deposit to the customer
    Customer_ID INT NOT NULL,
    -- Linked account for the fixed deposit
    Account_ID INT NOT NULL,
    -- Amount of the fixed deposit
    Deposit_Amount DECIMAL(15, 2) NOT NULL,
    -- Annual interest rate for the deposit
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    -- Date when the deposit starts
    Start_Date DATE NOT NULL,
    -- Date when the deposit matures
    Maturity_Date DATE NOT NULL,
    -- Status of the fixed deposit
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',
    -- Foreign key to link Customer_ID to the Customers table
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    -- Foreign key to link Account_ID to the Accounts table
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

-- Sample Data for FixedDeposits
INSERT INTO FixedDeposits (Deposit_ID, Customer_ID, Account_ID, Deposit_Amount, Interest_Rate, Start_Date, Maturity_Date, Status)
VALUES
    ('FD001', 1, 1, 50000.00, 5.50, '2023-01-01', '2026-01-01', 'Active'),
    ('FD002', 2, 2, 75000.00, 6.00, '2023-03-15', '2026-03-15', 'Active'),
    ('FD003', 3, 3, 100000.00, 5.25, '2022-05-20', '2025-05-20', 'Closed'),
    ('FD004', 4, 4, 25000.00, 6.75, '2024-07-01', '2027-07-01', 'Active'),
    ('FD005', 5, 5, 150000.00, 7.00, '2021-09-10', '2024-09-10', 'Matured'),
    ('FD006', 6, 6, 30000.00, 6.50, '2023-12-01', '2026-12-01', 'Active'),
    ('FD007', 7, 7, 45000.00, 5.75, '2022-11-25', '2025-11-25', 'Closed'),
    ('FD008', 8, 8, 80000.00, 6.25, '2023-04-15', '2026-04-15', 'Active'),
    ('FD009', 9, 9, 60000.00, 6.00, '2024-02-20', '2027-02-20', 'Active'),
    ('FD010', 10, 10, 120000.00, 7.50, '2023-06-01', '2026-06-01', 'Active');

  -- Query to view all records in FixedDeposits
   
   SELECT * FROM FixedDeposits;
   
  -- Using rank Window function to rank the fixed deposits by their Deposit Amount within the table. 
     
     SELECT 
     Deposit_ID, 
     Customer_ID, 
     Deposit_Amount, 
     Interest_Rate, 
     Start_Date, 
     Maturity_Date, 
     Status,
     RANK() OVER (ORDER BY Deposit_Amount DESC) AS Deposit_Rank
     FROM FixedDeposits;
  
-- Using windows function list deposits where the Interest_Rate is higher than the average interest rate across all fixed deposits.
   WITH AverageInterestRate AS (
    SELECT AVG(Interest_Rate) AS Avg_Interest_Rate FROM FixedDeposits
)
   SELECT 
    Deposit_ID, 
    Customer_ID, 
    Deposit_Amount, 
    Interest_Rate, 
    Start_Date, 
    Maturity_Date, 
    Status
    FROM FixedDeposits, AverageInterestRate
   WHERE Interest_Rate > Avg_Interest_Rate;
   
-- 16. Creating Table LockerService
    CREATE TABLE LockerServices (
     -- Unique identifier for each locker
     Locker_ID VARCHAR(10) PRIMARY KEY,
    -- Customer using the locker
     Customer_ID INT NOT NULL,
     -- Branch where the locker is located
     Branch_ID VARCHAR(10) NOT NULL,
     -- Size of the locker (e.g., Small, Medium, Large)
     Locker_Size VARCHAR(10) NOT NULL CHECK (Locker_Size IN ('Small', 'Medium', 'Large')),
     -- Annual fee for the locker
     Annual_Fee DECIMAL(10, 2) NOT NULL,
     -- Date when the locker service started
     Start_Date DATE NOT NULL,
     -- Status of the locker service
     Status VARCHAR(20) NOT NULL DEFAULT 'Active',
     -- Foreign key linking Customer_ID to Customers table
     FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
	  -- Foreign key linking Branch_ID to Branches table
     FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);

-- Insert sample records into LockerServices
INSERT INTO LockerServices (Locker_ID, Customer_ID, Branch_ID, Locker_Size, Annual_Fee, Start_Date, Status)
VALUES
    ('LCK001', 1, 'BR001', 'Small', 1500.00, '2023-01-15', 'Active'),
    ('LCK002', 2, 'BR002', 'Medium', 2500.00, '2023-03-20', 'Active'),
    ('LCK003', 3, 'BR003', 'Large', 3500.00, '2022-06-10', 'Inactive'),
    ('LCK004', 4, 'BR004', 'Small', 1500.00, '2024-02-01', 'Active'),
    ('LCK005', 5, 'BR005', 'Medium', 2500.00, '2023-08-05', 'Closed'),
    ('LCK006', 6, 'BR006', 'Large', 3500.00, '2023-11-12', 'Active'),
    ('LCK007', 7, 'BR007', 'Small', 1500.00, '2022-09-18', 'Inactive'),
    ('LCK008', 8, 'BR008', 'Medium', 2500.00, '2023-05-25', 'Active'),
    ('LCK009', 9, 'BR009', 'Large', 3500.00, '2024-01-10', 'Active'),
    ('LCK010', 10, 'BR010', 'Small', 1500.00, '2023-07-14', 'Closed');
    
-- Query to view all records in LockerServices
      SELECT * FROM LockerServices;

-- Adding  Manager Id 
    ALTER TABLE LockerServices
    ADD COLUMN Manager_ID INT,
    ADD FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID) ON DELETE CASCADE ON UPDATE CASCADE;
    

-- Creating user to grant permission to accsess in Locker Service                     -- Dcl Command
   CREATE USER 'manager_1'@'localhost'IDENTIFIED BY' password 123';
   
-- Grant SELECT, INSERT, and UPDATE permissions on LockerServices table to Manager role
   GRANT SELECT, INSERT, UPDATE ON LockerServices TO 'manager_1'@'localhost';

-- Revoke all permissions from any other user (if needed)
   REVOKE INSERT ON LockerServices FROM 'manager_1'@'localhost';

-- TCL comaands are using  for managing the transactional flow in database              -- TCL Command 
   START TRANSACTION;
   
-- Set a savepoint before making changes
   SAVEPOINT before_insert;
   
-- Insert a new locker service record
   INSERT INTO LockerServices (Locker_ID, Customer_ID, Branch_ID, Locker_Size, Annual_Fee, Start_Date, Status, Manager_ID)
   VALUES ('LCK012', 3, 'BR002', 'Large', 3500.00, '2024-12-24', 'Active', 3);
   

-- If something goes wrong to rollback changes
   ROLLBACK TO before_insert;

-- If everything is correct, commit the changes
   COMMIT;
   
   
   
-- 17. Creating Table
     CREATE TABLE Cheques (
     -- Unique identifier for each cheque
      Cheque_ID VARCHAR(15) PRIMARY KEY, 
	 -- Account linked to the cheque
      Account_ID INT NOT NULL,
	 -- Cheque number for identification
      Cheque_Number VARCHAR(20) NOT NULL UNIQUE, 
	 -- Date when the cheque was issued
      Issue_Date DATE NOT NULL, 
	 -- Name of the payee
      Payee_Name VARCHAR(100) NOT NULL, 
	 -- Amount mentioned on the cheque
      Amount DECIMAL(15, 2) NOT NULL, 
	 -- Status of the cheque 
      Status VARCHAR(20) NOT NULL DEFAULT 'Pending',
	 -- Foreign key linking Accounts_ID to Cheques table
      FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

-- Insert sample records
INSERT INTO Cheques (Cheque_ID, Account_ID, Cheque_Number, Issue_Date, Payee_Name, Amount, Status)
VALUES
    ('CHQ001', 1, 'CHK1234567890', '2023-12-15', 'John Doe', 5000.00, 'Cleared'),
    ('CHQ002', 2, 'CHK0987654321', '2023-12-16', 'Jane Smith', 10000.00, 'Bounced'),
    ('CHQ003', 3, 'CHK5678901234', '2023-12-17', 'ACME Corp', 7500.00, 'Pending'),
    ('CHQ004', 4, 'CHK4321098765', '2023-12-18', 'XYZ Pvt Ltd', 2000.00, 'Cleared'),
    ('CHQ005', 5, 'CHK3456789012', '2023-12-19', 'ABC Inc', 12000.00, 'Pending');

   -- Query to view records
   SELECT * FROM Cheques;

   
-- 18. Creating Table Complaints
    CREATE TABLE Complaints (
     -- Unique identifier for each complaint
      Complaint_ID INT PRIMARY KEY AUTO_INCREMENT,
     -- Customer who made the complaint
      Customer_ID INT NOT NULL,
     -- Branch where the complaint was made
      Branch_ID VARCHAR(10) NOT NULL,
     -- Date when the complaint was registered
      Complaint_Date DATETIME NOT NULL,
     -- Type of the complaint
      Complaint_Type VARCHAR(50) NOT NULL,
     -- Detailed description of the complaint
      Complaint_Description TEXT NOT NULL,
     -- Status of the complaint
      Status VARCHAR(20) NOT NULL DEFAULT 'Open',
	 -- Date when the complaint was resolved (nullable)
      Resolution_Date DATETIME,
     -- Foreign key linking Customer_ID to Customers table
      FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
     -- Foreign key linking Branch_ID to Branches table
      FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);

 -- Insert sample records into Complaints
    INSERT INTO Complaints (Customer_ID, Branch_ID, Complaint_Date, Complaint_Type, Complaint_Description, Status, Resolution_Date)
    VALUES
    (1, 'BR001', '2023-12-20 14:30:00', 'Service Issue', 'Long wait time at the counter.', 'Resolved', '2023-12-21 10:00:00'),
    (2, 'BR002', '2023-12-21 09:15:00', 'Transaction Error', 'Incorrect account balance shown.', 'Open', NULL),
    (3, 'BR003', '2023-12-22 11:45:00', 'Staff Behavior', 'Unfriendly behavior from a teller.', 'In Progress', NULL),
    (4, 'BR004', '2023-12-23 08:50:00', 'ATM Issue', 'ATM deducted amount but did not dispense cash.', 'Resolved', '2023-12-24 14:30:00'),
    (5, 'BR005', '2023-12-24 17:20:00', 'Account Issue', 'Difficulty accessing online banking.', 'Open', NULL),
    (6, 'BR006', '2023-12-25 12:10:00', 'Card Problem', 'Credit card declined without reason.', 'Open', NULL),
    (7, 'BR007', '2023-12-26 10:25:00', 'Service Issue', 'Delayed response to loan request.', 'Resolved', '2023-12-27 11:15:00'),
    (8, 'BR008', '2023-12-27 15:40:00', 'Branch Facilities', 'Insufficient seating at the branch.', 'In Progress', NULL),
    (9, 'BR009', '2023-12-28 13:00:00', 'ATM Issue', 'ATM out of order frequently.', 'Open', NULL),
    (10, 'BR010', '2023-12-29 16:45:00', 'Transaction Error', 'Duplicate transaction in account.', 'Resolved', '2023-12-30 10:30:00');

 -- Query to view all records in Complaints
    SELECT * FROM Complaints;
    
-- Creating User defined function for Days To Resolve Complaints.
   DELIMITER //

   CREATE FUNCTION Days_To_Resolve_Complaint (Complaint_ID INT)
     RETURNS INT
     DETERMINISTIC
      BEGIN
      DECLARE days INT;
    
-- Check if the complaint is resolved
      IF EXISTS (SELECT 1 FROM Complaints WHERE Complaint_ID = Complaint_ID AND Status = 'Resolved') THEN
       
-- Calculate the difference between Resolution_Date and Complaint_Date
        SELECT DATEDIFF(Resolution_Date, Complaint_Date) INTO days
        FROM Complaints
        WHERE Complaint_ID = Complaint_ID;
        
        RETURN days;
        ELSE
        RETURN NULL; -- Return NULL if the complaint is not resolved
    END IF;
   END ;

// DELIMITER ;
   
   
-- 19. Creating table Currency Exchange
   
   CREATE TABLE CurrencyExchange (
    -- Unique identifier for each exchange
     Exchange_ID VARCHAR(10) PRIMARY KEY,
	-- Customer performing the exchange
     Customer_ID INT NOT NULL, 
	-- Branch where the exchange occurred
	 Branch_ID VARCHAR(10) NOT NULL,
	-- Date and time of the transaction
     Transaction_Date DATETIME NOT NULL,
	-- Currency being exchanged 
     Currency_From VARCHAR(10) NOT NULL, 
	-- Currency received 
     Currency_To VARCHAR(10) NOT NULL, 
	-- Rate at which the exchange was made
     Exchange_Rate DECIMAL(10, 4) NOT NULL,
    -- Amount being exchanged
     Amount DECIMAL(15, 2) NOT NULL, 
   -- Foreign key linking Customer_ID to Customers table
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    -- Foreign key linking Branch_ID to Branches table
    FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);

-- Insert sample records
INSERT INTO CurrencyExchange (Exchange_ID, Customer_ID, Branch_ID, Transaction_Date, Currency_From, Currency_To, Exchange_Rate, Amount)
VALUES
    ('EXC001', 1, 'BR001', '2023-12-15 10:30:00', 'USD', 'INR', 82.50, 1000.00),
    ('EXC002', 2, 'BR002', '2023-12-16 12:45:00', 'EUR', 'INR', 89.30, 2000.00),
    ('EXC003', 3, 'BR003', '2023-12-17 14:20:00', 'GBP', 'INR', 101.25, 1500.00),
    ('EXC004', 4, 'BR004', '2023-12-18 16:10:00', 'USD', 'JPY', 109.75, 500.00),
    ('EXC005', 5, 'BR005', '2023-12-19 09:50:00', 'CAD', 'INR', 60.10, 800.00);

  -- Query to view records
     SELECT * FROM CurrencyExchange;

-- To calculate the average exchange rate for each currency pair (Currency_From and Currency_To), By using Average Windows Functions.
   SELECT 
    Exchange_ID,
    Customer_ID,
    Branch_ID,
    Transaction_Date,
    Currency_From,
    Currency_To,
    Exchange_Rate,
    Amount,
    AVG(Exchange_Rate) OVER (PARTITION BY Currency_From, Currency_To) AS Avg_Exchange_Rate
    FROM CurrencyExchange;
   
   
-- 20. Creating Customer Feedback Table
   
    CREATE TABLE Customer_Feedback (
     -- Unique identifier for Feedback_ID
      Feedback_ID INT PRIMARY KEY AUTO_INCREMENT,
	 -- Customer who provided the feedback
      Customer_ID INT NOT NULL,
	 -- Date and time when the feedback was given
      Feedback_Date DATETIME NOT NULL,
	 -- Rating provided by the customer
      Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5), 
	 -- Additional textual feedback
      Feedback_Text TEXT,
	 -- Foreign key to link Customer_ID to the Customers table
      FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

    INSERT INTO Customer_Feedback (Customer_ID, Feedback_Date, Rating, Feedback_Text)
    VALUES
   (1, '2024-12-18 15:00:00', 5, 'Excellent service, very satisfied with the assistance I received!'),
   (2, '2024-12-19 10:00:00', 4, 'Good service, but it could be faster.'),
   (3, '2024-12-17 13:30:00', 3, 'Service was okay, but could improve the response time.'),
   (4, '2024-12-16 11:45:00', 5, 'Great experience! Everything went smoothly.'),
   (5, '2024-12-15 12:15:00', 2, 'I had to wait too long for my loan approval.'),
   (6, '2024-12-14 14:20:00', 4, 'Satisfactory, though a few things were confusing.'),
   (7, '2024-12-13 09:10:00', 5, 'Very happy with the overall experience!'),
   (8, '2024-12-12 17:25:00', 4, 'Good, but there were some minor issues with the online portal.'),
   (9, '2024-12-11 16:30:00', 1, 'Very poor customer support. Could not resolve my issue.'),
   (10, '2024-12-10 08:50:00', 5, 'Exceptional customer service, will recommend to others!');
   
   SELECT * FROM Customer_Feedback ;
   
-- A view to summarize customer feedback ratings, including average of every customer.

    CREATE VIEW Feedback_Analysis_View AS 
     SELECT 
     F.Customer_ID,
     C.Customer_Name AS Customer_Name,
     COUNT(F.Feedback_ID) AS Total_Feedbacks,
     AVG(F.Rating) AS Average_Rating

     FROM Customer_Feedback F
     JOIN Customers C ON F.Customer_ID = C.Customer_ID
     GROUP BY F.Customer_ID;

    SELECT * FROM Feedback_Analysis_View;