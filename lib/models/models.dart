class MenuModel {
  final String title;
  final String imageName;
  final String description;
  MenuModel(this.title, this.imageName, this.description);
}

List<MenuModel> menuList = [
  MenuModel("Lokasi Rumah Sakit Terdekat", "assets/hospital_icon.png",
      "Memberikan lokasi terdekat rumah sakit untuk mendiagnosis lesi kulit Anda."),
  MenuModel("Deteksi Melanoma", "assets/skin_detect_icon.png",
      "Menganalisa gambar lesi kulit anda dan memberikan prediksi melanoma maupun tidak menggunakan Artificial Intelligence"),
  MenuModel("Apa itu Melanoma?", "assets/thinking_icon.png",
      "Informasi-informasi yang menjawab pertanyaan mengenai melanoma dari sumber-sumber terpecaya."),
];
