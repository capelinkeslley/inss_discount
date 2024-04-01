## INNS Discount

INNS Discount is a small application used to calculate INSS (Brazilian Social Security Contribution) discount based on a salary.

The application has two models, user and proponent. To log in, you can use the following credentials: email: first_user@email.com, password: 123123. After logging in, you can create new proponents, update them, delete them, and view reports.

To create a new account, you need to provide a name, email (a valid email to confirm it after registration; without confirmation, login is not possible), password, and password confirmation. After receiving the confirmation email, you can log in.

### Setup:

To run the application, you need to configure the development environment. Execute the following command in the terminal:

EDITOR="vi" rails credentials:edit --environment development

Add the following to development.yml:

```yaml
mailer:
  username: your_username
  password: your_password
```

You also need to configure the database information. To do this, create a .env.development file; you can find an example in .env.development.example.

Redis must be running to use Sidekiq.

After everything is set up:

```rails db:create && rails db:migrate && rails db:seed && rails s```

You can also use Docker:

```
docker compose build

docker compose up -d
```