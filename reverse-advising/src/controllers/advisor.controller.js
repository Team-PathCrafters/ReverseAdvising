const Major = require('../models/major.model');
const Job = require('../models/job.model');

// Get all majors
exports.getAllMajors = async (req, res) => {
    try {
        const majors = await Major.findAll();
        res.status(200).json(majors);
    } catch (error) {
        res.status(500).json({ message: 'Error retrieving majors', error });
    }
};

// Get a major by ID
exports.getMajorById = async (req, res) => {
    const { id } = req.params;
    try {
        const major = await Major.findById(id);
        if (major) {
            res.status(200).json(major);
        } else {
            res.status(404).json({ message: 'Major not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Error retrieving major', error });
    }
};

// Create a new major
exports.createMajor = async (req, res) => {
    const { Major_name, Description, CreditHrs, focus } = req.body;
    try {
        const newMajor = await Major.create({ Major_name, Description, CreditHrs, focus });
        res.status(201).json(newMajor);
    } catch (error) {
        res.status(500).json({ message: 'Error creating major', error });
    }
};

// Get all jobs
exports.getAllJobs = async (req, res) => {
    try {
        const jobs = await Job.findAll();
        res.status(200).json(jobs);
    } catch (error) {
        res.status(500).json({ message: 'Error retrieving jobs', error });
    }
};

// Get a job by ID
exports.getJobById = async (req, res) => {
    const { id } = req.params;
    try {
        const job = await Job.findById(id);
        if (job) {
            res.status(200).json(job);
        } else {
            res.status(404).json({ message: 'Job not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Error retrieving job', error });
    }
};

// Create a new job
exports.createJob = async (req, res) => {
    const { Job_name, years_needed, avgCost, Salary } = req.body;
    try {
        const newJob = await Job.create({ Job_name, years_needed, avgCost, Salary });
        res.status(201).json(newJob);
    } catch (error) {
        res.status(500).json({ message: 'Error creating job', error });
    }
};