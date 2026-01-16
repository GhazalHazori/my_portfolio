// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart' as cs;
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:new_store/core/data/models/cart_item.dart';
// import 'package:new_store/core/data/models/product_model.dart';
// import 'package:new_store/main.dart';
// import 'package:new_store/ui/shared/colors.dart';
// import 'package:new_store/ui/shared/custom_widgets/custom_cursor.dart';
// import 'package:new_store/ui/shared/utlis.dart';
// import 'package:new_store/ui/views/collection_view/collection_view.dart';
// import 'package:new_store/ui/views/product_details/product_details_controller.dart';
// import 'package:new_store/ui/views/review_view/review_view.dart';
// import 'package:share_plus/share_plus.dart';

// class ProductDetailsPage extends StatefulWidget {
//   const ProductDetailsPage({super.key, required this.id});
//   final String id;

//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   late ProductDetailsController controller;
//   final Map<int, RxInt> sliderIndex = {};

//   final TextEditingController _controller = TextEditingController(text: "1");
//   final FocusNode _focusNode = FocusNode();

//   int get quantity {
//     final value = int.tryParse(_controller.text);
//     return (value != null && value > 0) ? value : 1;
//   }

//   void _increase() {
//     setState(() {
//       _controller.text = (quantity + 1).toString();
//     });
//   }

//   void _decrease() {
//     if (quantity > 1) {
//       setState(() {
//         _controller.text = (quantity - 1).toString();
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(ProductDetailsController(widget.id));
//     _focusNode.addListener(() {
//       // لما المستخدم يترك الحقل (يفقد التركيز)
//       if (!_focusNode.hasFocus) {
//         if (int.tryParse(_controller.text) == null ||
//             _controller.text.isEmpty ||
//             int.parse(_controller.text) <= 0) {
//           setState(() {
//             _controller.text = "1";
//           });
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whitecolor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: Container(
//           width: screenWidth(3),
//           margin: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: AppColors.whitecolor,
//             shape: BoxShape.circle,
//             border: Border.all(color: AppColors.greySign),
//           ),
//           child: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Icon(Icons.arrow_back, color: AppColors.mainNewStoreColor),
//           ),
//         ),
//         title: Text(
//           "Product Details",
//           style: TextStyle(
//             color: AppColors.mainNewStoreColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [Obx(() {
//   final product = controller.productDetails.value;

//   return GestureDetector(
//     onTap: () async {
//       if (product.inWishlist == true) {
//         // حذف من المفضلة
//         final result = await controller.removefromWish(id_product: product.id!);
//         result.fold(
//           (error) => print(error),
//           (success) {
//           product.inWishlist = !product.inWishlist!;
// controller.productDetails.refresh();
//  // ✅ ضروري لتحديث الواجهة
//           },
//         );
//       } else {
//         // إضافة للمفضلة
//         final result = await controller.addtowish(id_product: product.id!);
//         result.fold(
//           (error) => print(error),
//           (success) {
//             product.inWishlist = !product.inWishlist!;
// controller.productDetails.refresh();
//  // ✅ ضروري لتحديث الواجهة
//           },
//         );
//       }
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           border: Border.all(color: AppColors.greySign),
//         ),
//         child: Icon(
//           product.inWishlist == true ? Icons.favorite : Icons.favorite_border,
//           color: product.inWishlist == true
//               ? AppColors.redcolor
//               : AppColors.redcolor.withOpacity(0.5),
//         ),
//       ),
//     ),
//   );
// })



//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Obx(() {
//             final product = controller.productDetails.value;
//             final selectedVariant = controller.selectedVariant.value;
//             final more = controller.productDetailsMore.value;

//             final collection = more.collection;
//             final comments = more.comments ?? [];
//             final similar = more.similarProducts ?? [];

//             String selectedColorName = '';
//             if (selectedVariant?.attributes != null) {
//               final colorAttr = selectedVariant!.attributes!.firstWhere(
//                 (a) => (a.name?.toLowerCase() ?? '').contains('color'),
//                 orElse: () => VariantAttributes(name: '', values: []),
//               );
//               if (colorAttr.values != null && colorAttr.values!.isNotEmpty) {
//                 selectedColorName = colorAttr.values!.first.toString();
//               }
//             }

//             if (product.id == null) {
//               return Center(child: CircularProgressIndicator());
//             }

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Search + Top button
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 16,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.shade300,
//                               blurRadius: 6,
//                               offset: const Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: const [
//                             Icon(Icons.search, color: Colors.grey, size: 24),
//                             SizedBox(width: 10),
//                             Text(
//                               "Search for the product you want...",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Container(
//                       height: screenHeight(15),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 14,
//                         vertical: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade300,
//                             blurRadius: 6,
//                             offset: const Offset(2, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: const [
//                           Icon(
//                             Icons.keyboard_arrow_up,
//                             color: Colors.grey,
//                             size: 10,
//                           ),
//                           SizedBox(height: 1),
//                           Text(
//                             "Top",
//                             style: TextStyle(color: Colors.grey, fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 screenHeight(40).ph,

//                 /// Product name + rating
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product.name?.en ?? '',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             product.description?.en ?? '',
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.star, color: Colors.orange, size: 20),
//                         const SizedBox(width: 4),
//                         Text(
//                           "${product.averageRating?.toStringAsFixed(1) ?? '0'} (${product.variants?.length})",
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 /// Product main image
//                 Column(
//                   children: [
//                     Center(
//                       child:
//                           selectedVariant != null &&
//                                   selectedVariant.images!.isNotEmpty
//                               ? CachedNetworkImage(
//                                 imageUrl:
//                                     selectedVariant
//                                         .images![controller
//                                             .selectedImageIndex
//                                             .value]
//                                         .url ??
//                                     '',
//                                 height: 250,
//                                 width: 200,
//                                 fit: BoxFit.contain,
//                               )
//                               : SvgPicture.asset(
//                                 "assets/images/product_details.svg",
//                                 height: 250,
//                               ),
//                     ),
//                     Positioned(
//                       top: 150 + 16,
//                       left: 0,
//                       right: 0,
//                       child: Stack(
//                         alignment: AlignmentDirectional.bottomCenter,
//                         children: [
//                           Center(
//                             child: SvgPicture.asset(
//                               "assets/images/circle.svg",
//                               width: 200,
//                               height: 40,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           Positioned(
//                             child: Container(
//                               width: 60,
//                               height: 20,
//                               decoration: BoxDecoration(
//                                 color: Colors.orange,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () => controller.previousImage(),
//                                     child: Icon(
//                                       Icons.arrow_left,
//                                       color: Colors.white,
//                                       size: 16,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   GestureDetector(
//                                     onTap: () => controller.nextImage(),
//                                     child: Icon(
//                                       Icons.arrow_right,
//                                       color: Colors.white,
//                                       size: 16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 /// Thumbnails
//                 if (selectedVariant != null)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           height: 60,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: selectedVariant.images?.length ?? 0,
//                             itemBuilder: (context, index) {
//                               final img = selectedVariant.images![index];
//                               return GestureDetector(
//                                 onTap: () {
//                                   controller.selectImage(index);
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(
//                                     horizontal: 4,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color:
//                                           controller.selectedImageIndex.value ==
//                                                   index
//                                               ? AppColors.mainNewStoreColor
//                                               : Colors.grey,
//                                     ),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: CachedNetworkImage(
//                                     imageUrl: img.url ?? '',
//                                     width: screenWidth(5),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 60,
//                         height: 60,
//                         margin: const EdgeInsets.only(left: 10),
//                         decoration: BoxDecoration(
//                           color: AppColors.secondaryNewStoreColor,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "+1",
//                             style: TextStyle(
//                               color: AppColors.whitecolor,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 const SizedBox(height: 20),

//                 /// Variants + Color + Price + Stock
//                 Text(
//                   "Color: ${selectedColorName.isNotEmpty ? selectedColorName : ''}",
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 SizedBox(
//                   height: 130,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: product.variants?.length,
//                     itemBuilder: (context, index) {
//                       final variant = product.variants?[index];
//                       final isSelected = variant?.id == selectedVariant?.id;

//                       String variantColor = '';
//                       if (variant?.attributes != null) {
//                         final colorAttr = variant!.attributes!.firstWhere(
//                           (a) =>
//                               (a.name?.toLowerCase() ?? '').contains('color'),
//                           orElse: () => VariantAttributes(name: '', values: []),
//                         );
//                         if (colorAttr.values != null &&
//                             colorAttr.values!.isNotEmpty) {
//                           variantColor = colorAttr.values!.first.toString();
//                         }
//                       }

//                       return GestureDetector(
//                         onTap: () {
//                           controller.selectVariant(variant);
//                           controller.selectImage(0);
//                         },
//                         child: Container(
//                           width: 130,
//                           margin: const EdgeInsets.only(right: 12),
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: isSelected ? Colors.purple : Colors.grey,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                              product.variants?[index].images != null &&
// product.variants![index].images!.isNotEmpty
//     ? CachedNetworkImage(
//         imageUrl: product.variants![index].images!.first.url ?? '',
//         height: 60,
//         fit: BoxFit.cover,
//       )
//     : const SizedBox(),

//                               const SizedBox(height: 5),
//                               Text(
//                                 variantColor,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: AppColors.greyDotsIndicator,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               Text("${variant?.finalPrice} SYP"),
//                               Text(
//                                 "Stock: ${variant?.amount}",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color:
//                                       variant?.amount != null &&
//                                               variant!.amount! > 0
//                                           ? Colors.green
//                                           : Colors.red,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 /// باقي التفاصيل مثل Attributes, Price, Quantity, Add to cart, Reviews, Similar products
//                 /// تم الاحتفاظ بها كما هي في الكود الأصلي
//                 if (product.attributes != null &&
//                     product.attributes!.isNotEmpty)
//                   Obx(
//                     () => Column(
//                       children:
//                           product.attributes!.map((attr) {
//                             final selectedValue =
//                                 controller.selectedAttributes[attr.name ?? ''];
//                             AttributeValue? selectedVal;
//                             if (attr.values != null && selectedValue != null) {
//                               selectedVal = attr.values!.firstWhere(
//                                 (v) => v.value == selectedValue,
//                                 orElse: () => AttributeValue(),
//                               );
//                               if (selectedVal.value == null) selectedVal = null;
//                             }

//                             return Column(
//                               children: [
//                                 ExpansionTile(
//                                   title: Text(
//                                     "${attr.name ?? ''}${selectedVal != null ? ': ${selectedVal!.value}' : ''}",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   children: [
//                                     if (attr.values != null &&
//                                         attr.values!.isNotEmpty)
//                                       Wrap(
//                                         spacing: 8,
//                                         children:
//                                             attr.values!.map((val) {
//                                               final isSelected =
//                                                   controller
//                                                       .selectedAttributes[attr
//                                                           .name ??
//                                                       ''] ==
//                                                   val.value;
//                                               return ChoiceChip(
//                                                 label: Text(val.value ?? ''),
//                                                 selected: isSelected,
//                                                 onSelected: (selected) {
//                                                   if (selected) {
//                                                     controller
//                                                             .selectedAttributes[attr
//                                                                 .name ??
//                                                             ''] =
//                                                         val.value ?? '';
//                                                     controller
//                                                         .selectVariantByAttribute(
//                                                           attr.name ?? "",
//                                                           val.value ?? "",
//                                                         );
//                                                   } else {
//                                                     controller
//                                                         .selectedAttributes
//                                                         .remove(
//                                                           attr.name ?? '',
//                                                         );
//                                                   }
//                                                 },
//                                               );
//                                             }).toList(),
//                                       ),
//                                   ],
//                                 ),
//                                 // const Divider(),
//                               ],
//                             );
//                           }).toList(),
//                     ),
//                   ),

//                 const SizedBox(height: 10),

//                 if (selectedVariant != null)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Price: ${selectedVariant?.finalPrice ?? 'N/A'} SYP",
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         "Available: ${selectedVariant?.amount ?? 'N/A'}",
//                         style: TextStyle(
//                           color: AppColors.thirdNewStoreColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                 const SizedBox(height: 20),

//                 // كمية المنتج
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 8,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // حقل الكتابة بدلاً من النص الثابت
//                             Row(
//                               children: [
//                                 Text(
//                                   "Quantity: ",
//                                   style: TextStyle(color: AppColors.greySign),
//                                 ),
//                                 SizedBox(
//                                   width: 20,
//                                   height: 25,
//                                   child: TextField(
//                                     controller: _controller,
//                                     focusNode: _focusNode,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(color: AppColors.greySign),
//                                     keyboardType: TextInputType.number,
//                                     decoration: const InputDecoration(
//                                       isDense: true,
//                                       contentPadding: EdgeInsets.zero,
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             // أزرار + و -
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: _decrease,
//                                   child: Container(
//                                     width: screenWidth(15),
//                                     decoration: BoxDecoration(
//                                       color: AppColors.secondaryNewStoreColor,
//                                       shape: BoxShape.rectangle,
//                                       border: Border.all(
//                                         color: AppColors.secondaryNewStoreColor,
//                                       ),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Icon(
//                                       Icons.remove,
//                                       color: AppColors.whitecolor,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 GestureDetector(
//                                   onTap: _increase,
//                                   child: Container(
//                                     width: screenWidth(15),
//                                     decoration: BoxDecoration(
//                                       color: AppColors.secondaryNewStoreColor,
//                                       shape: BoxShape.rectangle,
//                                       border: Border.all(
//                                         color: AppColors.secondaryNewStoreColor,
//                                       ),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Icon(
//                                       Icons.add,
//                                       color: AppColors.whitecolor,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),

//                 /// Add to cart button
//               SizedBox(
//   width: double.infinity,
//   child: Obx(() => ElevatedButton.icon(
//         onPressed: controller.isLoading.value || quantity <= 0
//             ? null // زر غير نشط أثناء التحميل أو إذا الكمية صفر
//             : () {
//                 controller.requestList.add(
//                   CartItem(
//                     variantId:
//                         controller.selectedVariant.value?.id ?? 0,
//                     quantity: quantity,
//                   ),
//                 );
//                 controller.addtoCart(listItems: controller.requestList);
//               },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: controller.isLoading.value
//               ? Colors.grey // أثناء التحميل يصبح رمادي
//               : Colors.orange, // اللون الطبيعي
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//         ),
//         icon: controller.isLoading.value
//             ? const SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//             : const Icon(Icons.lock, color: Colors.white),
//         label: Text(
//           controller.isLoading.value ? "Loading..." : "Add to cart",
//           style: const TextStyle(fontSize: 18, color: Colors.white),
//         ),
//       )),
// ),

//                 // const SizedBox(height: 20),

//                 // /// Shop with confidence section
//                 // const Text(
//                 //   "Shop with confidence",
//                 //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 // ),
//                 // const SizedBox(height: 10),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   children: [
//                 //     Text(
//                 //       "🚚 7 days to return",
//                 //       style: TextStyle(color: AppColors.secondaryNewStoreColor),
//                 //     ),
//                 //     Text(
//                 //       "💵 Cash on delivery",
//                 //       style: TextStyle(color: AppColors.secondaryNewStoreColor),
//                 //     ),
//                 //   ],
//                 // ),
//                 // const SizedBox(height: 5),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   children: [
//                 //     Text(
//                 //       "🔒 Your transaction is secure",
//                 //       style: TextStyle(color: AppColors.secondaryNewStoreColor),
//                 //     ),
//                 //     Text(
//                 //       "📦 Free delivery",
//                 //       style: TextStyle(color: AppColors.secondaryNewStoreColor),
//                 //     ),
//                 //   ],
//                 // ),
//                 // const Divider(height: 10),

//                 /// More Details
//                 if (product.additionalInfo != null &&
//                     product.additionalInfo!.isNotEmpty)
//                   ExpansionTile(
//                     title: const Text("More Details"),
//                     children: [
//                       const Divider(height: 2),
//                       ...product.additionalInfo!.map((info) {
//                         return Column(
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 info.attributeName?.isNotEmpty == true
//                                     ? info.attributeName!
//                                     : "Attribute ${info.attributeId ?? ''}",
//                               ),
//                               trailing: Text(
//                                 info.value?.isNotEmpty == true
//                                     ? info.value!
//                                     : 'N/A',
//                               ),
//                             ),
//                             const Divider(height: 2),
//                           ],
//                         );
//                       }).toList(),
//                     ],
//                   ),

//                 // Get the full package
//                 // const Text(
//                 //   "Get the full package",
//                 //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 // ),
//                 const SizedBox(height: 10),
//                 if (collection != null &&
//                     collection.products != null &&
//                     collection.products!.isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Divider(height: 10),
//                       const Text(
//                         "Get the full package",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),

//                       // صف المنتجات + إشارة "+"
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           for (
//                             int i = 0;
//                             i < collection.products!.length;
//                             i++
//                           ) ...[
//                             // صورة المنتج
//                             Container(
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 color: AppColors.greyDotsIndicator.withOpacity(
//                                   0.2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: CachedNetworkImage(
//                                 imageUrl:
//                                     collection.products![i].image?.isNotEmpty ==
//                                             true
//                                         ? (collection
//                                                 .products![i]
//                                                 .image
//                                                 ?.first
//                                                 .url ??
//                                             '') //لازم هون بدال ال 1نحط first
//                                         : '',
//                                 height: 60,
//                                 width: 60,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             // إشارة +
//                             if (i < collection.products!.length - 1)
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 8),
//                                 child: Text(
//                                   "+",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 10),

//                       // السعر الإجمالي
//                       Center(
//                         child: SizedBox(
//                           width: screenWidth(1.2),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Get.to(CollectionView(collection: collection));
//                             },
//                             style: ElevatedButton.styleFrom(
//                               padding: const EdgeInsets.all(15),
//                               backgroundColor: Colors.white,
//                               side: BorderSide(
//                                 color: AppColors.mainNewStoreColor,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Buy all offer price: ",
//                                   style: TextStyle(
//                                     color: AppColors.mainNewStoreColor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   " ${collection.finalPrice ?? 'N/A'} SYP",
//                                   style: TextStyle(
//                                     color: AppColors.thirdNewStoreColor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 screenWidth(70).pw,
//                                 Icon(
//                                   Icons.arrow_forward_ios_rounded,
//                                   color: AppColors.mainNewStoreColor,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Divider(height: 30),
//                     ],
//                   ),

//                 // const SizedBox(height: 10),
//                 // Center(
//                 //   child: SizedBox(width: screenWidth(1.2),
//                 //     child: ElevatedButton(
//                 //       onPressed: () {},
//                 //       style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15),
//                 //         backgroundColor: Colors.white,
//                 //         side: BorderSide(color:  AppColors.mainNewStoreColor),
//                 //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 //       ),
//                 //       child:  Row(
//                 //         mainAxisAlignment: MainAxisAlignment.center,
//                 //         children: [
//                 //           Text(
//                 //             "Buy all offer price: ",
//                 //             style: TextStyle(color: AppColors.mainNewStoreColor, fontWeight: FontWeight.bold),
//                 //           ),
//                 //             Text(
//                 //             " 270,000 SYP",
//                 //             style: TextStyle(color: AppColors.thirdNewStoreColor, fontWeight: FontWeight.bold),
//                 //           ),screenWidth(70).pw,
//                 //           Icon(Icons.arrow_forward_ios_rounded,color: AppColors.mainNewStoreColor,)
//                 //         ],
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),

//                 /// Reviews
//            comments.isEmpty?SizedBox():      Column(
//              children: [
//                SizedBox(width: screenWidth(1),
//                  child: Text(
//                         "Some customer reviews and opinions",
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                ), const SizedBox(height: 10),
//                 const Divider(height: 3),
//              ],
//            ),
//           Column(
//   children: List.generate(
//     comments.length > 2 ? 2 : comments.length, // أقصى عنصرين
//     (index) {
//       final comment = comments[index];
//       return Column(
//         children: [
//           if (index != 0) const Divider(height: 3), // يظهر قبل التعليق الثاني فقط
//           ListTile(
//             leading: Stack(
//               alignment: AlignmentDirectional.bottomStart,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: comment.user?.image?.url != null
//                       ? NetworkImage(comment.user!.image!.url!)
//                       : null,
//                   child: comment.user?.image?.url == null
//                       ? const Icon(Icons.person)
//                       : null,
//                 ),
//                 SvgPicture.asset("assets/images/check.svg"),
//               ],
//             ),
//             title: Text(
//               comment.user?.email ?? "Unknown User",
//               style: const TextStyle(fontSize: 13),
//             ),
//             subtitle: Text(
//               comment.comment ?? "",
//               style: const TextStyle(
//                 color: Color.fromRGBO(196, 196, 196, 1),
//                 fontSize: 10,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             trailing: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 const Text(
//                   "2 months ago",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color.fromRGBO(196, 196, 196, 1),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: List.generate(
//                     5,
//                     (i) => Icon(
//                       Icons.star,
//                       color: i < (comment.rating ?? 0)
//                           ? Colors.orange
//                           : Colors.grey,
//                       size: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   ),
// )

// ,
//                 // ListTile(
//                 //   leading: Stack(
//                 //     alignment: AlignmentDirectional.bottomStart,
//                 //     children: [
//                 //       const CircleAvatar(child: Icon(Icons.person)),
//                 //       SvgPicture.asset("assets/images/check.svg"),
//                 //     ],
//                 //   ),
//                 //   title: const Text("Ragheb Muhrat"),
//                 //   subtitle: const Text(
//                 //     "This text is an example of text that can be replaced in the same space.",
//                 //     style: TextStyle(
//                 //       color: Color.fromRGBO(196, 196, 196, 1),
//                 //       fontSize: 10,
//                 //       fontWeight: FontWeight.w400,
//                 //     ),
//                 //   ),
//                 //   trailing: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.end,
//                 //     children: [
//                 //       const Text(
//                 //         "2 months ago",
//                 //         style: TextStyle(
//                 //           fontSize: 12,
//                 //           color: Color.fromRGBO(196, 196, 196, 1),
//                 //         ),
//                 //       ),
//                 //       screenHeight(40).ph,
//                 //       Row(
//                 //         mainAxisSize: MainAxisSize.min,
//                 //         children: const [
//                 //           Icon(Icons.star, color: Colors.orange, size: 16),
//                 //           Icon(Icons.star, color: Colors.orange, size: 16),
//                 //           Icon(Icons.star, color: Colors.orange, size: 16),
//                 //           Icon(Icons.star, color: Colors.orange, size: 16),
//                 //           Icon(Icons.star, color: Colors.orange, size: 16),
//                 //         ],
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // const Divider(height: 23),
//                 comments.isNotEmpty?
//                 Center(
//                   child: Column(
//                     children: [
//                       const Divider(height: 3),
//                       screenHeight(80).ph,
//                       SizedBox(
//                         width: screenWidth(1.2),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Get.to(ReviewView(productId: widget.id));
//                           },
//                           style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.all(15),
//                             backgroundColor: Colors.white,
//                             side: BorderSide(color: AppColors.mainNewStoreColor),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "View all reviews",
//                                 style: TextStyle(
//                                   color: AppColors.mainNewStoreColor,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ):SizedBox(),

//                 if (similar.isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 10),
//                       const Divider(height: 3),
//                       const SizedBox(height: 10),
//                       const Text(
//                         "Similar products",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         height: 220,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: similar.length,
//                           itemBuilder: (context, index) {
//                             final s = similar[index];
//                             sliderIndex[index] ??= 0.obs;
//                             return Container(
//                               width: screenWidth(2.5),
//                               margin: EdgeInsets.symmetric(
//                                 horizontal: screenWidth(50),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // صور المنتج
//                                   Expanded(
//                                     child: ClipRRect(
//                                       borderRadius: const BorderRadius.all(
//                                         Radius.circular(15),
//                                       ),
//                                       child: Stack(
//                                         children: [
//                                           cs.CarouselSlider(
//                                             items:
//                                                 s.image?.map((img) {
//                                                   return CachedNetworkImage(
//                                                     imageUrl: img.url ?? '',
//                                                     fit: BoxFit.cover,
//                                                     width: double.infinity,
//                                                   );
//                                                 }).toList(),
//                                             options: cs.CarouselOptions(
//                                               height: double.infinity,
//                                               viewportFraction: 1.0,
//                                               enableInfiniteScroll: false,
//                                               enlargeCenterPage: false,
//                                               onPageChanged: (i, reason) {
//                                                 sliderIndex[index]!.value = i;
//                                               },
//                                             ),
//                                           ),
//                                           Positioned(
//                                             bottom: 8,
//                                             left: 0,
//                                             right: 0,
//                                             child: Obx(() {
//                                               return DotsIndicator(
//                                                 dotsCount: s.image?.length ?? 1,
//                                                 position:
//                                                     sliderIndex[index]!.value
//                                                         .toDouble(),
//                                                 decorator: DotsDecorator(
//                                                   size: const Size(6, 6),
//                                                   activeSize: const Size(8, 8),
//                                                   color: Colors.grey
//                                                       .withOpacity(0.5),
//                                                   activeColor:
//                                                       AppColors
//                                                           .mainNewStoreColor,
//                                                 ),
//                                               );
//                                             }),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),

//                                   // تفاصيل المنتج
//                                   Padding(
//                                     padding: EdgeInsets.all(screenWidth(50)),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           s.name ?? "",
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: screenWidth(30),
//                                           ),
//                                         ),
//                                         SizedBox(height: 5),
//                                         Text(
//                                           "\$${s.price}",
//                                           style: TextStyle(
//                                             color: AppColors.mainNewStoreColor,
//                                             fontSize: screenWidth(28),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         // if (product.oldPrice != null)
//                                         //   Row(
//                                         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         //     children: [
//                                         //       Text(
//                                         //         "\$${product.oldPrice}",
//                                         //         style: TextStyle(
//                                         //           color: AppColors.thirdNewStoreColor,
//                                         //           fontSize: screenWidth(32),
//                                         //           decoration: TextDecoration.lineThrough,
//                                         //           decorationColor: AppColors.greycolor,
//                                         //         ),
//                                         //       ),
//                                         //       SizedBox(width: 6),
//                                         //       Container(
//                                         //         padding: const EdgeInsets.all(2),
//                                         //         decoration: BoxDecoration(
//                                         //           borderRadius: BorderRadius.circular(5),
//                                         //           color: AppColors.greycolor.withOpacity(0.2),
//                                         //         ),
//                                         //         child: Text(
//                                         //           "-${product.discount ?? 0}%",
//                                         //           style: const TextStyle(
//                                         //             color: Colors.red,
//                                         //             fontWeight: FontWeight.bold,
//                                         //           ),
//                                         //         ),
//                                         //       ),
//                                         //     ],
//                                         //   ),
//                                         SizedBox(height: 8),
//                                         SizedBox(
//                                           width: double.infinity,
//                                           child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor:
//                                                   AppColors.mainNewStoreColor,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                               ),
//                                             ),
//                                             onPressed: () {},
//                                             child: Text(
//                                               "add to cart",
//                                               style: TextStyle(
//                                                 color: AppColors.whitecolor,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),

//                 /// كمية المنتج و Add to cart
//                 // ... تبقى كما هي بدون تعديل
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
