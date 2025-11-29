/******************************************************************
  steps.sql
  History of the main steps used to prepare the Zara database
  (based on SQL History from MySQL Workbench)
/


/******************************************************************
  STEP 0. Create project schema
******************************************************************/
-- Create a dedicated schema for the Zara project
CREATE SCHEMA IF NOT EXISTS zara;
USE zara;


/******************************************************************
  STEP 1. CSV import and initial column cleanup
******************************************************************/
-- At this stage, data was imported into:
--   zara_fact, zara_products, zara_position,
--   zara_section, zara_terms
-- using Table Data Import Wizard.
-- Columns originally had raw names (spaces, mixed case, BOM, etc.)

-- Example: renaming columns in fact table after import


ALTER TABLE zara_fact
  CHANGE COLUMN `п»їProduct_id` `Product_id` INT NULL,
  CHANGE COLUMN `Product_id`     `product_id` INT NULL,
  CHANGE COLUMN `Product Position` `Product_Position` TEXT NULL,
  CHANGE COLUMN `Promotion`        `promotion` TEXT NULL,
  CHANGE COLUMN `Product Category` `product Category` TEXT NULL,
  CHANGE COLUMN `Seasonal`         `seasonal` TEXT NULL,
  CHANGE COLUMN `Sales_volume`     `sales_volume` INT NULL;

-- Additional cleanup for column names
ALTER TABLE zara_fact
  CHANGE COLUMN `product_Position`   `product_position` TEXT NULL,
  CHANGE COLUMN `product Category`   `product_category` TEXT NULL;

-- Renaming columns in dimension tables

ALTER TABLE zara_products
  CHANGE COLUMN `п»їProduct_id` `Product_id` INT NULL,
  CHANGE COLUMN `Product_id`    `product_id` INT NULL;

ALTER TABLE zara_position
  CHANGE COLUMN `п»їposition_id` `position_id` INT NULL,
  CHANGE COLUMN `Product_Position` `product_position` TEXT NULL;

ALTER TABLE zara_terms
  CHANGE COLUMN `п»їterms_id` `iterms_id` INT NULL;

ALTER TABLE zara_section
  CHANGE COLUMN `п»їsection_id` `section_id` INT NULL;


/******************************************************************
  STEP 2. Add technical ID fields to fact table
******************************************************************/
-- To normalize the schema, add FK reference columns
ALTER TABLE zara_fact
  ADD COLUMN position_id  INT NULL,
  ADD COLUMN selection_id INT NULL,   -- temporary name; later becomes section_id
  ADD COLUMN terms_id     INT NULL;


/******************************************************************
  STEP 3. Populate position_id via JOIN with zara_position
******************************************************************/
-- Fill position_id based on textual column product_position

UPDATE zara_fact f
JOIN zara_position p
  ON f.product_position = p.product_position
SET f.position_id = p.position_id;


/******************************************************************
  STEP 4. Populate section_id via JOIN with zara_section
******************************************************************/
-- selection_id was originally used and later renamed to section_id
-- (intermediate renaming step omitted; final state documented)

-- Example of rename (if not already applied):
-- ALTER TABLE zara_fact
--   CHANGE COLUMN selection_id section_id INT NULL;

-- Fill section_id based on textual column section

UPDATE zara_fact f
JOIN zara_section s
  ON f.section = s.section
SET f.section_id = s.section_id;


/******************************************************************
  STEP 5. Fix iterms_id -> terms_id and populate terms_id
******************************************************************/
-- Fix incorrect column name in zara_terms

ALTER TABLE zara_terms
  CHANGE COLUMN iterms_id terms_id INT NULL;

-- Fill terms_id based on textual column terms

UPDATE zara_fact f
JOIN zara_terms t
  ON f.terms = t.terms
SET f.terms_id = t.terms_id;


/******************************************************************
  STEP 6. Assign primary keys in dimension tables
******************************************************************/
-- After fixing ID columns, they are used as primary keys

ALTER TABLE zara_position
  CHANGE COLUMN position_id position_id INT NOT NULL,
  CHANGE COLUMN product_position product_position TEXT NULL,
  ADD PRIMARY KEY (position_id);

ALTER TABLE zara_products
  CHANGE COLUMN product_id product_id INT NOT NULL,
  ADD PRIMARY KEY (product_id);

ALTER TABLE zara_section
  CHANGE COLUMN section_id section_id INT NOT NULL,
  ADD PRIMARY KEY (section_id);

ALTER TABLE zara_terms
  CHANGE COLUMN terms_id terms_id INT NOT NULL,
  ADD PRIMARY KEY (terms_id);


/******************************************************************
  STEP 7. Add surrogate key fact_id to fact table
******************************************************************/
-- Add auto-increment surrogate PK for zara_fact

ALTER TABLE zara_fact
  ADD COLUMN fact_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;


/******************************************************************
  STEP 8. Create foreign key relationships
******************************************************************/
-- Link fact table to dimension tables

ALTER TABLE zara_fact
  ADD CONSTRAINT fk_fact_position
    FOREIGN KEY (position_id) REFERENCES zara_position(position_id);

ALTER TABLE zara_fact
  ADD CONSTRAINT fk_fact_section
    FOREIGN KEY (section_id) REFERENCES zara_section(section_id);

ALTER TABLE zara_fact
  ADD CONSTRAINT fk_fact_terms
    FOREIGN KEY (terms_id) REFERENCES zara_terms(terms_id);


/******************************************************************
  STEP 9. Validation join (schema consistency check)
******************************************************************/
-- Validate that all foreign keys correctly map and data aligns

SELECT 
    f.fact_id,
    f.product_id,
    p.sku,
    p.name,
    pos.product_position,
    s.section,
    t.terms,
    f.sales_volume,
    f.price,
    f.currency
FROM zara_fact f
JOIN zara_products  p   ON f.product_id  = p.product_id
JOIN zara_position  pos ON f.position_id = pos.position_id
JOIN zara_section   s   ON f.section_id  = s.section_id
JOIN zara_terms     t   ON f.terms_id    = t.terms_id
LIMIT 20;
