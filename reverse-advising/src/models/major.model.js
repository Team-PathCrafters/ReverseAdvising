const db = require('../db/connection');

const Major = {
    findAll: async () => {
        const [rows] = await db.query('SELECT * FROM Major');
        return rows;
    },

    findById: async (id) => {
        const [rows] = await db.query('SELECT * FROM Major WHERE MajorID = ?', [id]);
        return rows[0];
    },

    create: async (majorData) => {
        const { Major_name, Description, CreditHrs, focus } = majorData;
        const [result] = await db.query(
            'INSERT INTO Major (Major_name, Description, CreditHrs, focus) VALUES (?, ?, ?, ?)',
            [Major_name, Description, CreditHrs, focus]
        );
        return result.insertId;
    },

    update: async (id, majorData) => {
        const { Major_name, Description, CreditHrs, focus } = majorData;
        await db.query(
            'UPDATE Major SET Major_name = ?, Description = ?, CreditHrs = ?, focus = ? WHERE MajorID = ?',
            [Major_name, Description, CreditHrs, focus, id]
        );
    },

    delete: async (id) => {
        await db.query('DELETE FROM Major WHERE MajorID = ?', [id]);
    }
};

module.exports = Major;