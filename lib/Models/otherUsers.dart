class OtherProfile {
  OtherProfile(
      {this.id,
      this.name,
      this.gender,
      this.mobile,
      this.isChef,
      this.followersCount,
      this.followingsCount,
      this.isFollowing,
      this.recipesCount});

  int? id;
  String? name;
  String? gender;
  String? mobile;
  bool? isChef;
  int? followersCount;
  int? followingsCount;
  bool? isFollowing;
  int? recipesCount;

  factory OtherProfile.fromJson(Map<String, dynamic> json) => OtherProfile(
      id: json["id"],
      name: json["name"],
      gender: json["gender"],
      mobile: json["mobile"],
      isChef: json["is_chef"] == 1 ? true : false,
      followersCount: json["followers_count"],
      followingsCount: json["followings_count"],
      isFollowing: json["is_following"] == 1 ? true : false,
      recipesCount: json["recipes_count"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "mobile": mobile,
        "is_chef": isChef,
        "followers_count": followersCount,
        "followings_count": followingsCount,
        "is_following": isFollowing,
        "recipes_count": recipesCount
      };
}
