-- =========================================
-- HRC (MSSQL)
-- =========================================
IF DB_ID('hrc') IS NULL
  CREATE DATABASE hrc;
GO
USE hrc;
GO

/* ========== CLEANUP (dev) ========== */
IF OBJECT_ID('dbo.TR_Orders_Confirm_EnforceCapacity','TR') IS NOT NULL
  DROP TRIGGER dbo.TR_Orders_Confirm_EnforceCapacity;
GO
DROP FUNCTION IF EXISTS dbo.fn_zone_sold_qty;
GO

IF OBJECT_ID('dbo.OrderItems','U')     IS NOT NULL DROP TABLE dbo.OrderItems;
IF OBJECT_ID('dbo.OrderPromos','U')    IS NOT NULL DROP TABLE dbo.OrderPromos;
IF OBJECT_ID('dbo.Orders','U')         IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.PromoCodes','U')     IS NOT NULL DROP TABLE dbo.PromoCodes;
IF OBJECT_ID('dbo.EventZones','U')     IS NOT NULL DROP TABLE dbo.EventZones;
IF OBJECT_ID('dbo.EventArtists','U')   IS NOT NULL DROP TABLE dbo.EventArtists;
IF OBJECT_ID('dbo.Events','U')         IS NOT NULL DROP TABLE dbo.Events;
IF OBJECT_ID('dbo.VenueZones','U')     IS NOT NULL DROP TABLE dbo.VenueZones;
IF OBJECT_ID('dbo.Venues','U')         IS NOT NULL DROP TABLE dbo.Venues;
IF OBJECT_ID('dbo.Artists','U')        IS NOT NULL DROP TABLE dbo.Artists;
IF OBJECT_ID('dbo.Customers','U')      IS NOT NULL DROP TABLE dbo.Customers;
IF OBJECT_ID('dbo.Users','U')          IS NOT NULL DROP TABLE dbo.Users;
GO

/* ========== CORE ENTITIES (no password fields) ========== */
CREATE TABLE dbo.Users(
  id             BIGINT IDENTITY PRIMARY KEY,
  email          VARCHAR(150) NOT NULL UNIQUE,
  full_name      NVARCHAR(120) NOT NULL,
  phone          VARCHAR(20) NULL,
  role           VARCHAR(30) NOT NULL CHECK (role IN ('ADMIN','STAFF')),
  active         BIT NOT NULL DEFAULT 1,
  password_hash  VARCHAR(200) NULL,
  created_at     DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);

CREATE TABLE dbo.Customers(
  id             BIGINT IDENTITY PRIMARY KEY,
  email          VARCHAR(150) NOT NULL UNIQUE,
  full_name      NVARCHAR(120) NOT NULL,
  phone          VARCHAR(20) NULL,
  password_hash  VARCHAR(200) NULL,
  created_at     DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);

CREATE TABLE dbo.Artists(
  id        BIGINT IDENTITY PRIMARY KEY,
  name      NVARCHAR(150) NOT NULL UNIQUE,
  country   NVARCHAR(80) NULL,
  about     NVARCHAR(1000) NULL
);

CREATE TABLE dbo.Venues(
  id        BIGINT IDENTITY PRIMARY KEY,
  name      NVARCHAR(150) NOT NULL UNIQUE,
  address   NVARCHAR(200) NULL,
  city      NVARCHAR(80) NULL,
  capacity  INT NULL
);

-- Zone đều là GA (đứng)
CREATE TABLE dbo.VenueZones(
  id         BIGINT IDENTITY PRIMARY KEY,
  venue_id   BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.Venues(id),
  name       NVARCHAR(100) NOT NULL,
  capacity   INT NULL,
  UNIQUE(venue_id, name)
);

CREATE TABLE dbo.Events(
  id           BIGINT IDENTITY PRIMARY KEY,
  venue_id     BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.Venues(id),
  name         NVARCHAR(200) NOT NULL,
  description  NVARCHAR(2000) NULL,
  start_at     DATETIME2 NOT NULL,
  end_at       DATETIME2 NULL,
  status       VARCHAR(20) NOT NULL CHECK (status IN ('DRAFT','ONSALE','SOLDOUT','CLOSED','CANCELLED')),
  min_age      INT NULL,
  created_at   DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);

CREATE TABLE dbo.EventArtists(
  event_id     BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.Events(id),
  artist_id    BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.Artists(id),
  is_headliner BIT NOT NULL DEFAULT 0,
  PRIMARY KEY(event_id, artist_id)
);

CREATE TABLE dbo.EventZones(
  id             BIGINT IDENTITY PRIMARY KEY,
  event_id       BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.Events(id),
  venue_zone_id  BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.VenueZones(id),
  currency       VARCHAR(10) NOT NULL DEFAULT 'VND',
  price          DECIMAL(12,2) NOT NULL,
  fee            DECIMAL(12,2) NOT NULL DEFAULT 0,
  allocation     INT NULL,  -- NULL -> dùng capacity zone
  UNIQUE(event_id, venue_zone_id)
);

CREATE TABLE dbo.PromoCodes(
  id                 BIGINT IDENTITY PRIMARY KEY,
  code               VARCHAR(50) NOT NULL UNIQUE,
  discount_type      VARCHAR(10) NOT NULL CHECK (discount_type IN ('PERCENT','AMOUNT')),
  discount_value     DECIMAL(12,2) NOT NULL,
  max_uses           INT NULL,
  per_customer_limit INT NULL,
  start_at           DATETIME2 NULL,
  end_at             DATETIME2 NULL,
  min_order_amount   DECIMAL(12,2) NULL
);

/* ========== ORDERS (BANK only) ========== */
CREATE TABLE dbo.Orders(
  id              BIGINT IDENTITY PRIMARY KEY,
  customer_id     BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.Customers(id),
  status          VARCHAR(20) NOT NULL CHECK (status IN ('PENDING','PAID','CANCELLED','REFUNDED')),
  currency        VARCHAR(10) NOT NULL DEFAULT 'VND',
  total_amount    DECIMAL(12,2) NOT NULL DEFAULT 0,
  payment_method  VARCHAR(10) NOT NULL DEFAULT 'BANK'
                    CONSTRAINT CK_Orders_payment_method CHECK (payment_method = 'BANK'),
  payment_status  VARCHAR(20) NOT NULL DEFAULT 'PENDING'
                    CONSTRAINT CK_Orders_payment_status CHECK (payment_status IN ('PENDING','CONFIRMED','FAILED','REFUNDED')),
  paid_amount     DECIMAL(12,2) NULL,
  bank_ref        VARCHAR(100) NULL,
  confirmed_by    BIGINT NULL FOREIGN KEY REFERENCES dbo.Users(id),
  confirmed_at    DATETIME2 NULL,
  created_at      DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
CREATE INDEX IX_Orders_bank_ref ON dbo.Orders(bank_ref);

CREATE TABLE dbo.OrderPromos(
  order_id BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.Orders(id),
  promo_id BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.PromoCodes(id),
  PRIMARY KEY(order_id, promo_id)
);

CREATE TABLE dbo.OrderItems(
  id             BIGINT IDENTITY PRIMARY KEY,
  order_id       BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.Orders(id),
  event_zone_id  BIGINT NOT NULL FOREIGN KEY REFERENCES dbo.EventZones(id),
  qty            INT NOT NULL CHECK (qty > 0),
  unit_price     DECIMAL(12,2) NOT NULL,
  fee_amount     DECIMAL(12,2) NOT NULL DEFAULT 0,
  final_price    AS (CAST((unit_price + fee_amount) AS DECIMAL(12,2))) PERSISTED
);
CREATE INDEX IX_OrderItems_order ON dbo.OrderItems(order_id);
CREATE INDEX IX_EventZones_event ON dbo.EventZones(event_id);

/* ========== SOLD QTY (GA) ========== */
GO
CREATE FUNCTION dbo.fn_zone_sold_qty(@event_zone_id BIGINT)
RETURNS INT
AS
BEGIN
  DECLARE @sold INT;
  SELECT @sold = ISNULL(SUM(oi.qty),0)
  FROM dbo.OrderItems oi
  JOIN dbo.Orders o ON o.id = oi.order_id AND o.payment_status = 'CONFIRMED'
  WHERE oi.event_zone_id = @event_zone_id;
  RETURN ISNULL(@sold,0);
END;
GO

/* ========== ENFORCE CAPACITY ON CONFIRM ========== */
GO
CREATE TRIGGER dbo.TR_Orders_Confirm_EnforceCapacity
ON dbo.Orders
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  ;WITH changed AS (
    SELECT i.id
    FROM inserted i
    JOIN deleted d ON d.id = i.id
    WHERE i.payment_status = 'CONFIRMED' AND d.payment_status <> 'CONFIRMED'
  )
  IF NOT EXISTS (SELECT 1 FROM changed) RETURN;

  ;WITH items AS (
    SELECT oi.event_zone_id, SUM(oi.qty) AS qty_in_this_order
    FROM dbo.OrderItems oi
    JOIN changed c ON c.id = oi.order_id
    GROUP BY oi.event_zone_id
  )
  SELECT 1/0 -- vượt allocation/capacity -> rollback
  FROM items it
  JOIN dbo.EventZones ez ON ez.id = it.event_zone_id
  JOIN dbo.VenueZones vz ON vz.id = ez.venue_zone_id
  CROSS APPLY (SELECT CAST(ISNULL(ez.allocation, vz.capacity) AS INT) AS max_alloc) cap
  CROSS APPLY (SELECT dbo.fn_zone_sold_qty(it.event_zone_id) AS sold_confirmed) sold
  WHERE (sold.sold_confirmed + it.qty_in_this_order) > cap.max_alloc;
END;
GO

/* ========== SEED DATA ========== */
-- Password: admin123 (SHA-256 hash)
INSERT INTO dbo.Users(email, full_name, phone, role, password_hash)
VALUES ('admin@rock.local', N'Admin', '0900000000', 'ADMIN', 
        '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9'),
       ('admin@hrc.com', N'HRC Administrator', '0123456789', 'ADMIN', 
        '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');

-- Password: customer123 (SHA-256 hash)
INSERT INTO dbo.Customers(email, full_name, phone, password_hash)
VALUES ('khoa@example.com', N'Khoa Nguyễn', '0912345678',
        '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'),
       ('fan@example.com',  N'Rock Fan',     '0988888888',
        '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92');

INSERT INTO dbo.Artists(name, country, about) VALUES
 (N'Giấy Trắng', N'VN', N'Indie rock band'),
 (N'StormRiff',  N'US', N'Heavy rock guest');

INSERT INTO dbo.Venues(name, address, city, capacity)
VALUES (N'Hanoi Rock Arena', N'123 Trần Duy Hưng', N'Hà Nội', 5000);

INSERT INTO dbo.VenueZones(venue_id, name, capacity)
VALUES (1, N'Front PIT', 800),
       (1, N'Mid Field', 2000),
       (1, N'Back Field', 2200);

INSERT INTO dbo.Events(venue_id, name, description, start_at, end_at, status, min_age)
VALUES (1, N'Rock Night 2025', N'Line-up cháy sân',
        '2025-09-20 19:30', '2025-09-20 22:30', 'ONSALE', 12);

INSERT INTO dbo.EventArtists(event_id, artist_id, is_headliner)
VALUES (1, 1, 1), (1, 2, 0);

INSERT INTO dbo.EventZones(event_id, venue_zone_id, currency, price, fee, allocation)
VALUES (1, 1, 'VND', 1500000, 30000, 700),
       (1, 2, 'VND',  900000, 20000, 1800),
       (1, 3, 'VND',  600000, 15000, 2000);

INSERT INTO dbo.PromoCodes(code, discount_type, discount_value, max_uses, per_customer_limit, start_at, end_at, min_order_amount)
VALUES ('ROCK10', 'PERCENT', 10, 1000, 2, '2025-08-01', '2025-09-20', 500000);

-- Demo: order GA Front PIT xác nhận
INSERT INTO dbo.Orders(customer_id, status, currency, total_amount, payment_status, paid_amount, bank_ref, confirmed_by, confirmed_at)
VALUES (1, 'PAID', 'VND', 1530000, 'PENDING', 1530000, 'REF001', 1, NULL);
DECLARE @o1 BIGINT = SCOPE_IDENTITY();

INSERT INTO dbo.OrderItems(order_id, event_zone_id, qty, unit_price, fee_amount)
VALUES (@o1, 1, 1, 1500000, 30000);

UPDATE dbo.Orders SET payment_status='CONFIRMED', confirmed_at=SYSDATETIME() WHERE id=@o1;
GO
