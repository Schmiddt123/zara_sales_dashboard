-- ==============================================================
-- DIMENSION TABLES
-- ==============================================================
CREATE TABLE `zara_position` (
  `position_id` int NOT NULL,
  `product_position` text,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
------------------------------------------------------------------------
CREATE TABLE `zara_products` (
  `product_id` int NOT NULL,
  `sku` text,
  `name` text,
  `description` text,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-----------------------------------------------------------------------
CREATE TABLE `zara_section` (
  `section_id` int NOT NULL,
  `section` text,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-----------------------------------------------------------------------
CREATE TABLE `zara_terms` (
  `terms_id` int NOT NULL,
  `terms` text,
  PRIMARY KEY (`terms_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- ==============================================================
-- FACT TABLE
-- ==============================================================
CREATE TABLE `zara_fact` (
  `fact_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `product_position` text,
  `promotion` text,
  `product_category` text,
  `seasonal` text,
  `sales_volume` int DEFAULT NULL,
  `sku` text,
  `name` text,
  `description` text,
  `price` double DEFAULT NULL,
  `currency` text,
  `scraped_at` text,
  `terms` text,
  `section` text,
  `position_id` int DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  `terms_id` int DEFAULT NULL,
  PRIMARY KEY (`fact_id`),
  KEY `fk_fact_position` (`position_id`),
  KEY `fk_fact_section` (`section_id`),
  KEY `fk_zara_fact` (`terms_id`),
  CONSTRAINT `fk_fact_position` FOREIGN KEY (`position_id`) REFERENCES `zara_position` (`position_id`),
  CONSTRAINT `fk_fact_section` FOREIGN KEY (`section_id`) REFERENCES `zara_section` (`section_id`),
  CONSTRAINT `fk_zara_fact` FOREIGN KEY (`terms_id`) REFERENCES `zara_terms` (`terms_id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


