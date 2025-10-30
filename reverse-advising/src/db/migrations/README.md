# Database Migrations for Advisor Application

This directory contains the migration files for the Advisor application. Migrations are used to manage changes to the database schema over time in a structured and organized manner.

## How to Create a Migration

1. **Create a New Migration File**: Use a naming convention that describes the change, e.g., `YYYYMMDDHHMMSS_create_table_name.js`.

2. **Define the Migration**: Each migration file should export an object with `up` and `down` methods:
   - `up`: Contains the code to apply the migration (e.g., creating tables).
   - `down`: Contains the code to revert the migration (e.g., dropping tables).

3. **Run Migrations**: Use the migration script to apply the changes to the database:
   ```bash
   node scripts/migrate.js
   ```

4. **Rollback Migrations**: If needed, you can rollback the last migration:
   ```bash
   node scripts/migrate.js --rollback
   ```

## Example Migration File Structure

```javascript
module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Code to create tables or modify schema
  },
  down: async (queryInterface, Sequelize) => {
    // Code to revert changes
  }
};
```

## Best Practices

- Always create a new migration for any changes to the database schema.
- Test migrations in a development environment before applying them to production.
- Keep migration files organized and well-documented for future reference.