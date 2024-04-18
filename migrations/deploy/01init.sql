-- Deploy ofact:01init to pg

BEGIN;

CREATE DOMAIN email_type AS TEXT
    CHECK (VALUE ~ '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');

CREATE DOMAIN zip_code_type AS TEXT
    CHECK (VALUE ~ '^\d{5}$');

CREATE TABLE visitor (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "email" email_type NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "zip_code" zip_code_type NOT NULL,
    "city" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE invoice (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "invoice_id" INT UNIQUE,
    "issued_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "paid_at" TIMESTAMPTZ,
    "visitor_id" TEXT,
    CONSTRAINT "fk_invoice_id" FOREIGN KEY ("invoice_id") REFERENCES "invoice" ("id")
);

CREATE TABLE product (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "label" TEXT UNIQUE NOT NULL,
    "price" INT NOT NULL,
    "price_with_taxes" INT NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE invoice_line (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "line_id" INT,
    "quantity" INT NOT NULL,
    "invoice_id" INT NOT NULL,
    "product_id" INT NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ,
    FOREIGN KEY ("invoice_id") REFERENCES "invoice"("id") ON DELETE CASCADE,
    FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE CASCADE
);

TRUNCATE visitor, product, invoice, invoice_line RESTART IDENTITY;

INSERT INTO visitor(email, password, name, address, zip_code, city) VALUES
('numero@bis.eg', '$2b$10$Btz1P5F51OMGfvuuL1wh7.kdwyEYXdzCSGpbLg1BAlx91GvwFGlXm', 'Numérobis', 'Dernière pyramide à gauche', '12345', 'Le Caire'),
('amon@bofis.eg', '$2b$10$XBG4JD2apNQs1S97bXlL/.7jd95ylW6h4ZFnP1dAE10RaqsaSd8De', 'Amonbofis', 'Première pyramide à droite', '54321', 'Le Caire'),
('pano@ramix.ga', '$2b$10$g8NKBH9OrxoUt.2jMJ.V3eyH7lN6EbVk7THcG3bAsUCtd.iKuqtnK', 'Panoramix', 'Grande hutte à la sortie du village', '98765', 'Village des irréductibles');


INSERT INTO product(label, price, price_with_taxes) VALUES 
('Lot de 20 pierres de taille', 2312, 2774.4),
('Esclave', 500, 527.5),
('Petit géranium', 43.2, 51.84),
('Strychnine (1L)', 32, 38.4),
('Arsenic (1L)', 35, 42),
('Bave de sangsue (20CL)', 12.5, 15),
('Scorpion séché', 7, 7.385),
('Branche de gui', 19, 22.8),
('Barquette de fraises', 39.5, 47.4),
('Cèpes (500G)', 48, 50.64);

INSERT INTO invoice(visitor_id, issued_at, paid_at) VALUES
(1, NOW(), null),
(1, NOW()-'1 day 3 hours'::interval, null),
(2, NOW()-'2 days'::interval, NOW()-'1 day'::interval),
(3, NOW()-'3 days 12 hours'::interval, NOW()-'1 day 6 hours'::interval),
(3, NOW()-'2 days'::interval, null),
(3, NOW(), null);

INSERT INTO invoice_line(quantity, invoice_id, product_id) VALUES
(2, 1, 1),
(5, 1, 2),
(10, 2, 3),
(3, 3, 4),
(1, 3, 5),
(5, 3, 6),
(18, 3, 7),
(5, 4, 9),
(3, 5, 8),
(2, 5, 9),
(3, 6, 8),
(4, 6, 10);

COMMIT;