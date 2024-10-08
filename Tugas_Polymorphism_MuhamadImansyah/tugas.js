class mobilSports {
    constructor(nama, jenis, kecepatan, kapasitas, panjang, lebar) {
        this.nama = nama;
        this.jenis = jenis;
        this.kecepatan = kecepatan;
        this.kapasitas = kapasitas;
        this.panjang = panjang;
        this.lebar = lebar;
    }

    infoMobil() {
        return `Nama Mobil : ${this.nama} <br>
                Jenis : ${this.jenis} <br>
                Kecepatan : ${this.kecepatan} km/h <br>
                Kapasitas : ${this.kapasitas} orang <br>
                Panjang : ${this.panjang} meter <br>
                Lebar : ${this.lebar} meter`;
    }
}

class mobilSedan extends mobilSports {
    constructor(nama, kecepatan, kapasitas, panjang, lebar, kenyamanan) {
        super(nama, 'Mobil Sedan', kecepatan, kapasitas, panjang, lebar);
        this.kenyamanan = kenyamanan;
    }

    infoMobil() {
        return super.infoMobil() + `<br>Kenyamanan: ${this.kenyamanan}`;
    }
}

class mobilSUV extends mobilSports {
    constructor(nama, kecepatan, kapasitas, panjang, lebar, offroadCapability) {
        super(nama, 'Mobil SUV', kecepatan, kapasitas, panjang, lebar);
        this.offroadCapability = offroadCapability;
    }

    infoMobil() {
        return super.infoMobil() + `<br>Kemampuan Off-road: ${this.offroadCapability}`;
    }
}

class mobilListrik extends mobilSports {
    constructor(nama, kecepatan, kapasitas, panjang, lebar, range) {
        super(nama, 'Mobil Listrik', kecepatan, kapasitas, panjang, lebar);
        this.range = range;
    }

    infoMobil() {
        return super.infoMobil() + `<br>Daya Tempuh: ${this.range} km`;
    }
}

class mobilBalap extends mobilSports {
    constructor(nama, kecepatan, kapasitas, panjang, lebar, trackTime) {
        super(nama, 'Mobil Balap', kecepatan, kapasitas, panjang, lebar);
        this.trackTime = trackTime;
    }

    infoMobil() {
        return super.infoMobil() + `<br>Waktu Lintasan: ${this.trackTime} detik`;
    }
}

class mobilFan extends mobilSports {
    constructor(nama, kecepatan, kapasitas, panjang, lebar, penggemar) {
        super(nama, 'Mobil Fan', kecepatan, kapasitas, panjang, lebar);
        this.penggemar = penggemar;
    }

    infoMobil() {
        return super.infoMobil() + `<br>Jumlah Penggemar: ${this.penggemar}`;
    }
}

class mobilCivic extends mobilSports {
    constructor(nama, kecepatan, kapasitas, panjang, lebar, generasi) {
        super(nama, 'Mobil Civic', kecepatan, kapasitas, panjang, lebar);
        this.generasi = generasi;
    }

    infoMobil() {
        return super.infoMobil() + `<br>Generasi: ${this.generasi}`;
    }
}

// Contoh Objek
const civicTypeR = new mobilCivic("Honda Civic Type R", 270, 4, 4.5, 1.8, "Generasi ke-10");
const teslaModelS = new mobilListrik("Tesla Model S", 250, 5, 5, 2, 600);
const fordMustang = new mobilBalap("Ford Mustang", 320, 2, 4.8, 2, 12.5);
const rangeRover = new mobilSUV("Range Rover", 210, 7, 5.2, 2.1, "Sangat Baik");
const mercedesSClass = new mobilSedan("Mercedes S-Class", 240, 5, 5.3, 2, "Tingkat Kenyamanan Tinggi");

console.log("Informasi Mobil Civic");
console.log(civicTypeR.infoMobil());

console.log("Informasi Mobil Listrik");
console.log(teslaModelS.infoMobil());

console.log("Informasi Mobil Balap");
console.log(fordMustang.infoMobil());

console.log("Informasi Mobil SUV");
console.log(rangeRover.infoMobil());

console.log("Informasi Mobil Sedan");
console.log(mercedesSClass.infoMobil());