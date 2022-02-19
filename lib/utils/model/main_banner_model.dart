class MainBannerModel {
  final int id;
  final String imageUrl;
  final String? url;
  final int? establishmentId;

  MainBannerModel(
      this.id,
      this.imageUrl,
      this.url,
      this.establishmentId
  );

  factory MainBannerModel.fromJson(json) {
    return MainBannerModel(
        json['id'],
        json['data'][0],
        json['url'],
        json['establishmentId']
    );
  }

}
