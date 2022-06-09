/*
{
"IdProduct": 1,
"Name": "prod-1",
"IdProductCategory": 1,
"Price": "100.00"
}
 */

class Producto {
    int IdProduct=0;
    String Name;
    int IdProductCategory;
    double Price;

    // (10,"hola",20,20.2) ---> Producto
    Producto.name(this.IdProduct, this.Name, this.IdProductCategory, this.Price);

    // mapa --> Producto
    Producto.fromMap(Map<String, dynamic> json) :
            IdProduct = json['IdProduct'],
            Name = json['Name'],
            IdProductCategory = json['IdProductCategory'],
            Price = json['Price'];

    // Producto ---> mapa
    Map<String, dynamic> toMap() {
        return {
            'IdProduct': IdProduct,
            'Name': Name,
            'IdProductCategory': IdProductCategory,
            'Price': Price,
        };
    }

}