class MyOrder{
   final int id;
   final String name;
   final String picture;
   final String description;
   final double price;
   final int quantity;

  /* MyOrder({
      this.id,
      this.name,
      this.picture,
      this.description,
      this.price,
      this.shoppingItem
   });

   @override
   bool operator==(Object other) => identical(this, other) || this.hashCode == other.hashCode;

   @override
   int get hashCode => id;*/

   const MyOrder({
      this.id,
      this.name,
      this.picture,
      this.description,
      this.price,
      this.quantity: 0,
   });

   MyOrder copyWith({String id, String image, String name, String price, int quantity}){
      return new MyOrder(
          id: id ?? this.id,
          name: name ?? this.name,
          picture: picture ?? this.picture,
          description: description ?? this.description,
          price: price ?? this.price,
          quantity: quantity ?? this.quantity
      );
   }
}