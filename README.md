## INNS Discount

INNS Discount is a small application used to calculate INSS (Brazilian Social Security Contribution) discount based on a salary.

The application has three models, user, proponent and address. To log in, you can use the following credentials: email: first_user@email.com, password: 123123. After logging in, you can create new proponents, update them, delete them, and view reports.

To create a new account, you need to provide a name, email (a valid email to confirm it after registration; without confirmation, login is not possible), password, and password confirmation. After receiving the confirmation email, you can log in.

### Setup:

You also need to configure the database information. To do this, create a .env.development file; you can find an example in .env.development.example.

```yaml
DB_HOST=db_host
DB_USERNAME=db_username
DB_PASSWORD=db_password
REDIS_URL = redis_url
```

After everything is set up:

```rails db:create && rails db:migrate && rails db:seed && rails s```

Redis must be running to use Sidekiq.


If you prefer to use Docker, you'll need to create a `.env.production` file following the same pattern as `.env.development`. After that, in the terminal, execute the following commands:

To build the images:
```bash
docker compose build
```

To start the services:

```bash
docker compose up -d
```

With the containers running, execute the following command to access the bash:

```bash
  docker exec -it inss_discount-web-1 /bin/bash
```

Check if you are in the bash prompt: root@/usr/app#

In the bash, execute the following command to create the database, run migrations, and seed the database:

```bash
rails db:create && rails db:migrate && rails db:seed
```

To exit bash, simply run the following command:

```bash
exit
```

## Email Confirmation

When creating a new user account to access the system, you will need to confirm the email, and for that, Mailcatcher is being used.

# If the project is running locally, you will need to install Mailcatcher:

Install the gem:

```bash
gem install mailcatcher
```

Run Mailcatcher:
```bash
mailcatcher 
```

# If you are running with Docker

If you are running with Docker you don't need to do anything, Docker is already configured to run Mailcatcher. Just be careful not to run Mailcatcher locally and then run Docker, as it may cause issues with sending emails.

To access the emails, simply access Mailcatcher at http://127.0.0.1:1080/





