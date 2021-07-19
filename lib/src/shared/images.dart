import 'package:flutter/material.dart';

class JImages {
  JImages._();

  static Image get empty =>
      Image.asset("lib/assets/images/square.png"); // criar uma imagem vazis

  static Image get rain => Image.asset("lib/assets/images/words/rain.png");

  static Image get hA => Image.asset("lib/assets/images/kanas/h_a.png");
  static Image get rA => Image.asset("lib/assets/images/kanas/r_a.png");

  static Image get correct => Image.asset("lib/assets/images/correct.png");
  static Image get square => Image.asset("lib/assets/images/square.png");
  static Image get wrong => Image.asset("lib/assets/images/wrong.png");

  static Image get hATest => Image.asset("lib/assets/images/h_a_test.png");
}
