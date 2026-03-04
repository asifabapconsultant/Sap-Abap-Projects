# ZVENDOR_UPLOAD – SAP BDC (Call Transaction Method)

## 📌 Project Overview
ZVENDOR_UPLOAD is an SAP ABAP BDC project developed to automate Vendor Master creation using the Call Transaction Method.

The program uploads vendor data from a flat file and creates vendors using transaction XK01.

---

## 🎯 Objective
- Automate vendor master creation
- Reduce manual data entry
- Enable bulk upload through file
- Capture and display success/error logs

---

## 🛠️ Technologies Used
- SAP ABAP
- BDC (Call Transaction Method)
- Function Module: GUI_UPLOAD
- Function Module: F4_FILENAME
- Internal Tables
- Modularization using Includes

---

## 📂 Program Structure

Main Program: ZVENDOR_UPLOAD

Includes:
- ZTOP        (Global Declarations)
- ZPRGMLOGIC  (Business Logic)

---

## 📑 Input File Format

The input file must contain the following fields:

| LIFNR | ANRED | NAME1        | SORTL | LAND1 |
|-------|-------|--------------|-------|-------|
| 10001 | Mr.   | ABC Traders  | ABC   | IN    |

Field Description:
- LIFNR  → Vendor Number
- ANRED  → Title
- NAME1  → Vendor Name
- SORTL  → Search Term
- LAND1  → Country Key

Place sample file inside:
sample_data/Vendor_Input_File.xlsx

---

## 🔄 Process Flow

1. User selects file from selection screen.
2. Data uploaded using GUI_UPLOAD.
3. Internal table GT_VEND populated.
4. BDCDATA prepared using:
   - BDC_DYNPRO
   - BDC_FIELD
5. CALL TRANSACTION 'XK01'
6. Messages captured in MESSTAB.
7. Success/Error displayed on output screen.

---

## 🖥️ Selection Screen Parameters

- IP_FILE  → File Path
- DISMODE  → Processing Mode (A / E / N)

Modes:
A → Display All Screens
E → Display Errors Only
N → Background Processing

---

## 📸 Screenshots

Add screenshots inside the folder:

screenshots/

Recommended Screenshots:
- Selection_Screen.png
- Input_File_Format.png
- SHDB_Recording_XK01.png
- Successful_Vendor_Creation.png
- Error_Log_Output.png

To display image in README:

```markdown
![Selection Screen](screenshots/Selection_Screen.png)
```

---

## ⚙️ Execution Steps

1. Upload ABAP code in SAP.
2. Execute program ZVENDOR_UPLOAD.
3. Select input file.
4. Choose processing mode.
5. Execute.
6. Review output log.

---

## 📌 Key Concepts Covered

- BDC Recording
- BDCDATA Structure
- BDCMSGCOLL
- CALL TRANSACTION
- File Upload Handling
- Message Handling
- Modular Programming

---

## 👨‍💻 Author

Your Name  
SAP ABAP Developer

---

## 📄 Repository Structure

ZVENDOR_UPLOAD/
│
├── src/
│   ├── ZVENDOR_UPLOAD.abap
│   ├── ZTOP.abap
│   ├── ZPRGMLOGIC.abap
│
├── documentation/
│   ├── Functional_Specification.pdf
│   ├── Technical_Specification.pdf
│
├── screenshots/
│
├── sample_data/
│
└── README.md

---

## 📌 GitHub Description (Short)

SAP ABAP BDC Project – Vendor Master Upload using Call Transaction Method (XK01) with file upload and message handling. 
