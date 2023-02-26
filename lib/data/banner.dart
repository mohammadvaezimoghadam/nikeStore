class BannerEntity{
  final int id;
  final String imageUrl;

   BannerEntity.fromjson(Map<String,dynamic> json):
  id=json["id"],
  imageUrl=json["image"];
}