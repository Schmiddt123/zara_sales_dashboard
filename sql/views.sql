USE zara;

CREATE OR REPLACE VIEW zara_sales_enriched AS
SELECT 
    f.fact_id,
    f.product_id,
    p.sku,
    p.name,
    p.description,
    pos.product_position,
    s.section,
    t.terms,
    f.product_category,
    f.promotion,
    f.seasonal,
    f.sales_volume,
    f.price,
    f.currency,
    f.scraped_at,
    (f.sales_volume * f.price) AS total_revenue
FROM zara_fact f
LEFT JOIN zara_products  p   ON f.product_id  = p.product_id
LEFT JOIN zara_position  pos ON f.position_id = pos.position_id
LEFT JOIN zara_section   s   ON f.section_id  = s.section_id
LEFT JOIN zara_terms     t   ON f.terms_id    = t.terms_id;
