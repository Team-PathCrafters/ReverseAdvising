const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');
const dbFilePath = path.join(__dirname, '../database/majors_jobs.sql');

const seedDatabase = () => {
    fs.readFile(dbFilePath, 'utf8', (err, sql) => {
        if (err) {
            console.error('Error reading SQL file:', err);
            return;
        }

        exec(`mysql -u your_username -p your_database < ${dbFilePath}`, (error, stdout, stderr) => {
            if (error) {
                console.error(`Error executing SQL: ${error.message}`);
                return;
            }
            if (stderr) {
                console.error(`SQL Error: ${stderr}`);
                return;
            }
            console.log('Database seeded successfully:', stdout);
        });
    });
};

seedDatabase();