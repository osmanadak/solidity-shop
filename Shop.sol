pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

contract Shop {
    
    //Data Structures
    struct User {
        string name;
        string surname;
        string birthdate;
        string shippingAddress;
        Order[] orders;
    }
    
    struct Category {
        uint parentCategory;
        string name;
    }
    
    struct Product {
        uint category;
        string name;
        string summary;
        string description;
        uint price;
        uint stock;
        string[] imageUrls;
    }
    
    struct Order {
        string products;
        uint status;
        uint totalAmount;
        string description;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    //Variables and lists
    address private owner;
    Category[] private categories;
    Product[] private products;
    mapping(address => User) users;
    
    //Constructor function
    constructor () public {
        owner = msg.sender;
    }
    
    //Change Owner
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
    
    //Create Category
    function createCategory (uint _parentCategory, string memory _name) public onlyOwner {
        Category memory _categoryToInsert;
        _categoryToInsert.parentCategory = _parentCategory;
        _categoryToInsert.name = _name;
        
        categories.push(_categoryToInsert);
    }
    
    //Update Category
    function updateCategory (uint _categoryId, uint _parentCategory, string memory _name) public onlyOwner {
        categories[_categoryId].name = _name;
        categories[_categoryId].parentCategory = _parentCategory;
    }
    
    //List Categories
    function listCategories () public view returns(Category[] memory){
        return categories;
    }
    
    //Create Product
    function createProduct (uint _category, string memory _name, string memory _summary, string memory _description, uint _price, uint _stock) public onlyOwner {
        Product memory _productToInsert;
        _productToInsert.category = _category;
        _productToInsert.name = _name;
        _productToInsert.summary = _summary;
        _productToInsert.description = _description;
        _productToInsert.price = _price;
        _productToInsert.stock = _stock;
        
        products.push(_productToInsert);
    }
    
    //Update Product
    function updateProduct (uint _productId, uint _category, string memory _name, string memory _summary, string memory _description, uint _price, uint _stock) public onlyOwner {
        products[_productId].category = _category;
        products[_productId].name = _name;
        products[_productId].summary = _summary;
        products[_productId].description = _description;
        products[_productId].price = _price;
        products[_productId].stock = _stock;
    }
    
    //Update Product Stock
    function updateProductStock (uint _productId, uint _stock) public onlyOwner {
        products[_productId].stock = _stock;
    }
    
    //Update Product Price
    function updateProductPrice (uint _productId, uint _price) public onlyOwner {
        products[_productId].price = _price;
    }
    
    //List Products
    function listProducts () public view returns(Product[] memory) {
        return products;
    }
    
    //Get Product Details
    function getProductDetails (uint _productId) public view returns(Product memory) {
        return products[_productId];
    }
    
    //Add Product Photo
    function addProductPhoto (uint _productId, string memory _imageUrl) public onlyOwner {
        products[_productId].imageUrls.push(_imageUrl);
    }
    
    //Checkout(Save Order)
    function updateUser (string memory _name, string memory _surname, string memory _birthdate, string memory _shippingAddress) public {
        users[msg.sender].name = _name;
        users[msg.sender].surname = _surname;
        users[msg.sender].birthdate = _birthdate;
        users[msg.sender].shippingAddress = _shippingAddress;
    }
    
    //Checkout(Save Order)
    function saveOrder (string memory _products, uint _totalAmount, string memory _description) public {
        Order memory _orderToInsert;
        _orderToInsert.products = _products;
        _orderToInsert.totalAmount = _totalAmount;
        _orderToInsert.description = _description;
        _orderToInsert.status = 1;
        
        users[msg.sender].orders.push(_orderToInsert);
    }
    
    //Update Order
    function updateOrder (address _userAddress, uint _orderId, uint _status) public onlyOwner {
        users[_userAddress].orders[_orderId].status = _status;
    }
}
