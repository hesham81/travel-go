class SeatEconomy {
  final String type;

  final String flightId;

  final String noOfSeats;

  final String price;

  SeatEconomy({
    required this.type,
    required this.flightId,
    required this.noOfSeats,
    required this.price,
  });

  factory SeatEconomy.fromJson(Map<String, dynamic> json) => SeatEconomy(
        type: json["type"],
        flightId: json["flight_id"],
        noOfSeats: json["no_of_seats"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "flight_id": flightId,
        "no_of_seats": noOfSeats,
        "price": price,
      };
}
