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
  // in english
  "What is your biggest achievement in the past?",
  "How did you achieve that achievement?",
  "What did you learn from that experience?",
  "What obstacles did you face and how did you overcome them?",
  "How did that achievement affect your life?",
  // "Apa pencapaian terbesar Anda di masa lalu?",
  // "Bagaimana Anda mencapai pencapaian tersebut?",
  // "Apa yang Anda pelajari dari pengalaman itu?",
  // "Rintangan apa yang Anda hadapi dan bagaimana Anda mengatasinya?",
  // "Bagaimana pencapaian tersebut memengaruhi hidup Anda?",
];

const List<String> presentQuestions = [
  // in english
  "What is your current goal?",
  "How much progress have you made in achieving that goal?",
  "What are you doing well?",
  "What can you do to improve yourself?",
  "What motivates you to achieve your goal?",
  "What obstacles are you facing right now?",
  "How do you plan to overcome those obstacles?",
  // "Apa tujuan Anda saat ini?",
  // "Seberapa besar kemajuan yang telah Anda capai dalam mencapai tujuan tersebut?",
  // "Apa yang Anda lakukan dengan baik?",
  // "Apa yang dapat Anda lakukan untuk meningkatkan diri?",
  // "Apa yang membuat Anda termotivasi untuk mencapai tujuan Anda?",
  // "Apa saja rintangan yang Anda hadapi saat ini?",
  // "Bagaimana Anda berencana untuk mengatasi rintangan tersebut?",
];

const List<String> futureQuestions = [
  // in english
  "What do you want to achieve in the future?",
  "How will you achieve that goal?",
  "What do you need to achieve that goal?",
  "What do you expect from yourself in the future?",
  "How do you want others to remember you?",
  // "Apa yang ingin Anda capai di masa depan?",
  // "Bagaimana Anda akan mencapai tujuan tersebut?",
  // "Apa yang Anda butuhkan untuk mencapai tujuan tersebut?",
  // "Apa yang Anda harapkan dari diri Anda di masa depan?",
  // "Bagaimana Anda ingin orang lain mengingat Anda?",
];
