import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(GirisAyiApp());

class GirisAyiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(38, 50, 56, 1),
        body: GirisEkrani(),
      ),
    );
  }
}

class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniDurumu createState() => _GirisEkraniDurumu();
}

class _GirisEkraniDurumu extends State<GirisEkrani> {
  String dogruSifre = 'admin';
  String animasyonTuru = 'idle';

  final sifreKontrol = TextEditingController();

  final sifreOdakNokta = FocusNode();
  final kullaniciAdiOdakNokta = FocusNode();

  @override
  void initState() {
    sifreOdakNokta.addListener(() {
      if (sifreOdakNokta.hasFocus) {
        setState(() {
          animasyonTuru = 'hands_up';
        });
      } else {
        setState(() {
          animasyonTuru = 'hands_down';
        });
      }
    });

    kullaniciAdiOdakNokta.addListener(() {
      if (kullaniciAdiOdakNokta.hasFocus) {
        setState(() {
          animasyonTuru = 'test';
        });
      } else {
        setState(() {
          animasyonTuru = 'idle';
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: 300,
            child: FlareActor(
              'assets/Teddy.flr',
              alignment: Alignment.bottomCenter,
              fit: BoxFit.contain,
              animation: animasyonTuru,
              callback: (animation) {
                setState(() {
                  animasyonTuru = 'idle';
                });
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Kullanıcı Adı",
                    contentPadding: EdgeInsets.all(20),
                  ),
                  focusNode: kullaniciAdiOdakNokta,
                ),
                Divider(),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Şifre",
                    contentPadding: EdgeInsets.all(20),
                  ),
                  controller: sifreKontrol,
                  focusNode: sifreOdakNokta,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(
                    0xFF0F9D58), // primary yerine backgroundColor kullanılır
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => girisYap(),
              child: Text(
                "GİRİŞ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  void girisYap() {
    if (animasyonTuru == 'hands_up') {
      setState(() {
        animasyonTuru = 'hands_down';
      });
    }

    if (sifreKontrol.text.compareTo(dogruSifre) == 0) {
      setState(() {
        animasyonTuru = "success";
      });
    } else {
      setState(() {
        animasyonTuru = "fail";
      });
    }
  }
}
