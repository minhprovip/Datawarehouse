IF EXISTS (SELECT name FROM sys.databases WHERE name = N'csdl_ket_hop')
BEGIN
    DROP DATABASE csdl_ket_hop;
END
GO

-- Tạo lại cơ sở dữ liệu
CREATE DATABASE csdl_ket_hop;
GO

USE csdl_ket_hop;
GO


-- TABLES CHÍNH

CREATE TABLE VanPhong (
    MaThanhPho INT IDENTITY(1,1) PRIMARY KEY,
    TenThanhPho NVARCHAR(255) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
    Bang NVARCHAR(100) NOT NULL,
    ThoiGian DATE DEFAULT GETDATE()
);

CREATE TABLE CuaHang (
    MaCuaHang INT IDENTITY(1,1) PRIMARY KEY,
    SoDienThoai VARCHAR(15) NOT NULL,
    ThoiGian DATE DEFAULT GETDATE(),
    MaThanhPho INT NOT NULL,
    FOREIGN KEY (MaThanhPho) REFERENCES VanPhong(MaThanhPho)
);

CREATE TABLE MatHang (
    MaMatHang INT IDENTITY(1,1) PRIMARY KEY,
    MoTa NVARCHAR(255),
    KichCo NVARCHAR(100),
    TrongLuong FLOAT,
    Gia FLOAT NOT NULL,
    ThoiGian DATE DEFAULT GETDATE()
);

CREATE TABLE KhachHang (
    MaKhachHang INT IDENTITY(1,1) PRIMARY KEY,
    TenKhachHang NVARCHAR(255) NOT NULL,
    NgayDatHangDauTien DATE,
    MaThanhPho INT NOT NULL,
    FOREIGN KEY (MaThanhPho) REFERENCES VanPhong(MaThanhPho)
);


-- TABLES LIÊN KẾT

CREATE TABLE DonDatHang (
    MaDon INT IDENTITY(1,1) PRIMARY KEY,
    NgayDatHang DATE DEFAULT GETDATE(),
    MaKhachHang INT NOT NULL,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

CREATE TABLE MatHangDuocLuuTru (
    MaMatHang INT NOT NULL,
    MaCuaHang INT NOT NULL,
    SoLuongKho FLOAT DEFAULT 0,
    ThoiGian DATE DEFAULT GETDATE(),
    PRIMARY KEY (MaMatHang, MaCuaHang),
    FOREIGN KEY (MaMatHang) REFERENCES MatHang(MaMatHang),
    FOREIGN KEY (MaCuaHang) REFERENCES CuaHang(MaCuaHang)
);

CREATE TABLE MatHangDuocDat (
    MaMatHang INT NOT NULL,
    MaDon INT NOT NULL,
    SoLuongDat FLOAT NOT NULL,
    Gia FLOAT NOT NULL,
    ThoiGian DATE DEFAULT GETDATE(),
    PRIMARY KEY (MaMatHang, MaDon),
    FOREIGN KEY (MaMatHang) REFERENCES MatHang(MaMatHang),
    FOREIGN KEY (MaDon) REFERENCES DonDatHang(MaDon)
);

CREATE TABLE KhachHangDuLich (
    MaKhachHang INT PRIMARY KEY,
    HuongDanVienDuLich NVARCHAR(255),
    ThoiGian DATE DEFAULT GETDATE(),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

CREATE TABLE KhachHangBuuDien (
    MaKhachHang INT PRIMARY KEY,
    DiaChiBuuDien NVARCHAR(255),
    ThoiGian DATE DEFAULT GETDATE(),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);
