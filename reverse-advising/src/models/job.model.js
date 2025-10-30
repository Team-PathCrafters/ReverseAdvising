const { Model, DataTypes } = require('sequelize');
const sequelize = require('../db/connection');

class Job extends Model {}

Job.init({
    JobID: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    Job_name: {
        type: DataTypes.STRING(100),
        allowNull: false
    },
    years_needed: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    avgCost: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    },
    Salary: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    }
}, {
    sequelize,
    modelName: 'Job',
    tableName: 'Jobs',
    timestamps: false
});

module.exports = Job;