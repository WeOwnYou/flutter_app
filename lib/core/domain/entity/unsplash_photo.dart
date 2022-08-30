class UnsplashPhoto {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  dynamic description;
  dynamic altDescription;
  Urls? urls;
  Links? links;
  List<dynamic>? categories;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  TopicSubmissions? topicSubmissions;
  User? user;
  Exif? exif;
  Location? location;
  int? views;
  int? downloads;

  UnsplashPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.topicSubmissions,
    this.user,
    this.exif,
    this.location,
    this.views,
    this.downloads,
  });

  UnsplashPhoto.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    promotedAt = json['promoted_at'] as String?;
    width = json['width'] as int;
    height = json['height'] as int;
    color = json['color'] as String?;
    blurHash = json['blur_hash'] as String?;
    description = json['description'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null
        ? Urls.fromJson(json['urls'] as Map<String, dynamic>)
        : null;
    links = json['links'] != null
        ? Links.fromJson(json['links'] as Map<String, dynamic>)
        : null;
    if (json['categories'] != null) {
      categories = <dynamic>[];
      for (final v in json['categories'] as List) {
        categories!.add(v);
      }
    }
    likes = json['likes'] as int;
    likedByUser = json['liked_by_user'] as bool;
    if (json['current_user_collections'] != null) {
      currentUserCollections = <Null>[];
      for (final v in json['current_user_collections'] as List) {
        currentUserCollections!.add(v);
      }
    }
    sponsorship = json['sponsorship'];
    topicSubmissions = json['topic_submissions'] != null
        ? TopicSubmissions.fromJson(
            json['topic_submissions'] as Map<String, dynamic>,
          )
        : null;
    user = json['user'] != null
        ? User.fromJson(json['user'] as Map<String, dynamic>)
        : null;
    exif = json['exif'] != null
        ? Exif.fromJson(json['exif'] as Map<String, dynamic>)
        : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'] as Map<String, dynamic>)
        : null;
    views = json['views'] as int;
    downloads = json['downloads'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['promoted_at'] = promotedAt;
    data['width'] = width;
    data['height'] = height;
    data['color'] = color;
    data['blur_hash'] = blurHash;
    data['description'] = description;
    data['alt_description'] = altDescription;
    if (urls != null) {
      data['urls'] = urls!.toJson();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.toList();
    }
    data['likes'] = likes;
    data['liked_by_user'] = likedByUser;
    if (currentUserCollections != null) {
      data['current_user_collections'] = currentUserCollections!.toList();
    }
    data['sponsorship'] = sponsorship;
    if (topicSubmissions != null) {
      data['topic_submissions'] = topicSubmissions!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (exif != null) {
      data['exif'] = exif!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['views'] = views;
    data['downloads'] = downloads;
    return data;
  }
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'] as String;
    full = json['full'] as String;
    regular = json['regular'] as String;
    small = json['small'] as String;
    thumb = json['thumb'] as String;
    smallS3 = json['small_s3'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raw'] = raw;
    data['full'] = full;
    data['regular'] = regular;
    data['small'] = small;
    data['thumb'] = thumb;
    data['small_s3'] = smallS3;
    return data;
  }
}

class Links {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  Links({this.self, this.html, this.download, this.downloadLocation});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] as String?;
    html = json['html'] as String?;
    download = json['download'] as String?;
    downloadLocation = json['download_location'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['self'] = self;
    data['html'] = html;
    // data['download'] = this.download;
    // data['download_location'] = this.downloadLocation;
    return data;
  }
}

class TopicSubmissions {
  Renders3d? renders3d;
  TexturesPatterns? texturesPatterns;

  TopicSubmissions({this.renders3d, this.texturesPatterns});

  TopicSubmissions.fromJson(Map<String, dynamic> json) {
    renders3d = (json['3d-renders']) != null
        ? Renders3d.fromJson(json['3d-renders'] as Map<String, dynamic>)
        : null;
    texturesPatterns = json['textures-patterns'] != null
        ? TexturesPatterns.fromJson(
            json['textures-patterns'] as Map<String, dynamic>,
          )
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (renders3d != null) {
      data['3d-renders'] = renders3d!.toJson();
    }
    if (texturesPatterns != null) {
      data['textures-patterns'] = texturesPatterns!.toJson();
    }
    return data;
  }
}

class Renders3d {
  String? status;
  String? approvedOn;

  Renders3d({this.status, this.approvedOn});

  Renders3d.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    approvedOn = json['approved_on'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['approved_on'] = approvedOn;
    return data;
  }
}

class TexturesPatterns {
  String? status;

  TexturesPatterns({this.status});

  TexturesPatterns.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class User {
  String? id;
  String? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  Links? links;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
    this.forHire,
    this.social,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    updatedAt = json['updated_at'] as String?;
    username = json['username'] as String?;
    name = json['name'] as String?;
    firstName = json['first_name'] as String?;
    lastName = json['last_name'] as String?;
    twitterUsername = json['twitter_username'] as String?;
    portfolioUrl = json['portfolio_url'] as String?;
    bio = json['bio'] as String?;
    location = json['location'] as String?;
    links = json['links'] != null
        ? Links.fromJson(json['links'] as Map<String, dynamic>)
        : null;
    profileImage = json['profile_image'] != null
        ? ProfileImage.fromJson(json['profile_image'] as Map<String, dynamic>)
        : null;
    instagramUsername = json['instagram_username'] as String?;
    totalCollections = json['total_collections'] as int;
    totalLikes = json['total_likes'] as int;
    totalPhotos = json['total_photos'] as int;
    acceptedTos = json['accepted_tos'] as bool;
    forHire = json['for_hire'] as bool;
    social = json['social'] != null
        ? Social.fromJson(json['social'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['username'] = username;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['twitter_username'] = twitterUsername;
    data['portfolio_url'] = portfolioUrl;
    data['bio'] = bio;
    data['location'] = location;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (profileImage != null) {
      data['profile_image'] = profileImage!.toJson();
    }
    data['instagram_username'] = instagramUsername;
    data['total_collections'] = totalCollections;
    data['total_likes'] = totalLikes;
    data['total_photos'] = totalPhotos;
    data['accepted_tos'] = acceptedTos;
    data['for_hire'] = forHire;
    if (social != null) {
      data['social'] = social!.toJson();
    }
    return data;
  }
}

class UserLinks {
  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;
  String? following;
  String? followers;

  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  UserLinks.fromJson(Map<String, dynamic> json) {
    self = json['self'] as String?;
    html = json['html'] as String?;
    photos = json['photos'] as String?;
    likes = json['likes'] as String?;
    portfolio = json['portfolio'] as String?;
    following = json['following'] as String?;
    followers = json['followers'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['self'] = self;
    data['html'] = html;
    data['photos'] = photos;
    data['likes'] = likes;
    data['portfolio'] = portfolio;
    data['following'] = following;
    data['followers'] = followers;
    return data;
  }
}

class ProfileImage {
  String? small;
  String? medium;
  String? large;

  ProfileImage({this.small, this.medium, this.large});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    small = json['small'] as String;
    medium = json['medium'] as String;
    large = json['large'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['small'] = small;
    data['medium'] = medium;
    data['large'] = large;
    return data;
  }
}

class Social {
  String? instagramUsername;
  String? portfolioUrl;
  String? twitterUsername;
  dynamic paypalEmail;

  Social({
    this.instagramUsername,
    this.portfolioUrl,
    this.twitterUsername,
    this.paypalEmail,
  });

  Social.fromJson(Map<String, dynamic> json) {
    instagramUsername = json['instagram_username'] as String?;
    portfolioUrl = json['portfolio_url'] as String?;
    twitterUsername = json['twitter_username'] as String?;
    paypalEmail = json['paypal_email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['instagram_username'] = instagramUsername;
    data['portfolio_url'] = portfolioUrl;
    data['twitter_username'] = twitterUsername;
    data['paypal_email'] = paypalEmail;
    return data;
  }
}

class Exif {
  dynamic make;
  dynamic model;
  dynamic name;
  dynamic exposureTime;
  dynamic aperture;
  dynamic focalLength;
  dynamic iso;

  Exif({
    this.make,
    this.model,
    this.name,
    this.exposureTime,
    this.aperture,
    this.focalLength,
    this.iso,
  });

  Exif.fromJson(Map<String, dynamic> json) {
    make = json['make'];
    model = json['model'];
    name = json['name'];
    exposureTime = json['exposure_time'];
    aperture = json['aperture'];
    focalLength = json['focal_length'];
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['make'] = make;
    data['model'] = model;
    data['name'] = name;
    data['exposure_time'] = exposureTime;
    data['aperture'] = aperture;
    data['focal_length'] = focalLength;
    data['iso'] = iso;
    return data;
  }
}

class Location {
  dynamic title;
  dynamic name;
  dynamic city;
  dynamic country;
  Position? position;

  Location({this.title, this.name, this.city, this.country, this.position});

  Location.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    city = json['city'];
    country = json['country'];
    position = json['position'] != null
        ? Position.fromJson(json['position'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['name'] = name;
    data['city'] = city;
    data['country'] = country;
    if (position != null) {
      data['position'] = position!.toJson();
    }
    return data;
  }
}

class Position {
  dynamic latitude;
  dynamic longitude;

  Position({this.latitude, this.longitude});

  Position.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
