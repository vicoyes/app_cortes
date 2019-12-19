

class FavoriteImg {
    int id;
    int idImg;
    String url;
    String like;

    FavoriteImg({
        this.id,
        this.idImg,
        this.url,
        this.like,
    });

    factory FavoriteImg.fromJson(Map<String, dynamic> json) => FavoriteImg(
        id: json["id"],
        idImg: json["id_img"],
        url: json["Url"],
        like: json["like"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_img": idImg,
        "Url": url,
        "like": like,
    };
}
