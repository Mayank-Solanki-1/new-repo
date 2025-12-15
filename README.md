# 🛒 E-commerce Enterprise Application

A full-featured, enterprise-grade e-commerce web application built with Java, designed to provide a complete online shopping experience with robust features for buyers, sellers, and administrators.

[![Java](https://img.shields.io/badge/Java-11+-orange.svg)](https://www.oracle.com/java/)
[![Maven](https://img.shields.io/badge/Maven-3.6+-blue.svg)](https://maven.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3.0-purple.svg)](https://getbootstrap.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📋 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Technology Stack](#-technology-stack)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Database Setup](#-database-setup)
- [Configuration](#-configuration)
- [Running the Application](#-running-the-application)
- [Project Structure](#-project-structure)
- [User Roles & Access](#-user-roles--access)
- [API Endpoints](#-api-endpoints)
- [Screenshots](#-screenshots)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)
- [Contact](#-contact)

---

## 🎯 About

This e-commerce enterprise application is a comprehensive Java-based web platform that provides complete functionality for online retail operations. It features a modern, responsive interface with role-based access control, secure authentication, shopping cart management, order processing, and administrative capabilities.

**Key Highlights:**
- ✅ Multi-role architecture (Admin, Seller, Buyer)
- ✅ Complete product lifecycle management
- ✅ Secure authentication with password hashing
- ✅ Real-time inventory tracking
- ✅ Transaction management with rollback support
- ✅ Responsive Bootstrap UI
- ✅ Session-based cart management
- ✅ Invoice generation
- ✅ Sales analytics and reporting

---

## ✨ Features

### 👤 User Management
- User registration with role selection (Admin, Seller, Buyer)
- Secure login with SHA-256 password hashing
- Profile management with shipping address
- Role-based access control with servlet filters

### 📦 Product Management
- **Sellers:**
  - Add, edit, and delete products
  - Upload product images
  - Manage inventory levels
  - View sales history
  - Sales performance analytics
- **Buyers:**
  - Browse products with search and filter
  - View detailed product information
  - Live search suggestions
  - Wishlist functionality

### 🛍 Shopping Experience
- Session-based shopping cart
- Real-time stock validation
- Add to cart with quantity selection
- Remove items from cart
- Wishlist management
- Product search with AJAX suggestions

### 💳 Order Processing
- Multi-step checkout process
- Shipping address management
- Multiple payment options (COD, Card, UPI)
- Order history tracking
- Order status updates (Pending → Processing → Shipped → Delivered)
- Invoice generation with PDF view

### 👨‍💼 Admin Panel
- Dashboard with key metrics
- User management (view, delete)
- Product oversight (view all products)
- Order management (update status, view details)
- System-wide analytics

### 📊 Analytics & Reporting
- Sales performance tracking
- Product-wise revenue analysis
- Monthly sales charts
- Inventory overview with low-stock alerts
- Top-selling products

---

## 🛠 Technology Stack

### Backend
- **Java 11** - Core programming language
- **Java Servlets** - Server-side logic
- **JSP (JavaServer Pages)** - Dynamic web pages
- **JDBC** - Database connectivity
- **Maven** - Dependency management

### Frontend
- **HTML5, CSS3, JavaScript** - Core web technologies
- **Bootstrap 5.3.0** - Responsive UI framework
- **Tailwind CSS** - Utility-first CSS (select pages)
- **jQuery** - AJAX and DOM manipulation
- **Chart.js** - Data visualization

### Database
- **MySQL 8.0+** - Relational database
- **HikariCP** - High-performance connection pooling

### Server
- **Apache Tomcat 9.x** - Servlet container

### Security
- **SHA-256** - Password hashing
- **Servlet Filters** - Authentication and authorization

### Additional Tools
- **Gson** - JSON parsing
- **Font Awesome & Bootstrap Icons** - Icon libraries

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

| Requirement | Version | Download Link |
|------------|---------|---------------|
| **Java Development Kit (JDK)** | 11 or higher | [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) |
| **Apache Maven** | 3.6+ | [Maven Download](https://maven.apache.org/download.cgi) |
| **Apache Tomcat** | 9.x or higher | [Tomcat Download](https://tomcat.apache.org/download-90.cgi) |
| **MySQL** | 8.0+ | [MySQL Download](https://dev.mysql.com/downloads/mysql/) |
| **Git** | Latest | [Git Download](https://git-scm.com/downloads) |
| **IDE** (Optional) | - | [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) / [Eclipse](https://www.eclipse.org/downloads/) |

**Verify installations:**
```bash
java -version
mvn -version
mysql --version
git --version
```

---

## 🚀 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/Mayank-Solanki-1/new-repo.git
cd new-repo
```

### 2. Build the Project
```bash
mvn clean install
```

This will:
- Download all dependencies
- Compile Java source files
- Run tests (if any)
- Package the application into a WAR file

**Expected output:**
```
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: XX s
[INFO] ------------------------------------------------------------------------
```

The WAR file will be generated at: `target/ecommerce-enterprise.war`

---

## 💾 Database Setup

### 1. Create Database
```bash
mysql -u root -p
```

In MySQL shell:
```sql
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;
```

### 2. Run Schema Script
```bash
mysql -u root -p ecommerce_db < sql/schema.sql
```

This creates the following tables:
- `users` - User accounts with roles
- `products` - Product catalog
- `orders` - Order records
- `order_items` - Order line items
- `wishlist` - User wishlists
- `cart` - Shopping cart (optional, using session storage)

### 3. Verify Tables
```sql
SHOW TABLES;
DESCRIBE users;
```

### 4. Create Admin Account (Optional)
You can create an admin account through the application's registration page using the admin secret key `SuperSecret123`, or manually:

```sql
-- Password for 'admin123' after SHA-256 hashing
INSERT INTO users(name, email, password, role, phone, address, city, state, pincode) 
VALUES('Admin User', 'admin@mystore.com', 
       'YOUR_HASHED_PASSWORD_HERE', 
       'admin', '9999999999', 'Admin Address', 
       'City', 'State', '000000');
```

---

## ⚙️ Configuration

### 1. Database Configuration
Update `src/main/resources/application.properties`:

```properties
db.url=jdbc:mysql://localhost:3306/ecommerce_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.user=your_mysql_username
db.pass=your_mysql_password
```

**Important:** Replace `your_mysql_username` and `your_mysql_password` with your actual MySQL credentials.

### 2. Admin Secret Key
Located in `RegisterServlet.java`:
```java
private static final String ADMIN_SECRET_KEY = "SuperSecret123";
```
Change this to a secure value in production.

### 3. File Upload Directory
Products images are stored in: `src/main/webapp/product_images/`

Ensure this directory exists:
```bash
mkdir -p src/main/webapp/product_images
```

### 4. Tomcat Configuration (Smart Tomcat Plugin)
If using IntelliJ IDEA with Smart Tomcat:
- Configuration files are in `.smarttomcat/ecommerce-enterprise/conf/`
- Default port: `8080`
- Context path: `/ecommerce-enterprise`

---

## 🏃 Running the Application

### Method 1: Using IDE (IntelliJ IDEA with Smart Tomcat)

1. **Configure Smart Tomcat:**
   - Go to `Run` → `Edit Configurations`
   - Add new `Smart Tomcat` configuration
   - Set Tomcat Server path
   - Set deployment context: `/ecommerce-enterprise`
   - Set port: `8080`

2. **Run the application:**
   - Click the Run button
   - Application will deploy automatically

3. **Access the application:**
   ```
   http://localhost:8080/ecommerce-enterprise
   ```

### Method 2: Using Command Line

1. **Build the WAR:**
   ```bash
   mvn clean package
   ```

2. **Deploy to Tomcat:**
   ```bash
   cp target/ecommerce-enterprise.war $CATALINA_HOME/webapps/
   ```

3. **Start Tomcat:**
   ```bash
   # Linux/Mac
   $CATALINA_HOME/bin/startup.sh
   
   # Windows
   %CATALINA_HOME%\bin\startup.bat
   ```

4. **Access the application:**
   ```
   http://localhost:8080/ecommerce-enterprise
   ```

### Method 3: Using Maven Tomcat Plugin

Add to `pom.xml`:
```xml
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
    <configuration>
        <port>8080</port>
        <path>/ecommerce-enterprise</path>
    </configuration>
</plugin>
```

Run:
```bash
mvn tomcat7:run
```

---

## 📁 Project Structure

```
new-repo/
├── .idea/                          # IntelliJ IDEA project files
├── .smarttomcat/                   # Smart Tomcat configuration
│   └── ecommerce-enterprise/
│       └── conf/
├── sql/                            # Database scripts
│   ├── schema.sql                  # Database schema
│   └── seed.sql                    # Sample data (optional)
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── ecomm/
│       │           ├── dao/                  # Data Access Objects
│       │           │   ├── CartDAO.java
│       │           │   ├── DBPool.java
│       │           │   ├── OrderDAO.java
│       │           │   ├── ProductDAO.java
│       │           │   ├── UserDAO.java
│       │           │   └── WishlistDAO.java
│       │           ├── filter/               # Servlet Filters
│       │           │   └── AuthFilter.java
│       │           ├── model/                # Entity classes
│       │           │   ├── CartItem.java
│       │           │   ├── Order.java
│       │           │   ├── Product.java
│       │           │   └── User.java
│       │           ├── service/              # Business logic
│       │           │   ├── CartService.java
│       │           │   ├── CheckoutService.java
│       │           │   └── OrderService.java
│       │           ├── servlet/              # HTTP Servlets
│       │           │   ├── AdminServlet.java
│       │           │   ├── AuthServlet.java
│       │           │   ├── BuyerServlet.java
│       │           │   ├── CartServlet.java
│       │           │   ├── CheckoutServlet.java
│       │           │   ├── InventoryServlet.java
│       │           │   ├── OrderServlet.java
│       │           │   ├── PaymentServlet.java
│       │           │   ├── PaymentSuccessServlet.java
│       │           │   ├── ProductServlet.java
│       │           │   ├── ProfileServlet.java
│       │           │   ├── RegisterServlet.java
│       │           │   ├── SalesServlet.java
│       │           │   ├── SellerServlet.java
│       │           │   └── WishlistServlet.java
│       │           └── util/                 # Utility classes
│       │               └── PasswordUtil.java
│       ├── resources/
│       │   └── application.properties        # Database configuration
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── jsp/                      # JSP pages
│           │   │   ├── admin/
│           │   │   │   ├── dashboard.jsp
│           │   │   │   ├── orders.jsp
│           │   │   │   ├── products.jsp
│           │   │   │   └── users.jsp
│           │   │   ├── buyer/
│           │   │   │   ├── dashboard.jsp
│           │   │   │   ├── profile.jsp
│           │   │   │   └── wishlist.jsp
│           │   │   ├── order/
│           │   │   │   ├── Checkout.jsp
│           │   │   │   ├── history.jsp
│           │   │   │   ├── invoice.jsp
│           │   │   │   ├── payment.jsp
│           │   │   │   └── success.jsp
│           │   │   ├── product/
│           │   │   │   ├── list.jsp
│           │   │   │   └── product_details.jsp
│           │   │   ├── seller/
│           │   │   │   ├── dashboard.jsp
│           │   │   │   ├── inventory.jsp
│           │   │   │   ├── orders.jsp
│           │   │   │   ├── products.jsp
│           │   │   │   └── salesPerformance.jsp
│           │   │   └── cart.jsp
│           │   └── web.xml                   # Deployment descriptor
│           ├── product_images/               # Product image uploads
│           ├── index.jsp                     # Landing page
│           ├── login.jsp                     # Login page
│           └── register.jsp                  # Registration page
├── target/                         # Compiled classes and WAR
├── pom.xml                         # Maven configuration
├── .gitattributes
└── README.md                       # This file
```

---

## 👥 User Roles & Access

### 🔴 Admin
**Access:** All system features

**Capabilities:**
- View dashboard with system metrics
- Manage all users (view, delete)
- Manage all products (view, delete)
- Manage all orders (view, update status)
- System-wide analytics

**Login:** Create via registration with admin secret key

**Routes:**
- `/admin/dashboard`
- `/admin/users`
- `/admin/products`
- `/admin/orders`

---

### 🟢 Seller
**Access:** Product and sales management

**Capabilities:**
- Manage own products (create, edit, delete)
- Upload product images
- Track inventory levels
- View sales history
- Access sales performance analytics
- View orders for their products

**Registration:** Select "Seller" role during registration

**Routes:**
- `/seller/dashboard`
- `/seller/products`
- `/seller/inventory`
- `/seller/orders`
- `/seller/salesPerformance`

---

### 🔵 Buyer
**Access:** Shopping and order features

**Capabilities:**
- Browse and search products
- Add products to cart
- Manage wishlist
- Place orders
- Track order status
- View order history
- Generate invoices
- Update profile information

**Registration:** Select "Buyer" role during registration

**Routes:**
- `/buyer/dashboard`
- `/buyer/profile`
- `/buyer/wishlist`
- `/product/list`
- `/cart`
- `/order/*`

---

## 🌐 API Endpoints

### Authentication
| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| POST | `/login` | User login | Public |
| POST | `/register` | User registration | Public |
| GET | `/logout` | User logout | Authenticated |

### Products
| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| GET | `/product/list` | List all products | Public |
| GET | `/product/product_details?productId={id}` | Product details | Public |
| POST | `/product/action` | Add/Update/Delete product | Seller, Admin |
| GET | `/product/suggest?query={q}` | Search suggestions (AJAX) | Public |

### Cart
| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| GET | `/cart` | View cart | Authenticated |
| POST | `/cart/add` | Add to cart | Authenticated |
| POST | `/cart/remove` | Remove from cart | Authenticated |

### Orders
| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| GET | `/order/Checkout` | Checkout page | Buyer |
| POST | `/order/Checkout` | Submit checkout | Buyer |
| GET | `/order/payment` | Payment page | Buyer |
| POST | `/order/payment` | Process payment | Buyer |
| GET | `/order/success` | Order success | Buyer |
| GET | `/order/history` | Order history | Buyer |
| GET | `/order/invoice?id={orderId}` | View invoice | Buyer, Seller, Admin |

### Wishlist
| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| GET | `/buyer/wishlist` | View wishlist | Buyer |
| POST | `/buyer/wishlist` | Add/Remove item | Buyer |

### Admin
| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| GET | `/admin/dashboard` | Admin dashboard | Admin |
| GET | `/admin/users` | Manage users | Admin |
| GET | `/admin/products` | Manage products | Admin |
| GET | `/admin/orders` | Manage orders | Admin |
| POST | `/admin/orders/action` | Update order status | Admin |

### Seller
| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| GET | `/seller/dashboard` | Seller dashboard | Seller |
| GET | `/seller/products` | Manage products | Seller |
| GET | `/seller/inventory` | View inventory | Seller |
| GET | `/seller/orders` | View sales | Seller |
| GET | `/seller/salesPerformance` | Analytics | Seller |

---

## 📸 Screenshots

### Landing Page
Modern hero section with category cards
![Landing Page Placeholder](https://via.placeholder.com/800x400/6b73ff/ffffff?text=Landing+Page)

### Product Catalog
Responsive grid layout with search and filters
![Product List Placeholder](https://via.placeholder.com/800x400/000dff/ffffff?text=Product+Catalog)

### Shopping Cart
Real-time stock validation and cart management
![Cart Placeholder](https://via.placeholder.com/800x400/4CAF50/ffffff?text=Shopping+Cart)

### Seller Dashboard
Analytics and product management
![Seller Dashboard Placeholder](https://via.placeholder.com/800x400/FF6B6B/ffffff?text=Seller+Dashboard)

### Admin Panel
System-wide management and monitoring
![Admin Panel Placeholder](https://via.placeholder.com/800x400/1f8a70/ffffff?text=Admin+Panel)

---

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 1. **Build Fails with "Cannot resolve dependencies"**
**Problem:** Maven cannot download dependencies

**Solution:**
```bash
# Clean Maven cache
mvn clean
mvn dependency:purge-local-repository
mvn install
```

#### 2. **Database Connection Error**
**Problem:** `SQLException: Access denied for user`

**Solution:**
- Verify MySQL credentials in `application.properties`
- Ensure MySQL server is running:
  ```bash
  # Check MySQL status
  sudo systemctl status mysql  # Linux
  brew services list           # Mac
  ```
- Test connection:
  ```bash
  mysql -u your_username -p
  ```

#### 3. **Application Fails to Deploy**
**Problem:** Tomcat deployment errors

**Solution:**
- Check Tomcat logs: `$CATALINA_HOME/logs/catalina.out`
- Verify Tomcat version compatibility (9.x)
- Ensure port 8080 is not in use:
  ```bash
  # Linux/Mac
  lsof -i :8080
  
  # Windows
  netstat -ano | findstr :8080
  ```

#### 4. **404 Error on All Pages**
**Problem:** Context path mismatch

**Solution:**
- Verify context path in deployment
- Check `web.xml` configuration
- Access with correct URL: `http://localhost:8080/ecommerce-enterprise`

#### 5. **Images Not Displaying**
**Problem:** Product images show broken links

**Solution:**
- Verify `product_images/` directory exists
- Check file permissions
- Use relative paths: `${pageContext.request.contextPath}/product_images/${image}`

#### 6. **Session Lost on Page Refresh**
**Problem:** Cart items disappear

**Solution:**
- Check session timeout in `web.xml`:
  ```xml
  <session-config>
      <session-timeout>30</session-timeout>
  </session-config>
  ```
- Verify cookies are enabled in browser

#### 7. **JDBC Driver Not Found**
**Problem:** `ClassNotFoundException: com.mysql.cj.jdbc.Driver`

**Solution:**
- Ensure MySQL connector is in `pom.xml`:
  ```xml
  <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>8.1.0</version>
  </dependency>
  ```
- Rebuild: `mvn clean install`

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

### How to Contribute

1. **Fork the repository**
   ```bash
   git clone https://github.com/YOUR-USERNAME/new-repo.git
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. **Make your changes**
   - Write clean, documented code
   - Follow existing code style
   - Add comments where necessary

4. **Commit your changes**
   ```bash
   git commit -m 'Add: Amazing new feature'
   ```

5. **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```

6. **Open a Pull Request**
   - Provide a clear description
   - Reference any related issues

### Code Style Guidelines
- Use meaningful variable and method names
- Follow Java naming conventions (camelCase for methods, PascalCase for classes)
- Add JavaDoc comments for public methods
- Keep methods focused and concise
- Handle exceptions properly

### Reporting Issues
- Use GitHub Issues
- Provide detailed description
- Include steps to reproduce
- Add screenshots if applicable

---

## 📄 License

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2025 Mayank Solanki

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Contact

**Mayank Solanki**

- GitHub: [@Mayank-Solanki-1](https://github.com/Mayank-Solanki-1)
- Repository: [new-repo](https://github.com/Mayank-Solanki-1/new-repo)
- Email: [Create an issue](https://github.com/Mayank-Solanki-1/new-repo/issues) for queries

---

## 🙏 Acknowledgments

- Bootstrap team for the excellent UI framework
- Apache Foundation for Tomcat and Maven
- MySQL team for the robust database system
- Chart.js for data visualization
- Font Awesome and Bootstrap Icons for icon libraries
- The open-source community for continuous inspiration

---

## 📚 Additional Resources

- [Java Servlets Documentation](https://docs.oracle.com/javaee/7/tutorial/servlets.htm)
- [Bootstrap Documentation](https://getbootstrap.com/docs/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Maven Guide](https://maven.apache.org/guides/)
- [Tomcat Documentation](https://tomcat.apache.org/tomcat-9.0-doc/)

---

## 🎯 Future Enhancements

Planned features for future releases:

- [ ] RESTful API with JWT authentication
- [ ] Email notifications for orders
- [ ] Product reviews and ratings
- [ ] Advanced search with filters
- [ ] Payment gateway integration (Stripe, PayPal)
- [ ] Multi-language support
- [ ] Mobile application (Android/iOS)
- [ ] Product recommendations engine
- [ ] Discount codes and promotions
- [ ] Shipping provider integration
- [ ] Advanced analytics dashboard
- [ ] Social media integration

---

<div align="center">

**⭐ Star this repository if you find it helpful!**

Made with ❤️ by [Mayank Solanki](https://github.com/Mayank-Solanki-1)

</div>
