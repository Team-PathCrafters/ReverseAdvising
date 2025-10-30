import express from 'express';
import { getAllMajors, getMajorById, createMajor, updateMajor, deleteMajor } from '../controllers/advisor.controller.js';
import { getAllJobs, getJobById, createJob, updateJob, deleteJob } from '../controllers/advisor.controller.js';

const router = express.Router();

// Major routes
router.get('/majors', getAllMajors);
router.get('/majors/:id', getMajorById);
router.post('/majors', createMajor);
router.put('/majors/:id', updateMajor);
router.delete('/majors/:id', deleteMajor);

// Job routes
router.get('/jobs', getAllJobs);
router.get('/jobs/:id', getJobById);
router.post('/jobs', createJob);
router.put('/jobs/:id', updateJob);
router.delete('/jobs/:id', deleteJob);

export default router;