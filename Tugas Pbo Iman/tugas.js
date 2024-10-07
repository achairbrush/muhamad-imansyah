//Class1 Laptop
class laptop {
    constructor (nama) {
        this.nama = nama
    }
    spesifikasi(){
        console.log(`Laptop ${this.nama} memiliki spesifikasi high end`)
    }
}   

class hp extends laptop {
    spesifikasi() {
        console.log(`Laptop ${this.nama} merupakan laptop yang cocok umtuk pelajar dan mahasiswa` )
    }
}

class asusROG extends laptop {
    spesifikasi() {
        console.log(`Laptop ${this.nama} merupakan laptop gaming`)
    }
}

let Laptop = [new hp('hp'), new asusROG('asusROG')]
Laptop.forEach(laptop => laptop.spesifikasi())


//Class2 Motor
class motor {
    constructor (nama) {
        this.nama = nama
    }
    spesifikasi(){
        console.log(`Motor ${this.nama} merupakan motor dari perusahaan yamaha `)
    }
}   

class zr25 extends motor {
    spesifikasi() {
        console.log(`Motor ${this.nama} cocok untuk motor sport` )
    }
}

class mio extends motor {
   spesifikasi() {
        console.log(`Motor ${this.nama} sering dipakai masyarakat indonesia`)
    }
}

let Motor = [new zr25('zr25'), new mio('mio')]
Motor.forEach(motor => motor.spesifikasi())


//Class3 segitiga
class segitiga {
    constructor (bentuk) {
        this.bentuk = bentuk
    }
    panjangSisi(){
        console.log(`Segitiga ${this.bentuk} memiliki sisi yang sama antara 2 sisi`)
    }
}   

class samakaki extends segitiga {
    panjangSisi() {
        console.log(`Segitiga ${this.bentuk} memiliki panjang kaki yang sama `)
    }
}

class samasisi extends segitiga {
    panjangSisi() {
        console.log(`Segitiga ${this.bentuk} memiliki panjang sisi yang sama antara sisi sisinya `)
    }
}

let Segitiga = [new samakaki('samakaki'), new samasisi('samasisi')]
Segitiga.forEach(segitiga => segitiga.panjangSisi())


//class4 film
class film {
    constructor (genre) {
        this.genre = genre
    }
    genrefilm(){
        console.log(`Filml ini bergenre ${this.genre}`)
    }
}   

class horor extends film {
    genrefilm() {
        console.log(`Film ini bergenre ${this.genre} dan banyak adegan jumpscare dan hantunya`)
    }
}

class action extends film {
    genrefilm() {
        console.log(`Film ini bergenre ${this.genre} dan banyak adegan perangnya`)
    }
}

let Film = [new horor('horor'), new action('action')]
Film.forEach(film => film.genrefilm())