# E-commerce Enterprise Application

A full-featured e-commerce web application built with Java, designed to provide a complete online shopping experience with enterprise-grade features.

## 📋 Table of Contents

- [About](#about)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Database Setup](#database-setup)
- [Configuration](#configuration)
- [Running the Application](#running-the-application)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## 🎯 About

This e-commerce enterprise application is a robust Java-based web application that provides a comprehensive platform for online retail operations. It includes product management, shopping cart functionality, user authentication, order processing, and administrative features.

## ✨ Features

- **User Management**
  - User registration and authentication
  - Profile management
  - Role-based access control (Admin, Customer)

- **Product Management**
  - Browse products by category
  - Product search and filtering
  - Detailed product information
  - Product inventory management

- **Shopping Experience**
  - Shopping cart functionality
  - Wishlist management
  - Order placement and tracking
  - Payment processing integration

- **Admin Panel**
  - Product CRUD operations
  - Order management
  - User management
  - Sales analytics and reporting

- **Additional Features**
  - Responsive design
  - Secure payment gateway integration
  - Email notifications
  - Invoice generation

## 🛠 Technologies Used

- **Backend:**
  - Java (JDK 8 or higher)
  - Java Servlets & JSP
  - JDBC for database connectivity
  - Maven for dependency management

- **Frontend:**
  - HTML5, CSS3, JavaScript
  - Bootstrap (for responsive design)
  - AJAX for dynamic content

- **Database:**
  - MySQL / PostgreSQL

- **Server:**
  - Apache Tomcat 9.x or higher

- **IDE:**
  - IntelliJ IDEA (recommended)
  - Eclipse

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- Java Development Kit (JDK) 8 or higher
- Apache Maven 3.6+
- Apache Tomcat 9.x or higher
- MySQL 8.0+ or PostgreSQL 12+
- Git (for cloning the repository)
- An IDE (IntelliJ IDEA, Eclipse, or NetBeans)

## 🚀 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Mayank-Solanki-1/new-repo.git
   cd new-repo
   ```

2. **Build the project using Maven:**
   ```bash
   mvn clean install
   ```

3. **Verify the build:**
   - Ensure the build completes successfully without errors
   - Check that the WAR file is generated in the `target` directory

## 💾 Database Setup

1. **Create the database:**
   ```sql
   CREATE DATABASE ecommerce_db;
   USE ecommerce_db;
   ```

2. **Run the SQL scripts:**
   - Navigate to the `sql` directory
   - Execute the SQL scripts in the following order:
   ```bash
   mysql -u your_username -p ecommerce_db < sql/schema.sql
   mysql -u your_username -p ecommerce_db < sql/data.sql
   ```

3. **Verify the database:**
   - Check that all tables are created successfully
   - Verify sample data is inserted (if applicable)

## ⚙️ Configuration

1. **Database Configuration:**
   - Open `src/main/resources/db.properties` (or similar configuration file)
   - Update the database connection settings:
   ```properties
   db.url=jdbc:mysql://localhost:3306/ecommerce_db
   db.username=your_username
   db.password=your_password
   db.driver=com.mysql.cj.jdbc.Driver
   ```

2. **Application Properties:**
   - Configure email settings (if applicable)
   - Set up payment gateway credentials
   - Update any environment-specific configurations

3. **Tomcat Configuration:**
   - If using Smart Tomcat plugin, configuration files are in `.smarttomcat` directory
   - Ensure the correct port is configured (default: 8080)

## 🏃 Running the Application

### Using IDE (IntelliJ IDEA with Smart Tomcat):

1. Open the project in IntelliJ IDEA
2. Configure Smart Tomcat:
   - Go to Run → Edit Configurations
   - Add new Smart Tomcat configuration
   - Set Tomcat server path
   - Set deployment context path (e.g., `/ecommerce`)
3. Click Run or Debug

### Using Maven and Tomcat:

1. **Build the WAR file:**
   ```bash
   mvn clean package
   ```

2. **Deploy to Tomcat:**
   - Copy the WAR file from `target` directory to Tomcat's `webapps` folder
   - Start Tomcat server:
   ```bash
   # On Linux/Mac
   $CATALINA_HOME/bin/startup.sh
   
   # On Windows
   %CATALINA_HOME%\bin\startup.bat
   ```

3. **Access the application:**
   - Open your browser and navigate to: `http://localhost:8080/ecommerce-enterprise`

## 📁 Project Structure

```
new-repo/
├── .idea/                          # IntelliJ IDEA project files
├── .smarttomcat/                   # Smart Tomcat configuration
│   └── ecommerce-enterprise/
│       └── conf/
├── sql/                            # Database scripts
│   ├── schema.sql                  # Database schema
│   └── data.sql                    # Sample data
├── src/
│   └── main/
│       ├── java/                   # Java source files
│       │   └── com/
│       │       └── ecommerce/
│       │           ├── controller/ # Servlets
│       │           ├── model/      # Entity classes
│       │           ├── dao/        # Data Access Objects
│       │           ├── service/    # Business logic
│       │           └── util/       # Utility classes
│       ├── resources/              # Configuration files
│       │   └── db.properties       # Database configuration
│       └── webapp/                 # Web resources
│           ├── WEB-INF/
│           │   └── web.xml         # Deployment descriptor
│           ├── css/                # Stylesheets
│           ├── js/                 # JavaScript files
│           ├── images/             # Image assets
│           └── jsp/                # JSP pages
├── target/                         # Compiled classes and WAR
├── pom.xml                         # Maven configuration
└── README.md                       # Project documentation
```

## 📖 Usage

### For Customers:

1. **Register/Login:**
   - Navigate to the registration page
   - Create a new account or login with existing credentials

2. **Browse Products:**
   - Browse products by category
   - Use search and filter options
   - View product details

3. **Shopping Cart:**
   - Add products to cart
   - Update quantities or remove items
   - Proceed to checkout

4. **Place Order:**
   - Enter shipping information
   - Select payment method
   - Confirm and place order
   - Receive order confirmation

### For Administrators:

1. **Login:**
   - Access admin panel with admin credentials
   - Default credentials (change after first login):
     - Username: `admin`
     - Password: `admin123`

2. **Manage Products:**
   - Add, edit, or delete products
   - Update inventory levels
   - Manage categories

3. **Manage Orders:**
   - View all orders
   - Update order status
   - Process refunds

4. **Manage Users:**
   - View registered users
   - Manage user roles
   - Handle customer inquiries

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Mayank Solanki** - [Mayank-Solanki-1](https://github.com/Mayank-Solanki-1)

## 📞 Contact

For any questions or suggestions, please open an issue or contact the maintainer.

## 🙏 Acknowledgments

- Thanks to all contributors who have helped with this project
- Special thanks to the open-source community for their invaluable tools and libraries

---

**Happy Shopping! 🛒**
