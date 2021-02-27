class Pdf {
  String freeEBook;

  Pdf({this.freeEBook});

  Pdf.fromJson(Map<String, dynamic> json) {
    freeEBook = json['Free eBook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Free eBook'] = this.freeEBook;
    return data;
  }
}
