# Restoration CRM

Restoration CRM is a Ruby on Rails application designed to assist Restoration Church in managing its administrative and operational tasks efficiently. The goal is to streamline processes and provide tools for better management of church activities and resources.

## Getting Started

### Ruby Version
- Ruby 3.4.1
- Rails 8.0.1

### System Dependencies
- PostgreSQL (pg gem required)
- RSpec for testing (`rspec-rails`)
- Other dependencies can be found in the `Gemfile`.

### Installation
1. Clone the repository:
   ```bash
   git clone git@github.com:FTorrenegraG/restoration-crm.git
   cd restoration-crm
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Configure the database:
   Update `config/database.yml` with your PostgreSQL credentials.

4. Set up the database:
   ```bash
   rails db:create db:migrate db:seed
   ```

### Running the Application
Start the Rails server:
```bash
rails server
```
Access the application at [http://localhost:3000](http://localhost:3000).

### Testing
Run the test suite with RSpec:
```bash
bundle exec rspec
```

### Deployment
1. Ensure all migrations are up-to-date:
   ```bash
   rails db:migrate
   ```