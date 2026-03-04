📌 Project Title
ZVENDOR_UPLOAD – SAP BDC (Call Transaction Method)
📖 Project Description
This project demonstrates Vendor Master creation using BDC Call Transaction Method in SAP ABAP.
The program uploads vendor data from a flat file and creates vendors using transaction XK01.
🎯 Objective
To automate vendor master creation by:
Uploading vendor data from a file
Processing data using BDC
Calling transaction XK01
Displaying success/error messages
🛠️ Technologies Used
SAP ABAP
BDC (Call Transaction Method)
Function Module: GUI_UPLOAD
Internal Tables
Modularization Techniques
📂 Program Structure
🔹 Main Program: ZVENDOR_UPLOAD
Includes:
ZTOP (Global Declarations)
ZPRGMLOGIC (Business Logic)
📑 Input File Format
LIFNR
ANRED
NAME1
SORTL
LAND1
10001
Mr.
ABC Traders
ABC
IN
📌 Screenshot Location:
👉 /screenshots/Input_File_Example.png
🔄 Process Flow
User selects input file
Data uploaded using GUI_UPLOAD
Loop through internal table
BDC data prepared
CALL TRANSACTION 'XK01'
Success/Error message displayed
🖥️ Selection Screen
Parameters:
File Path
Processing Mode (A / E / N)
📸 Screenshot:
👉 /screenshots/Selection_Screen.png
📸 Screenshots to Attach
Upload these inside /screenshots/ folder:
Selection Screen
Input File Format
SHDB Recording of XK01
Successful Vendor Creation
Error Log Output
⚙️ How to Execute
Upload ABAP code into SAP
Execute program ZVENDOR_UPLOAD
Select vendor file
Choose display mode
Execute
📌 Key Concepts Covered
BDC Recording
BDCDATA Structure
BDCMSGCOLL
CALL TRANSACTION
Message Handling
Modular Programming
👨‍💻 Author
Your Name 
