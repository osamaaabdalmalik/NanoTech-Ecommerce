import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';

class Cart extends Equatable {
  final int totalPrice;
  final List<ItemCart> itemsCart;

  const Cart({
    required this.totalPrice,
    required this.itemsCart,
  });

  @override
  List<Object?> get props => [
        totalPrice,
        itemsCart,
      ];
}
