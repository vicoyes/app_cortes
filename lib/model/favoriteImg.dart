
class FavoriteImg {
    int id;
    String url;
    String like;

    FavoriteImg({
        this.id,
        this.url,
        this.like,
    });

    factory FavoriteImg.fromJson(Map<String, dynamic> json) => FavoriteImg(
        id: json['id'],
        url: json['url'],
        like: json['like']
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'like': like
    };
}
