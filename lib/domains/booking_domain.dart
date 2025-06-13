/* 
Booking Model
This is what a booking abject is.

It has these properties:
-id
-address
*/

class Booking {
  final String address;
  final String id;
  final double payment;

  Booking(this.address, this.id, this.payment);
}
