// import 'package:flutter/material.dart';
// import 'package:currency_converter/core/extension/extensions.dart';
// import 'package:shimmer/shimmer.dart';

// class InterestsPlaceholder extends StatelessWidget {
//   const InterestsPlaceholder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       enabled: true,
//       child: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 1,
//         ),
//         itemCount: 18,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               Material(
//                 shape: ContinuousRectangleBorder(
//                   borderRadius: BorderRadius.circular(60),
//                 ),
//                 clipBehavior: Clip.antiAlias,
//                 child: const SizedBox(
//                   height: 80,
//                   width: 80,
//                 ),
//               ),
//               5.heightBox,
//               Container(
//                 height: 5,
//                 width: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
