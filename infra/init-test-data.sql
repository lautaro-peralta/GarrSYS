-- ============================================================================
-- THE GARRISON SYSTEM - Test Data Script
-- ============================================================================
-- Este script carga datos de prueba para evaluación académica.
-- Incluye usuarios, productos, zonas, distribuidores, clientes, ventas, etc.
-- Basado en el universo de Peaky Blinders (Birmingham, años 1920)
-- ============================================================================

-- ============================================================================
-- LIMPIAR DATOS EXISTENTES (en orden inverso a dependencias)
-- ============================================================================
TRUNCATE TABLE bribes, sale_details, sales, clandestine_agreements, monthly_reviews, consejos_shelby, strategic_decisions_socios, strategic_decisions, topics, distributors_products, distributors, clients, authorities, partners, admins, role_requests, user_verifications, email_verifications, refresh_tokens, users, persons, products, zones RESTART IDENTITY CASCADE;

-- ============================================================================
-- 1. ZONAS DE BIRMINGHAM
-- ============================================================================
INSERT INTO zones (name, is_headquarters) VALUES
('Small Heath', true),
('Camden Town', false),
('Digbeth', false),
('Sparkbrook', false),
('Bordesley', false);

-- ============================================================================
-- 2. PRODUCTOS (Legales e Ilegales)
-- ============================================================================
INSERT INTO products (description, detail, price, stock, is_illegal) VALUES
-- Productos LEGALES
('Irish Whiskey Premium', 'Whiskey irlandés de alta calidad, destilado en barrica de roble', 45, 150, false),
('Scotch Whisky 12 Years', 'Whisky escocés con 12 años de añejamiento', 65, 80, false),
('English Gin', 'Ginebra tradicional inglesa con botánicos', 35, 200, false),
('Cuban Cigars Box', 'Caja de 25 puros cubanos auténticos', 120, 50, false),
('Virginia Tobacco', 'Tabaco de Virginia para pipa, 500g', 28, 100, false),

-- Productos ILEGALES
('Snow (Cocaine)', 'Polvo blanco de alta pureza, mercancía controlada', 250, 25, true),
('Opium Den Package', 'Paquete para fumadero de opio, incluye pipas y láudano', 180, 15, true),
('Smuggled Firearms', 'Armas de contrabando sin registro oficial', 500, 10, true),
('Racing Fix Package', 'Acuerdo clandestino para arreglar carreras de caballos', 1000, 5, true),
('Protection Racket Contract', 'Contrato de protección mensual para negocios locales', 350, 20, true);

-- ============================================================================
-- 3. INFORMACIÓN PERSONAL (Persons) - DEBE IR ANTES DE USERS
-- ============================================================================
INSERT INTO persons (id, dni, name, email, phone, address) VALUES
-- Admin
('01936e9f-3000-7000-8000-000000000001', '12345678', 'Thomas Michael Shelby', 'thomas.shelby@shelbyltd.co.uk', '+44-121-555-0001', '6 Watery Lane, Small Heath, Birmingham'),

-- Partners
('01936e9f-3000-7000-8000-000000000002', '23456789', 'Arthur Shelby Jr.', 'arthur.shelby@shelbyltd.co.uk', '+44-121-555-0002', '8 Watery Lane, Small Heath, Birmingham'),
('01936e9f-3000-7000-8000-000000000003', '34567890', 'Elizabeth Gray', 'polly.gray@shelbyltd.co.uk', '+44-121-555-0003', '10 Watery Lane, Small Heath, Birmingham'),

-- Distributors
('01936e9f-3000-7000-8000-000000000004', '45678901', 'John Shelby', 'john.shelby@shelbyltd.co.uk', '+44-121-555-0004', '12 Watery Lane, Small Heath, Birmingham'),
('01936e9f-3000-7000-8000-000000000005', '56789012', 'Michael Gray', 'michael.gray@shelbyltd.co.uk', '+44-121-555-0005', '14 Watery Lane, Small Heath, Birmingham'),
('01936e9f-3000-7000-8000-000000000006', '67890123', 'Isaiah Jesus', 'isaiah.jesus@shelbyltd.co.uk', '+44-121-555-0006', 'Charlie Strong Yard, Digbeth, Birmingham'),

-- Clients
('01936e9f-3000-7000-8000-000000000007', '78901234', 'Alfie Solomons', 'alfie@solomonsltd.co.uk', '+44-20-555-0001', 'Camden Bakery, Camden Town, London'),
('01936e9f-3000-7000-8000-000000000008', '89012345', 'Johnny Dogs', 'johnny@example.com', '+44-121-555-0008', '22 Garrison Lane, Birmingham'),
('01936e9f-3000-7000-8000-000000000009', '90123456', 'Aberama Gold', 'aberama@goldltd.com', '+44-161-555-0001', 'Manchester Road, Manchester'),

-- Authorities
('01936e9f-3000-7000-8000-000000000010', '11223344', 'Chief Inspector Campbell', 'campbell@birminghampd.gov.uk', '+44-121-555-9001', 'Birmingham Police HQ'),
('01936e9f-3000-7000-8000-000000000011', '22334455', 'Constable Moss', 'moss@birminghampd.gov.uk', '+44-121-555-9002', 'Small Heath Station');

-- ============================================================================
-- 4. USUARIOS BASE
-- ============================================================================
-- Nota: Passwords están hasheadas con Argon2 (contraseña: "password123")
-- Hash: $argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw

INSERT INTO users (id, username, email, password, roles, is_active, is_verified, email_verified, profile_completeness, last_login_at, created_at, updated_at, person_id) VALUES
-- ADMIN (Thomas Shelby)
('01936e9f-2000-7000-8000-000000000001', 'thomas.shelby', 'thomas.shelby@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"ADMIN"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000001'),

-- PARTNERS (Socios del consejo Shelby)
('01936e9f-2000-7000-8000-000000000002', 'arthur.shelby', 'arthur.shelby@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"PARTNER"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000002'),
('01936e9f-2000-7000-8000-000000000003', 'polly.gray', 'polly.gray@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"PARTNER"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000003'),

-- DISTRIBUTORS (Distribuidores)
('01936e9f-2000-7000-8000-000000000004', 'john.shelby', 'john.shelby@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000004'),
('01936e9f-2000-7000-8000-000000000005', 'michael.gray', 'michael.gray@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000005'),
('01936e9f-2000-7000-8000-000000000006', 'isaiah.jesus', 'isaiah.jesus@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000006'),

-- CLIENTS (Clientes verificados)
('01936e9f-2000-7000-8000-000000000007', 'alfie.solomons', 'alfie@solomonsltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000007'),
('01936e9f-2000-7000-8000-000000000008', 'johnny.dogs', 'johnny@example.com', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000008'),
('01936e9f-2000-7000-8000-000000000009', 'aberama.gold', 'aberama@goldltd.com', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000009'),

-- AUTHORITIES (Autoridades corruptas)
('01936e9f-2000-7000-8000-000000000010', 'insp.campbell', 'campbell@birminghampd.gov.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"AUTHORITY"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000010'),
('01936e9f-2000-7000-8000-000000000011', 'moss.officer', 'moss@birminghampd.gov.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"AUTHORITY"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000011'),

-- USER sin verificar (para pruebas de flujo de verificación)
('01936e9f-2000-7000-8000-000000000012', 'new.user', 'newuser@example.com', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER"}', true, false, false, 25, NULL, NOW(), NOW(), NULL);

-- ============================================================================
-- 5. ADMINS (Entidad Admin separada)
-- ============================================================================
INSERT INTO admins (id, dni, name, email, phone, address, user_id, department) VALUES
('01936e9f-3000-7000-8000-000000000001', '12345678', 'Thomas Michael Shelby', 'thomas.shelby@shelbyltd.co.uk', '+44-121-555-0001', '6 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000001', 'Operations');

-- ============================================================================
-- 6. PARTNERS (Socios)
-- ============================================================================
INSERT INTO partners (id, dni, name, email, phone, address, user_id) VALUES
('01936e9f-3000-7000-8000-000000000002', '23456789', 'Arthur Shelby Jr.', 'arthur.shelby@shelbyltd.co.uk', '+44-121-555-0002', '8 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000002'),
('01936e9f-3000-7000-8000-000000000003', '34567890', 'Elizabeth Gray', 'polly.gray@shelbyltd.co.uk', '+44-121-555-0003', '10 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000003');

-- ============================================================================
-- 7. DISTRIBUTORS (Distribuidores)
-- ============================================================================
INSERT INTO distributors (id, dni, name, email, phone, address, user_id, zone_id) VALUES
('01936e9f-3000-7000-8000-000000000004', '45678901', 'John Shelby', 'john.shelby@shelbyltd.co.uk', '+44-121-555-0004', '12 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000004', 1),
('01936e9f-3000-7000-8000-000000000005', '56789012', 'Michael Gray', 'michael.gray@shelbyltd.co.uk', '+44-121-555-0005', '14 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000005', 2),
('01936e9f-3000-7000-8000-000000000006', '67890123', 'Isaiah Jesus', 'isaiah.jesus@shelbyltd.co.uk', '+44-121-555-0006', 'Charlie Strong Yard, Digbeth, Birmingham', '01936e9f-2000-7000-8000-000000000006', 3);

-- Relación Distributors <-> Products (ManyToMany)
INSERT INTO distributors_products (distributor_id, product_id) VALUES
-- John Shelby (Small Heath) - Productos legales e ilegales
('01936e9f-3000-7000-8000-000000000004', 1),
('01936e9f-3000-7000-8000-000000000004', 2),
('01936e9f-3000-7000-8000-000000000004', 6),
('01936e9f-3000-7000-8000-000000000004', 10),

-- Michael Gray (Camden Town) - Especializado en productos ilegales
('01936e9f-3000-7000-8000-000000000005', 6),
('01936e9f-3000-7000-8000-000000000005', 7),
('01936e9f-3000-7000-8000-000000000005', 8),
('01936e9f-3000-7000-8000-000000000005', 9),

-- Isaiah Jesus (Digbeth) - Productos legales
('01936e9f-3000-7000-8000-000000000006', 3),
('01936e9f-3000-7000-8000-000000000006', 4),
('01936e9f-3000-7000-8000-000000000006', 5);

-- ============================================================================
-- 8. CLIENTS (Clientes)
-- ============================================================================
INSERT INTO clients (id, dni, name, email, phone, address, user_id) VALUES
('01936e9f-3000-7000-8000-000000000007', '78901234', 'Alfie Solomons', 'alfie@solomonsltd.co.uk', '+44-20-555-0001', 'Camden Bakery, Camden Town, London', '01936e9f-2000-7000-8000-000000000007'),
('01936e9f-3000-7000-8000-000000000008', '89012345', 'Johnny Dogs', 'johnny@example.com', '+44-121-555-0008', '22 Garrison Lane, Birmingham', '01936e9f-2000-7000-8000-000000000008'),
('01936e9f-3000-7000-8000-000000000009', '90123456', 'Aberama Gold', 'aberama@goldltd.com', '+44-161-555-0001', 'Manchester Road, Manchester', '01936e9f-2000-7000-8000-000000000009');

-- ============================================================================
-- 9. AUTHORITIES (Autoridades)
-- ============================================================================
INSERT INTO authorities (id, dni, name, email, phone, address, user_id, rank, zone_id) VALUES
('01936e9f-3000-7000-8000-000000000010', '11223344', 'Chief Inspector Campbell', 'campbell@birminghampd.gov.uk', '+44-121-555-9001', 'Birmingham Police HQ', '01936e9f-2000-7000-8000-000000000010', 3, 1),
('01936e9f-3000-7000-8000-000000000011', '22334455', 'Constable Moss', 'moss@birminghampd.gov.uk', '+44-121-555-9002', 'Small Heath Station', '01936e9f-2000-7000-8000-000000000011', 1, 2);

-- ============================================================================
-- 10. VENTAS (Sales)
-- ============================================================================
INSERT INTO sales (description, sale_date, sale_amount, distributor_id, client_id, authority_id) VALUES
-- Venta 1: Whiskey a Alfie Solomons (con "protección" de Campbell)
('Envío de whiskey premium a Camden', '2025-01-10 14:30:00', 455, '01936e9f-3000-7000-8000-000000000004', '01936e9f-3000-7000-8000-000000000007', '01936e9f-3000-7000-8000-000000000010'),

-- Venta 2: Productos ilegales a Aberama Gold
('Mercancía especial para Manchester', '2025-01-12 18:45:00', 1500, '01936e9f-3000-7000-8000-000000000005', '01936e9f-3000-7000-8000-000000000009', NULL),

-- Venta 3: Tabaco a Johnny Dogs
('Suministro mensual de tabaco', '2025-01-15 10:00:00', 280, '01936e9f-3000-7000-8000-000000000006', '01936e9f-3000-7000-8000-000000000008', '01936e9f-3000-7000-8000-000000000011'),

-- Venta 4: Arreglo de carreras
('Contrato especial - Derby', '2025-01-18 20:00:00', 2000, '01936e9f-3000-7000-8000-000000000005', '01936e9f-3000-7000-8000-000000000007', NULL);

-- ============================================================================
-- 11. DETALLES DE VENTAS (Sale Details)
-- ============================================================================
INSERT INTO sale_details (quantity, subtotal, sale_id, product_id) VALUES
-- Detalles de Venta 1
(5, 225.00, 1, 1),  -- Irish Whiskey
(3, 195.00, 1, 2),  -- Scotch Whisky
(1, 35.00, 1, 3),   -- English Gin

-- Detalles de Venta 2
(4, 1000.00, 2, 6), -- Cocaine
(1, 500.00, 2, 8),  -- Smuggled Firearms

-- Detalles de Venta 3
(10, 280.00, 3, 5), -- Virginia Tobacco

-- Detalles de Venta 4
(2, 2000.00, 4, 9); -- Racing Fix

-- ============================================================================
-- 12. SOBORNOS (Bribes)
-- ============================================================================
INSERT INTO bribes (amount, paid, creation_date, authority_id, sale_id) VALUES
(500, true, '2025-01-10 13:00:00', '01936e9f-3000-7000-8000-000000000010', 1),
(150, true, '2025-01-15 09:30:00', '01936e9f-3000-7000-8000-000000000011', 3),
(750, false, '2025-01-20 22:00:00', '01936e9f-3000-7000-8000-000000000010', 4);

-- ============================================================================
-- FINALIZACIÓN
-- ============================================================================


-- ============================================================================
-- INFORMACIÓN PARA EVALUACIÓN
-- ============================================================================
-- Usuarios de prueba (todos con password: "password123"):
--
-- ADMIN:
--   - username: thomas.shelby | email: thomas.shelby@shelbyltd.co.uk
--
-- PARTNERS:
--   - username: arthur.shelby | email: arthur.shelby@shelbyltd.co.uk
--   - username: polly.gray | email: polly.gray@shelbyltd.co.uk
--
-- DISTRIBUTORS:
--   - username: john.shelby | email: john.shelby@shelbyltd.co.uk
--   - username: michael.gray | email: michael.gray@shelbyltd.co.uk
--   - username: isaiah.jesus | email: isaiah.jesus@shelbyltd.co.uk
--
-- CLIENTS:
--   - username: alfie.solomons | email: alfie@solomonsltd.co.uk
--   - username: johnny.dogs | email: johnny@example.com
--   - username: aberama.gold | email: aberama@goldltd.com
--
-- AUTHORITIES:
--   - username: insp.campbell | email: campbell@birminghampd.gov.uk
--   - username: moss.officer | email: moss@birminghampd.gov.uk
--
-- USER NO VERIFICADO (para probar flujo de verificación):
--   - username: new.user | email: newuser@example.com
-- ============================================================================
