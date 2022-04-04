import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/constants.dart';
import 'package:flutter_app/helpers/tokens.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class GotoPro extends StatefulWidget {
  const GotoPro({Key? key}) : super(key: key);

  @override
  State<GotoPro> createState() => _GotoProState();
}

class _GotoProState extends State<GotoPro> {
  // int nbTokens = 13;

  bool addToken(int a) {
    if (nbTokens + a < 0) return false;
    setState(() {
      nbTokens += a;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAction: Row(
          children: [
            Text(
              nbTokens.toString() + " ",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Icon(
              Icons.monetization_on_rounded,
            ),
            Gap(10),
          ],
        ),
      ),
      backgroundColor: maincol,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Spacer(),
              SizedBox(
                child: Image.asset(
                  "assets/images/diamond_200px.png",
                  fit: BoxFit.scaleDown,
                ),
                height: 150,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "Passez à PRO pour avoir accès à d'autres fonctionnalités",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    // fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: cardcol.withOpacity(.6),
                  ),
                ),
              ),
              Gap(20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: cardcol,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (!addToken(-5))
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Tokens insuffisants",
                              textAlign: TextAlign.center,
                            ),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(milliseconds: 350),
                            backgroundColor: themecol,
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                        );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(3)),
                    ),
                    child: Text(
                      "Payer avec des FreshTokens",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: maincol,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  decoration: BoxDecoration(
                    color: themecol,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(3)),
                    ),
                    child: Text(
                      "Payer avec une carte de crédit",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: cardcol,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
