# SAP RAP Unmanaged Purchase Order Application

## Overview

This project demonstrates an end-to-end Purchase Order (Header-Item) application built using SAP RAP Unmanaged Implementation. All CRUD operations and database persistence are handled manually through Behavior Handler and Saver classes.

## Objects Used

### Database Tables

* ZSD_POHEADER48
* ZSD_POLINEITEM48

### CDS View Entities

* ZI_SD_POHEADER48
* ZI_SD_POITEM48

### Behavior Classes

* LHC_ZI_SD_POHEADER48
* LHC_ZI_SD_POITEM48

### Saver Class

* LSC_ZI_SD_POHEADER48

## Features

* Create Purchase Order Header
* Create Purchase Order Items using CBA
* Update Header and Item Records
* Delete Header and Item Records
* Read Operations
* Read By Association (Header → Item)
* Deep Insert Support
* OData V2 Service Exposure
* Fiori Elements UI

## RAP Concepts Covered

* Unmanaged RAP
* Behavior Definition & Implementation
* Saver Class
* CRUD Operations
* Internal Buffering
* Read By Association (RBA)
* Create By Association (CBA)
* Composition Relationship
* Transaction Handling

## Save Flow

Create/Update/Delete
        ↓
Behavior Handler
        ↓
Buffer Tables
        ↓
Saver Class
        ↓
Database Tables

## Technologies

* SAP ABAP
* RAP Framework
* CDS View Entities
* OData V2
* SAP Fiori Elements

## Author
S Mohammad Asif
SAP ABAP Developer

