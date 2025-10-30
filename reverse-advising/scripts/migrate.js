const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

// Path to the SQL file
const sqlFilePath = path.join(__dirname, '../database/majors_jobs.sql');

// Function to execute SQL commands
const executeSqlFile = (filePath) => {
    return new Promise((resolve, reject) => {
        const command = `mysql -u <username> -p<password> <database> < ${filePath}`;
        exec(command, (error, stdout, stderr) => {
            if (error) {
                reject(`Error executing SQL file: ${stderr}`);
            } else {
                resolve(stdout);
            }
        });
    });
};

// Main function to run the migration
const migrate = async () => {
    try {
        console.log('Starting database migration...');
        await executeSqlFile(sqlFilePath);
        console.log('Database migration completed successfully.');
    } catch (error) {
        console.error(error);
    }
};

// Run the migration
migrate();