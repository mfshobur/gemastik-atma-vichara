import 'package:flutter/material.dart';

const kAppName = "Atma Vichara";

const kDarkGrey = Color(0xff555555);
const kLightGrey = Color(0xffB1B1B1);
const kDisable = Color(0xffF0F0F0);
final kDefaultErrorColor = Colors.red[700]!;
const kInputBorderColor = Color(0xff919191);
const kTextGreyColor = Color(0xffB1B1B1);
const kRedColor = Color(0xffFF0000);
const kSemiGrayColor = Color(0xffB1B1B1);

const kNotesBackgroundTileColor = Color(0xffE1E8FF);

const kDefaultPadding = 24.0;

final kShadow1 = [
  BoxShadow(
    color: const Color(0xff000000).withOpacity(0.05),
    offset: const Offset(0, 4),
    blurRadius: 6,
    spreadRadius: 0.2,
  ),
];

const kConnectionFailTitle = "Internet disconnected";
const kConnectionFailMessage = "Connect your phone with the internet";

const kFontweightBold = FontWeight.w700;
const kFontweightSemiBold = FontWeight.w600;
const kFontweightRegular = FontWeight.w400;
const kFontweightLight = FontWeight.w300;

const List<String> pastQuestions = [
  "Apa pencapaian terbesar Anda di masa lalu?",
  "Bagaimana Anda mencapai pencapaian tersebut?",
  "Apa yang Anda pelajari dari pengalaman itu?",
  "Rintangan apa yang Anda hadapi dan bagaimana Anda mengatasinya?",
  "Bagaimana pencapaian tersebut memengaruhi hidup Anda?",
];

const List<String> presentQuestions = [
  "Apa tujuan Anda saat ini?",
  "Seberapa besar kemajuan yang telah Anda capai dalam mencapai tujuan tersebut?",
  "Apa yang Anda lakukan dengan baik?",
  "Apa yang dapat Anda lakukan untuk meningkatkan diri?",
  "Apa yang membuat Anda termotivasi untuk mencapai tujuan Anda?",
  "Apa saja rintangan yang Anda hadapi saat ini?",
  "Bagaimana Anda berencana untuk mengatasi rintangan tersebut?",
];

const List<String> futureQuestions = [
  "Apa yang ingin Anda capai di masa depan?",
  "Bagaimana Anda akan mencapai tujuan tersebut?",
  "Apa yang Anda butuhkan untuk mencapai tujuan tersebut?",
  "Apa yang Anda harapkan dari diri Anda di masa depan?",
  "Bagaimana Anda ingin orang lain mengingat Anda?",
];
