import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String name;
  final String street;
  final String locality;
  final String administrativeArea;
  final String country;
  final String postalCode;
  final double latitude;
  final double longitude;

  AddressModel(this.name, this.street, this.locality, this.administrativeArea,
      this.country, this.postalCode, this.latitude, this.longitude);

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
