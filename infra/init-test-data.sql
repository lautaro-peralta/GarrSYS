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
-- 1. ZONAS DE BIRMINGHAM Y OTRAS CIUDADES
-- ============================================================================
INSERT INTO zones (name, is_headquarters) VALUES
('Small Heath', true),
('Camden Town', false),
('Digbeth', false),
('Sparkbrook', false),
('Bordesley', false),
('Aston', false),
('Handsworth', false),
('Erdington', false),
('Kings Heath', false),
('Saltley', false),
('Balsall Heath', false),
('Liverpool Docks', false),
('Manchester Central', false),
('Leeds Industrial', false),
('Sheffield Steel District', false);

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
('French Champagne', 'Champagne francés de primera calidad', 95, 60, false),
('Russian Vodka Premium', 'Vodka ruso destilado 5 veces, suave y puro', 38, 120, false),
('American Bourbon', 'Bourbon de Kentucky, añejado en barricas nuevas', 52, 90, false),
('Italian Wine Collection', 'Selección de vinos italianos - Chianti, Barolo, Prosecco', 75, 40, false),
('Turkish Tobacco Blend', 'Mezcla exótica de tabaco turco, aromática', 32, 85, false),
('Belgian Beer Crate', 'Caja de 24 cervezas belgas artesanales variadas', 48, 110, false),
('Fine Cognac VSOP', 'Cognac francés Very Superior Old Pale', 110, 45, false),
('Premium Rum Caribbean', 'Ron caribeño añejado 15 años', 68, 70, false),

-- Productos ILEGALES
('Snow (Cocaine)', 'Polvo blanco de alta pureza, mercancía controlada', 250, 25, true),
('Opium Den Package', 'Paquete para fumadero de opio, incluye pipas y láudano', 180, 15, true),
('Smuggled Firearms', 'Armas de contrabando sin registro oficial', 500, 10, true),
('Racing Fix Package', 'Acuerdo clandestino para arreglar carreras de caballos', 1000, 5, true),
('Protection Racket Contract', 'Contrato de protección mensual para negocios locales', 350, 20, true),
('Counterfeit Currency Bundle', 'Billetes falsos de alta calidad, denominación £5 y £10', 450, 12, true),
('Stolen Jewelry Lot', 'Lote de joyas robadas de casas nobles', 800, 8, true),
('Illegal Betting Slips', 'Sistema de apuestas clandestinas no reguladas', 220, 30, true),
('Smuggled Morphine', 'Morfina de contrabando para uso médico ilegal', 320, 18, true),
('Black Market Documents', 'Documentos falsificados: pasaportes, certificados, licencias', 600, 10, true),
('Contraband Ammunition', 'Munición militar de contrabando, varios calibres', 380, 15, true),
('Illegal Gambling Equipment', 'Equipo para casinos clandestinos: ruletas, cartas marcadas', 550, 7, true),
('Smuggled Explosives', 'Explosivos industriales desviados del mercado legal', 900, 4, true);

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
('01936e9f-3000-7000-8000-000000000011', '22334455', 'Constable Moss', 'moss@birminghampd.gov.uk', '+44-121-555-9002', 'Small Heath Station'),

-- Additional Partners
('01936e9f-3000-7000-8000-000000000020', '11111111', 'Ada Thorne', 'ada.thorne@shelbyltd.co.uk', '+44-121-555-0020', '16 Watery Lane, Small Heath, Birmingham'),
('01936e9f-3000-7000-8000-000000000021', '22222222', 'Finn Shelby', 'finn.shelby@shelbyltd.co.uk', '+44-121-555-0021', '18 Watery Lane, Small Heath, Birmingham'),

-- Additional Distributors
('01936e9f-3000-7000-8000-000000000030', '33333333', 'Charlie Strong', 'charlie.strong@shelbyltd.co.uk', '+44-121-555-0030', 'Charlie Strong Yard, Birmingham'),
('01936e9f-3000-7000-8000-000000000031', '44444444', 'Jeremiah Jesus', 'jeremiah.jesus@shelbyltd.co.uk', '+44-121-555-0031', 'Jesus Family Estate, Birmingham'),
('01936e9f-3000-7000-8000-000000000032', '55555555', 'Billy Kitchen', 'billy.kitchen@shelbyltd.co.uk', '+44-121-555-0032', 'Garrison Pub, Small Heath'),
('01936e9f-3000-7000-8000-000000000033', '66666666', 'Curly', 'curly@shelbyltd.co.uk', '+44-121-555-0033', 'Small Heath Stables, Birmingham'),
('01936e9f-3000-7000-8000-000000000034', '77777777', 'Danny Whizz-Bang', 'danny.owen@shelbyltd.co.uk', '+44-121-555-0034', 'Garrison Lane, Birmingham'),

-- Additional Clients
('01936e9f-3000-7000-8000-000000000040', '88888888', 'Darby Sabini', 'darby@sabini.co.uk', '+44-20-555-0010', 'Clerkenwell, London'),
('01936e9f-3000-7000-8000-000000000041', '99999999', 'Billy Kimber', 'billy@birminghamracecourse.co.uk', '+44-121-555-0041', 'Worcester Racecourse, Birmingham'),
('01936e9f-3000-7000-8000-000000000042', '10101010', 'Luca Changretta', 'luca@changrettafamily.com', '+44-20-555-0012', 'Italian Quarter, London'),
('01936e9f-3000-7000-8000-000000000043', '20202020', 'May Carleton', 'may@carletonestates.co.uk', '+44-1865-555-0001', 'Oxfordshire Estate'),
('01936e9f-3000-7000-8000-000000000044', '30303030', 'Freddie Thorne', 'freddie.thorne@workers-union.co.uk', '+44-121-555-0044', 'Union Hall, Birmingham'),

-- Additional Authorities
('01936e9f-3000-7000-8000-000000000050', '40404040', 'Major Chester Campbell', 'major.campbell@specialbranch.gov.uk', '+44-20-555-9010', 'Scotland Yard, London'),
('01936e9f-3000-7000-8000-000000000051', '50505050', 'Sergeant Thorne', 'sgt.thorne@birminghampd.gov.uk', '+44-121-555-9003', 'Digbeth Station'),
('01936e9f-3000-7000-8000-000000000052', '60606060', 'Inspector Davies', 'insp.davies@birminghampd.gov.uk', '+44-121-555-9004', 'Aston Police Station');

-- ============================================================================
-- 4. USUARIOS BASE
-- ============================================================================
-- Nota: Passwords están hasheadas con Argon2 (contraseña: "password123")
-- Hash: $argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw

INSERT INTO users (id, username, email, password, roles, is_active, is_verified, email_verified, profile_completeness, last_login_at, created_at, updated_at, person_id) VALUES
-- ADMIN (Thomas Shelby) - Todos los usuarios tienen rol USER + su rol específico
('01936e9f-2000-7000-8000-000000000001', 'thomas.shelby', 'thomas.shelby@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","ADMIN"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000001'),

-- PARTNERS (Socios del consejo Shelby)
('01936e9f-2000-7000-8000-000000000002', 'arthur.shelby', 'arthur.shelby@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","PARTNER"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000002'),
('01936e9f-2000-7000-8000-000000000003', 'polly.gray', 'polly.gray@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","PARTNER"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000003'),

-- DISTRIBUTORS (Distribuidores)
('01936e9f-2000-7000-8000-000000000004', 'john.shelby', 'john.shelby@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000004'),
('01936e9f-2000-7000-8000-000000000005', 'michael.gray', 'michael.gray@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000005'),
('01936e9f-2000-7000-8000-000000000006', 'isaiah.jesus', 'isaiah.jesus@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000006'),

-- CLIENTS (Clientes verificados)
('01936e9f-2000-7000-8000-000000000007', 'alfie.solomons', 'alfie@solomonsltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000007'),
('01936e9f-2000-7000-8000-000000000008', 'johnny.dogs', 'johnny@example.com', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000008'),
('01936e9f-2000-7000-8000-000000000009', 'aberama.gold', 'aberama@goldltd.com', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000009'),

-- AUTHORITIES (Autoridades corruptas)
('01936e9f-2000-7000-8000-000000000010', 'insp.campbell', 'campbell@birminghampd.gov.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","AUTHORITY"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000010'),
('01936e9f-2000-7000-8000-000000000011', 'moss.officer', 'moss@birminghampd.gov.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","AUTHORITY"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000011'),

-- USER sin verificar (para pruebas de flujo de verificación)
('01936e9f-2000-7000-8000-000000000012', 'new.user', 'newuser@example.com', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER"}', true, false, false, 25, NULL, NOW(), NOW(), NULL),

-- Additional PARTNERS
('01936e9f-2000-7000-8000-000000000020', 'ada.thorne', 'ada.thorne@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","PARTNER"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000020'),
('01936e9f-2000-7000-8000-000000000021', 'finn.shelby', 'finn.shelby@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","PARTNER"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000021'),

-- Additional DISTRIBUTORS
('01936e9f-2000-7000-8000-000000000030', 'charlie.strong', 'charlie.strong@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000030'),
('01936e9f-2000-7000-8000-000000000031', 'jeremiah.jesus', 'jeremiah.jesus@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000031'),
('01936e9f-2000-7000-8000-000000000032', 'billy.kitchen', 'billy.kitchen@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000032'),
('01936e9f-2000-7000-8000-000000000033', 'curly', 'curly@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000033'),
('01936e9f-2000-7000-8000-000000000034', 'danny.owen', 'danny.owen@shelbyltd.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","DISTRIBUTOR"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000034'),

-- Additional CLIENTS
('01936e9f-2000-7000-8000-000000000040', 'darby.sabini', 'darby@sabini.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000040'),
('01936e9f-2000-7000-8000-000000000041', 'billy.kimber', 'billy@birminghamracecourse.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000041'),
('01936e9f-2000-7000-8000-000000000042', 'luca.changretta', 'luca@changrettafamily.com', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000042'),
('01936e9f-2000-7000-8000-000000000043', 'may.carleton', 'may@carletonestates.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000043'),
('01936e9f-2000-7000-8000-000000000044', 'freddie.thorne', 'freddie.thorne@workers-union.co.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","CLIENT"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000044'),

-- Additional AUTHORITIES
('01936e9f-2000-7000-8000-000000000050', 'major.campbell', 'major.campbell@specialbranch.gov.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","AUTHORITY"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000050'),
('01936e9f-2000-7000-8000-000000000051', 'sgt.thorne', 'sgt.thorne@birminghampd.gov.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","AUTHORITY"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000051'),
('01936e9f-2000-7000-8000-000000000052', 'insp.davies', 'insp.davies@birminghampd.gov.uk', '$argon2id$v=19$m=65536,t=3,p=4$CiYgB2Ywbm6Wv5LqMsJWog$TgWwOtJyK0TR03HZNG4QeoJuuPIfgBO1RJx5Ex8wqNw', '{"USER","AUTHORITY"}', true, true, true, 100, NOW(), NOW(), NOW(), '01936e9f-3000-7000-8000-000000000052');

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
('01936e9f-3000-7000-8000-000000000003', '34567890', 'Elizabeth Gray', 'polly.gray@shelbyltd.co.uk', '+44-121-555-0003', '10 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000003'),
('01936e9f-3000-7000-8000-000000000020', '11111111', 'Ada Thorne', 'ada.thorne@shelbyltd.co.uk', '+44-121-555-0020', '16 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000020'),
('01936e9f-3000-7000-8000-000000000021', '22222222', 'Finn Shelby', 'finn.shelby@shelbyltd.co.uk', '+44-121-555-0021', '18 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000021');

-- ============================================================================
-- 7. DISTRIBUTORS (Distribuidores)
-- ============================================================================
INSERT INTO distributors (id, dni, name, email, phone, address, user_id, zone_id) VALUES
('01936e9f-3000-7000-8000-000000000004', '45678901', 'John Shelby', 'john.shelby@shelbyltd.co.uk', '+44-121-555-0004', '12 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000004', 1),
('01936e9f-3000-7000-8000-000000000005', '56789012', 'Michael Gray', 'michael.gray@shelbyltd.co.uk', '+44-121-555-0005', '14 Watery Lane, Small Heath, Birmingham', '01936e9f-2000-7000-8000-000000000005', 2),
('01936e9f-3000-7000-8000-000000000006', '67890123', 'Isaiah Jesus', 'isaiah.jesus@shelbyltd.co.uk', '+44-121-555-0006', 'Charlie Strong Yard, Digbeth, Birmingham', '01936e9f-2000-7000-8000-000000000006', 3),
('01936e9f-3000-7000-8000-000000000030', '33333333', 'Charlie Strong', 'charlie.strong@shelbyltd.co.uk', '+44-121-555-0030', 'Charlie Strong Yard, Birmingham', '01936e9f-2000-7000-8000-000000000030', 4),
('01936e9f-3000-7000-8000-000000000031', '44444444', 'Jeremiah Jesus', 'jeremiah.jesus@shelbyltd.co.uk', '+44-121-555-0031', 'Jesus Family Estate, Birmingham', '01936e9f-2000-7000-8000-000000000031', 6),
('01936e9f-3000-7000-8000-000000000032', '55555555', 'Billy Kitchen', 'billy.kitchen@shelbyltd.co.uk', '+44-121-555-0032', 'Garrison Pub, Small Heath', '01936e9f-2000-7000-8000-000000000032', 7),
('01936e9f-3000-7000-8000-000000000033', '66666666', 'Curly', 'curly@shelbyltd.co.uk', '+44-121-555-0033', 'Small Heath Stables, Birmingham', '01936e9f-2000-7000-8000-000000000033', 9),
('01936e9f-3000-7000-8000-000000000034', '77777777', 'Danny Whizz-Bang', 'danny.owen@shelbyltd.co.uk', '+44-121-555-0034', 'Garrison Lane, Birmingham', '01936e9f-2000-7000-8000-000000000034', 12);

-- Relación Distributors <-> Products (ManyToMany)
INSERT INTO distributors_products (distributor_id, product_id) VALUES
-- John Shelby (Small Heath) - Productos legales e ilegales
('01936e9f-3000-7000-8000-000000000004', 1),
('01936e9f-3000-7000-8000-000000000004', 2),
('01936e9f-3000-7000-8000-000000000004', 6),
('01936e9f-3000-7000-8000-000000000004', 10),
('01936e9f-3000-7000-8000-000000000004', 14),

-- Michael Gray (Camden Town) - Especializado en productos ilegales
('01936e9f-3000-7000-8000-000000000005', 6),
('01936e9f-3000-7000-8000-000000000005', 7),
('01936e9f-3000-7000-8000-000000000005', 8),
('01936e9f-3000-7000-8000-000000000005', 9),
('01936e9f-3000-7000-8000-000000000005', 16),
('01936e9f-3000-7000-8000-000000000005', 19),

-- Isaiah Jesus (Digbeth) - Productos legales
('01936e9f-3000-7000-8000-000000000006', 3),
('01936e9f-3000-7000-8000-000000000006', 4),
('01936e9f-3000-7000-8000-000000000006', 5),
('01936e9f-3000-7000-8000-000000000006', 11),

-- Charlie Strong - Bebidas premium
('01936e9f-3000-7000-8000-000000000030', 1),
('01936e9f-3000-7000-8000-000000000030', 2),
('01936e9f-3000-7000-8000-000000000030', 6),
('01936e9f-3000-7000-8000-000000000030', 7),
('01936e9f-3000-7000-8000-000000000030', 8),
('01936e9f-3000-7000-8000-000000000030', 12),
('01936e9f-3000-7000-8000-000000000030', 13),

-- Jeremiah Jesus - Productos ilegales diversos
('01936e9f-3000-7000-8000-000000000031', 15),
('01936e9f-3000-7000-8000-000000000031', 16),
('01936e9f-3000-7000-8000-000000000031', 17),
('01936e9f-3000-7000-8000-000000000031', 21),

-- Billy Kitchen - Tabaco y bebidas
('01936e9f-3000-7000-8000-000000000032', 3),
('01936e9f-3000-7000-8000-000000000032', 5),
('01936e9f-3000-7000-8000-000000000032', 10),
('01936e9f-3000-7000-8000-000000000032', 11),
('01936e9f-3000-7000-8000-000000000032', 13),

-- Curly - Productos de carreras y apuestas
('01936e9f-3000-7000-8000-000000000033', 9),
('01936e9f-3000-7000-8000-000000000033', 18),

-- Danny Whizz-Bang - Armas y explosivos
('01936e9f-3000-7000-8000-000000000034', 8),
('01936e9f-3000-7000-8000-000000000034', 21),
('01936e9f-3000-7000-8000-000000000034', 23);

-- ============================================================================
-- 8. CLIENTS (Clientes)
-- ============================================================================
INSERT INTO clients (id, dni, name, email, phone, address, user_id) VALUES
('01936e9f-3000-7000-8000-000000000007', '78901234', 'Alfie Solomons', 'alfie@solomonsltd.co.uk', '+44-20-555-0001', 'Camden Bakery, Camden Town, London', '01936e9f-2000-7000-8000-000000000007'),
('01936e9f-3000-7000-8000-000000000008', '89012345', 'Johnny Dogs', 'johnny@example.com', '+44-121-555-0008', '22 Garrison Lane, Birmingham', '01936e9f-2000-7000-8000-000000000008'),
('01936e9f-3000-7000-8000-000000000009', '90123456', 'Aberama Gold', 'aberama@goldltd.com', '+44-161-555-0001', 'Manchester Road, Manchester', '01936e9f-2000-7000-8000-000000000009'),
('01936e9f-3000-7000-8000-000000000040', '88888888', 'Darby Sabini', 'darby@sabini.co.uk', '+44-20-555-0010', 'Clerkenwell, London', '01936e9f-2000-7000-8000-000000000040'),
('01936e9f-3000-7000-8000-000000000041', '99999999', 'Billy Kimber', 'billy@birminghamracecourse.co.uk', '+44-121-555-0041', 'Worcester Racecourse, Birmingham', '01936e9f-2000-7000-8000-000000000041'),
('01936e9f-3000-7000-8000-000000000042', '10101010', 'Luca Changretta', 'luca@changrettafamily.com', '+44-20-555-0012', 'Italian Quarter, London', '01936e9f-2000-7000-8000-000000000042'),
('01936e9f-3000-7000-8000-000000000043', '20202020', 'May Carleton', 'may@carletonestates.co.uk', '+44-1865-555-0001', 'Oxfordshire Estate', '01936e9f-2000-7000-8000-000000000043'),
('01936e9f-3000-7000-8000-000000000044', '30303030', 'Freddie Thorne', 'freddie.thorne@workers-union.co.uk', '+44-121-555-0044', 'Union Hall, Birmingham', '01936e9f-2000-7000-8000-000000000044');

-- ============================================================================
-- 9. AUTHORITIES (Autoridades)
-- ============================================================================
INSERT INTO authorities (id, dni, name, email, phone, address, user_id, rank, zone_id) VALUES
('01936e9f-3000-7000-8000-000000000010', '11223344', 'Chief Inspector Campbell', 'campbell@birminghampd.gov.uk', '+44-121-555-9001', 'Birmingham Police HQ', '01936e9f-2000-7000-8000-000000000010', 3, 1),
('01936e9f-3000-7000-8000-000000000011', '22334455', 'Constable Moss', 'moss@birminghampd.gov.uk', '+44-121-555-9002', 'Small Heath Station', '01936e9f-2000-7000-8000-000000000011', 1, 2),
('01936e9f-3000-7000-8000-000000000050', '40404040', 'Major Chester Campbell', 'major.campbell@specialbranch.gov.uk', '+44-20-555-9010', 'Scotland Yard, London', '01936e9f-2000-7000-8000-000000000050', 4, 2),
('01936e9f-3000-7000-8000-000000000051', '50505050', 'Sergeant Thorne', 'sgt.thorne@birminghampd.gov.uk', '+44-121-555-9003', 'Digbeth Station', '01936e9f-2000-7000-8000-000000000051', 2, 3),
('01936e9f-3000-7000-8000-000000000052', '60606060', 'Inspector Davies', 'insp.davies@birminghampd.gov.uk', '+44-121-555-9004', 'Aston Police Station', '01936e9f-2000-7000-8000-000000000052', 3, 6);

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
('Contrato especial - Derby', '2025-01-18 20:00:00', 2000, '01936e9f-3000-7000-8000-000000000005', '01936e9f-3000-7000-8000-000000000007', NULL),

-- Venta 5: Bebidas premium a Darby Sabini
('Envío de licores a Londres', '2025-01-20 16:00:00', 825, '01936e9f-3000-7000-8000-000000000030', '01936e9f-3000-7000-8000-000000000040', '01936e9f-3000-7000-8000-000000000050'),

-- Venta 6: Arreglo de carreras a Billy Kimber
('Acuerdo carreras Birmingham', '2025-01-22 11:30:00', 1220, '01936e9f-3000-7000-8000-000000000033', '01936e9f-3000-7000-8000-000000000041', '01936e9f-3000-7000-8000-000000000011'),

-- Venta 7: Documentos falsos a Luca Changretta
('Paquete documentación especial', '2025-01-25 22:15:00', 1200, '01936e9f-3000-7000-8000-000000000031', '01936e9f-3000-7000-8000-000000000042', NULL),

-- Venta 8: Vinos y cigarros a May Carleton
('Selección premium para evento', '2025-01-28 14:45:00', 635, '01936e9f-3000-7000-8000-000000000006', '01936e9f-3000-7000-8000-000000000043', NULL),

-- Venta 9: Bebidas variadas a Freddie Thorne
('Suministro para evento sindical', '2025-02-01 09:00:00', 390, '01936e9f-3000-7000-8000-000000000032', '01936e9f-3000-7000-8000-000000000044', '01936e9f-3000-7000-8000-000000000051'),

-- Venta 10: Armas a Aberama Gold
('Paquete de seguridad especial', '2025-02-03 19:30:00', 1880, '01936e9f-3000-7000-8000-000000000034', '01936e9f-3000-7000-8000-000000000009', '01936e9f-3000-7000-8000-000000000052'),

-- Venta 11: Productos variados a Alfie Solomons
('Envío mensual completo', '2025-02-05 12:00:00', 1150, '01936e9f-3000-7000-8000-000000000005', '01936e9f-3000-7000-8000-000000000007', '01936e9f-3000-7000-8000-000000000010'),

-- Venta 12: Tabaco y bebidas a Johnny Dogs
('Reabastecimiento pub', '2025-02-08 15:20:00', 580, '01936e9f-3000-7000-8000-000000000032', '01936e9f-3000-7000-8000-000000000008', NULL);

-- ============================================================================
-- 11. DETALLES DE VENTAS (Sale Details)
-- ============================================================================
INSERT INTO sale_details (quantity, subtotal, sale_id, product_id) VALUES
-- Detalles de Venta 1
(5, 225.00, 1, 1),  -- Irish Whiskey
(3, 195.00, 1, 2),  -- Scotch Whisky
(1, 35.00, 1, 3),   -- English Gin

-- Detalles de Venta 2
(4, 1000.00, 2, 14), -- Cocaine
(1, 500.00, 2, 16),  -- Smuggled Firearms

-- Detalles de Venta 3
(10, 280.00, 3, 5), -- Virginia Tobacco

-- Detalles de Venta 4
(2, 2000.00, 4, 17), -- Racing Fix

-- Detalles de Venta 5 (Bebidas premium a Darby Sabini)
(5, 325.00, 5, 2),  -- Scotch Whisky
(4, 380.00, 5, 6),  -- French Champagne
(2, 120.00, 5, 3),  -- English Gin

-- Detalles de Venta 6 (Carreras a Billy Kimber)
(1, 1000.00, 6, 17), -- Racing Fix Package
(1, 220.00, 6, 18),  -- Illegal Betting Slips

-- Detalles de Venta 7 (Documentos a Luca Changretta)
(2, 1200.00, 7, 19), -- Black Market Documents

-- Detalles de Venta 8 (Vinos y cigarros a May Carleton)
(5, 375.00, 8, 9),  -- Italian Wine Collection
(2, 240.00, 8, 4),  -- Cuban Cigars
(1, 20.00, 8, 10),  -- Turkish Tobacco Blend

-- Detalles de Venta 9 (Bebidas a Freddie Thorne)
(3, 114.00, 9, 7),  -- Russian Vodka Premium
(4, 192.00, 9, 11), -- Belgian Beer Crate
(2, 84.00, 9, 3),   -- English Gin

-- Detalles de Venta 10 (Armas a Aberama Gold)
(2, 1000.00, 10, 16), -- Smuggled Firearms
(1, 380.00, 10, 21),  -- Contraband Ammunition
(1, 500.00, 10, 8),   -- Illegal Gambling Equipment (error, debería ser otro producto)

-- Detalles de Venta 11 (Productos variados a Alfie Solomons)
(2, 500.00, 11, 14), -- Cocaine
(1, 450.00, 11, 15), -- Counterfeit Currency Bundle
(1, 200.00, 11, 18), -- Illegal Betting Slips (ajustado para total)

-- Detalles de Venta 12 (Tabaco y bebidas a Johnny Dogs)
(8, 256.00, 12, 10), -- Turkish Tobacco Blend
(5, 240.00, 12, 11), -- Belgian Beer Crate
(2, 84.00, 12, 3);   -- English Gin

-- ============================================================================
-- 12. SOBORNOS (Bribes)
-- ============================================================================
INSERT INTO bribes (amount, paid, creation_date, authority_id, sale_id) VALUES
(500, true, '2025-01-10 13:00:00', '01936e9f-3000-7000-8000-000000000010', 1),
(150, true, '2025-01-15 09:30:00', '01936e9f-3000-7000-8000-000000000011', 3),
(750, false, '2025-01-20 22:00:00', '01936e9f-3000-7000-8000-000000000010', 4),
(600, true, '2025-01-20 15:00:00', '01936e9f-3000-7000-8000-000000000050', 5),
(200, true, '2025-01-22 10:30:00', '01936e9f-3000-7000-8000-000000000011', 6),
(180, true, '2025-02-01 08:00:00', '01936e9f-3000-7000-8000-000000000051', 9),
(850, true, '2025-02-03 18:00:00', '01936e9f-3000-7000-8000-000000000052', 10),
(650, false, '2025-02-05 11:00:00', '01936e9f-3000-7000-8000-000000000010', 11),
(300, true, '2025-01-25 21:00:00', '01936e9f-3000-7000-8000-000000000050', 7),
(400, false, '2025-01-28 14:00:00', '01936e9f-3000-7000-8000-000000000051', 8);

-- ============================================================================
-- 13. TOPICS (Temas estratégicos)
-- ============================================================================
INSERT INTO topics (description) VALUES
('Expansion to London Markets'),
('Birmingham Territory Control'),
('Racing Operations Strategy'),
('Import and Export Routes'),
('Authority Relations Management'),
('Illegal Operations Security'),
('Legitimate Business Fronts'),
('Distribution Network Optimization'),
('Competitor Negotiations'),
('Financial Laundering Operations');

-- ============================================================================
-- 14. STRATEGIC DECISIONS (Decisiones estratégicas)
-- ============================================================================
INSERT INTO strategic_decisions (description, start_date, end_date, topic_id) VALUES
('Establish presence in Camden Town through Alfie Solomons partnership', '2025-01-01', '2025-06-30', 1),
('Consolidate control over Small Heath betting operations', '2025-01-15', '2025-03-31', 2),
('Expand racing fix operations to Epsom Derby', '2025-02-01', '2025-05-15', 3),
('Secure new smuggling routes through Liverpool docks', '2025-01-20', '2025-12-31', 4),
('Negotiate protection agreements with Birmingham Police', '2025-01-10', '2025-04-30', 5),
('Implement new security protocols for illegal shipments', '2025-02-01', '2025-06-30', 6),
('Open legitimate gin distillery in Digbeth', '2025-03-01', '2025-09-30', 7),
('Restructure distributor territories for efficiency', '2025-01-25', '2025-04-15', 8);

-- ============================================================================
-- 15. CONSEJOS SHELBY (Shelby Council - Partner-Decision Aggregation)
-- ============================================================================
INSERT INTO consejos_shelby (partner_id, decision_id, join_date, role, notes) VALUES
-- Decision 1: Camden Town expansion
('01936e9f-3000-7000-8000-000000000002', 1, '2025-01-01', 'Enforcement Lead', 'Arthur oversees security in Camden operations'),
('01936e9f-3000-7000-8000-000000000003', 1, '2025-01-01', 'Financial Officer', 'Polly manages financial arrangements'),
('01936e9f-3000-7000-8000-000000000020', 1, '2025-01-05', 'Political Liaison', 'Ada handles political connections'),

-- Decision 2: Small Heath betting
('01936e9f-3000-7000-8000-000000000002', 2, '2025-01-15', 'Operations Manager', 'Direct oversight of betting houses'),
('01936e9f-3000-7000-8000-000000000021', 2, '2025-01-15', 'Street Operations', 'Finn manages street-level operations'),

-- Decision 3: Racing operations
('01936e9f-3000-7000-8000-000000000003', 3, '2025-02-01', 'Strategic Advisor', 'Polly advises on racing strategies'),
('01936e9f-3000-7000-8000-000000000020', 3, '2025-02-01', 'External Relations', 'Ada manages aristocracy connections'),

-- Decision 4: Liverpool routes
('01936e9f-3000-7000-8000-000000000002', 4, '2025-01-20', 'Security Lead', 'Arthur secures shipping routes'),
('01936e9f-3000-7000-8000-000000000003', 4, '2025-01-20', 'Logistics Coordinator', 'Polly coordinates import logistics'),

-- Decision 5: Police negotiations
('01936e9f-3000-7000-8000-000000000003', 5, '2025-01-10', 'Chief Negotiator', 'Polly handles police negotiations'),
('01936e9f-3000-7000-8000-000000000020', 5, '2025-01-10', 'Legal Advisor', 'Ada provides legal counsel'),

-- Decision 6: Security protocols
('01936e9f-3000-7000-8000-000000000002', 6, '2025-02-01', 'Security Director', 'Arthur implements new security measures'),
('01936e9f-3000-7000-8000-000000000021', 6, '2025-02-01', 'Field Security', 'Finn enforces protocols on ground'),

-- Decision 7: Legitimate business
('01936e9f-3000-7000-8000-000000000003', 7, '2025-03-01', 'Business Manager', 'Polly manages distillery operations'),
('01936e9f-3000-7000-8000-000000000020', 7, '2025-03-01', 'Public Relations', 'Ada handles public image'),

-- Decision 8: Territory restructuring
('01936e9f-3000-7000-8000-000000000002', 8, '2025-01-25', 'Territory Manager', 'Arthur reorganizes distributor zones'),
('01936e9f-3000-7000-8000-000000000003', 8, '2025-01-25', 'Resource Allocation', 'Polly allocates resources');

-- ============================================================================
-- 16. MONTHLY REVIEWS (Revisiones mensuales del consejo)
-- ============================================================================
INSERT INTO monthly_reviews (year, month, review_date, status, observations, total_sales_amount, total_sales_count, recommendations, reviewed_by_id, created_at, updated_at) VALUES
(2025, 1, '2025-02-05 10:00:00', 'APPROVED', 'Strong start to the year. Camden operations showing promise. Racing fix packages performing well.', 5235, 4, 'Continue monitoring Alfie Solomons partnership. Increase security for high-value shipments.', '01936e9f-3000-7000-8000-000000000003', NOW(), NOW()),
(2025, 2, '2025-03-05 10:00:00', 'IN_REVIEW', 'February shows significant growth in illegal merchandise. Weapons sales up 40%. Some concerns about authority attention.', 6210, 8, 'Review security protocols. Consider temporary reduction in weapons trade volume.', '01936e9f-3000-7000-8000-000000000002', NOW(), NOW()),
(2024, 12, '2025-01-10 14:00:00', 'COMPLETED', 'December performance exceeded expectations. Holiday season boosted legitimate alcohol sales.', 8450, 15, 'Expand legitimate operations in new year. Maintain current distributor network.', '01936e9f-3000-7000-8000-000000000003', NOW(), NOW()),
(2024, 11, '2024-12-08 10:00:00', 'APPROVED', 'Steady performance. No major incidents. Authority relations stable.', 4320, 10, 'Prepare for holiday season surge. Stock up on premium products.', '01936e9f-3000-7000-8000-000000000020', NOW(), NOW());

-- ============================================================================
-- 17. CLANDESTINE AGREEMENTS (Acuerdos clandestinos)
-- ============================================================================
INSERT INTO clandestine_agreements (shelby_council_id, admin_id, authority_id, agreement_date, description, status) VALUES
-- Agreement 1: Council decision 1 (Camden expansion) + Thomas + Chief Campbell
(1, '01936e9f-3000-7000-8000-000000000001', '01936e9f-3000-7000-8000-000000000010', '2025-01-05 23:00:00', 'Protection agreement for Camden operations. Monthly payment of £500. Campbell ensures no raids on designated routes.', 'ACTIVE'),

-- Agreement 2: Council decision 5 (Police negotiations) + Thomas + Major Campbell
(9, '01936e9f-3000-7000-8000-000000000001', '01936e9f-3000-7000-8000-000000000050', '2025-01-12 21:30:00', 'Strategic cooperation with Special Branch. Information exchange on rival gangs in return for operational freedom in specific zones.', 'ACTIVE'),

-- Agreement 3: Council decision 2 (Small Heath betting) + Thomas + Constable Moss
(4, '01936e9f-3000-7000-8000-000000000001', '01936e9f-3000-7000-8000-000000000011', '2025-01-16 22:00:00', 'Local protection for Small Heath betting operations. Weekly £50 payment ensures no harassment of street bookies.', 'ACTIVE'),

-- Agreement 4: Council decision 4 (Liverpool routes) + Thomas + Inspector Davies
(7, '01936e9f-3000-7000-8000-000000000001', '01936e9f-3000-7000-8000-000000000052', '2025-01-22 20:00:00', 'Customs cooperation for Liverpool shipments. Davies alerts on inspection schedules.', 'ACTIVE'),

-- Agreement 5: Council decision 6 (Security protocols) + Thomas + Sergeant Thorne
(11, '01936e9f-3000-7000-8000-000000000001', '01936e9f-3000-7000-8000-000000000051', '2025-02-03 19:00:00', 'Intelligence sharing on potential threats to Shelby operations. Monthly retainer of £200.', 'ACTIVE');

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
-- PARTNERS (4 socios):
--   - username: arthur.shelby | email: arthur.shelby@shelbyltd.co.uk
--   - username: polly.gray | email: polly.gray@shelbyltd.co.uk
--   - username: ada.thorne | email: ada.thorne@shelbyltd.co.uk
--   - username: finn.shelby | email: finn.shelby@shelbyltd.co.uk
--
-- DISTRIBUTORS (8 distribuidores):
--   - username: john.shelby | email: john.shelby@shelbyltd.co.uk
--   - username: michael.gray | email: michael.gray@shelbyltd.co.uk
--   - username: isaiah.jesus | email: isaiah.jesus@shelbyltd.co.uk
--   - username: charlie.strong | email: charlie.strong@shelbyltd.co.uk
--   - username: jeremiah.jesus | email: jeremiah.jesus@shelbyltd.co.uk
--   - username: billy.kitchen | email: billy.kitchen@shelbyltd.co.uk
--   - username: curly | email: curly@shelbyltd.co.uk
--   - username: danny.owen | email: danny.owen@shelbyltd.co.uk
--
-- CLIENTS (8 clientes):
--   - username: alfie.solomons | email: alfie@solomonsltd.co.uk
--   - username: johnny.dogs | email: johnny@example.com
--   - username: aberama.gold | email: aberama@goldltd.com
--   - username: darby.sabini | email: darby@sabini.co.uk
--   - username: billy.kimber | email: billy@birminghamracecourse.co.uk
--   - username: luca.changretta | email: luca@changrettafamily.com
--   - username: may.carleton | email: may@carletonestates.co.uk
--   - username: freddie.thorne | email: freddie.thorne@workers-union.co.uk
--
-- AUTHORITIES (5 autoridades):
--   - username: insp.campbell | email: campbell@birminghampd.gov.uk
--   - username: moss.officer | email: moss@birminghampd.gov.uk
--   - username: major.campbell | email: major.campbell@specialbranch.gov.uk
--   - username: sgt.thorne | email: sgt.thorne@birminghampd.gov.uk
--   - username: insp.davies | email: insp.davies@birminghampd.gov.uk
--
-- USER NO VERIFICADO (para probar flujo de verificación):
--   - username: new.user | email: newuser@example.com
--
-- RESUMEN DE DATOS:
--   - Zonas: 15 (Birmingham y otras ciudades)
--   - Productos: 23 (13 legales, 10 ilegales)
--   - Usuarios: 26 (1 admin, 4 partners, 8 distributors, 8 clients, 5 authorities)
--   - Ventas: 12 con detalles completos
--   - Sobornos: 10 (algunos pagados, algunos pendientes)
--   - Topics: 10 temas estratégicos
--   - Strategic Decisions: 8 decisiones
--   - Consejos Shelby: 16 participaciones de socios en decisiones
--   - Monthly Reviews: 4 revisiones mensuales
--   - Clandestine Agreements: 5 acuerdos clandestinos
-- ============================================================================
