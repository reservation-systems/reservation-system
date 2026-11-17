# Reservation system

Requires Java 21. Maven is supplied by the wrapper.

## Run on Windows (PowerShell)

```powershell
cd C:\Users\kanishka\Desktop\reservation-system
$env:ADMIN_EMAIL = "your-admin@example.com"
$env:ADMIN_PASSWORD = "choose-a-strong-password"
.\mvnw.cmd spring-boot:run
```

Open http://localhost:8080. Use the credentials you chose for the admin login. Register a customer through the website.

The admin environment variables create an administrator only when that email does not already exist. Remove them after the first successful startup. There is no built-in admin password. The old seeded admin@gmail.com / admin123 password is disabled on migration; an explicit ADMIN_EMAIL matching that old email plus ADMIN_PASSWORD can recover that account on its first migration. Existing admins can manage other admins through the dashboard.

The default database is persistent H2, stored in data/restaurant_db. MySQL is optional; the old MySQL data is retained in MySQL and is not automatically copied to H2.

## Use an existing MySQL database

Create restaurant_db and a dedicated database user with access to that database, then set:

```powershell
$env:SPRING_PROFILES_ACTIVE = "mysql"
$env:DB_URL = "jdbc:mysql://localhost:3306/restaurant_db?serverTimezone=UTC"
$env:DB_USER = "restaurant_app"
$env:DB_PASSWORD = "your-database-password"
.\mvnw.cmd spring-boot:run
```

Back up your database before the first upgraded startup. Existing plaintext passwords are hashed during startup. Old global RESERVED flags backed by reservations are released; date and time determine availability afterward. Duplicate table numbers or customer emails in existing data must be resolved before the new uniqueness constraints can be applied.

## Verify and package

```powershell
.\mvnw.cmd clean verify
java -jar target/reservation-system-0.0.1-SNAPSHOT.war
```

Use an executable WAR so JSP pages are included in the packaged application. On Linux/macOS use `bash mvnw clean verify` and `bash mvnw spring-boot:run`. To enable direct `./mvnw` invocation after copying from Windows, run `chmod +x mvnw`; if tracked in Git, record it with `git update-index --chmod=+x mvnw`. Windows filesystem copies do not preserve Unix executable bits.

## Booking and access rules

- Server sessions enforce admin privileges and customer ownership. Browser localStorage is only a display cache.
- Requests that change data require CSRF tokens. The shared frontend script obtains them automatically. Logout invalidates the server session.
- Passwords are stored using BCrypt and omitted from every JSON response. Blank passwords on profile edits preserve the old password. Customer email is the stable account and booking identifier.
- Bookings occupy a two-hour interval. Back-to-back intervals and different days can use the same table. Change app.reservation.duration-minutes to change the interval (1–1440).
- Pending and confirmed reservations block their time interval. Cancellation/deletion releases only that booking. Capacity, future dates, overlapping intervals, and concurrent requests are checked in a database transaction with a table-row lock.
- Customers may edit their own active reservations or cancel/delete them. Editing returns the reservation to PENDING. Only admins confirm reservations.
- Table status describes physical availability. Use OCCUPIED or UNAVAILABLE to block a table; reservation bookings do not set a global RESERVED status.
- Payments remain a university-project simulation. No funds are charged. Do not enter real card data. The server masks card numbers and validates amounts, methods and offer discounts; a simulated payment does not grant admin approval of a reservation.
- For HTTPS deployments set SESSION_COOKIE_SECURE=true.

Original source files are preserved in backups/before-fixes. This backup contains the original insecure configuration and should remain local.
