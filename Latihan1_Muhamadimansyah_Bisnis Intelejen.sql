CREATE TABLE anggota1 (
  id_anggota INT(3) PRIMARY KEY,
  nm_anggota VARCHAR(32),
  alamat TEXT,
  ttl_anggota TEXT,
  status_anggota VARCHAR(1)
) ENGINE=InnoDB;

CREATE TABLE buku1 (
  kd_buku VARCHAR(5) PRIMARY KEY,
  judul_buku VARCHAR(32),
  pengarang VARCHAR(32),
  jenis_buku VARCHAR(32),
  penerbit VARCHAR(32)
) ENGINE=InnoDB;

CREATE TABLE meminjam1 (
  id_pinjam INT(3) PRIMARY KEY,
  tgl_pinjam DATE,
  jumlah_pinjam INT(2),
  tgl_kembali DATE,
  id_anggota INT(3),
  kd_buku INT(5), 
  kembali INT(1),
  FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
  FOREIGN KEY (kd_buku) REFERENCES buku(kd_buku)
) ENGINE=InnoDB;

INSERT INTO anggota1 VALUES
(101, 'Iman', 'Bandung', '2003-05-15', 'A'),
(102, 'Acha', 'Garut', '2002-09-10', 'A'),
(103, 'Syah', 'Tasik', '2003-01-21', 'A'),
(104, 'Dian', 'Serang', '2004-03-30', 'A');

INSERT INTO buku1 VALUES
(10001, 'pengatar pasut', 'Andi', 'Teknologi', 'Informatika Press'),
(10002, 'Pemrograman Web', 'Budi', 'Teknologi', 'Graha Ilmu'),
(10003, 'pengantar bisnis intelejen', 'Sari', 'Bisnis', 'Erlangga');

INSERT INTO meminjam1 VALUES
(1, '2025-10-01', 1, '2025-10-05', 101, '10001', 1),
(2, '2025-10-03', 2, '2025-10-10', 102, '10002', 0),
(3, '2025-10-08', 4, '2025-10-12', 103, '10003', 0);

SELECT DISTINCT a.*
FROM anggota1 a
JOIN meminjam1 m ON a.id_anggota = m.id_anggota;

SELECT a.*
FROM anggota1 a
LEFT JOIN meminjam1 m ON a.id_anggota = m.id_anggota
WHERE m.id_anggota IS NULL;

SELECT a.*, m.tgl_pinjam
FROM anggota1 a
JOIN meminjam1 m ON a.id_anggota = m.id_anggota
WHERE m.tgl_pinjam = CURDATE();

SELECT a.nm_anggota, SUM(m.jumlah_pinjam) AS total_pinjam
FROM anggota1 a
JOIN meminjam1 m ON a.id_anggota = m.id_anggota
GROUP BY a.id_anggota
HAVING total_pinjam > 3;

SELECT b.judul_buku, m.tgl_kembali, m.kembali
FROM buku b
JOIN meminjam1 m ON b.kd_buku = m.kd_buku
WHERE m.kembali = 0 AND m.tgl_kembali < CURDATE();

UPDATE anggota1
SET status_anggota = 'T'
WHERE id_anggota NOT IN (SELECT DISTINCT id_anggota FROM meminjam1);
