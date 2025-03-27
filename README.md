# Spring Boot JTE & JWT Authentication Project

![Java](https://img.shields.io/badge/Java-23%2B-blue)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.0-green)
![JWT](https://img.shields.io/badge/JWT-0.11.5-orange)
![MySQL](https://img.shields.io/badge/MySQL-8.0.33-blue)
![JTE](https://img.shields.io/badge/JTE-1.0.0-blue)

A secure Spring Boot application with JWT authentication, featuring registration, login, protected endpoints, and proper logout functionality and a simple JWT admin dashboard for role-based access control.

## Features

- ✅ **JWT Authentication** - Stateless token-based authentication
- 🔐 **Role-Based Access Control** - USER and ADMIN roles
- 📝 **Registration & Login** - Secure forms with validation
- 🚪 **Complete Logout** - Token blacklisting and cleanup
- 🛡️ **CSRF Protection** - For form submissions
- 📱 **API Endpoints** - Protected resources with proper authorization
- 📊 **Admin Dashboard** - Role-specific views
- 🍪 **Token Storage** - Cookies and Authorization header support
- 📦 **JTE** - Java template engine for dynamic content generation

## Prerequisites

- Java 23+
- Maven 3.8+
- Spring Boot 3.4.0
- MySQL 8+ Database

## Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:shakhawatmollah/spring-auth-jte-layout.git
   cd spring-auth-jte-layout
   ```

2. Build the project:
   ```bash
   mvn clean install
   ```

3. Run the application:
   ```bash
   mvn spring-boot:run
   ```

## Configuration

Configure your application in `application.properties`:

```yaml
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/spring_auth_jte_layout
spring.datasource.username=username
spring.datasource.password=password
spring.jpa.show-sql=true
spring.jpa.hibernate.ddl-auto=update

app.jwt.secret=secret
app.jwt.expiration=3600000
```

## API Endpoints

| Endpoint         | Method | Description         | Access |
|------------------|--------|---------------------|--------|
| `/auth/register` | POST   | Register new user   | Public |
| `/auth/login`    | POST   | Login user          | Public |
| `/auth/logout`   | POST   | Logout user         | Authenticated |
| `/api/register`  | POST   | Register API User   | Public |
| `/api/login`     | POST   | Login API User      | Public |
| `/dashboard`     | GET    | Dashboard           | Authenticated |
| `/index`         | GET    | Home                | Public |

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/shakhawat/springauthjtelayout/
│   │       ├── config/        # Configuration classes
│   │       ├── controller/    # MVC and API controllers
│   │       ├── dto/           # Data transfer objects
│   │       ├── exception/     # Custom exceptions
│   │       ├── model/         # Entity classes
│   │       ├── repository/    # Data repositories
│   │       ├── security/      # Security components
│   │       └── service/       # Business logic
│   └── jte/
│       ├── index.jte          # Index page
│       ├── dashboard.jte      # Dashboard page
│       ├── login.jte          # Login page
│       └── register.jte       # Login page

```

## Usage

### 1. Registration
Visit `/auth/register` to create a new account.

### 2. Login
Authenticate at `/auth/login` to receive a JWT token.

### 4. Logout
- POST to `/logout` to invalidate the token
- Client-side cleanup is automatically handled

## Best Practices Implemented

1. Secure password storage with BCrypt
2. JWT token expiration and refresh
3. Proper CORS configuration
4. CSRF protection for forms
5. Input validation
6. Secure HTTP headers
7. Token blacklisting on logout

## Acknowledgments

- Spring Security team
- JJWT library maintainers
- JTE template engine developers
