# Database Seeding Documentation

This README file provides instructions on how to seed the database with initial data for the Advisor application.

## Seeding the Database

To populate the database with initial data, follow these steps:

1. **Ensure Database Connection**: Make sure that your database is running and accessible. Check the database connection settings in the `src/db/connection.js` file.

2. **Run the Seed Script**: Use the following command to execute the seed script, which will insert the initial data into the database:

   ```bash
   node scripts/seed.js
   ```

3. **Verify Data**: After running the seed script, you can verify that the data has been inserted correctly by querying the relevant tables in your database.

## Seed Data Overview

The seed script will insert initial questions and answers related to majors and jobs into the database. This data is essential for the functionality of the Advisor application, allowing users to explore different majors and associated job opportunities.

## Troubleshooting

- If you encounter any errors while running the seed script, check the console output for error messages.
- Ensure that the SQL schema has been set up correctly by running the migration script before seeding the database.

## Additional Information

For more details on the database schema and structure, refer to the `database/majors_jobs.sql` file.