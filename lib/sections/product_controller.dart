// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:new_store/core/data/models/cart_item.dart' show CartItem;
// import 'package:new_store/core/data/models/product_details_more.dart';
// import 'package:new_store/core/data/models/product_model.dart';
// import 'package:new_store/core/data/repositories/cart_repository.dart';
// import 'package:new_store/core/data/repositories/product_details_repository.dart';
// import 'package:new_store/core/data/repositories/wishe_repository.dart';
// import 'package:new_store/core/enums/message_type.dart';
// import 'package:new_store/core/enums/operation_type.dart';
// import 'package:new_store/core/services/base_controller.dart';
// import 'package:new_store/ui/shared/colors.dart';
// import 'package:new_store/ui/shared/custom_widgets/custom_toast.dart';

// class ProductDetailsController extends BaseControoler {
//   String id_product = '';

//   ProductDetailsController(String id) {
//     id_product = id;
//   }

//   // المنتج نفسه
//   Rx<ProductModel> productDetails = ProductModel().obs;
// Rx<ProductDetailsResponse> productDetailsMore = ProductDetailsResponse().obs;
//   // الفاريانت المختار حالياً
//   Rxn<Variants> selectedVariant = Rxn<Variants>();

//   // الفهرس المختار للصورة داخل الفاريانت
//   RxInt selectedImageIndex = 0.obs;

//   // الكمية المختارة
//   RxInt quantity = 1.obs;

//   // RequestOptions
//   RxString selectedPower = '220W'.obs;
//   RxString selectedSize = 'S'.obs;
//   RxString selectedCapacity = '256GB'.obs;

//   // Selected attributes for bidirectional sync
//   RxMap<String, String> selectedAttributes = <String, String>{}.obs;

//   // Available attribute values based on current selections
//   RxMap<String, List<String>> availableAttributeValues = <String, List<String>>{}.obs;

//   /// جلب تفاصيل المنتج من الريبو
//   Future<void> getProductDetails({required String id}) async {
//     runLoadingFutureFunction(
//       type: OperationType.CATEGORY,
//       function: ProductDetailsRepository().getProductDetails(id: id).then((value) {
//         value.fold(
//           (l) {
//             // يمكن عرض رسالة خطأ هنا
//             // CustomToast.showMessage(message: l, messagetype: MessagType.REJECTED);
//           },
//           (r) {
//             productDetails.value = r;

//             // اختيار الفاريانت الأول تلقائياً إذا موجود
//             if (r.variants != null && r.variants!.isNotEmpty) {
//               selectVariant(r.variants!.first);
//             }

//             _updateAvailableValues();
//           },
//         );
//       }),
//     );
//   }
//   Future<void> getProductDetailsMore({required String id}) async {
//     runLoadingFutureFunction(
//       type: OperationType.CATEGORY,
//       function: ProductDetailsRepository().getProductDetailsMore(id: id).then((value) {
//         value.fold(
//           (l) {
//             // يمكن عرض رسالة خطأ هنا
//             // CustomToast.showMessage(message: l, messagetype: MessagType.REJECTED);
//           },
//           (r) {
//             productDetailsMore.value = r;

//             // اختيار الفاريانت الأول تلقائياً إذا موجود
//             // if (r.variants != null && r.variants!.isNotEmpty) {
//             //   selectedVariant.value = r.variants!.first;
//             //   selectedImageIndex.value = 0;
//             // }
//           },
//         );
//       }),
//     );
//   }
// final List<CartItem> requestList = [];
//   var isLoading = false.obs; // حالة التحميل

//   Future<void> addtoCart({required List<CartItem> listItems}) async {
//     isLoading.value = true; // بدء التحميل
//     runLoadingFutureFunction(
//       type: OperationType.SLIDER,
//       function: CartRepository().addTocart(requestCart: listItems).then((value) {
//         value.fold(
//           (l) {
//             CustomToast.showMessage(
//               message: l,
//               messageType: MessagType.REJECTED,
//             );
//           },
//           (r) {
//             CustomToast.showMessage(
//               message: "succed",
//               messageType: MessagType.SUCCSESS,
//             );
//           },
//         );
//       }).whenComplete(() {
//         isLoading.value = false; // انتهاء التحميل
//       }),
//     );
//   }
  
//  addtowish({required int id_product}) {
//   runFullLoadingFunction(
//     function: WisheRepository()
//         .addtowish(product_id: id_product)
//         .then(
//           (value) => value.fold(
//             (l) {
//               // رسالة خطأ
//               print(l);
//               print(id_product);
//               Flushbar(
//                 title: "Error",
//                 message: "Something went wrong",
//                 duration: const Duration(seconds: 4),
//                 flushbarPosition: FlushbarPosition.BOTTOM,
//                 backgroundColor: Colors.redAccent,
//                 margin: const EdgeInsets.all(8),
//                 borderRadius: BorderRadius.circular(12),
//                 icon: const Icon(Icons.error, color: Colors.white),
//                 leftBarIndicatorColor: Colors.white,
//               ).show(Get.context!);
//             },
//             (r) {productDetails.value.inWishlist = true;
//             productDetails.refresh();
            
//               // رسالة نجاح
//               Flushbar(
//                 title: "added",
//                 message: "add to your favorite",
//                 duration: const Duration(seconds: 3),
//                 flushbarPosition: FlushbarPosition.BOTTOM,
//                 backgroundColor: AppColors.secondaryNewStoreColor,
//                 margin: const EdgeInsets.all(8),
//                 borderRadius: BorderRadius.circular(12),
//                 icon: const Icon(Icons.check_circle, color: Colors.white),
//                 leftBarIndicatorColor: Colors.white,
//               ).show(Get.overlayContext!);
//             },
//           ),
//         ),
//   );
// }
//  removefromWish({required int id_product}) {
//   runFullLoadingFunction(
//     function: WisheRepository()
//         .removefromWish(product_id: id_product)
//         .then(
//           (value) => value.fold(
//             (l) {
//               // رسالة خطأ
//               Flushbar(
//                 title: "Error",
//                 message: "Something went wrong",
//                 duration: const Duration(seconds: 4),
//                 flushbarPosition: FlushbarPosition.BOTTOM,
//                 backgroundColor: Colors.redAccent,
//                 margin: const EdgeInsets.all(8),
//                 borderRadius: BorderRadius.circular(12),
//                 icon: const Icon(Icons.error, color: Colors.white),
//                 leftBarIndicatorColor: Colors.white,
//               ).show(Get.context!);
//             },
//             (r) {productDetails.value.inWishlist = false;productDetails.refresh();
//               // رسالة نجاح
//               Flushbar(
//                 title: "removed",
//                 message: "remove from your favorite",
//                 duration: const Duration(seconds: 3),
//                 flushbarPosition: FlushbarPosition.BOTTOM,
//                 backgroundColor: AppColors.secondaryNewStoreColor,
//                 margin: const EdgeInsets.all(8),
//                 borderRadius: BorderRadius.circular(12),
//                 icon: const Icon(Icons.check_circle, color: Colors.white),
//                 leftBarIndicatorColor: Colors.white,
//               ).show(Get.overlayContext!);
//             },
//           ),
//         ),
//   );
// }
//   /// اختيار فاريانت
//   void selectVariant(Variants? variant) {
//     if (variant != null) {
//       selectedVariant.value = variant;
//       selectedImageIndex.value = 0; // إعادة ضبط الصورة عند تغيير الفاريانت

//       // Update selectedAttributes based on variant attributes
//       selectedAttributes.clear();
//       if (variant.attributes != null) {
//         for (var attr in variant.attributes!) {
//           if (attr.values != null && attr.values!.isNotEmpty) {
//             selectedAttributes[attr.name ?? ''] = attr.values!.first.valueLabel ?? '';
//           }
//         }
//       }

//       _updateAvailableValues();
//     }
//   }

//   /// اختيار صورة من داخل الفاريانت
//   void selectImage(int index) {
//     selectedImageIndex.value = index;
//   }

//   /// زيادة الكمية
//   void increaseQuantity() {
//     quantity.value++;
//   }

//   /// تقليل الكمية
//   void decreaseQuantity() {
//     if (quantity.value > 1) {
//       quantity.value--;
//     }
//   }

//   /// اختيار Power
//   void selectPower(String power) {
//     selectedPower.value = power;
//   }
// void selectVariantByAttribute(String attributeName, String value) {
//   selectedAttributes[attributeName] = value;

//   final product = productDetails.value;
//   if (product.variants == null) return;

//   // Find variant that matches all selectedAttributes
//   final match = product.variants!.firstWhere(
//     (v) => selectedAttributes.entries.every((entry) =>
//         v.attributes!.any((attr) =>
//             attr.name?.toLowerCase() == entry.key.toLowerCase() &&
//             attr.values != null &&
//             attr.values!.any((val) =>
//                 val.valueLabel?.toLowerCase() == entry.value.toLowerCase()))),
//     orElse: () => product.variants!.firstWhere(
//       (v) => v.attributes!.any((attr) =>
//           attr.name?.toLowerCase() == attributeName.toLowerCase() &&
//           attr.values != null &&
//           attr.values!.any((val) =>
//               val.valueLabel?.toLowerCase() == value.toLowerCase())),
//       orElse: () => product.variants!.first,
//     ),
//   );

//   selectedVariant.value = match;
//   selectedImageIndex.value = 0;

//   _updateAvailableValues();
// }


//   /// اختيار Size
//   void selectSize(String size) {
//     selectedSize.value = size;
//   }

//   /// اختيار Capacity
//   void selectCapacity(String capacity) {
//     selectedCapacity.value = capacity;
//   }

//   void _updateAvailableValues() {
//     availableAttributeValues.value = getAvailableAttributeValues();
//   }

//   /// Get available values for each attribute based on current selections
//   Map<String, List<String>> getAvailableAttributeValues() {
//     final product = productDetails.value;
//     if (product.attributes == null || product.variants == null) return {};

//     Map<String, List<String>> available = {};

//     for (var attr in product.attributes!) {
//       available[attr.name ?? ''] = [];
//       Set<String> uniqueValues = {};

//       for (var val in attr.values ?? []) {
//         String valueLabel = val.value ?? '';

//         // Check if there is a variant that matches this value and all other selected attributes
//         bool isAvailable = product.variants!.any((v) {
//           bool hasThisAttr = v.attributes?.any((va) =>
//             va.name?.toLowerCase() == attr.name?.toLowerCase() &&
//             va.values?.any((vv) => vv.valueLabel?.toLowerCase() == valueLabel.toLowerCase()) == true
//           ) ?? false;

//           if (!hasThisAttr) return false;

//           // Check all other selected attributes are matched
//           return selectedAttributes.entries.where((e) => e.key.toLowerCase() != attr.name?.toLowerCase()).every((e) =>
//             v.attributes?.any((va) =>
//               va.name?.toLowerCase() == e.key.toLowerCase() &&
//               va.values?.any((vv) => vv.valueLabel?.toLowerCase() == e.value.toLowerCase()) == true
//             ) ?? false
//           );
//         });

//         if (isAvailable && !uniqueValues.contains(valueLabel)) {
//           uniqueValues.add(valueLabel);
//           available[attr.name ?? '']!.add(valueLabel);
//         }
//       }
//     }

//     return available;
//   }

//   void nextImage() {
//     if (selectedVariant.value != null &&
//         selectedVariant.value!.images != null &&
//         selectedImageIndex.value < selectedVariant.value!.images!.length - 1) {
//       selectedImageIndex.value++;
//     }
//   }

//   void previousImage() {
//     if (selectedImageIndex.value > 0) {
//       selectedImageIndex.value--;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     print(id_product);
//     getProductDetails(id: id_product);
//     getProductDetailsMore(id: id_product);
//   }
// }
