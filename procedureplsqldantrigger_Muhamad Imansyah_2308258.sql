-- Procedure PL-SQL 
-- ===================================================================
CREATE TABLE IF NOT EXISTS mahasiswa (
  id_mahasiswa INT PRIMARY KEY,
  nama VARCHAR(100),
  total_nilai DECIMAL(18,2) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS nilai (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_mahasiswa INT NOT NULL,
  nilai DECIMAL(5,2) NOT NULL,
  CONSTRAINT fk_nilai_mahasiswa FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa)
);

CREATE TABLE IF NOT EXISTS log_nilai (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_mahasiswa INT,
  nilai DECIMAL(18,2),
  deleted_at DATETIME
);

DELIMITER //

-- 1) Latihan Kondisional: Buat prosedur cek_kelulusan yang menerima ID mahasiswa dan mengevaluasi apakah mahasiswa tersebut lulus atau tidak berdasarkan nilai rata-rata. Jika rata-rata >= 75, mahasiswa dinyatakan lulus.

CREATE OR REPLACE PROCEDURE cek_kelulusan(IN p_id_mahasiswa INT)
BEGIN
  DECLARE v_rata DECIMAL(6,2);

  SELECT AVG(COALESCE(n.nilai, 0))
    INTO v_rata
    FROM nilai n
   WHERE n.id_mahasiswa = p_id_mahasiswa;

  IF v_rata IS NULL THEN
    SELECT CONCAT('Tidak ada nilai untuk mahasiswa ', p_id_mahasiswa) AS pesan;
  ELSEIF v_rata >= 75 THEN
    SELECT CONCAT('Mahasiswa ', p_id_mahasiswa, ' dinyatakan lulus. Rata-rata: ', FORMAT(v_rata, 2)) AS pesan;
  ELSE
    SELECT CONCAT('Mahasiswa ', p_id_mahasiswa, ' dinyatakan tidak lulus. Rata-rata: ', FORMAT(v_rata, 2)) AS pesan;
  END IF;
END //

-- 2) Latihan Looping: Buat prosedur total_nilai_semua_mahasiswa yang menghitung total nilai seluruh mahasiswa dalam tabel nilai dengan menggunakan loop.

CREATE OR REPLACE PROCEDURE total_nilai_semua_mahasiswa(OUT p_total DECIMAL(18,2))
BEGIN
  DECLARE v_nilai DECIMAL(18,2);
  DECLARE done INT DEFAULT 0;
  DECLARE cur_nilai CURSOR FOR SELECT COALESCE(n.nilai, 0) FROM nilai n;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  SET p_total = 0;
  OPEN cur_nilai;
  read_loop: LOOP
    FETCH cur_nilai INTO v_nilai;
    IF done = 1 THEN LEAVE read_loop; END IF;
    SET p_total = p_total + v_nilai;
  END LOOP;
  CLOSE cur_nilai;

  SELECT CONCAT('Total nilai seluruh mahasiswa: ', FORMAT(p_total, 2)) AS pesan;
END //

-- 3) Latihan Error Handling: Buat prosedur cari_nama_matakuliah yang menerima ID mata kuliah dan mengembalikan nama mata kuliah. Jika ID mata kuliah tidak ditemukan, tampilkan pesan 'Mata kuliah tidak ditemukan'.

CREATE OR REPLACE PROCEDURE cari_nama_matakuliah(
  IN p_id_matakuliah INT,
  OUT p_nama VARCHAR(255)
)
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  SELECT m.nama_matakuliah
    INTO p_nama
    FROM mata_kuliah m
   WHERE m.id_matakuliah = p_id_matakuliah;

  IF done = 1 THEN
    SET p_nama = NULL;
    SELECT 'Mata kuliah tidak ditemukan' AS pesan;
  ELSE
    SELECT CONCAT('Nama mata kuliah: ', p_nama) AS pesan;
  END IF;
END //

DELIMITER ;

-- ===================================================================
-- Triggers 
-- ===================================================================
DELIMITER //

-- 1) Buat trigger yang memblokir penghapusan data dari tabel nilai jika nilai tersebut di bawah 50.
CREATE OR REPLACE TRIGGER trg_nilai_block_delete_low
BEFORE DELETE ON nilai
FOR EACH ROW
BEGIN
  IF OLD.nilai < 50 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Penghapusan ditolak: nilai di bawah 50';
  END IF;
END //

-- 2) Buat trigger AFTER DELETE yang mencatat data yang dihapus dari tabel nilai ke tabel log.

CREATE OR REPLACE TRIGGER trg_nilai_after_delete_log
AFTER DELETE ON nilai
FOR EACH ROW
BEGIN
  INSERT INTO log_nilai(id_mahasiswa, nilai, deleted_at)
  VALUES (OLD.id_mahasiswa, OLD.nilai, NOW());
END //

-- 3) Buat trigger BEFORE UPDATE yang menambahkan kolom total_nilai di tabel mahasiswa, di mana total_nilai adalah total semua nilai mahasiswa di tabel nilai.
CREATE OR REPLACE TRIGGER trg_mahasiswa_before_update_total
BEFORE UPDATE ON mahasiswa
FOR EACH ROW
BEGIN
  SET NEW.total_nilai = (
    SELECT COALESCE(SUM(n.nilai), 0)
      FROM nilai n
     WHERE n.id_mahasiswa = NEW.id_mahasiswa
  );
END //

DELIMITER ;

INSERT INTO mahasiswa (id_mahasiswa, nama) VALUES
  (1, 'Iman'),
  (2, 'Bagas')
ON DUPLICATE KEY UPDATE nama = VALUES(nama);

INSERT INTO nilai (id_mahasiswa, nilai) VALUES
  (1, 80.00),
  (1, 70.00),
  (2, 40.00)
ON DUPLICATE KEY UPDATE nilai = VALUES(nilai);
CALL cek_kelulusan(1);
CALL cek_kelulusan(2);
CALL total_nilai_semua_mahasiswa(@total_semua);
SELECT @total_semua AS total_semua;
DELETE FROM nilai WHERE id_mahasiswa = 2 AND nilai = 40.00;

DELETE FROM nilai WHERE id_mahasiswa = 1 AND nilai = 70.00;

SELECT * FROM log_nilai;

UPDATE mahasiswa SET nama = nama;
SELECT id_mahasiswa, total_nilai FROM mahasiswa;
