class Mobil {
    constructor(nama, merk, tahun, warna) {
        this.nama = nama;
        this.merk = merk;
        this.tahun = tahun;
        this.warna = warna;
    }

    infoMobil() {
        return `Mobil ${this.nama} adalah ${this.merk} tahun ${this.tahun} berwarna ${this.warna}.`;
    }
}

class MobilSport extends Mobil {
    constructor(nama, merk, tahun, warna, kecepatanMaks) {
        super(nama, merk, tahun, warna); 
        this.kecepatanMaks = kecepatanMaks; 
    }

    infoMobilSport() {
        return `${this.infoMobil()} Mobil ini memiliki kecepatan maksimum ${this.kecepatanMaks} km/jam.`;
    }
}

const mobilSedan = new Mobil("Civic", "Honda", 2020, "hitam");
const mobilSUV = new Mobil("Fortuner", "Toyota", 2022, "putih");

const mobilSport1 = new MobilSport("Mustang", "Ford", 2023, "merah", 300);

console.log(mobilSedan.infoMobil());
console.log(mobilSUV.infoMobil());

console.log(mobilSport1.infoMobilSport());
