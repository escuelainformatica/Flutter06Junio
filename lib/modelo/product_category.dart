class ProductCategory {
  int IdProductCategory;
  String Name;

  ProductCategory(this.IdProductCategory, this.Name);

  // mapa --> ProductCategory
  ProductCategory.fromMap(Map<String, dynamic> json) :
        IdProductCategory = json['IdProductCategory'],
        Name = json['Name'];

  // ProductCategory ---> mapa
  Map<String, dynamic> toMap() {
    return {
      'IdProductCategory': IdProductCategory,
      'Name': Name
    };
  }


}