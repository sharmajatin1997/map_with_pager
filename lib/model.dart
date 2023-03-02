import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersModel {
  String name;
  String address;
  String image;
  LatLng cordinates;

  MarkersModel({required this.name, required this.address,required this.image, required this.cordinates});
}

final List<MarkersModel> list=[
  MarkersModel(name: 'India Gate', address: 'Delhi', cordinates: const LatLng(28.6129,77.2295), image: 'https://images.unsplash.com/photo-1587474260584-136574528ed5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
  MarkersModel(name: 'Taj Mahal', address: 'Agra', cordinates: const LatLng(27.1751,78.0421), image: 'https://th-thumbnailer.cdn-si-edu.com/CbddkFFO3OB80rRz83Iiuf-Z0FY=/1000x750/filters:no_upscale():focal(1471x1061:1472x1062)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/b6/30/b630b48b-7344-4661-9264-186b70531bdc/istock-478831658.jpg'),
  MarkersModel(name: 'Butterfly Beach', address: 'Goa', cordinates: const LatLng(15.0196,74.0016), image: 'https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2018/08/16/Pictures/_dbca9ffa-a138-11e8-9345-8d51f8ed9678.jpg'),
  MarkersModel(name: 'Baba Murad Shah Ji', address: 'Nakodar', cordinates: const LatLng(31.1292,75.4732), image: 'https://lh3.googleusercontent.com/p/AF1QipN9nFQjX7xeUO3okjagM0CmOVCj-hViSy-eAAxe'),
  MarkersModel(name: 'Shri Harmandir Sahib', address: 'Amritsar', cordinates: const LatLng(31.6200,74.8765), image: 'https://sacredsites.com/images/asia/india/golden_temple_1200.jpg')
];