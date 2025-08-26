# Hanoi Rock City (HRC) - Event Ticketing System

A comprehensive Java web application for managing rock concert events, ticket sales, and venue management in Hanoi, Vietnam.

## 🎸 Project Overview

HRC (Hanoi Rock City) is a full-featured event ticketing system built with Java 17, Jakarta EE, and MSSQL. The system provides complete event management capabilities for rock concerts, including venue management, artist booking, ticket sales, and order processing.

## 🚀 Features

### For Event Organizers (Admin/Staff)
- **Event Management**: Create, edit, and manage rock concerts
- **Venue Management**: Manage concert venues and their zones
- **Artist Management**: Book and manage performing artists
- **Ticket Zone Management**: Configure pricing and capacity for different seating zones
- **Order Management**: Process and confirm ticket orders
- **Promo Code Management**: Create and manage discount codes
- **Customer Management**: View and manage customer accounts
- **Staff Management**: Manage admin and staff accounts

### For Customers
- **Browse Events**: View upcoming rock concerts
- **Ticket Purchase**: Select seats and purchase tickets
- **Order History**: View past ticket purchases
- **Account Management**: Manage personal information

## 🛠️ Technology Stack

- **Backend**: Java 17, Jakarta Servlet 5.0
- **View Layer**: JSP, JSTL
- **Database**: Microsoft SQL Server (MSSQL)
- **Build Tool**: Apache Ant
- **Server**: Apache Tomcat 10
- **Architecture**: MVC Pattern

## 📁 Project Structure

```
HRC/
├── src/
│   └── java/hrc/
│       ├── controller/     # Servlet controllers
│       ├── dao/           # Data Access Objects
│       ├── entity/        # POJO entities
│       ├── service/       # Business logic
│       ├── filter/        # Authentication filters
│       └── util/          # Utility classes
├── web/
│   ├── WEB-INF/
│   │   ├── views/         # JSP pages
│   │   │   ├── admin/     # Admin interface
│   │   │   └── public/    # Public pages
│   │   └── web.xml        # Web configuration
│   └── resources/         # Static resources
├── build.xml              # Ant build configuration
└── README.md             # This file
```

## 🗄️ Database Schema

### Core Tables
- **Users**: Admin and staff accounts
- **Customers**: Customer accounts
- **Venues**: Concert venues
- **VenueZones**: Seating zones within venues
- **Events**: Rock concert events
- **EventZones**: Ticket zones for events
- **Artists**: Performing artists
- **EventArtists**: Artist-event relationships
- **Orders**: Ticket orders
- **OrderItems**: Individual ticket items
- **PromoCodes**: Discount codes

## 🚀 Getting Started

### Prerequisites
- Java 17 or higher
- Apache Tomcat 10
- Microsoft SQL Server
- Apache Ant

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd HRC
   ```

2. **Database Setup**
   - Create a MSSQL database named `hrc`
   - Run the provided SQL scripts to create tables and seed data
   - Update database connection settings in `src/java/hrc/util/DBConnect.java`

3. **Build the project**
   ```bash
   ant compile
   ```

4. **Deploy to Tomcat**
   ```bash
   ant war
   ```
   Copy the generated `HRC.war` file to Tomcat's `webapps` directory

5. **Start Tomcat**
   ```bash
   # Navigate to Tomcat bin directory
   cd $TOMCAT_HOME/bin
   ./startup.sh  # Linux/Mac
   startup.bat   # Windows
   ```

6. **Access the application**
   - Open browser and navigate to `http://localhost:8080/HRC`
   - Default admin account: `admin@hrc.com` / `admin123`

## 👥 User Roles

### Admin
- Full system access
- Manage all events, venues, artists
- Process orders and payments
- Manage staff accounts

### Staff
- Event and order management
- Customer support
- Cannot manage admin accounts

### Customer
- Browse and purchase tickets
- View order history
- Manage personal information

## 🎫 Event Management Workflow

1. **Create Venue**: Add concert venue with seating zones
2. **Add Artists**: Register performing artists
3. **Create Event**: Set up rock concert with venue and artists
4. **Configure Zones**: Set pricing and capacity for each seating zone
5. **Publish Event**: Change status from DRAFT to ONSALE
6. **Process Orders**: Confirm payments and manage ticket sales

## 🔧 Configuration

### Database Connection
Update `src/java/hrc/util/DBConnect.java`:
```java
private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=hrc;encrypt=false";
private static final String USERNAME = "sa";
private static final String PASSWORD = "yourPassword";
```

### Build Configuration
The project uses Apache Ant for building. Key targets:
- `ant compile`: Compile Java source files
- `ant war`: Create deployable WAR file
- `ant clean`: Clean build artifacts

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Failed**
   - Verify MSSQL is running
   - Check connection credentials in `DBConnect.java`
   - Ensure database `hrc` exists

2. **Build Failures**
   - Ensure Java 17 is installed and `JAVA_HOME` is set
   - Verify Apache Ant is installed and in PATH
   - Check all required dependencies are present

3. **Deployment Issues**
   - Ensure Tomcat 10 is used (Jakarta EE compatibility)
   - Check Tomcat logs for detailed error messages
   - Verify WAR file is properly deployed

## 📝 API Endpoints

### Public Endpoints
- `GET /events` - List public events
- `GET /event?id={id}` - View event details
- `POST /login` - User authentication
- `POST /register` - Customer registration

### Admin/Staff Endpoints
- `GET /admin` - Dashboard
- `GET /admin/events` - Event management
- `GET /admin/orders` - Order management
- `GET /admin/venues` - Venue management
- `GET /admin/artists` - Artist management
- `GET /admin/promo-codes` - Promo code management

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Development Team

- **Project**: Hanoi Rock City (HRC) Ticketing System
- **Technology**: Java 17, Jakarta EE, MSSQL
- **Purpose**: Rock concert event management and ticketing

## 🎵 About Hanoi Rock City

Hanoi Rock City is a premier venue and event organizer for rock concerts in Hanoi, Vietnam. This ticketing system supports the vibrant rock music scene in Vietnam's capital city, providing seamless event management and ticket sales for rock enthusiasts.

---

**Rock on! 🤘**


Prompt:
Continue HRC Project Development
I'm working on a Java web project named HRC (Hanoi Rock City) - a concert ticketing system. The project is built with Java 17, Jakarta EE 5.0, Apache Ant, Tomcat 10, and MSSQL.
Current Status:
The project is fully functional with MVC architecture
Database schema is complete with all tables (Users, Customers, Events, Venues, Artists, etc.)
All DAO classes, services, and controllers are implemented
Role-based authentication (ADMIN, STAFF, CUSTOMER) is working
Frontend has been redesigned with modern Bootstrap 5 and rock theme (red/black)
What was just completed:
Fixed blank page issue on events.jsp caused by LocalDateTime formatting
Updated events.jsp to use direct EL expressions instead of fmt:formatDate
The events page is now working and displaying properly
Current Issue:
The header navigation is missing login/register and order management links. The user is asking "where is my login and register order" - they can't see these navigation elements in the header.
Next Task:
Add the missing login/register and order management links to the header navigation in events.jsp. The header currently has:
Logo and navigation links on the left
Language selector on the right
But it's missing:
Login/Register links
Order management links (for logged-in users)
User account dropdown (for logged-in users)
Technical Context:
Use JSTL to check user session and role
Links should be role-appropriate (customers see "My Orders", admins see "Admin Dashboard")
Follow the existing red/black rock theme
No emoji characters
Use Bootstrap 5 styling
Files to modify:
web/WEB-INF/views/events.jsp - add missing navigation elements to header
Please continue from where we left off and add the missing login/register and order management navigation to the header