// import 'package:chat_app/common.dart';
// import 'package:chat_app/repository/auth_repository.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';

// class PhoneNumberInputPage extends StatelessWidget {
//   PhoneNumberInputPage({super.key});
//   CountryCode? countryCode;

//   TextEditingController phoneNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: defaultBgColor,
//       body: Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           SizedBox(height: 60),
//           SizedBox(
//             width: 250,
//             child: Text(
//               "What's your number?",
//               style: TextStyle(
//                 fontSize: 35,
//                 fontWeight: FontWeight.w800,
//                 color: mainRedColor,
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           SizedBox(
//             width: 300,
//             child: Text(
//               'Please enter your valid phone number.We will send you 4-digit code to verify your account.',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           SizedBox(height: 40),
//           Row(
//             children: [
//               countryCodeWidget(),
//               SizedBox(width: 20),
//               SizedBox(
//                 width: 200,
//                 child: TextFormField(
//                     controller: phoneNumberController,
//                     keyboardType: TextInputType.number),
//               )
//             ],
//           ),
//           SizedBox(height: 60),
//           Center(
//               child: SizedBox(
//                   width: 260,
//                   height: 55,
//                   child: ElevatedButton(
//                       onPressed: () {
//                         print(
//                             'country code : ${countryCode?.code} , number: ${phoneNumberController.text}');
//                         if (phoneNumberController.text != null &&
//                             countryCode?.dialCode != null) {
//                           String phone =
//                               "${countryCode?.dialCode}${phoneNumberController.text}";
//                           AuthRepository.signInWithPhone(phone);
//                           print('...............signin called');
//                         } else {
//                           if (countryCode == null) {
//                             String phone = "+91${phoneNumberController.text}";
//                             AuthRepository.signInWithPhone(phone);
//                             print('...............signin called');
//                             print('...country code null');
//                           }
//                         }
//                         Navigator.pushNamed(context,
//                             '/LoginPage/PhoneNumberInputPage/OtpVerificationPage');
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: mainRedColor,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12.0))),
//                       child: Text(
//                         'Continue',
//                         style: TextStyle(fontSize: 18),
//                       )))),
//         ]),
//       ),
//     );
//   }

//   countryCodeWidget() {
//     return CountryCodePicker(
//       onChanged: (code) {
//         countryCode = code;

//         print(
//             '.........country name : ${countryCode?.name} dial code: ${countryCode?.dialCode} country code: ${countryCode?.code}');
//       },
//       // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//       initialSelection: 'IN',
//       showCountryOnly: false,
//       // optional. Shows only country name and flag when popup is closed.
//       showOnlyCountryWhenClosed: false,
//       // optional. aligns the flag and the Text left
//       alignLeft: false,
//     );
//   }
// }
