import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:melanoma/selectImage.dart';
import 'dart:io';
import 'hasilAnalisa.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File selectedImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 100, bottom: 20),
              child: Image(
                width: 200,
                height: 200,
                image: AssetImage('assets/icon.png'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                children: <Widget>[
                  Text(
                    "Perikasa Tanda Awal Melanoma",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Ambil gambar sekarang dan aplikasi akan membantu mendeteksi awal melanoma dari lesi kulit anda. ',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: TextButton.icon(
                label: const Icon(Icons.chevron_right_rounded),
                icon: const Text('Ambil Gambar'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xffD21F3C)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return bottomSheet(context);
                      });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: TextButton.icon(
                label: const Icon(Icons.chevron_right_rounded),
                icon: const Text('Apa itu Melanoma?'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xffD21F3C)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/informasiMelanoma');
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextButton.icon(
                label: const Icon(Icons.chevron_right_rounded),
                icon: const Text('Kontak Dokter'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xffD21F3C)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/kontakDokter');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
          vertical: MediaQuery.of(context).size.height * 0.1),
      child: Column(
        children: <Widget>[
          Text(
            "Aplikasi dilengkapi dengan sebuah kecerdasan buatan yang telah dilatih dengan akurasi sebesar 85%",
            textAlign: TextAlign.justify,
            maxLines: 5,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Silahkan Mengambil Gambar",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton.icon(
            label: const Icon(Icons.camera),
            icon: const Text('Kamera'),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffD21F3C)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            onPressed: () async {
              final selectedImage =
                  await SelectImage.instance.pickImage(ImageSource.camera);
              this.selectedImage = selectedImage;
              if (selectedImage != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HasilAnalisa(
                          selectedImage: this.selectedImage,
                        )));
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextButton.icon(
            label: const Icon(Icons.image),
            icon: const Text('Galeri'),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffD21F3C)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            onPressed: () async {
              final selectedImage =
                  await SelectImage.instance.pickImage(ImageSource.gallery);
              this.selectedImage = selectedImage;
              if (selectedImage != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HasilAnalisa(
                      selectedImage: this.selectedImage,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
