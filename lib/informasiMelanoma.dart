import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class InformasiMelanoma extends StatefulWidget {
  @override
  State<InformasiMelanoma> createState() => _InformasiMelanomaState();
}

class _InformasiMelanomaState extends State<InformasiMelanoma> {
  List<String> title = [
    "Apa itu kanker melanoma?",
    "Ada berapa jenis kanker melanoma?",
    "Seberapa umumkah kanker melanoma?"
        "Apa saja tanda-tanda dan gejala kanker melanoma?",
    "Apa penyebab kanker melanoma?",
    "Apa yang membuat saya berisiko mengalami kanker melanoma?",
    "Apa saja tes yang biasanya dilakukan untuk mendiagnosis kanker melanoma?"
  ];
  List<String> urlsToLaunch = [
    "https://hellosehat.com/kanker/kanker-kulit/melanoma/",
  ];

  List<String> gambarMelanoma = [
    "https://cdn.hellosehat.com/wp-content/uploads/2016/08/melanoma.jpg",
    "https://cdn.hellosehat.com/wp-content/uploads/2020/02/operasi-kanker-kulit.jpg",
    "https://cdn.hellosehat.com/wp-content/uploads/2019/10/efek-operasi-ganti-kelamin-802x452.jpg",
    "https://cdn.hellosehat.com/wp-content/uploads/2020/02/operasi-kanker-laser.jpg",
    "https://cdn.hellosehat.com/wp-content/uploads/2018/05/Apa-Benar-Kanker-Kulit-Melanoma-Disebabkan-Faktor-Keturunan.jpg",
    "https://cdn.hellosehat.com/wp-content/uploads/2017/09/shutterstock_613484831-700x467.jpg",
    "https://cdn.hellosehat.com/wp-content/uploads/2018/01/Mengenal-Kanker-Kulit-Melanoma-Anak-700x467.jpg"
  ];

  _launchUrl(index) async {
    if (await launchUrl(Uri.parse(urlsToLaunch[index]))) {
      await launchUrl(Uri.parse(urlsToLaunch[index]));
    } else {
      throw "Could not open $urlsToLaunch";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Apa itu Melanoma?'),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: title.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 375),
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Card(
                        child: GestureDetector(
                          onTap: () async {
                            _launchUrl(0);
                          },
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Image.network(gambarMelanoma[index]),
                                ),
                              ),
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 0),
                                    child: Container(
                                      child: Text(
                                        title[index],
                                        maxLines: 4,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                      "https://hellosehat.com/kanker/kanker-kulit/melanoma/",
                                      maxLines: 3,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
