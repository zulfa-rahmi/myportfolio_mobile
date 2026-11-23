# MyPortfolio Mobile
Aplikasi mobile portofolio pribadi yang dikembangkan menggunakan Flutter sebagai bagian dari mata kuliah Pemrograman Berbasis Platform (PBP), Fakultas Ilmu Komputer, Universitas Indonesia.

Aplikasi ini menampilkan informasi profil pemilik portofolio serta menyediakan beberapa menu aksi sederhana, seperti melihat proyek, menambahkan proyek, dan logout.

## Technologies Used
- Flutter
- Dart
- Material Design

## Project Structure
```text
myportfolio_mobile/
├── lib/
│   ├── main.dart
│   └── menu.dart
├── test/
├── android/
├── ios/
├── web/
├── pubspec.yaml
└── README.md
```

## Features
- Display personal information (NPM, Name, and Class).
- Display portfolio action cards.
- Provide different background colors for each action card.
- Show interactive SnackBar messages when an action card is pressed.

## Installation and Setup
1. Make sure Flutter SDK is installed on your computer.
2. Clone this repository:

   ```bash
   git clone https://github.com/zulfa-rahmi/myportfolio_mobile.git
   ```

3. Navigate to the project directory:

   ```bash
   cd myportfolio_mobile
   ```

4. Install project dependencies:

   ```bash
   flutter pub get
   ```

5. Run the application:

   ```bash
   flutter run
   ```

6. Check the project for potential issues:

   ```bash
   flutter analyze
   ```

## Tugas 7

### 1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

Widget tree adalah struktur hierarkis yang menggambarkan susunan widget dalam aplikasi Flutter. Setiap widget dapat memiliki widget lain sebagai anaknya (child), sehingga membentuk sebuah struktur bertingkat.

Widget parent bertanggung jawab mengatur bagaimana widget child ditampilkan dan disusun. Sebagai contoh, pada aplikasi ini, Scaffold menjadi parent yang memiliki AppBar dan Padding sebagai bagian dari tampilannya. Padding kemudian memiliki Column sebagai child, yang berisi beberapa widget lain seperti Row, InfoCard, dan Center.

Hubungan parent-child memungkinkan Flutter menyusun tampilan aplikasi secara modular dan terstruktur. Ketika parent mengalami perubahan, Flutter dapat membangun ulang bagian widget tree yang berkaitan.

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

Widget yang digunakan dalam proyek ini antara lain:

- MaterialApp: Menjadi root widget aplikasi dan menyediakan konfigurasi seperti tema serta halaman utama.
- Scaffold: Menyediakan struktur dasar halaman, seperti AppBar dan body.
- AppBar: Menampilkan bagian header aplikasi.
- Text: Menampilkan teks, seperti judul aplikasi, informasi profil, dan nama tombol.
- Padding: Memberikan jarak di sekitar widget.
- Column: Menyusun widget secara vertikal.
- Row: Menyusun widget secara horizontal.
- InfoCard: Widget khusus untuk menampilkan informasi profil berupa NPM, nama, dan kelas.
- Card: Menampilkan informasi dalam bentuk kartu.
- Container: Mengatur ukuran, padding, dan tata letak konten.
- SizedBox: Memberikan jarak dengan ukuran tertentu.
- Center: Memposisikan child widget di tengah.
- GridView.count: Menampilkan kumpulan ItemCard dalam bentuk grid dengan jumlah kolom yang ditentukan.
- ItemCard: Widget khusus untuk menampilkan tombol aksi portofolio.
- Material: Menyediakan latar belakang dan tampilan Material Design untuk kartu tombol.
- InkWell: Memberikan interaksi ketika kartu ditekan.
- Icon: Menampilkan ikon yang sesuai dengan masing-masing tombol.
- SnackBar: Menampilkan pesan sementara setelah pengguna menekan tombol.

Selain itu, ScaffoldMessenger digunakan untuk mengelola dan menampilkan SnackBar pada halaman aplikasi.

### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

MaterialApp merupakan widget yang menyediakan konfigurasi dasar untuk aplikasi Flutter yang menggunakan Material Design.

Widget ini mengatur berbagai kebutuhan aplikasi, seperti tema, navigasi, title, dan halaman utama melalui properti home.

MaterialApp umumnya digunakan sebagai root widget karena menjadi dasar bagi widget-widget lain untuk memperoleh konfigurasi dan fitur Material Design yang konsisten.

Pada proyek ini, MaterialApp digunakan di dalam MyApp untuk mengatur tema aplikasi dan menampilkan MyHomePage sebagai halaman utama.

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?

StatelessWidget adalah widget yang tidak memiliki state internal yang dapat berubah selama widget digunakan. Tampilan widget ditentukan berdasarkan konfigurasi atau data yang diterima ketika widget dibuat.

Sebaliknya, StatefulWidget adalah widget yang memiliki state yang dapat berubah selama aplikasi berjalan. Perubahan state dapat dilakukan menggunakan setState() sehingga Flutter membangun ulang tampilan yang berkaitan.

StatelessWidget sebaiknya digunakan ketika tampilan tidak membutuhkan perubahan state internal, misalnya untuk menampilkan informasi profil atau komponen kartu.

StatefulWidget lebih tepat digunakan ketika widget membutuhkan perubahan data atau tampilan berdasarkan interaksi pengguna, seperti form input, checkbox, atau counter.

Pada proyek ini, MyHomePage, InfoCard, dan ItemCard menggunakan StatelessWidget karena komponen tersebut tidak membutuhkan perubahan state internal.

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?

BuildContext merupakan representasi lokasi sebuah widget dalam widget tree. BuildContext digunakan untuk mengakses informasi dan layanan yang tersedia dari widget parent dalam struktur widget tree.

BuildContext penting karena memungkinkan sebuah widget memperoleh konfigurasi atau informasi dari widget lain yang berada di atasnya.

Dalam metode build, BuildContext digunakan sebagai parameter untuk mengakses informasi tersebut.

Contohnya pada proyek ini:

```dart
Theme.of(context).colorScheme.primary
```

Kode tersebut menggunakan BuildContext untuk mengakses tema aplikasi yang disediakan oleh MaterialApp.

Contoh lainnya adalah:

```dart
ScaffoldMessenger.of(context)
```

Kode tersebut digunakan untuk memperoleh ScaffoldMessenger yang tersedia pada struktur widget tree sehingga aplikasi dapat menampilkan SnackBar.

### 6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

Hot reload merupakan fitur Flutter yang memungkinkan developer melihat perubahan kode secara langsung tanpa harus menjalankan ulang seluruh aplikasi. Fitur ini mempertahankan state aplikasi yang sedang berjalan sehingga proses pengembangan menjadi lebih cepat.

Hot restart merupakan proses memulai ulang aplikasi dari awal dengan membangun ulang widget tree dan menginisialisasi kembali state aplikasi.

Perbedaannya adalah hot reload mempertahankan state yang sedang berjalan, sedangkan hot restart menghapus state sementara dan memulai aplikasi kembali dari awal.

Hot reload cocok digunakan ketika developer hanya mengubah tampilan, teks, warna, atau struktur widget tanpa mengubah proses inisialisasi aplikasi.

Hot restart diperlukan ketika perubahan berkaitan dengan inisialisasi state, variabel global, atau konfigurasi awal aplikasi yang tidak dapat diperbarui melalui hot reload.

Sementara itu, full restart diperlukan ketika perubahan melibatkan konfigurasi native, seperti perubahan pada kode Android atau iOS, yang membutuhkan proses build ulang aplikasi.

## AI Disclosure

### Tools yang Digunakan
- ChatGPT (OpenAI)

### Penggunaan AI

Saya menggunakan ChatGPT sebagai alat bantu selama pengerjaan Individual Assignment 7, terutama untuk memahami instruksi tugas, mengevaluasi implementasi Flutter yang telah dibuat pada Tutorial 08, serta mengidentifikasi perubahan yang diperlukan untuk memenuhi checklist tugas.

AI digunakan untuk membantu:
- Memahami implementasi warna latar yang berbeda pada setiap ItemCard.
- Meninjau dan memberikan saran perubahan pada model ItemHomepage dan widget ItemCard.
- Menyusun dokumentasi README.md.
- Memahami materi dan menyusun draft jawaban untuk enam pertanyaan reflektif.

### Strategi Prompting

Saya memberikan instruksi Tutorial 08, dokumen Individual Assignment 7, serta kode dari repository GitHub sebagai referensi. Selanjutnya, saya meminta ChatGPT untuk membandingkan implementasi yang sudah ada dengan persyaratan tugas dan memberikan rekomendasi perubahan kode yang diperlukan.

### Evaluasi dan Modifikasi Manual

Saran kode dan penjelasan yang diberikan oleh AI ditinjau kembali dan disesuaikan dengan struktur proyek yang sudah ada. Implementasi tetap mengacu pada materi dan pola pengerjaan Tutorial 08.

Saya bertanggung jawab untuk memahami, meninjau, menguji, dan memverifikasi seluruh implementasi akhir sebelum dikumpulkan.


## Tugas 8

### 1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop()! Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.

Navigator mengelola halaman (route) sebagai tumpukan atau stack. Perbedaan ketiga method tersebut terletak pada apa yang dilakukan terhadap route yang berada di atas stack.

- `Navigator.push()`: menambahkan route baru di atas stack. Halaman sebelumnya tetap ada di bawahnya sehingga pengguna dapat kembali.
- `Navigator.pushReplacement()`: mengganti route yang sedang tampil dengan route baru. Halaman lama dibuang dari stack.
- `Navigator.pop()`: menghapus route teratas sehingga aplikasi kembali ke route di bawahnya.

Untuk membuka formulir dari kartu aksi, proyek ini menggunakan `Navigator.push()` pada `ItemCard`:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ExperienceFormPage(),
  ),
);
```

Dengan cara ini, pengguna dapat kembali ke halaman utama menggunakan tombol Back bawaan perangkat.

Opsi Home di drawer menggunakan `Navigator.pushReplacement()` ke `MyHomePage()`. Halaman formulir yang sedang tampil digantikan oleh halaman utama, sehingga pengguna langsung berada di halaman utama tanpa harus menekan tombol Back.

### 2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

Scaffold menyediakan kerangka dasar halaman, yaitu AppBar di bagian atas, drawer di sisi kiri, dan body sebagai isi halaman. Karena setiap halaman memakai susunan yang sama, pengguna selalu menemukan navigasi di tempat yang sama.

Drawer dibuat satu kali sebagai widget `LeftDrawer` pada `lib/widgets/left_drawer.dart`, lalu dipasang pada halaman utama, formulir proyek, dan formulir pengalaman melalui properti `drawer: const LeftDrawer()`. Dengan begitu, perubahan menu cukup dilakukan di satu tempat.

Warna tema portofolio adalah indigo. Warna ini digunakan pada AppBar halaman utama (melalui `ColorScheme.fromSeed(seedColor: Colors.indigo)`), AppBar kedua halaman formulir (`backgroundColor: Colors.indigo`), header drawer, dan tombol Simpan.

### 3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan juga peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

Formulir disusun menggunakan `Column` di dalam `Form` karena isian diisi secara berurutan dari atas ke bawah, yang paling natural pada layar ponsel.

Setiap field dibungkus `Padding` agar tidak saling menempel dan memiliki jarak yang konsisten. `SizedBox` atau `Padding` digunakan untuk mengatur jarak antar-elemen.

`Column` tidak dapat di-scroll secara bawaan. Karena itu, `Column` dibungkus `SingleChildScrollView` agar seluruh field dan tombol Simpan tetap dapat dijangkau pada layar sempit atau ketika papan ketik tampil. Halaman utama juga dibungkus `SingleChildScrollView` agar kisi kartu aksi tidak overflow ketika jumlah kartu bertambah.

### 4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

`GlobalKey<FormState>` dipasang pada widget `Form` agar kode di luar field, seperti tombol Simpan, dapat mengakses state form.

`validator` adalah fungsi pada setiap field yang mengembalikan pesan error apabila isian tidak sesuai aturan, atau `null` apabila isian valid.

Saat tombol Simpan ditekan, `_formKey.currentState!.validate()` menjalankan seluruh validator sekaligus, menampilkan pesan error pada field yang bermasalah, dan mengembalikan `true` hanya jika semua isian valid. Dialog ringkasan baru ditampilkan setelah itu.

Contoh nilai yang ditolak adalah isian Posisi yang hanya berisi spasi (`"   "`), karena setelah `trim()` isiannya menjadi kosong. Contoh lain adalah tautan `abc` yang ditolak karena bukan URL http/https, serta tanggal selesai yang lebih awal dari tanggal mulai.

Memilih jenis input atau papan ketik saja belum cukup karena hal tersebut hanya memengaruhi tampilan dan kenyamanan input. `TextInputType.url` tetap memperbolehkan pengguna mengetik teks apa pun, dan `showDatePicker` tidak mencegah pengguna memilih tanggal yang tidak masuk akal. Aturan data tetap harus diperiksa oleh validator.

## AI Disclosure

### Tools yang Digunakan
- ChatGPT (OpenAI)

### Penggunaan AI

Saya menggunakan ChatGPT sebagai alat bantu selama pengerjaan Individual Assignment 8, terutama untuk memahami instruksi tugas, mempelajari konsep Flutter Navigation, Layouts, Forms, and Input Elements dari Tutorial 09, serta memahami implementasi fitur formulir Pengalaman (*Experience Form*).

AI digunakan untuk membantu:
- Memahami perbedaan `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pushAndRemoveUntil()`, serta pengaruhnya terhadap navigation stack.
- Memahami penggunaan widget layout seperti `SingleChildScrollView`, `Column`, `GridView`, `Padding`, dan `SizedBox`.
- Memahami implementasi formulir menggunakan `StatefulWidget`, `Form`, `GlobalKey<FormState>`, dan validator.
- Memahami perbedaan penggunaan `onChanged` dengan `setState()` dan `TextEditingController`.
- Memahami pengelolaan lifecycle widget, termasuk penggunaan `dispose()` dan pengecekan `mounted` setelah operasi asynchronous.
- Memahami penggunaan `Key` untuk mengatur ulang state Dropdown.
- Memahami konsep modularitas dan pemisahan kode ke dalam direktori `screens/` dan `widgets/`.

### Strategi Prompting

Saya memberikan dokumen Individual Assignment 8, referensi commit terakhir Tutorial 09 pada repository GitHub, serta pertanyaan spesifik mengenai implementasi dan konsep Flutter yang digunakan. Selanjutnya, saya meminta ChatGPT untuk menjelaskan fungsi setiap komponen, membandingkan beberapa pendekatan implementasi, dan memberikan contoh kode yang relevan dengan struktur proyek yang sudah ada.
Tautan: https://chatgpt.com/share/6b043ed2-e5d0-83ec-a4c2-a6db65822fc6

### Evaluasi dan Modifikasi Manual

Penjelasan dan contoh kode yang diberikan AI digunakan sebagai referensi untuk memahami konsep dan mengevaluasi implementasi secara mandiri. Saya tetap mengembangkan halaman Experience Form berdasarkan pemahaman terhadap materi Tutorial 09 dan menyesuaikannya dengan kebutuhan proyek portofolio.

Saya juga meninjau kembali setiap saran AI agar sesuai dengan struktur proyek, kebutuhan tugas, dan perilaku aplikasi yang diharapkan. Seluruh implementasi akhir menjadi tanggung jawab saya, termasuk proses pengujian, debugging, dan verifikasi menggunakan `flutter analyze`.