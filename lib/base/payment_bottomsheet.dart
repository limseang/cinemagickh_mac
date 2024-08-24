//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:miss_planet/controller/auth_controller.dart';
// //
// import 'package:miss_planet/util/style.dart';
//
// class PaymentSheet {
//
//   static void show({required int amount}){
//      showModalBottomSheet(
//         context: Get.context!,
//         isScrollControlled: true,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//                 ),
//                 height: Get.height * 0.4,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 8,),
//                     Container(
//                       width: 40,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(2)
//                       ),
//                     ),
//                     const SizedBox(height: 10,),
//                     Text("Payment Options", style: textStyleBold.copyWith(fontSize: 16),),
//                     const SizedBox(height: 10,),
//                     paymentHolder("paypal (1)", "Paypal Card",size: 60,amount: amount),
//                     paymentHolder("apple-pay", "Apple pay", color: Colors.white, size: 40,amount: amount),
//                     const SizedBox(height: 10,),
//                   ],)
//               ),
//             );
//           }
//         ));
//   }
//
//   static paymentHolder(String image, String title, {bool isSeleted = false, Color? color, double? size, required int amount}){
//     return  InkWell(
//       onTap: () async{
//         await Get.find<AuthController>().requestTopUp(currencyId: 1, amount: amount, type: 'PayPal',packageID: '7').then((value) async {
//           if(value == 'ok'){
//             Navigator.of(Get.context!).push(MaterialPageRoute(
//               builder: (BuildContext context) => PaypalCheckoutView(
//                 sandboxMode: true,
//                 clientId: "AVZatZhCTvbvH1fR61RJxjcxqKWjXPqipDiJAVfw6ZFdyxA6ESUgZiPnKOWTIOhWPP5D3bZkPp9zHfDX",
//                 secretKey: "ELpoqg9uYOHV0gmI4T7ORtb3eYJolVepFQgLaqWVR60lUfdswRUd_dIouMGaehgv15rVSBN-EreMNjiA",
//                 transactions:  [
//                   {
//                     "amount": {
//                       "total": '$amount',
//                       "currency": "USD",
//                     },
//                     "description": "Miss Planet App",
//
//                   }
//                 ],
//                 note: "Contact us for any questions on your order.",
//                 onSuccess: (Map params) async {
//                   print(params);
//                   Get.find<AuthController>().verifyToUpUp();
//
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 },
//                 onError: (error) {
//                   Get.find<AuthController>().cancelTopUp();
//                   Navigator.pop(context);
//                 },
//                 onCancel: () {
//                   Get.find<AuthController>().cancelTopUp();
//                   Navigator.pop(context);
//                 },
//               ),
//             ));
//
//           }
//
//         });
//
//
//       },
//       child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             height: 60,
//             // margin: const EdgeInsets.symmetric(vertical: 10),
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//               // color: Colors.white.withOpacity(0.1),
//               border: Border.all(color: Colors.grey.withOpacity(0.3)),
//               borderRadius: BorderRadius.circular(4)
//             ),
//             child: Row(
//               children: [
//                  Image(image: AssetImage("assets/images/$image.png"), height: size ?? 60, color: color,),
//                  SizedBox(width: 10,),
//                 // const Spacer(),
//                 // Container(
//                 //         width: 20,
//                 //         height: 20,
//                 //         decoration: BoxDecoration(
//                 //           color: Colors.white.withOpacity(0.3),
//                 //           borderRadius: BorderRadius.circular(10)
//                 //         ),
//                 //         child: const Icon(Icons.check, color: Colors.white, size: 12,),
//                 //       )
//               ],
//             ),
//           ),
//         ),
//     );
//   }
// }