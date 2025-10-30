# Reverse Advising Application

## Overview
The Reverse Advising application is designed to help students explore potential career paths based on their majors. It provides a database of majors and associated jobs, along with a set of questions to guide students in their decision-making process.

## Project Structure
```
reverse-advising
├── src
│   ├── index.js               # Entry point of the application
│   ├── app.js                 # Express application setup
│   ├── db
│   │   ├── connection.js       # Database connection setup
│   │   ├── migrations          # Directory for database migrations
│   │   │   └── README.md       # Documentation for migrations
│   │   └── seeds               # Directory for seeding data
│   │       └── README.md       # Documentation for seeding
│   ├── models
│   │   ├── major.model.js      # Major model definition
│   │   └── job.model.js        # Job model definition
│   ├── controllers
│   │   └── advisor.controller.js # Controller for handling requests
│   └── routes
│       └── advisor.routes.js    # Routes for advisor-related endpoints
├── database
│   └── majors_jobs.sql         # SQL schema and initial data
├── scripts
│   ├── migrate.js              # Script for migrating the database
│   └── seed.js                 # Script for seeding the database
├── .env.example                 # Template for environment variables
├── .gitignore                   # Git ignore file
├── package.json                 # Project metadata and dependencies
├── README.md                    # Project documentation
└── docker-compose.yml           # Docker configuration
```

## Getting Started

### Prerequisites
- Node.js (version 14 or higher)
- npm (Node package manager)
- A MySQL or PostgreSQL database

### Installation
1. Clone the repository:
   ```
   git clone <repository-url>
   cd reverse-advising
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Set up your environment variables:
   - Copy `.env.example` to `.env` and fill in the required values.

### Database Setup
1. Run the migration script to set up the database schema:
   ```
   node scripts/migrate.js
   ```

2. Seed the database with initial data:
   ```
   node scripts/seed.js
   ```

### Running the Application
Start the application:
```
node src/index.js
```

### API Endpoints
- **GET /majors**: Retrieve a list of all majors.
- **GET /jobs**: Retrieve a list of all jobs.
- **POST /advisor**: Submit answers to questions and get career recommendations.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.