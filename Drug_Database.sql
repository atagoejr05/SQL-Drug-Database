CREATE DATABASE IF NOT EXISTS drug_database;
USE drug_database;


CREATE TABLE IF NOT EXISTS compounds (
    id INT AUTO_INCREMENT PRIMARY KEY,
    catalog_id VARCHAR(255),
    drug_name VARCHAR(255),
    plate_id VARCHAR(255),
    well VARCHAR(10),
    molecular_weight DECIMAL(10,3),
    clogp DECIMAL(10,3),
    hbd INT,
    hbac INT,
    tpsa DECIMAL(10,3),
    rot_bonds INT,
    cluster_number INT,
    sdf TEXT
);


CREATE TABLE IF NOT EXISTS atoms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    compound_id INT,
    element VARCHAR(10),
    x DECIMAL(10,4),
    y DECIMAL(10,4),
    z DECIMAL(10,4) NULL, -- NULL for 2D data
    FOREIGN KEY (compound_id) REFERENCES compounds(id) ON DELETE CASCADE
);

-- Insert Sample Data into Compounds Table
INSERT INTO compounds (catalog_id, drug_name, plate_id, well, molecular_weight, clogp, hbd, hbac, tpsa, rot_bonds, cluster_number, sdf)
VALUES 
('Z279783288', 'Sample Drug', '1260807-R-074', 'D02', 271.357, 2.683, 2, 3, 64.920, 4, 1, 'SDF_CONTENT_HERE');

-- Get the ID of the inserted compound
SET @compound_id = LAST_INSERT_ID();

-- Insert Atoms Data
INSERT INTO atoms (compound_id, element, x, y, z)
VALUES 
(@compound_id, 'O', 1.6107, -1.4451, 0.0000),
(@compound_id, 'C', 1.6107, -2.2701, 0.0000),
(@compound_id, 'C', 0.8962, -2.6826, 0.0000),
(@compound_id, 'N', 0.1817, -2.2701, 0.0000);

-- View the Compounds Table
SELECT * FROM compounds;

-- View the Atoms Table
SELECT * FROM atoms;

-- Query Compound with Its Atoms
SELECT 
    c.id AS Compound_ID, 
    c.catalog_id, 
    c.drug_name, 
    a.id AS Atom_ID, 
    a.element, sys_config 
    ,a.x, a.y, a.z
FROM compounds c
JOIN atoms a ON c.id = a.compound_id;
SHOW TABLES;