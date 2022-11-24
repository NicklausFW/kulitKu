import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class KontakDokter extends StatefulWidget {
  @override
  State<KontakDokter> createState() => _KontakDokterState();
}

List<String> namaDokter = [
  "dr. Jose L. Anggowarsito, G.Dip.Derm, SpKK",
  "dr. Djoni Pandapotan Sirait, SpDV",
  "dr. Novita Damayanti, SpKK",
  "dr. Myrna S. Widiarto, Sp.KK",
  "dr. Purwi Mussadeq, Sp.KK",
  "dr. Yuri Widia, Sp.KK",
  "dr. Winawati Eka Putri, Sp.DV"
];
List<String> gambarDokter = [
  "https://national-hospital.com/storage/ugc/teams/625790bfd8293-dr-jose-l-anggowarsito-md.webp",
  "https://national-hospital.com/storage/ugc/teams/61de32a63d813-djoni-pandapotan-sirait-md.webp",
  "https://national-hospital.com/storage/ugc/teams/61de2fe3ac5d2-novita-damayanti-md.webp",
  "https://ramsaysimedarby.co.id/cfind/source/thumb/images/dokter-rsps/cover_w389_h401_dr.-myrna.png",
  "https://ramsaysimedarby.co.id/cfind/source/thumb/images/dokter-rsps/cover_w389_h401_dr.-purwi.png",
  "https://ramsaysimedarby.co.id/cfind/source/thumb/images/dokter-rsps/cover_w389_h401_dr.-yuri.png",
  "https://ramsaysimedarby.co.id/cfind/source/thumb/images/dokter-rsps/cover_w389_h401_dr.-winawati-eka-putri-sp.dv.png"
];
List<String> doctorUrlsToLaunch = [
  "https://national-hospital.com/doctor/dr-jose-l-anggowarsito-g-dip-derm-spkk",
  "https://national-hospital.com/doctor/dr-djoni-pandapotan-sirait-spdv",
  "https://national-hospital.com/doctor/dr-novita-damayanti-spkk",
  "https://ramsaysimedarby.co.id/dr-myrna-s-widiarto-spkk-in",
  "https://ramsaysimedarby.co.id/dr-purwi-mussadeq-spkk-in",
  "https://ramsaysimedarby.co.id/dr-yuri-widia-spkk-in",
  "https://ramsaysimedarby.co.id/dr-winawati-eka-putri-sp-dv-in"
];

_doctorLaunchUrl(index) async {
  if (await canLaunchUrl(Uri.parse(doctorUrlsToLaunch[index]))) {
    await launchUrl(Uri.parse(doctorUrlsToLaunch[index]));
  } else {
    throw "Could not open $doctorUrlsToLaunch";
  }
}

class _KontakDokterState extends State<KontakDokter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kontak Dokter'),
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
          child: Column(
            children: <Widget>[
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: namaDokter.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 375),
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Card(
                            child: GestureDetector(
                              onTap: () async {
                                _doctorLaunchUrl(index);
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 100,
                                    child: Image.network(gambarDokter[index]),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                        child: Text(
                                          namaDokter[index],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
