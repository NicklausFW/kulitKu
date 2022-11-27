import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:melanoma/imageClassification.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tflite/tflite.dart';

class HasilAnalisa extends StatefulWidget {
  HasilAnalisa(this.selectedImage);
  final File selectedImage;

  @override
  _HasilAnalisaState createState() => _HasilAnalisaState();
}

class _HasilAnalisaState extends State<HasilAnalisa> {
  var finalPrediction;

  Future loadModel() async {
    Tflite.close();
    Tflite.loadModel(
      model: "assets/newearlymelanoma13.tflite",
      labels: "assets/newearlymelanomaLabel.txt",
    );
  }

  prediction() async {
    final List prediction = await ImageClassification.instance
        .imageClassification(widget.selectedImage);
    return prediction;
  }

  Future labelPrediction() async {
    final String label = finalPrediction[0]["label"].toString();
    String finalLabel = label.replaceAll(RegExp('_+'), ' ');
    return finalLabel;
  }

  Future labelConfidence() async {
    final String confidence = finalPrediction[0]["confidence"].toString();
    double finalConfidence =
        double.parse(confidence.replaceAll(RegExp('_+'), ' ')) * 100;
    String finalConfidenceConverted = finalConfidence.toStringAsFixed(0);
    return finalConfidenceConverted;
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    prediction().then((value) {
      setState(() {
        finalPrediction = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Hasil Analisa'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: widget.selectedImage != null
                        ? Image.file(
                            widget.selectedImage,
                            fit: BoxFit.cover,
                            height: 299,
                            width: 299,
                          )
                        : CircularProgressIndicator(),
                  )),
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
                child: FutureBuilder(
                  future: Future.wait([labelConfidence(), labelPrediction()]),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: (Colors.grey[300])!,
                            highlightColor: (Colors.grey[100])!,
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 10, left: 30, right: 30),
                              color: Colors.grey,
                              child: CustomText(
                                text: "90% DIDUGA MELANOMA",
                                inherit: false,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                                color: Colors.black,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                              baseColor: (Colors.grey[300])!,
                              highlightColor: (Colors.grey[100])!,
                              child: Container(
                                color: Colors.grey,
                                margin: EdgeInsets.only(
                                    top: 10, left: 30, right: 30),
                                child: Column(
                                  children: <Widget>[
                                    CustomText(
                                      text:
                                          "Melanoma merupakan kanker kulit paling berbahaya yang dapat menyerupai berbagai kondisi kulit seperti tahi lalat. Diharapkan untuk mengunjungi dokter kulit untuk diperiksakan.",
                                      inherit: false,
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                ),
                              )),
                        ],
                      );
                    }
                    return Column(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: CustomText(
                            text: "${snapshot.data![0]}%" +
                                " " +
                                snapshot.data![1],
                            inherit: false,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            color: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 30, right: 30),
                          child: Column(
                            children: <Widget>[
                              snapshot.data![1] == "DIDUGA MELANOMA"
                                  ? CustomText(
                                      text:
                                          "Melanoma merupakan kanker kulit paling berbahaya yang dapat menyerupai berbagai kondisi kulit seperti tahi lalat. Diharapkan untuk mengunjungi dokter kulit untuk diperiksakan.",
                                      inherit: false,
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      textAlign: TextAlign.justify,
                                    )
                                  : CustomText(
                                      text:
                                          "Diharapkan memantau beberapa kali seminggu. Jika ada perubahan maupun dari ukuran, warna, tekstur, bentuk, atau memiliki gejala seperti gatal, sakit, atau berdarah, harap untuk mengunjungi dokter kulit untuk diperiksakan.",
                                      inherit: false,
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      textAlign: TextAlign.justify,
                                    ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 40, right: 30),
                child: Row(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.warning_amber_outlined,
                          size: 20,
                          color: Colors.grey,
                        )),
                    Flexible(
                      child: CustomText(
                        text:
                            "Aplikasi tidak memberikan diagnosa dan perawatan. Jika memiliki kekhawatiran, harap mengunjungi dokter kulit.",
                        inherit: false,
                        fontSize: 16.0,
                        maxLines: 5,
                        color: Colors.grey,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}

class CustomText extends StatelessWidget {
  CustomText(
      {this.text,
      this.style,
      this.inherit,
      this.fontFamily,
      this.fontWeight,
      this.letterSpacing,
      this.color,
      this.fontSize,
      this.textAlign,
      this.maxLines});

  final String? text;
  final Widget? style;
  final bool? inherit;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
          inherit: inherit!,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          color: color,
        ));
  }
}
